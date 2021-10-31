#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Create commit message
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

# Build the project.
echo ""
echo ""
echo "Committing changes to $(pwd)"
hugo -D

#Update remote
echo ""
echo ""
echo "Committing changes to $(pwd)"
git add -A .
git commit -m "$msg"
git push origin master

# Copy everything to the host repo
rm -rf ../tomkimpson.github.io/* #delete all old stuff
cp -rf public/* ../tomkimpson.github.io/ #copy everything

#Go to the host repo, commit and push

# Go To Public folder
cd ../tomkimpson.github.io
# Add this repos changes to git and commit/push. First 'cd' out of public
echo ""
echo ""
echo "Committing changes to $(pwd)"
git add -A .
git commit -m "$msg"
git push origin master

