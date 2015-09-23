From: han.lu@intel.com
Subject: [PATCH V2 2/7] BAT: Add common definitions and
	functions
Date: Wed, 23 Sep 2015 15:48:50 +0800
Message-ID: <45f232d5170199a9ee31b39e47f173100927422b.1442993440.git.han.lu@intel.com>
References: <cover.1442993440.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A510426518B
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 09:51:13 +0200 (CEST)
In-Reply-To: <cover.1442993440.git.han.lu@intel.com>
In-Reply-To: <cover.1442993440.git.han.lu@intel.com>
References: <cover.1442993440.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, caleb@crome.org, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Add common definitions of macros and data structures; Add functions
that used by multiple components, such as wav file reading and writing.

Signed-off-by: Lu, Han <han.lu@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bernard Gautier <bernard.gautier@intel.com>

diff --git a/bat/common.c b/bat/common.c
new file mode 100644
index 0000000..798b00b
--- /dev/null
+++ b/bat/common.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright (C) 2013-2015 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <stdio.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+
+#include "aconfig.h"
+#include "gettext.h"
+
+#include "common.h"
+#include "alsa.h"
+
+int retval_play;
+int retval_record;
+
+/* update chunk_fmt data to bat */
+static int update_fmt_to_bat(struct bat *bat, struct chunk_fmt *fmt)
+{
+	bat->channels = fmt->channels;
+	bat->rate = fmt->sample_rate;
+	bat->sample_size = fmt->sample_length / 8;
+	if (bat->sample_size > 4) {
+		fprintf(bat->err, _("Invalid format: sample size=%d\n"),
+				bat->sample_size);
+		return -EINVAL;
+	}
+	bat->frame_size = fmt->blocks_align;
+
+	return 0;
+}
+
+/* calculate frames and update to bat */
+static int update_frames_to_bat(struct bat *bat,
+		struct wav_chunk_header *header, FILE *fp)
+{
+	/* The number of analyzed captured frames is arbitrarily set to half of
+	   the number of frames of the wav file or the number of frames of the
+	   wav file when doing direct analysis (--local) */
+	bat->frames = header->length / bat->frame_size;
+	if (!bat->local)
+		bat->frames /= 2;
+
+	return 0;
+}
+
+static int read_chunk_fmt(struct bat *bat, char *file, FILE *fp, bool skip,
+		struct wav_chunk_header *header)
+{
+	size_t err;
+	int header_skip;
+	struct chunk_fmt chunk_fmt;
+
+	err = fread(&chunk_fmt, sizeof(chunk_fmt), 1, fp);
+	if (err != 1) {
+		fprintf(bat->err, _("Read chunk fmt error: %s:%zd\n"),
+				file, err);
+		return -EIO;
+	}
+	/* If the format header is larger, skip the rest */
+	header_skip = header->length - sizeof(chunk_fmt);
+	if (header_skip > 0) {
+		err = fseek(fp, header_skip, SEEK_CUR);
+		if (err == -1) {
+			fprintf(bat->err, _("Seek fmt header error: %s:%zd\n"),
+					file, err);
+			return -EINVAL;
+		}
+	}
+	/* If the file is opened for playback, update BAT data;
+	   If the file is opened for analysis, no update */
+	if (skip == false) {
+		err = update_fmt_to_bat(bat, &chunk_fmt);
+		if (err != 0)
+			return err;
+	}
+
+	return 0;
+}
+
+int read_wav_header(struct bat *bat, char *file, FILE *fp, bool skip)
+{
+	struct wav_header riff_wave_header;
+	struct wav_chunk_header chunk_header;
+	int more_chunks = 1;
+	size_t err;
+
+	/* Read header of RIFF wav file */
+	err = fread(&riff_wave_header, sizeof(riff_wave_header), 1, fp);
+	if (err != 1) {
+		fprintf(bat->err, _("Read header error: %s:%zd\n"), file, err);
+		return -EIO;
+	}
+	if ((riff_wave_header.magic != WAV_RIFF)
+			|| (riff_wave_header.type != WAV_WAVE)) {
+		fprintf(bat->err, _("%s is not a riff/wave file\n"), file);
+		return -EINVAL;
+	}
+
+	/* Read chunks in RIFF wav file */
+	do {
+		err = fread(&chunk_header, sizeof(chunk_header), 1, fp);
+		if (err != 1) {
+			fprintf(bat->err, _("Read chunk header error: "));
+			fprintf(bat->err, _("%s:%zd\n"), file, err);
+			return -EIO;
+		}
+
+		switch (chunk_header.type) {
+		case WAV_FMT:
+			/* WAV_FMT chunk, read and analyze */
+			err = read_chunk_fmt(bat, file, fp, skip,
+					&chunk_header);
+			if (err != 0)
+				return err;
+			break;
+		case WAV_DATA:
+			/* WAV_DATA chunk, break looping */
+			/* If the file is opened for playback, update BAT data;
+			   If the file is opened for analysis, no update */
+			if (skip == false) {
+				err = update_frames_to_bat(bat, &chunk_header,
+						fp);
+				if (err != 0)
+					return err;
+			}
+			/* Stop looking for chunks */
+			more_chunks = 0;
+			break;
+		default:
+			/* Unknown chunk, skip bytes */
+			err = fseek(fp, chunk_header.length, SEEK_CUR);
+			if (err == -1) {
+				fprintf(bat->err, _("Fail to skip unknown"));
+				fprintf(bat->err, _(" chunk of %s:%zd\n"),
+						file, err);
+				return -EINVAL;
+			}
+		}
+	} while (more_chunks);
+
+	return 0;
+}
+
+void prepare_wav_info(struct wav_container *wav, struct bat *bat)
+{
+	wav->header.magic = WAV_RIFF;
+	wav->header.type = WAV_WAVE;
+	wav->format.magic = WAV_FMT;
+	wav->format.fmt_size = 16;
+	wav->format.format = WAV_FORMAT_PCM;
+	wav->format.channels = bat->channels;
+	wav->format.sample_rate = bat->rate;
+	wav->format.sample_length = bat->sample_size * 8;
+	wav->format.blocks_align = bat->channels * bat->sample_size;
+	wav->format.bytes_p_second = wav->format.blocks_align * bat->rate;
+	wav->chunk.length = bat->frames * bat->frame_size;
+	wav->chunk.type = WAV_DATA;
+	wav->header.length = (wav->chunk.length) + sizeof(wav->chunk)
+			+ sizeof(wav->format) + sizeof(wav->header) - 8;
+}
+
+int write_wav_header(FILE *fp, struct wav_container *wav, struct bat *bat)
+{
+	int err = 0;
+
+	err = fwrite(&wav->header, 1, sizeof(wav->header), fp);
+	if (err != sizeof(wav->header)) {
+		fprintf(bat->err, _("Write file error: header %d\n"), err);
+		return -EIO;
+	}
+	err = fwrite(&wav->format, 1, sizeof(wav->format), fp);
+	if (err != sizeof(wav->format)) {
+		fprintf(bat->err, _("Write file error: format %d\n"), err);
+		return -EIO;
+	}
+	err = fwrite(&wav->chunk, 1, sizeof(wav->chunk), fp);
+	if (err != sizeof(wav->chunk)) {
+		fprintf(bat->err, _("Write file error: chunk %d\n"), err);
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/bat/common.h b/bat/common.h
new file mode 100644
index 0000000..e6ff7f1
--- /dev/null
+++ b/bat/common.h
@@ -0,0 +1,176 @@
+/*
+ * Copyright (C) 2013-2015 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <alsa/asoundlib.h>
+
+#define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav"
+
+#define OPT_BASE			300
+#define OPT_LOG				(OPT_BASE + 1)
+#define OPT_READFILE			(OPT_BASE + 2)
+#define OPT_SAVEPLAY			(OPT_BASE + 3)
+#define OPT_LOCAL			(OPT_BASE + 4)
+
+#define COMPOSE(a, b, c, d)		((a) | ((b)<<8) | ((c)<<16) | ((d)<<24))
+#define WAV_RIFF			COMPOSE('R', 'I', 'F', 'F')
+#define WAV_WAVE			COMPOSE('W', 'A', 'V', 'E')
+#define WAV_FMT				COMPOSE('f', 'm', 't', ' ')
+#define WAV_DATA			COMPOSE('d', 'a', 't', 'a')
+#define WAV_FORMAT_PCM			1	/* PCM WAVE file encoding */
+
+#define MAX_CHANNELS			2
+#define MIN_CHANNELS			1
+#define MAX_PEAKS			10
+#define MAX_FRAMES			(10 * 1024 * 1024)
+/* Given in ms */
+#define CAPTURE_DELAY			500
+/* signal frequency should be less than samplerate * RATE_FACTOR */
+#define RATE_FACTOR			0.4
+/* valid range of samplerate: (1 - RATE_RANGE, 1 + RATE_RANGE) * samplerate */
+#define RATE_RANGE			0.05
+/* Given in us */
+#define MAX_BUFFERTIME			500000
+/* devide factor, was 4, changed to 8 to remove reduce capture overrun */
+#define DIV_BUFFERTIME			8
+/* margin to avoid sign inversion when generate sine wav */
+#define RANGE_FACTOR			0.95
+
+#define EBATBASE			1000
+#define ENOPEAK				(EBATBASE + 1)
+#define EONLYDC				(EBATBASE + 2)
+#define EBADPEAK			(EBATBASE + 3)
+
+#define DC_THRESHOLD			7.01
+
+/* tolerance of detected peak = max (DELTA_HZ, DELTA_RATE * target_freq).
+ * If DELTA_RATE is too high, BAT may not be able to recognize negative result;
+ * if too low, BAT may be too sensitive and results in uncecessary failure. */
+#define DELTA_RATE			0.005
+#define DELTA_HZ			1
+
+#define FOUND_DC			(1<<1)
+#define FOUND_WRONG_PEAK		(1<<0)
+
+struct wav_header {
+	unsigned int magic; /* 'RIFF' */
+	unsigned int length; /* file len */
+	unsigned int type; /* 'WAVE' */
+};
+
+struct wav_chunk_header {
+	unsigned int type; /* 'data' */
+	unsigned int length; /* sample count */
+};
+
+struct wav_fmt {
+	unsigned int magic; /* 'FMT '*/
+	unsigned int fmt_size; /* 16 or 18 */
+	unsigned short format; /* see WAV_FMT_* */
+	unsigned short channels;
+	unsigned int sample_rate; /* Frequency of sample */
+	unsigned int bytes_p_second;
+	unsigned short blocks_align; /* sample size; 1 or 2 bytes */
+	unsigned short sample_length; /* 8, 12 or 16 bit */
+};
+
+struct chunk_fmt {
+	unsigned short format; /* see WAV_FMT_* */
+	unsigned short channels;
+	unsigned int sample_rate; /* Frequency of sample */
+	unsigned int bytes_p_second;
+	unsigned short blocks_align; /* sample size; 1 or 2 bytes */
+	unsigned short sample_length; /* 8, 12 or 16 bit */
+};
+
+struct wav_container {
+	struct wav_header header;
+	struct wav_fmt format;
+	struct wav_chunk_header chunk;
+};
+
+struct bat;
+
+enum _bat_op_mode {
+	MODE_UNKNOWN = -1,
+	MODE_SINGLE = 0,
+	MODE_LOOPBACK,
+	MODE_LAST
+};
+
+struct pcm {
+	char *device;
+	char *file;
+	enum _bat_op_mode mode;
+	void *(*fct)(struct bat *);
+};
+
+struct sin_generator;
+
+struct sin_generator {
+	double state_real;
+	double state_imag;
+	double phasor_real;
+	double phasor_imag;
+	float frequency;
+	float sample_rate;
+	float magnitude;
+};
+
+struct bat {
+	unsigned int rate;		/* sampling rate */
+	int channels;			/* nb of channels */
+	int frames;			/* nb of frames */
+	int frame_size;			/* size of frame */
+	int sample_size;		/* size of sample */
+	snd_pcm_format_t format;	/* PCM format */
+
+	float sigma_k;			/* threshold for peak detection */
+	float target_freq[MAX_CHANNELS];
+
+	int sinus_duration;		/* number of frames for playback */
+	char *narg;			/* argument string of duration */
+	char *logarg;			/* path name of log file */
+	char *debugplay;		/* path name to store playback signal */
+
+	struct pcm playback;
+	struct pcm capture;
+
+	unsigned int periods_played;
+	unsigned int periods_total;
+	bool period_is_limited;
+
+	FILE *fp;
+
+	FILE *log;
+	FILE *err;
+
+	void (*convert_sample_to_double)(void *, double *, int);
+	void (*convert_float_to_sample)(float *, void *, int, int);
+
+	void *buf;			/* PCM Buffer */
+
+	bool local;			/* true for internal test */
+};
+
+struct analyze {
+	void *buf;
+	double *in;
+	double *out;
+	double *mag;
+};
+
+void prepare_wav_info(struct wav_container *, struct bat *);
+int read_wav_header(struct bat *, char *, FILE *, bool);
+int write_wav_header(FILE *, struct wav_container *, struct bat *);
-- 
1.9.1
