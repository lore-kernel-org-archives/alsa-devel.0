From: Vikram Narayanan <vikram186@gmail.com>
Subject: [PATCH] Remove the cvscompile file
Date: Sat, 18 Feb 2012 20:53:56 +0530
Message-ID: <4F3FC28C.3010605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

package: alsa-utils

Removed the cvscompile file.

Signed-off-by: Vikram Narayanan <vikram186@gmail.com>
---
 cvscompile |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)
 delete mode 100755 cvscompile

diff --git a/cvscompile b/cvscompile
deleted file mode 100755
index 64ade4f..0000000
--- a/cvscompile
+++ /dev/null
@@ -1,25 +0,0 @@
-#!/bin/bash
-
-if test -d ../alsa-lib/utils && ! test -r `aclocal --print-ac-dir`/alsa.m4; then
-  alsa_m4_flags="-I ../alsa-lib/utils"
-fi
-aclocal $alsa_m4_flags $ACLOCAL_FLAGS
-# save original files to avoid stupid modifications by gettextize
-cp Makefile.am Makefile.am.ok
-cp configure.in configure.in.ok
-gettextize -c -f --no-changelog
-echo "EXTRA_DIST = gettext.m4" > m4/Makefile.am
-cp Makefile.am.ok Makefile.am
-cp configure.in.ok configure.in
-autoheader
-automake --foreign --copy --add-missing
-touch depcomp		# for older automake
-autoconf
-export CFLAGS='-O2 -Wall -pipe -g'
-echo "CFLAGS=$CFLAGS"
-echo "./configure $@"
-./configure $@ || exit 1
-unset CFLAGS
-if [ -z "$CVSCOMPILE_NO_MAKE" ]; then
-  make
-fi
-- 
1.7.4.1
