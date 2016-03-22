From: han.lu@intel.com
Subject: [PATCH 5/6] alsabat: move alsa process to alsa.c
Date: Tue, 22 Mar 2016 13:10:28 +0800
Message-ID: <3e5babc3e79ce22d8e98608036c378a892f4bd6a.1458623090.git.han.lu@intel.com>
References: <cover.1458623090.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5493F26172C
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 06:09:06 +0100 (CET)
In-Reply-To: <cover.1458623090.git.han.lu@intel.com>
In-Reply-To: <cover.1458623090.git.han.lu@intel.com>
References: <cover.1458623090.git.han.lu@intel.com>
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

Move all alsa callings to alsa.c and only keep common processes in
main frame.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 94f47f4..75158cb 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -40,15 +40,49 @@ struct pcm_container {
 	char *buffer;
 };
 
+struct format_map_table {
+	enum _bat_pcm_format format_bat;
+	snd_pcm_format_t format_alsa;
+};
+
+static struct format_map_table map_tables[] = {
+	{ BAT_PCM_FORMAT_UNKNOWN, SND_PCM_FORMAT_UNKNOWN },
+	{ BAT_PCM_FORMAT_U8, SND_PCM_FORMAT_U8 },
+	{ BAT_PCM_FORMAT_S16_LE, SND_PCM_FORMAT_S16_LE },
+	{ BAT_PCM_FORMAT_S24_3LE, SND_PCM_FORMAT_S24_3LE },
+	{ BAT_PCM_FORMAT_S32_LE, SND_PCM_FORMAT_S32_LE },
+	{ BAT_PCM_FORMAT_MAX, },
+};
+
+static int format_convert(struct bat *bat, snd_pcm_format_t *fmt)
+{
+	struct format_map_table *t = map_tables;
+
+	for (; t->format_bat != BAT_PCM_FORMAT_MAX; t++) {
+		if (t->format_bat == bat->format) {
+			*fmt = t->format_alsa;
+			return 0;
+		}
+	}
+	fprintf(bat->err, _("Invalid format!\n"));
+	return -EINVAL;
+}
+
 static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 {
 	snd_pcm_hw_params_t *params;
+	snd_pcm_format_t format;
 	unsigned int buffer_time = 0;
 	unsigned int period_time = 0;
 	unsigned int rate;
 	int err;
 	const char *device_name = snd_pcm_name(sndpcm->handle);
 
+	/* Convert common format to ALSA format */
+	err = format_convert(bat, &format);
+	if (err != 0)
+		return err;
+
 	/* Allocate a hardware parameters object. */
 	snd_pcm_hw_params_alloca(&params);
 
@@ -72,11 +106,10 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 	}
 
 	/* Set format */
-	err = snd_pcm_hw_params_set_format(sndpcm->handle, params, bat->format);
+	err = snd_pcm_hw_params_set_format(sndpcm->handle, params, format);
 	if (err < 0) {
 		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("PCM format: %d %s: %s(%d)\n"),
-				bat->format,
+		fprintf(bat->err, _("PCM format: %d %s: %s(%d)\n"), format,
 				device_name, snd_strerror(err), err);
 		return err;
 	}
@@ -181,7 +214,7 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 		return -EINVAL;
 	}
 
-	err = snd_pcm_format_physical_width(bat->format);
+	err = snd_pcm_format_physical_width(format);
 	if (err < 0) {
 		fprintf(bat->err, _("Invalid parameters: "));
 		fprintf(bat->err, _("snd_pcm_format_physical_width: %d\n"),
diff --git a/bat/bat.c b/bat/bat.c
index 85a7282..f10c647 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -92,37 +92,30 @@ static void get_sine_frequencies(struct bat *bat, char *freq)
 static void get_format(struct bat *bat, char *optarg)
 {
 	if (strcasecmp(optarg, "cd") == 0) {
-		bat->format = SND_PCM_FORMAT_S16_LE;
+		bat->format = BAT_PCM_FORMAT_S16_LE;
 		bat->rate = 44100;
 		bat->channels = 2;
+		bat->sample_size = 2;
 	} else if (strcasecmp(optarg, "dat") == 0) {
-		bat->format = SND_PCM_FORMAT_S16_LE;
+		bat->format = BAT_PCM_FORMAT_S16_LE;
 		bat->rate = 48000;
 		bat->channels = 2;
-	} else {
-		bat->format = snd_pcm_format_value(optarg);
-		if (bat->format == SND_PCM_FORMAT_UNKNOWN) {
-			fprintf(bat->err, _("wrong extended format '%s'\n"),
-					optarg);
-			exit(EXIT_FAILURE);
-		}
-	}
-
-	switch (bat->format) {
-	case SND_PCM_FORMAT_U8:
+		bat->sample_size = 2;
+	} else if (strcasecmp(optarg, "U8") == 0) {
+		bat->format = BAT_PCM_FORMAT_U8;
 		bat->sample_size = 1;
-		break;
-	case SND_PCM_FORMAT_S16_LE:
+	} else if (strcasecmp(optarg, "S16_LE") == 0) {
+		bat->format = BAT_PCM_FORMAT_S16_LE;
 		bat->sample_size = 2;
-		break;
-	case SND_PCM_FORMAT_S24_3LE:
+	} else if (strcasecmp(optarg, "S24_3LE") == 0) {
+		bat->format = BAT_PCM_FORMAT_S24_3LE;
 		bat->sample_size = 3;
-		break;
-	case SND_PCM_FORMAT_S32_LE:
+	} else if (strcasecmp(optarg, "S32_LE") == 0) {
+		bat->format = BAT_PCM_FORMAT_S32_LE;
 		bat->sample_size = 4;
-		break;
-	default:
-		fprintf(bat->err, _("unsupported format: %d\n"), bat->format);
+	} else {
+		bat->format = BAT_PCM_FORMAT_UNKNOWN;
+		fprintf(bat->err, _("wrong extended format '%s'\n"), optarg);
 		exit(EXIT_FAILURE);
 	}
 }
@@ -295,11 +288,8 @@ _("Usage: alsabat [-options]...\n"
 "      --local            internal loop, set to bypass pcm hardware devices\n"
 "      --standalone       standalone mode, to bypass analysis\n"
 ));
-	fprintf(bat->log, _("Recognized sample formats are: %s %s %s %s\n"),
-			snd_pcm_format_name(SND_PCM_FORMAT_U8),
-			snd_pcm_format_name(SND_PCM_FORMAT_S16_LE),
-			snd_pcm_format_name(SND_PCM_FORMAT_S24_3LE),
-			snd_pcm_format_name(SND_PCM_FORMAT_S32_LE));
+	fprintf(bat->log, _("Recognized sample formats are: "));
+	fprintf(bat->log, _("U8 S16_LE S24_3LE S32_LE\n"));
 	fprintf(bat->log, _("The available format shotcuts are:\n"));
 	fprintf(bat->log, _("-f cd (16 bit little endian, 44100, stereo)\n"));
 	fprintf(bat->log, _("-f dat (16 bit little endian, 48000, stereo)\n"));
@@ -314,7 +304,7 @@ static void set_defaults(struct bat *bat)
 	bat->channels = 1;
 	bat->frame_size = 2;
 	bat->sample_size = 2;
-	bat->format = SND_PCM_FORMAT_S16_LE;
+	bat->format = BAT_PCM_FORMAT_S16_LE;
 	bat->convert_float_to_sample = convert_float_to_int16;
 	bat->convert_sample_to_double = convert_int16_to_double;
 	bat->frames = bat->rate * 2;
diff --git a/bat/common.c b/bat/common.c
index 11a7e4e..d3d1f28 100644
--- a/bat/common.c
+++ b/bat/common.c
@@ -17,6 +17,7 @@
 #include <stddef.h>
 #include <stdlib.h>
 #include <stdbool.h>
+#include <errno.h>
 
 #include "aconfig.h"
 #include "gettext.h"
diff --git a/bat/common.h b/bat/common.h
index 37d1e4b..ed33d51 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -13,8 +13,6 @@
  *
  */
 
-#include <alsa/asoundlib.h>
-
 #define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav.XXXXXX"
 #define DEFAULT_DEV_NAME		"default"
 
@@ -110,6 +108,15 @@ struct wav_container {
 
 struct bat;
 
+enum _bat_pcm_format {
+	BAT_PCM_FORMAT_UNKNOWN = -1,
+	BAT_PCM_FORMAT_S16_LE = 0,
+	BAT_PCM_FORMAT_S32_LE,
+	BAT_PCM_FORMAT_U8,
+	BAT_PCM_FORMAT_S24_3LE,
+	BAT_PCM_FORMAT_MAX
+};
+
 enum _bat_op_mode {
 	MODE_UNKNOWN = -1,
 	MODE_SINGLE = 0,
@@ -142,7 +149,7 @@ struct bat {
 	int frames;			/* nb of frames */
 	int frame_size;			/* size of frame */
 	int sample_size;		/* size of sample */
-	snd_pcm_format_t format;	/* PCM format */
+	enum _bat_pcm_format format;	/* PCM format */
 
 	float sigma_k;			/* threshold for peak detection */
 	float target_freq[MAX_CHANNELS];
diff --git a/bat/signal.c b/bat/signal.c
index 8026a35..a47ba97 100644
--- a/bat/signal.c
+++ b/bat/signal.c
@@ -23,9 +23,11 @@
 #include <stdio.h>
 #include <stddef.h>
 #include <stdlib.h>
+#include <string.h>
 #include <math.h>
 #include <stdint.h>
 #include <stdbool.h>
+#include <errno.h>
 
 #include "gettext.h"
 #include "common.h"
@@ -113,22 +115,21 @@ static int adjust_waveform(struct bat *bat, float *val, int frames)
 	float factor, offset = 0.0;
 
 	switch (bat->format) {
-	case SND_PCM_FORMAT_U8:
+	case BAT_PCM_FORMAT_U8:
 		max = INT8_MAX;
 		offset = max;	/* shift for unsigned format */
 		break;
-	case SND_PCM_FORMAT_S16_LE:
+	case BAT_PCM_FORMAT_S16_LE:
 		max  = INT16_MAX;
 		break;
-	case SND_PCM_FORMAT_S24_3LE:
+	case BAT_PCM_FORMAT_S24_3LE:
 		max = (1 << 23) - 1;
 		break;
-	case SND_PCM_FORMAT_S32_LE:
+	case BAT_PCM_FORMAT_S32_LE:
 		max = INT32_MAX;
 		break;
 	default:
-		fprintf(bat->err, _("Invalid PCM format: %s\n"),
-				snd_pcm_format_name(bat->format));
+		fprintf(bat->err, _("Invalid PCM format: %d\n"), bat->format);
 		return -EINVAL;
 	}
 
-- 
2.5.0
