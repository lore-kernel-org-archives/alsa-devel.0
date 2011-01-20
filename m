From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [alsa-utils PATCH 3/3] Fix xmlto detection,
	allow building without xmlto installed.
Date: Thu, 20 Jan 2011 16:02:26 +0100
Message-ID: <1295535746-24051-3-git-send-email-flameeyes@gmail.com>
References: <1295535746-24051-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 4858824526
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 16:04:14 +0100 (CET)
Received: by wyi11 with SMTP id 11so684456wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 07:04:14 -0800 (PST)
In-Reply-To: <1295535746-24051-1-git-send-email-flameeyes@gmail.com>
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

---
 configure.in |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure.in b/configure.in
index 6892fbf..51e7d63 100644
--- a/configure.in
+++ b/configure.in
@@ -102,11 +102,9 @@ AC_ARG_ENABLE(alsaloop,
      esac],[alsaloop=true])
 AM_CONDITIONAL(ALSALOOP, test x$alsaloop = xtrue)
 
-xmlto=""
 AC_ARG_ENABLE(xmlto,
- AS_HELP_STRING([--disable-xmlto], [Disable man page creation via xmlto]),
- xmlto="$enableval", xmlto="yes")
-if test "$xmlto" = "yes"; then
+ AS_HELP_STRING([--disable-xmlto], [Disable man page creation via xmlto]))
+if test "x$enable_xmlto" != "xno"; then
   AC_CHECK_PROG([xmlto], [xmlto], [yes])
 fi
 AM_CONDITIONAL(USE_XMLTO, test x"$xmlto" = xyes)
-- 
1.7.4.rc2
