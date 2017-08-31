From: Zhang Keqiao <keqiao.zhang@intel.com>
Subject: [PATCH v1 2/4] alsabat: parse the card and PCM ID for
	XRUN injections path
Date: Thu, 31 Aug 2017 21:37:07 +0800
Message-ID: <20170831133709.25537-3-keqiao.zhang@intel.com>
References: <20170831133709.25537-1-keqiao.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 22D912673C7
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

This patch intends to parse the card ID and PCM ID of playback
and capture, then replace it in the path macro.

Signed-off-by: Zhang Keqiao <keqiao.zhang@intel.com>
---
 bat/bat.c    | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bat/common.h |  3 +++
 2 files changed, 72 insertions(+)

diff --git a/bat/bat.c b/bat/bat.c
index bf6873a..b12e5d3 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -127,6 +127,69 @@ static void get_sine_frequencies(struct bat *bat, char *freq)
 	}
 }
 
+/* parse the card and pcm ID of playback device and capture device */
+/* Then we can get the path for specify device to do the XRUN injection */
+static int parse_card_and_pcm_id(struct bat *bat)
+{
+	char *tmp1;
+	char *tmp2;
+	char playback_device[MAX_DEV];
+	char capture_device[MAX_DEV];
+
+	strcpy(playback_device, bat->playback.device);
+	strcpy(capture_device, bat->capture.device);
+
+	if (bat->playback.device == bat->capture.device) {
+		tmp1 = strchr(playback_device, ',');
+		if (tmp1 != NULL) {
+			*tmp1 = '\0';
+			bat->playback.pcm_id = bat->capture.pcm_id = (tmp1 + 1);
+		} else {
+			fprintf(bat->err, _("err, cannot find the pcm ID\n"));
+			return -EINVAL;
+		}
+		tmp2 = strchr(playback_device, ':');
+		if (tmp2 != NULL) {
+			bat->playback.card_id = bat->capture.card_id = (tmp2 + 1);
+		} else {
+			fprintf(bat->err, _("err, cannot find the card ID\n"));
+			return -EINVAL;
+		}
+	} else {
+		tmp1 = strchr(playback_device, ',');
+		if (tmp1 != NULL) {
+			*tmp1 = '\0';
+			bat->playback.pcm_id = (tmp1 + 1);
+		} else {
+			fprintf(bat->err, _("err, cannot find the pcm ID of playback\n"));
+			return -EINVAL;
+		}
+		tmp2 = strchr(playback_device, ':');
+		if (tmp2 != NULL)
+			bat->playback.card_id = (tmp2 + 1);
+		else {
+			fprintf(bat->err, _("err, cannot find the card ID of playback\n"));
+			return -EINVAL;
+		}
+		tmp1 = strchr(capture_device, ',');
+		if (tmp1 != NULL) {
+			*tmp1 = '\0';
+			bat->capture.pcm_id = (tmp1 + 1);
+		} else {
+			fprintf(bat->err, _("err, cannot find the pcm ID of capture"));
+			return -EINVAL;
+		}
+		tmp2 = strchr(capture_device, ':');
+		if (tmp2 != NULL)
+			bat->capture.card_id = (tmp2 + 1);
+		else {
+			fprintf(bat->err, _("err, cannot find the card ID of capture"));
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static void get_format(struct bat *bat, char *optarg)
 {
 	if (strcasecmp(optarg, "cd") == 0) {
@@ -561,6 +624,12 @@ static int bat_init(struct bat *bat)
 			return err;
 	}
 
+	if (bat->xarg) {
+		err = parse_card_and_pcm_id(bat);
+		if (err < 0)
+			return err;
+	}
+
 	/* Set default playback and capture devices */
 	if (bat->playback.device == NULL && bat->capture.device == NULL)
 		bat->playback.device = bat->capture.device = DEFAULT_DEV_NAME;
diff --git a/bat/common.h b/bat/common.h
index a014f87..9f71c6c 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -16,6 +16,7 @@
 #define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav.XXXXXX"
 #define DEFAULT_DEV_NAME		"default"
 
+#define MAX_DEV				15
 #define OPT_BASE			300
 #define OPT_LOG				(OPT_BASE + 1)
 #define OPT_READFILE			(OPT_BASE + 2)
@@ -167,6 +168,8 @@ struct pcm {
 	unsigned int device_tiny;
 	char *device;
 	char *file;
+	char *pcm_id;
+	char *card_id;
 	enum _bat_op_mode mode;
 	void *(*fct)(struct bat *);
 };
-- 
2.9.3
