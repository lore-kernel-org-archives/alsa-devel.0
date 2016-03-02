From: han.lu@intel.com
Subject: [PATCH 02/10] alsabat: add standalone mode
Date: Wed,  2 Mar 2016 16:53:12 +0800
Message-ID: <5c8e6ec9f17e113f77f4ac89b02c51809e377400.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C350261566
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 09:51:08 +0100 (CET)
In-Reply-To: <cover.1456907242.git.han.lu@intel.com>
In-Reply-To: <cover.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, bernard.gautier@intel.com, edward.c.popescu@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add support for standalone mode where alsabat will run on a
different machine to the one being tested.
In standalone mode, the sound data can be generated, playback and
captured just like in normal mode, but will not be analyzed.
The alsabat being built without libfftw3 support is always work
in standalone mode.
The alsabat in normal mode can also bypass data analysis using
option "--standalone".

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/Makefile.am b/bat/Makefile.am
index 8dfafa9..5646e9a 100644
--- a/bat/Makefile.am
+++ b/bat/Makefile.am
@@ -6,7 +6,6 @@ EXTRA_DIST = alsabat.1
 alsabat_SOURCES = \
 	bat.c \
 	common.c \
-	analyze.c \
 	signal.c \
 	convert.c \
 	alsa.c
@@ -15,8 +14,12 @@ noinst_HEADERS = \
 	common.h \
 	bat-signal.h \
 	alsa.h \
-	convert.h \
-	analyze.h
+	convert.h
+
+if HAVE_LIBFFTW3
+alsabat_SOURCES += analyze.c
+noinst_HEADERS += analyze.h
+endif
 
 AM_CPPFLAGS = \
 	      -Wall -I$(top_srcdir)/include
diff --git a/bat/alsabat.1 b/bat/alsabat.1
index 8d0b9c0..5f41669 100644
--- a/bat/alsabat.1
+++ b/bat/alsabat.1
@@ -120,6 +120,15 @@ Internal loopback mode.
 Playback, capture and analysis internal to ALSABAT only. This is intended
 for developers to test new ALSABAT features as no audio is routed outside
 of ALSABAT.
+.TP
+\fI\-\-standalone\fP
+Add support for standalone mode where ALSABAT will run on a different machine
+to the one being tested.
+In standalone mode, the sound data can be generated, playback and captured
+just like in normal mode, but will not be analyzed.
+The ALSABAT being built without libfftw3 support is always in standalone mode.
+The ALSABAT in normal mode can also bypass data analysis using option
+"--standalone".
 
 .SH EXAMPLES
 
diff --git a/bat/bat.c b/bat/bat.c
index 9c637f2..85ec5aa 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -33,7 +33,9 @@
 
 #include "alsa.h"
 #include "convert.h"
+#ifdef HAVE_LIBFFTW3
 #include "analyze.h"
+#endif
 
 static int get_duration(struct bat *bat)
 {
@@ -289,6 +291,7 @@ _("Usage: alsabat [-options]...\n"
 "      --file=#           file for playback\n"
 "      --saveplay=#       file that storing playback content, for debug\n"
 "      --local            internal loop, set to bypass pcm hardware devices\n"
+"      --standalone       standalone mode, to bypass analysis\n"
 ));
 	fprintf(bat->log, _("Recognized sample formats are: %s %s %s %s\n"),
 			snd_pcm_format_name(SND_PCM_FORMAT_U8),
@@ -339,6 +342,7 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 		{"file",     1, 0, OPT_READFILE},
 		{"saveplay", 1, 0, OPT_SAVEPLAY},
 		{"local",    0, 0, OPT_LOCAL},
+		{"standalone", 0, 0, OPT_STANDALONE},
 		{0, 0, 0, 0}
 	};
 
@@ -357,6 +361,9 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 		case OPT_LOCAL:
 			bat->local = true;
 			break;
+		case OPT_STANDALONE:
+			bat->standalone = true;
+			break;
 		case 'D':
 			if (bat->playback.device == NULL)
 				bat->playback.device = optarg;
@@ -601,7 +608,12 @@ int main(int argc, char *argv[])
 		test_loopback(&bat);
 
 analyze:
-	err = analyze_capture(&bat);
+#ifdef HAVE_LIBFFTW3
+	if (!bat.standalone)
+		err = analyze_capture(&bat);
+#else
+	fprintf(bat.log, _("No libfftw3 library. Exit without analysis.\n"));
+#endif
 out:
 	fprintf(bat.log, _("\nReturn value is %d\n"), err);
 
diff --git a/bat/common.h b/bat/common.h
index 5417c0e..30e39fc 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -23,6 +23,7 @@
 #define OPT_READFILE			(OPT_BASE + 2)
 #define OPT_SAVEPLAY			(OPT_BASE + 3)
 #define OPT_LOCAL			(OPT_BASE + 4)
+#define OPT_STANDALONE			(OPT_BASE + 5)
 
 #define COMPOSE(a, b, c, d)		((a) | ((b)<<8) | ((c)<<16) | ((d)<<24))
 #define WAV_RIFF			COMPOSE('R', 'I', 'F', 'F')
@@ -150,6 +151,7 @@ struct bat {
 	char *narg;			/* argument string of duration */
 	char *logarg;			/* path name of log file */
 	char *debugplay;		/* path name to store playback signal */
+	bool standalone;		/* enable to bypass analysis */
 
 	struct pcm playback;
 	struct pcm capture;
diff --git a/configure.ac b/configure.ac
index bdb133c..f6f8103 100644
--- a/configure.ac
+++ b/configure.ac
@@ -70,7 +70,9 @@ if test x$bat = xtrue; then
   FFTW_INC=""
   FFTW_LIB=""
   FFTW_CFLAGS=""
-  AC_CHECK_LIB([fftw3], [fftw_malloc], , [AC_MSG_ERROR([Error: need FFTW3 library])])
+  dnl Check for libfftw3
+  have_libfftw3="yes"
+  AC_CHECK_LIB([fftw3], [fftw_malloc], , [have_libfftw3="no"])
   AC_CHECK_LIB([m], [sqrtf], , [AC_MSG_ERROR([Error: Need sqrtf])])
   AC_CHECK_LIB([pthread], [pthread_create], , [AC_MSG_ERROR([Error: need PTHREAD library])])
   FFTW_CFLAGS="$CFLAGS"
@@ -83,6 +85,7 @@ if test x$bat = xtrue; then
   AC_SUBST(FFTW_CFLAGS)
 
 fi
+AM_CONDITIONAL(HAVE_LIBFFTW3, test "$have_libfftw3" = "yes")
 
 dnl Check for librt
 LIBRT=""
-- 
2.5.0
