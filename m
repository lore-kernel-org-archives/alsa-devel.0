From: Zhang Keqiao <keqiao.zhang@intel.com>
Subject: [PATCH v1 3/4] alsabat: add XRUN injections function
Date: Thu, 31 Aug 2017 21:37:08 +0800
Message-ID: <20170831133709.25537-4-keqiao.zhang@intel.com>
References: <20170831133709.25537-1-keqiao.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 638632673CC
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 15:40:43 +0200 (CEST)
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

This patch add XRUN injections function, alsabat can trigger the XRUNs
by writing the 'XRUN INJECTION' files.

Signed-off-by: Zhang Keqiao <keqiao.zhang@intel.com>
---
 bat/bat.c    | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 bat/common.h |  6 ++++
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/bat/bat.c b/bat/bat.c
index b12e5d3..20fa926 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -127,8 +127,81 @@ static void get_sine_frequencies(struct bat *bat, char *freq)
 	}
 }
 
-/* parse the card and pcm ID of playback device and capture device */
-/* Then we can get the path for specify device to do the XRUN injection */
+static int xrun_injection(struct bat *bat)
+{
+	char playback_file[MAX_PATH + MAX_FILE];
+	char capture_file[MAX_PATH + MAX_FILE];
+	char filename[MAX_FILE] = XRUN_INJECTION_FILE;
+	char playback_filepath[MAX_PATH] = PLAYBACK_XRUN_INJECTION_PATH;
+	char capture_filepath[MAX_PATH] = CAPTURE_XRUN_INJECTION_PATH;
+	FILE *fp, *fc;
+
+	if (bat->xrun_playback) {
+		/* replace the card ID and PCM ID in macro for xrun injection path */
+		sprintf(playback_filepath, playback_filepath, bat->playback.card_id,
+				bat->playback.pcm_id);
+		sprintf(playback_file, "%s/%s", playback_filepath, filename);
+		bat->playback.xrun_file = playback_file;
+
+		fp = fopen(playback_file, "w");
+		if (fp == NULL) {
+			fprintf(bat->err, _("Can't open the XRUN injection file for playback: %s\n"),
+					playback_file);
+			return -ENOENT; /* No such file or directory */
+		}
+
+		/* enable XRUN for playback */
+		fputs("1", fp);
+		fclose(fp);
+	}
+
+	if (bat->xrun_capture) {
+		/* replace the card ID and PCM ID in macro for xrun injection path */
+		sprintf(capture_filepath, capture_filepath, bat->capture.card_id,
+				bat->capture.pcm_id);
+		sprintf(capture_file, "%s/%s", capture_filepath, filename);
+
+		fc = fopen(capture_file, "w");
+		if (fc == NULL) {
+			fprintf(bat->err, _("Can't open the XRUN injection file for capture: %s\n"),
+					capture_file);
+			return -ENOENT; /* No such file or directory */
+		}
+
+		/* enable XRUN for capture */
+		fputs("1", fc);
+		fclose(fc);
+	}
+
+	return 0;
+}
+
+static int check_xrun_period(struct bat *bat)
+{
+	int duration_t;
+	float duration_p;
+	char *ptrf;
+
+	duration_t = (bat->frames / bat->rate) * 1000;
+	duration_p = strtof(bat->xarg, &ptrf);
+	bat->xrun_period = duration_p;
+	if (bat->xrun_period < 1 || bat->xrun_period > duration_t) {
+		fprintf(bat->err, _("Invalid period for xrun injections: (1, %d)\n"),
+				duration_t);
+	return -EINVAL;
+	}
+
+	if (*ptrf == 'p')
+		bat->xrun_playback = 1;
+	else if (*ptrf == 'c')
+		bat->xrun_capture = 1;
+	else
+		bat->xrun_playback = bat->xrun_capture = 1;
+	return 0;
+}
+
+/* parse the card and pcm ID of playback device and capture device, then */
+/* we can get the path for the specify device to do the XRUN injection */
 static int parse_card_and_pcm_id(struct bat *bat)
 {
 	char *tmp1;
@@ -187,6 +260,7 @@ static int parse_card_and_pcm_id(struct bat *bat)
 			return -EINVAL;
 		}
 	}
+
 	return 0;
 }
 
@@ -238,6 +312,7 @@ static void test_loopback(struct bat *bat)
 {
 	pthread_t capture_id, playback_id;
 	int err;
+	int timeout = 0;
 	int *thread_result_capture, *thread_result_playback;
 
 	/* start playback */
@@ -261,6 +336,20 @@ static void test_loopback(struct bat *bat)
 		exit(EXIT_FAILURE);
 	}
 
+	/* check for xrun injections */
+	while (bat->xrun_period) {
+		/* inject 1 XRUN every set time */
+		usleep(bat->xrun_period * 1000);
+		timeout = timeout + (bat->xrun_period);
+		err = xrun_injection(bat);
+		if (err < 0) {
+			fprintf(bat->err, _("XRUN injections error: %d\n"), err);
+			exit(EXIT_FAILURE);
+		}
+		if (timeout >= ((bat->frames / bat->rate) * 1000))
+			break;
+	}
+
 	/* wait for playback to complete */
 	err = thread_wait_completion(bat, playback_id, &thread_result_playback);
 	if (err != 0) {
@@ -625,6 +714,10 @@ static int bat_init(struct bat *bat)
 	}
 
 	if (bat->xarg) {
+		err = check_xrun_period(bat);
+		if (err < 0)
+			return err;
+
 		err = parse_card_and_pcm_id(bat);
 		if (err < 0)
 			return err;
diff --git a/bat/common.h b/bat/common.h
index 9f71c6c..6eebba0 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -15,6 +15,11 @@
 
 #define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav.XXXXXX"
 #define DEFAULT_DEV_NAME		"default"
+#define PLAYBACK_XRUN_INJECTION_PATH	"/proc/asound/card%s/pcm%sp/sub0"
+#define CAPTURE_XRUN_INJECTION_PATH	"/proc/asound/card%s/pcm%sc/sub0"
+#define XRUN_INJECTION_FILE		"xrun_injection"
+#define MAX_PATH   256
+#define MAX_FILE   128
 
 #define MAX_DEV				15
 #define OPT_BASE			300
@@ -170,6 +175,7 @@ struct pcm {
 	char *file;
 	char *pcm_id;
 	char *card_id;
+	char *xrun_file;
 	enum _bat_op_mode mode;
 	void *(*fct)(struct bat *);
 };
-- 
2.9.3
