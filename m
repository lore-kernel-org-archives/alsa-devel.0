From: vivian.zhang@intel.com
Subject: [PATCH] alsabat: add buffer size and period size setup
	support
Date: Mon, 30 May 2016 17:07:22 +0800
Message-ID: <1464599242-8145-1-git-send-email-vivian.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F8582606B7
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 11:15:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, han.lu@intel.com, alsa-devel@alsa-project.org
Cc: "vivian,zhang" <vivian.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "vivian,zhang" <vivian.zhang@intel.com>

Signed-off-by: Zhang Vivian <vivian.zhang@intel.com>
---
 bat/alsa.c     |   95 +++++++++++++++++++++++++++++++++++++++-----------------
 bat/bat.c      |   16 ++++++++--
 bat/common.h   |    2 ++
 bat/tinyalsa.c |    5 ++-
 4 files changed, 86 insertions(+), 32 deletions(-)

diff --git a/bat/alsa.c b/bat/alsa.c
index 75158cb..167dbad 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -74,6 +74,8 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 	snd_pcm_format_t format;
 	unsigned int buffer_time = 0;
 	unsigned int period_time = 0;
+	snd_pcm_uframes_t buffer_size = 0;
+	snd_pcm_uframes_t period_size = 0;
 	unsigned int rate;
 	int err;
 	const char *device_name = snd_pcm_name(sndpcm->handle);
@@ -145,39 +147,71 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 		return -EINVAL;
 	}
 
-	if (snd_pcm_hw_params_get_buffer_time_max(params,
-			&buffer_time, 0) < 0) {
-		fprintf(bat->err, _("Get parameter from device error: "));
-		fprintf(bat->err, _("buffer time: %d %s: %s(%d)\n"),
-				buffer_time,
-				device_name, snd_strerror(err), err);
-		return -EINVAL;
-	}
+	if (bat->buffer_size > 0) {
+		if (bat->period_size == 0)
+			bat->period_size = bat->buffer_size / DIV_BUFFERTIME;
 
-	if (buffer_time > MAX_BUFFERTIME)
-		buffer_time = MAX_BUFFERTIME;
+		buffer_size = bat->buffer_size;
+		period_size = bat->period_size;
 
-	period_time = buffer_time / DIV_BUFFERTIME;
+		fprintf(bat->log, _("Set period size: %d  buffer size: %d\n"),
+				(int) period_size, (int) buffer_size);
 
-	/* Set buffer time and period time */
-	err = snd_pcm_hw_params_set_buffer_time_near(sndpcm->handle, params,
-			&buffer_time, 0);
-	if (err < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("buffer time: %d %s: %s(%d)\n"),
-				buffer_time,
-				device_name, snd_strerror(err), err);
-		return err;
-	}
+		err = snd_pcm_hw_params_set_buffer_size_near(sndpcm->handle,
+				params, &buffer_size);
+		if (err < 0) {
+			fprintf(bat->err, _("Set parameter to device error: "));
+			fprintf(bat->err, _("buffer size: %d %s: %s(%d)\n"),
+					(int) buffer_size,
+					device_name, snd_strerror(err), err);
+			return err;
+		}
 
-	err = snd_pcm_hw_params_set_period_time_near(sndpcm->handle, params,
-			&period_time, 0);
-	if (err < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("period time: %d %s: %s(%d)\n"),
-				period_time,
-				device_name, snd_strerror(err), err);
-		return err;
+		err = snd_pcm_hw_params_set_period_size_near(sndpcm->handle,
+				params, &period_size, 0);
+		if (err < 0) {
+			fprintf(bat->err, _("Set parameter to device error: "));
+			fprintf(bat->err, _("period size: %d %s: %s(%d)\n"),
+					(int) period_size,
+					device_name, snd_strerror(err), err);
+			return err;
+		}
+	} else {
+		if (snd_pcm_hw_params_get_buffer_time_max(params,
+				&buffer_time, 0) < 0) {
+			fprintf(bat->err,
+					_("Get parameter from device error: "));
+			fprintf(bat->err, _("buffer time: %d %s: %s(%d)\n"),
+					buffer_time,
+					device_name, snd_strerror(err), err);
+			return -EINVAL;
+		}
+
+		if (buffer_time > MAX_BUFFERTIME)
+			buffer_time = MAX_BUFFERTIME;
+
+		period_time = buffer_time / DIV_BUFFERTIME;
+
+		/* Set buffer time and period time */
+		err = snd_pcm_hw_params_set_buffer_time_near(sndpcm->handle,
+				params, &buffer_time, 0);
+		if (err < 0) {
+			fprintf(bat->err, _("Set parameter to device error: "));
+			fprintf(bat->err, _("buffer time: %d %s: %s(%d)\n"),
+					buffer_time,
+					device_name, snd_strerror(err), err);
+			return err;
+		}
+
+		err = snd_pcm_hw_params_set_period_time_near(sndpcm->handle,
+				params, &period_time, 0);
+		if (err < 0) {
+			fprintf(bat->err, _("Set parameter to device error: "));
+			fprintf(bat->err, _("period time: %d %s: %s(%d)\n"),
+					period_time,
+					device_name, snd_strerror(err), err);
+			return err;
+		}
 	}
 
 	/* Write the parameters to the driver */
@@ -214,6 +248,9 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 		return -EINVAL;
 	}
 
+	fprintf(bat->log, _("Get period size: %d  buffer size: %d\n"),
+			(int) sndpcm->period_size, (int) sndpcm->buffer_size);
+
 	err = snd_pcm_format_physical_width(format);
 	if (err < 0) {
 		fprintf(bat->err, _("Invalid parameters: "));
diff --git a/bat/bat.c b/bat/bat.c
index 1afdcb4..0d5aaa5 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -292,6 +292,8 @@ _("Usage: alsabat [-options]...\n"
 "  -k                     parameter for frequency detecting threshold\n"
 "  -F                     target frequency\n"
 "  -p                     total number of periods to play/capture\n"
+"  -B                     buffer size in frames\n"
+"  -E                     period size in frames\n"
 "      --log=#            file that both stdout and strerr redirecting to\n"
 "      --file=#           file for playback\n"
 "      --saveplay=#       file that storing playback content, for debug\n"
@@ -324,6 +326,8 @@ static void set_defaults(struct bat *bat)
 	bat->capture.device = NULL;
 	bat->buf = NULL;
 	bat->local = false;
+	bat->buffer_size = 0;
+	bat->period_size = 0;
 #ifdef HAVE_LIBTINYALSA
 	bat->channels = 2;
 	bat->playback.fct = &playback_tinyalsa;
@@ -342,8 +346,8 @@ static void set_defaults(struct bat *bat)
 
 static void parse_arguments(struct bat *bat, int argc, char *argv[])
 {
-	int c, option_index;
-	static const char short_options[] = "D:P:C:f:n:F:c:r:s:k:p:lth";
+	int c, option_index, err;
+	static const char short_options[] = "D:P:C:f:n:F:c:r:s:k:p:B:E:lth";
 	static const struct option long_options[] = {
 		{"help",     0, 0, 'h'},
 		{"log",      1, 0, OPT_LOG},
@@ -414,6 +418,14 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 			bat->periods_total = atoi(optarg);
 			bat->period_is_limited = true;
 			break;
+		case 'B':
+			err = atoi(optarg);
+			bat->buffer_size = err >= 32 && err < 200000 ? err : 0;
+			break;
+		case 'E':
+			err = atoi(optarg);
+			bat->period_size = err >= 32 && err < 200000 ? err : 0;
+			break;
 		case 'h':
 		default:
 			usage(bat);
diff --git a/bat/common.h b/bat/common.h
index b789af5..52c8cb1 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -152,6 +152,8 @@ struct bat {
 	int frame_size;			/* size of frame */
 	int sample_size;		/* size of sample */
 	enum _bat_pcm_format format;	/* PCM format */
+	int buffer_size;		/* buffer size in frames */
+	int period_size;		/* period size in frames */
 
 	float sigma_k;			/* threshold for peak detection */
 	float target_freq[MAX_CHANNELS];
diff --git a/bat/tinyalsa.c b/bat/tinyalsa.c
index ea5f848..faa1ad0 100644
--- a/bat/tinyalsa.c
+++ b/bat/tinyalsa.c
@@ -57,7 +57,10 @@ static int init_config(struct bat *bat, struct pcm_config *config)
 {
 	config->channels = bat->channels;
 	config->rate = bat->rate;
-	config->period_size = 1024;
+	if (bat->period_size > 0)
+		config->period_size = bat->period_size;
+	else
+		config->period_size = 1024;
 	config->period_count = 4;
 	config->start_threshold = 0;
 	config->stop_threshold = 0;
-- 
1.7.9.5
