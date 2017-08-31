From: Zhang Keqiao <keqiao.zhang@intel.com>
Subject: [PATCH v1 1/4] alsabat: add one option for XRUN
	injections
Date: Thu, 31 Aug 2017 21:37:06 +0800
Message-ID: <20170831133709.25537-2-keqiao.zhang@intel.com>
References: <20170831133709.25537-1-keqiao.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id EAF812673C4
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 15:40:41 +0200 (CEST)
In-Reply-To: <20170831133709.25537-1-keqiao.zhang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: keqiao.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

This patch add a new option '-X' to alsabat, this option allows alsabat
to do the xrun injection with given period. eg. '-X 100' means do XRUN
injections every 100ms for both playback and capture. '-X 100p/c' means
do XRUN injections every 100ms for playback/capture.

Signed-off-by: Zhang Keqiao <keqiao.zhang@intel.com>
---
 bat/bat.c    | 9 ++++++++-
 bat/common.h | 4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/bat/bat.c b/bat/bat.c
index 8645770..bf6873a 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -328,6 +328,7 @@ _("Usage: alsabat [-options]...\n"
 "  -p                     total number of periods to play/capture\n"
 "  -B                     buffer size in frames\n"
 "  -E                     period size in frames\n"
+"  -X                     period of xrun injection, given in millisecond\n"
 "      --log=#            file that both stdout and strerr redirecting to\n"
 "      --file=#           file for playback\n"
 "      --saveplay=#       file that storing playback content, for debug\n"
@@ -367,6 +368,9 @@ static void set_defaults(struct bat *bat)
 	bat->buffer_size = 0;
 	bat->period_size = 0;
 	bat->roundtriplatency = false;
+	bat->xrun_period = 0;
+	bat->xrun_playback = 0;
+	bat->xrun_capture = 0;
 #ifdef HAVE_LIBTINYALSA
 	bat->channels = 2;
 	bat->playback.fct = &playback_tinyalsa;
@@ -386,7 +390,7 @@ static void set_defaults(struct bat *bat)
 static void parse_arguments(struct bat *bat, int argc, char *argv[])
 {
 	int c, option_index, err;
-	static const char short_options[] = "D:P:C:f:n:F:c:r:s:k:p:B:E:lth";
+	static const char short_options[] = "D:P:C:f:n:F:c:r:s:k:p:B:E:X:lth";
 	static const struct option long_options[] = {
 		{"help",     0, 0, 'h'},
 		{"log",      1, 0, OPT_LOG},
@@ -479,6 +483,9 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 			bat->period_size = err >= MIN_PERIODSIZE
 					&& err < MAX_PERIODSIZE ? err : 0;
 			break;
+		case 'X':
+			bat->xarg = optarg;
+			break;
 		case 'h':
 		default:
 			usage(bat);
diff --git a/bat/common.h b/bat/common.h
index 1b07fbe..a014f87 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -214,6 +214,9 @@ struct bat {
 	enum _bat_pcm_format format;	/* PCM format */
 	int buffer_size;		/* buffer size in frames */
 	int period_size;		/* period size in frames */
+	int xrun_playback;		/* enable xrun injection for playback */
+	int xrun_capture;		/* enable xrun injection for capture */
+	int xrun_period;		/* period of XRUN injections, given in milliseconds */
 
 	float sigma_k;			/* threshold for peak detection */
 	float snr_thd_db;		/* threshold for noise detection (dB) */
@@ -221,6 +224,7 @@ struct bat {
 
 	int sinus_duration;		/* number of frames for playback */
 	char *narg;			/* argument string of duration */
+	char *xarg;			/* argument string of xrun injection */
 	char *logarg;			/* path name of log file */
 	char *debugplay;		/* path name to store playback signal */
 	bool standalone;		/* enable to bypass analysis */
-- 
2.9.3
