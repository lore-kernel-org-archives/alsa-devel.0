From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/3] cvscompile: Remove in favour of gitcompile.
Date: Tue, 29 Sep 2009 23:48:19 +0200
Message-ID: <1254260901-1161-2-git-send-email-stefan@datenfreihafen.org>
References: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CB182434E
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 23:48:37 +0200 (CEST)
In-Reply-To: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Stefan Schmidt <stefan@slimlogic.co.uk>

Alsa-lib is no longer hosted in cvs but in git and the only difference between
both helper scripts is the name of the NO_MAKE env VAR check.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 cvscompile |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)
 delete mode 100755 cvscompile

diff --git a/cvscompile b/cvscompile
deleted file mode 100755
index af7700e..0000000
--- a/cvscompile
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/bash
-
-set -e
-
-touch ltconfig
-libtoolize --force --copy --automake
-aclocal $ACLOCAL_FLAGS
-autoheader
-automake --foreign --copy --add-missing
-touch depcomp		# seems to be missing for old automake
-autoconf
-export CFLAGS='-O2 -Wall -W -pipe -g'
-echo "CFLAGS=$CFLAGS"
-echo "./configure $@"
-./configure $@ || exit 1
-unset CFLAGS
-if [ -z "$CVSCOMPILE_NO_MAKE" ]; then
-  make
-fi
-- 
1.6.4.3
