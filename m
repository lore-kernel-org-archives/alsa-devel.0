From: sutar.mounesh@gmail.com
Subject: [PATCH 1/1] alsa-plugins: enhancing configuration
	support for alsa plugins
Date: Fri, 17 Feb 2017 12:54:19 +0530
Message-ID: <1487316259-9321-1-git-send-email-sutar.mounesh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mikhail Durnev <mikhail_durnev@mentor.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Mounesh Sutar <mounesh_sutar@mentor.com>

Following plugins are made configurable in alsa-plugins:
* oss
* mix
* usbstream
* arcamav
* speexdsp

Signed-off-by: Mikhail Durnev <mikhail_durnev@mentor.com>
Signed-off-by: Mounesh Sutar <mounesh_sutar@mentor.com>

diff --git a/configure.ac b/configure.ac
index a55c735..190d935 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,6 +20,30 @@ PKG_CHECK_MODULES(ALSA, alsa >= 1.0.11)
 AC_CHECK_LIB(asound, snd_pcm_ioplug_create,,
 	     AC_ERROR([*** libasound has no external plugin SDK]), -ldl)
 
+AC_ARG_ENABLE([oss],
+      AS_HELP_STRING([--disable-oss], [Disable building of OSS plugin]))
+AS_IF([test "x$enable_oss" != "xno"],
+      [AM_CONDITIONAL(HAVE_OSS, true)],
+      [AM_CONDITIONAL(HAVE_OSS, false)])
+
+AC_ARG_ENABLE([mix],
+      AS_HELP_STRING([--disable-mix], [Disable building of upmix and vdownmix plugins]))
+AS_IF([test "x$enable_mix" != "xno"],
+      [AM_CONDITIONAL(HAVE_MIX, true)],
+      [AM_CONDITIONAL(HAVE_MIX, false)])
+
+AC_ARG_ENABLE([usbstream],
+      AS_HELP_STRING([--disable-usbstream], [Disable building of usb_stream plugin]))
+AS_IF([test "x$enable_usbstream" != "xno"],
+      [AM_CONDITIONAL(HAVE_USBSTREAM, true)],
+      [AM_CONDITIONAL(HAVE_USBSTREAM, false)])
+
+AC_ARG_ENABLE([arcamav],
+      AS_HELP_STRING([--disable-arcamav], [Disable building of Arcam AV control plugin]))
+AS_IF([test "x$enable_arcamav" != "xno"],
+      [AM_CONDITIONAL(HAVE_ARCAMAV, true)],
+      [AM_CONDITIONAL(HAVE_ARCAMAV, false)])
+
 AC_ARG_ENABLE([jack],
       AS_HELP_STRING([--disable-jack], [Disable building of JACK plugin]))
 
@@ -108,7 +132,12 @@ AC_SUBST(AVCODEC_CFLAGS)
 AC_SUBST(AVCODEC_LIBS)
 AC_SUBST(AVCODEC_HEADER)
 
-PKG_CHECK_MODULES(speexdsp, [speexdsp >= 1.2], [HAVE_SPEEXDSP="yes"], [HAVE_SPEEXDSP=""])
+AC_ARG_ENABLE([speexdsp],
+      AS_HELP_STRING([--disable-speexdsp], [Disable building of speexdsp plugin]))
+
+if test "x$enable_speexdsp" != "xno"; then
+  PKG_CHECK_MODULES(speexdsp, [speexdsp >= 1.2rc2], [HAVE_SPEEXDSP="yes"], [HAVE_SPEEXDSP=""])
+fi
 AM_CONDITIONAL(HAVE_SPEEXDSP, test "$HAVE_SPEEXDSP" = "yes")
 
 AC_ARG_WITH([speex],
-- 
2.7.4
