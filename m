From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: [PATCH] configure.in: Fix xmlto detection
Date: Wed,  5 Jan 2011 13:01:04 +0200
Message-ID: <1294225264-28475-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 729BF103927
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 12:06:38 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

xmlto was never detected when alsaconf is disabled leading to a missing
alsactl_init man page.
---
 configure.in |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/configure.in b/configure.in
index 2d6c80c..561ca46 100644
--- a/configure.in
+++ b/configure.in
@@ -102,13 +102,11 @@ AC_ARG_ENABLE(alsaloop,
 AM_CONDITIONAL(ALSALOOP, test x$alsaloop = xtrue)
 
 xmlto=""
-if test x"$alsaconf" = xtrue; then
-   AC_ARG_ENABLE(xmlto,
-     AS_HELP_STRING([--disable-xmlto], [Disable man page creation via xmlto]),
-     xmlto="$enableval", xmlto="yes")
-   if test "$xmlto" = "yes"; then
-      AC_CHECK_PROG([xmlto], [xmlto], [yes])
-   fi
+AC_ARG_ENABLE(xmlto,
+ AS_HELP_STRING([--disable-xmlto], [Disable man page creation via xmlto]),
+ xmlto="$enableval", xmlto="yes")
+if test "$xmlto" = "yes"; then
+  AC_CHECK_PROG([xmlto], [xmlto], [yes])
 fi
 AM_CONDITIONAL(USE_XMLTO, test x"$xmlto" = xyes)
 
-- 
1.7.3.4
