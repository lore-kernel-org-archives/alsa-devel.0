From: =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@gmail.com>
Subject: [PATCH 3/4] List libavutil as a dependency together
	with libavcodec.
Date: Thu, 20 Jan 2011 04:45:15 +0100
Message-ID: <1295495116-19937-3-git-send-email-flameeyes@gmail.com>
References: <1295495116-19937-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BD400103A2B
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 04:46:31 +0100 (CET)
Received: by wwe15 with SMTP id 15so152328wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 19:46:31 -0800 (PST)
In-Reply-To: <1295495116-19937-1-git-send-email-flameeyes@gmail.com>
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

Without this it is possible that the a52 plugin ends up with an undefined
reference to av_free().
---
 configure.in |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/configure.in b/configure.in
index 5d71cae..973900b 100644
--- a/configure.in
+++ b/configure.in
@@ -67,7 +67,8 @@ AC_ARG_ENABLE([avcodec],
       AS_HELP_STRING([--disable-avcodec], [Don't build plugins depending on avcodec (a52)]))
 
 if test "x$enable_avcodec" != "xno"; then
-  PKG_CHECK_MODULES(AVCODEC, [libavcodec], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
+  # you need libavutil linked in for av_free
+  PKG_CHECK_MODULES(AVCODEC, [libavcodec libavutil], [HAVE_AVCODEC=yes], [HAVE_AVCODEC=no])
 fi
 
 if test "x$HAVE_AVCODEC" = "xno"; then
-- 
1.7.4.rc2
