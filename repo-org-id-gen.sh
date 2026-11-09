#!/bin/bash

read -rsp "Enter your GitHub PAT: " GH_TOKEN
echo
export GH_TOKEN

OWNER="thankgodntemcloud"
REPO="thankgod-eks-terraform-infrastructure"

# Get GitHub Owner/User ID
OWNER_RESPONSE=$(curl -fsSL \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/user")

OWNER_ID=$(echo "$OWNER_RESPONSE" | jq -r '.id')
OWNER_LOGIN=$(echo "$OWNER_RESPONSE" | jq -r '.login')
OWNER_TYPE=$(echo "$OWNER_RESPONSE" | jq -r '.type')

# Get Repository ID
REPO_RESPONSE=$(curl -fsSL \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/$OWNER/$REPO")

REPO_ID=$(echo "$REPO_RESPONSE" | jq -r '.id')

echo
echo "========================================"
echo "GitHub OIDC Configuration Details"
echo "========================================"
echo "GitHub Owner:       $OWNER_LOGIN"
echo "Owner Type:         $OWNER_TYPE"
echo "Owner ID:           $OWNER_ID"
echo "Repository:         $OWNER_LOGIN/$REPO"
echo "Repository ID:      $REPO_ID"
echo
echo "Immutable OIDC Subject:"
echo "repo:${OWNER_LOGIN}@${OWNER_ID}/${REPO}@${REPO_ID}"
echo "========================================"

unset GH_TOKEN
