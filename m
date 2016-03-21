From: han.lu@intel.com
Subject: [PATCH 1/3] alsabat: fix misusing of errno
Date: Mon, 21 Mar 2016 19:05:47 +0800
Message-ID: <56ab78e9851c04f74b40dd958c650d586678a6a7.1458558001.git.han.lu@intel.com>
References: <cover.1458558001.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9884F261A0D
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 12:04:20 +0100 (CET)
In-Reply-To: <cover.1458558001.git.han.lu@intel.com>
In-Reply-To: <cover.1458558001.git.han.lu@intel.com>
References: <cover.1458558001.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Preserve errno value before use, since the value might be
changed by another library call.
Add "#include <errno.h>" and remove redundant include.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 5775748..638012a 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -19,6 +19,7 @@
 #include <math.h>
 #include <stdint.h>
 #include <pthread.h>
+#include <errno.h>
 
 #include <alsa/asoundlib.h>
 
@@ -300,17 +301,17 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 
 	if (bat->debugplay) {
 		fp = fopen(bat->debugplay, "wb");
+		err = -errno;
 		if (fp == NULL) {
 			fprintf(bat->err, _("Cannot open file for capture: "));
-			fprintf(bat->err, _("%s %d\n"), bat->debugplay, -errno);
-			return -errno;
+			fprintf(bat->err, _("%s %d\n"), bat->debugplay, err);
+			return err;
 		}
 		/* leave space for wav header */
-		err = fseek(fp, sizeof(wav), SEEK_SET);
-		if (err != 0) {
-			fprintf(bat->err, _("Seek file error: %d %d\n"),
-					err, -errno);
-			return -errno;
+		if (fseek(fp, sizeof(wav), SEEK_SET) != 0) {
+			err = -errno;
+			fclose(fp);
+			return err;
 		}
 	}
 
@@ -401,10 +402,11 @@ void *playback_alsa(struct bat *bat)
 		fprintf(bat->log, _("Playing input audio file: %s\n"),
 				bat->playback.file);
 		bat->fp = fopen(bat->playback.file, "rb");
+		err = -errno;
 		if (bat->fp == NULL) {
 			fprintf(bat->err, _("Cannot open file for capture: "));
 			fprintf(bat->err, _("%s %d\n"),
-					bat->playback.file, -errno);
+					bat->playback.file, err);
 			retval_play = 1;
 			goto exit3;
 		}
@@ -544,9 +546,10 @@ void *record_alsa(struct bat *bat)
 
 	remove(bat->capture.file);
 	fp = fopen(bat->capture.file, "w+");
+	err = -errno;
 	if (fp == NULL) {
 		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
-				bat->capture.file, -errno);
+				bat->capture.file, err);
 		retval_record = 1;
 		goto exit3;
 	}
diff --git a/bat/analyze.c b/bat/analyze.c
index 5cfdac3..63481fb 100644
--- a/bat/analyze.c
+++ b/bat/analyze.c
@@ -294,10 +294,10 @@ int analyze_capture(struct bat *bat)
 		return -ENOMEM;
 
 	bat->fp = fopen(bat->capture.file, "rb");
+	err = -errno;
 	if (bat->fp == NULL) {
 		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
-				bat->capture.file, -errno);
-		err = -errno;
+				bat->capture.file, err);
 		goto exit1;
 	}
 
diff --git a/bat/bat.c b/bat/bat.c
index 85ec5aa..4821532 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -39,13 +39,15 @@
 
 static int get_duration(struct bat *bat)
 {
+	int err;
 	float duration_f;
 	long duration_i;
 	char *ptrf, *ptri;
 
 	duration_f = strtof(bat->narg, &ptrf);
+	err = -errno;
 	if (duration_f == HUGE_VALF || duration_f == -HUGE_VALF
-			|| (duration_f == 0.0 && errno != 0))
+			|| (duration_f == 0.0 && err != 0))
 		goto err_exit;
 
 	duration_i = strtol(bat->narg, &ptri, 10);
@@ -68,9 +70,9 @@ static int get_duration(struct bat *bat)
 	return 0;
 
 err_exit:
-	fprintf(bat->err, _("Duration overflow/underflow: %d\n"), -errno);
+	fprintf(bat->err, _("Duration overflow/underflow: %d\n"), err);
 
-	return -errno;
+	return err;
 }
 
 static void get_sine_frequencies(struct bat *bat, char *freq)
@@ -458,17 +460,18 @@ static int validate_options(struct bat *bat)
 static int bat_init(struct bat *bat)
 {
 	int err = 0;
+	int fd = 0;
 	char name[] = TEMP_RECORD_FILE_NAME;
 
 	/* Determine logging to a file or stdout and stderr */
 	if (bat->logarg) {
 		bat->log = NULL;
 		bat->log = fopen(bat->logarg, "wb");
+		err = -errno;
 		if (bat->log == NULL) {
 			fprintf(bat->err, _("Cannot open file for capture:"));
-			fprintf(bat->err, _(" %s %d\n"),
-					bat->logarg, -errno);
-			return -errno;
+			fprintf(bat->err, _(" %s %d\n"), bat->logarg, err);
+			return err;
 		}
 		bat->err = bat->log;
 	}
@@ -489,18 +492,20 @@ static int bat_init(struct bat *bat)
 		bat->capture.file = bat->playback.file;
 	} else {
 		/* create temp file for sound record and analysis */
-		err = mkstemp(name);
-		if (err == -1) {
+		fd = mkstemp(name);
+		err = -errno;
+		if (fd == -1) {
 			fprintf(bat->err, _("Fail to create record file: %d\n"),
-					-errno);
-			return -errno;
+					err);
+			return err;
 		}
 		/* store file name which is dynamically created */
 		bat->capture.file = strdup(name);
+		err = -errno;
 		if (bat->capture.file == NULL)
-			return -errno;
+			return err;
 		/* close temp file */
-		close(err);
+		close(fd);
 	}
 
 	/* Initial for playback */
@@ -526,11 +531,12 @@ static int bat_init(struct bat *bat)
 		}
 	} else {
 		bat->fp = fopen(bat->playback.file, "rb");
+		err = -errno;
 		if (bat->fp == NULL) {
 			fprintf(bat->err, _("Cannot open file for playback:"));
 			fprintf(bat->err, _(" %s %d\n"),
-					bat->playback.file, -errno);
-			return -errno;
+					bat->playback.file, err);
+			return err;
 		}
 		err = read_wav_header(bat, bat->playback.file, bat->fp, false);
 		fclose(bat->fp);
diff --git a/bat/common.c b/bat/common.c
index 798b00b..41aaf3a 100644
--- a/bat/common.c
+++ b/bat/common.c
@@ -17,7 +17,6 @@
 #include <stddef.h>
 #include <stdlib.h>
 #include <stdbool.h>
-#include <errno.h>
 
 #include "aconfig.h"
 #include "gettext.h"
-- 
2.5.0
