From: vivian.zhang@intel.com
Subject: [PATCH] alsabat: add round trip audio latency test
Date: Fri,  3 Jun 2016 10:05:08 +0800
Message-ID: <1464919508-8607-1-git-send-email-vivian.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BAF352612D0
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 04:13:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, han.lu@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com
Cc: "vivian,zhang" <vivian.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "vivian,zhang" <vivian.zhang@intel.com>

Audio latency is the time delay as an audio signal passes through
a system. There are many kinds of audio latency metrics. One useful
metric is the round trip latency, which is the sum of output latency
and input latency.

The measurement step works like below:
1. Listen and measure the average loudness of the environment for
one second;
2. Create a threshold value 16 decibels higher than the average
loudness;
3. Begin playing a ~1000 Hz sine wave and start counting the samples
elapsed;
4. Stop counting and playing if the input's loudness is higher than
the threshold, as the output wave is probably coming back;
5. Calculate the audio latency value in milliseconds.

Signed-off-by: Zhang Vivian <vivian.zhang@intel.com>
---
 bat/Makefile.am     |    2 +
 bat/alsa.c          |  144 +++++++++++++++++++++++++++++-
 bat/alsabat-test.sh |    2 +
 bat/alsabat.1       |    6 ++
 bat/bat.c           |   36 ++++++++
 bat/common.h        |   29 ++++++
 bat/latencytest.c   |  242 +++++++++++++++++++++++++++++++++++++++++++++++++++
 bat/latencytest.h   |   17 ++++
 bat/tinyalsa.c      |   95 +++++++++++++++++++-
 9 files changed, 568 insertions(+), 5 deletions(-)
 create mode 100644 bat/latencytest.c
 create mode 100644 bat/latencytest.h

diff --git a/bat/Makefile.am b/bat/Makefile.am
index 24e3eb8..6883826 100644
--- a/bat/Makefile.am
+++ b/bat/Makefile.am
@@ -7,11 +7,13 @@ alsabat_SOURCES = \
 	bat.c \
 	common.c \
 	signal.c \
+	latencytest.c \
 	convert.c
 
 noinst_HEADERS = \
 	common.h \
 	bat-signal.h \
+	latencytest.h \
 	convert.h
 
 if HAVE_LIBFFTW3
diff --git a/bat/alsa.c b/bat/alsa.c
index 0a37714..cef1734 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -27,6 +27,7 @@
 
 #include "common.h"
 #include "alsa.h"
+#include "latencytest.h"
 
 struct pcm_container {
 	snd_pcm_t *handle;
@@ -148,7 +149,33 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 	}
 
 	if (bat->buffer_size > 0 && bat->period_size == 0)
-		bat->period_size = bat->buffer_size / DIV_BUFFERTIME;
+		bat->period_size = bat->buffer_size / DIV_BUFFERSIZE;
+
+	if (bat->roundtriplatency && bat->buffer_size == 0) {
+		/* Set to minimum buffer size and period size
+		   for latency test */
+		if (snd_pcm_hw_params_get_buffer_size_min(params,
+				&buffer_size) < 0) {
+			fprintf(bat->err,
+					_("Get parameter from device error: "));
+			fprintf(bat->err, _("buffer size min: %d %s: %s(%d)\n"),
+					(int) buffer_size,
+					device_name, snd_strerror(err), err);
+			return -EINVAL;
+		}
+
+		if (snd_pcm_hw_params_get_period_size_min(params,
+				&period_size, 0) < 0) {
+			fprintf(bat->err,
+					_("Get parameter from device error: "));
+			fprintf(bat->err, _("period size min: %d %s: %s(%d)\n"),
+					(int) period_size,
+					device_name, snd_strerror(err), err);
+			return -EINVAL;
+		}
+		bat->buffer_size = (int) buffer_size;
+		bat->period_size = (int) period_size;
+	}
 
 	if (bat->buffer_size > 0) {
 		buffer_size = bat->buffer_size;
@@ -289,6 +316,8 @@ static int write_to_pcm(const struct pcm_container *sndpcm,
 		} else if (err == -EPIPE) {
 			fprintf(bat->err, _("Underrun: %s(%d)\n"),
 					snd_strerror(err), err);
+			if (bat->roundtriplatency)
+				bat->latency.xrun_error = true;
 			snd_pcm_prepare(sndpcm->handle);
 		} else if (err < 0) {
 			fprintf(bat->err, _("Write PCM device error: %s(%d)\n"),
@@ -305,6 +334,43 @@ static int write_to_pcm(const struct pcm_container *sndpcm,
 	return 0;
 }
 
+/**
+ * Process output data for latency test
+ */
+static int latencytest_process_output(struct pcm_container *sndpcm,
+		struct bat *bat)
+{
+	int err = 0;
+	int bytes = sndpcm->period_bytes; /* playback buffer size */
+	int frames = sndpcm->period_size; /* frame count */
+
+	bat->latency.is_playing = true;
+
+	while (1) {
+		/* generate output data */
+		err = handleoutput(bat, sndpcm->buffer, bytes, frames);
+		if (err != 0)
+			break;
+
+		err = write_to_pcm(sndpcm, frames, bat);
+		if (err != 0)
+			break;
+
+		/* Xrun error, terminate the playback thread*/
+		if (bat->latency.xrun_error == true)
+			break;
+
+		if (bat->latency.state == LATENCY_STATE_COMPLETE_SUCCESS)
+			break;
+
+		bat->periods_played++;
+	}
+
+	bat->latency.is_playing = false;
+
+	return err;
+}
+
 static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 {
 	int err = 0;
@@ -414,7 +480,10 @@ void *playback_alsa(struct bat *bat)
 		}
 	}
 
-	err = write_to_pcm_loop(&sndpcm, bat);
+	if (bat->roundtriplatency)
+		err = latencytest_process_output(&sndpcm, bat);
+	else
+		err = write_to_pcm_loop(&sndpcm, bat);
 	if (err < 0) {
 		retval_play = err;
 		goto exit4;
@@ -447,6 +516,8 @@ static int read_from_pcm(struct pcm_container *sndpcm,
 			snd_pcm_prepare(sndpcm->handle);
 			fprintf(bat->err, _("Overrun: %s(%d)\n"),
 					snd_strerror(err), err);
+			if (bat->roundtriplatency)
+				bat->latency.xrun_error = true;
 		} else if (err < 0) {
 			fprintf(bat->err, _("Read PCM device error: %s(%d)\n"),
 					snd_strerror(err), err);
@@ -517,6 +588,70 @@ static int read_from_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 	return err;
 }
 
+/**
+ * Process input data for latency test
+ */
+static int latencytest_process_input(struct pcm_container *sndpcm,
+		struct bat *bat)
+{
+	int err = 0;
+	FILE *fp = NULL;
+	int bytes_read = 0;
+	int frames = sndpcm->period_size;
+	int size = sndpcm->period_bytes;
+	int bytes_count = bat->frames * bat->frame_size;
+
+	remove(bat->capture.file);
+	fp = fopen(bat->capture.file, "wb");
+	err = -errno;
+	if (fp == NULL) {
+		fprintf(bat->err, _("Cannot open file: %s %d\n"),
+				bat->capture.file, err);
+		return err;
+	}
+	/* leave space for file header */
+	if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
+		fclose(fp);
+		return err;
+	}
+
+	bat->latency.is_capturing = true;
+
+	while (bytes_read < bytes_count) {
+		/* read a chunk from pcm device */
+		err = read_from_pcm(sndpcm, frames, bat);
+		if (err != 0)
+			break;
+
+		/* Xrun error, terminate the capture thread*/
+		if (bat->latency.xrun_error == true)
+			break;
+
+		err = handleinput(bat, sndpcm->buffer, frames);
+		if (err != 0)
+			break;
+
+		if (bat->latency.is_playing == false)
+			break;
+
+		/* write the chunk to file */
+		if (fwrite(sndpcm->buffer, 1, size, fp) != size) {
+			err = -EIO;
+			break;
+		}
+
+		bytes_read += size;
+	}
+
+	bat->latency.is_capturing = false;
+
+	update_wav_header(bat, fp, bytes_read);
+
+	fclose(fp);
+	return err;
+}
+
+
 static void pcm_cleanup(void *p)
 {
 	snd_pcm_close(p);
@@ -558,7 +693,10 @@ void *record_alsa(struct bat *bat)
 	pthread_cleanup_push(free, sndpcm.buffer);
 
 	fprintf(bat->log, _("Recording ...\n"));
-	err = read_from_pcm_loop(&sndpcm, bat);
+	if (bat->roundtriplatency)
+		err = latencytest_process_input(&sndpcm, bat);
+	else
+		err = read_from_pcm_loop(&sndpcm, bat);
 	if (err != 0) {
 		retval_record = err;
 		goto exit3;
diff --git a/bat/alsabat-test.sh b/bat/alsabat-test.sh
index 2d31a77..24caa0b 100755
--- a/bat/alsabat-test.sh
+++ b/bat/alsabat-test.sh
@@ -81,6 +81,8 @@ feature_list_test () {
 	latestfile=`ls -t1 /tmp/bat.wav.* | head -n 1`
 	feature_test "--local -F $maxfreq --file $latestfile" \
 			"local mode: analyze local file"
+	feature_test "--roundtriplatency" \
+			"round trip latency test"
 
 	print_result
 }
diff --git a/bat/alsabat.1 b/bat/alsabat.1
index 3f9b767..231b154 100644
--- a/bat/alsabat.1
+++ b/bat/alsabat.1
@@ -132,6 +132,12 @@ just like in normal mode, but will not be analyzed.
 The ALSABAT being built without libfftw3 support is always in standalone mode.
 The ALSABAT in normal mode can also bypass data analysis using option
 "--standalone".
+.TP
+\fI\-\-roundtriplatency\fP
+Round trip latency test.
+Audio latency is the time delay as an audio signal passes through a system.
+There are many kinds of audio latency metrics. One useful metric is the
+round trip latency, which is the sum of output latency and input latency.
 
 .SH EXAMPLES
 
diff --git a/bat/bat.c b/bat/bat.c
index cd4ea2d..9f4cc59 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -40,6 +40,7 @@
 #ifdef HAVE_LIBFFTW3
 #include "analyze.h"
 #endif
+#include "latencytest.h"
 
 static int get_duration(struct bat *bat)
 {
@@ -299,6 +300,7 @@ _("Usage: alsabat [-options]...\n"
 "      --saveplay=#       file that storing playback content, for debug\n"
 "      --local            internal loop, set to bypass pcm hardware devices\n"
 "      --standalone       standalone mode, to bypass analysis\n"
+"      --roundtriplatency round trip latency mode\n"
 ));
 	fprintf(bat->log, _("Recognized sample formats are: "));
 	fprintf(bat->log, _("U8 S16_LE S24_3LE S32_LE\n"));
@@ -328,6 +330,7 @@ static void set_defaults(struct bat *bat)
 	bat->local = false;
 	bat->buffer_size = 0;
 	bat->period_size = 0;
+	bat->roundtriplatency = false;
 #ifdef HAVE_LIBTINYALSA
 	bat->channels = 2;
 	bat->playback.fct = &playback_tinyalsa;
@@ -355,6 +358,7 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 		{"saveplay", 1, 0, OPT_SAVEPLAY},
 		{"local",    0, 0, OPT_LOCAL},
 		{"standalone", 0, 0, OPT_STANDALONE},
+		{"roundtriplatency", 0, 0, OPT_ROUNDTRIPLATENCY},
 		{0, 0, 0, 0}
 	};
 
@@ -376,6 +380,9 @@ static void parse_arguments(struct bat *bat, int argc, char *argv[])
 		case OPT_STANDALONE:
 			bat->standalone = true;
 			break;
+		case OPT_ROUNDTRIPLATENCY:
+			bat->roundtriplatency = true;
+			break;
 		case 'D':
 			if (bat->playback.device == NULL)
 				bat->playback.device = optarg;
@@ -616,6 +623,35 @@ int main(int argc, char *argv[])
 	if (err < 0)
 		goto out;
 
+	/* round trip latency test thread */
+	if (bat.roundtriplatency) {
+		while (1) {
+			fprintf(bat.log,
+				_("\nStart round trip latency\n"));
+			roundtrip_latency_init(&bat);
+			test_loopback(&bat);
+
+			if (bat.latency.xrun_error == false)
+				break;
+			else {
+				/* Xrun error in playback or capture,
+				increase period size and try again */
+				bat.period_size += bat.rate / 1000;
+				bat.buffer_size =
+					bat.period_size * DIV_BUFFERSIZE;
+
+				/* terminate the test if period_size is
+				large enough */
+				if (bat.period_size > bat.rate * 0.2)
+					break;
+			}
+
+			/* Waiting 500ms and start the next round */
+			usleep(CAPTURE_DELAY * 1000);
+		}
+		goto out;
+	}
+
 	/* single line playback thread: playback only, no capture */
 	if (bat.playback.mode == MODE_SINGLE) {
 		test_playback(&bat);
diff --git a/bat/common.h b/bat/common.h
index ad02a5a..0e8f042 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -22,6 +22,7 @@
 #define OPT_SAVEPLAY			(OPT_BASE + 3)
 #define OPT_LOCAL			(OPT_BASE + 4)
 #define OPT_STANDALONE			(OPT_BASE + 5)
+#define OPT_ROUNDTRIPLATENCY		(OPT_BASE + 6)
 
 #define COMPOSE(a, b, c, d)		((a) | ((b)<<8) | ((c)<<16) | ((d)<<24))
 #define WAV_RIFF			COMPOSE('R', 'I', 'F', 'F')
@@ -53,6 +54,10 @@
 /* default period size for tinyalsa */
 #define TINYALSA_PERIODSIZE			1024
 
+#define LATENCY_TEST_NUMBER			5
+#define LATENCY_TEST_TIME_LIMIT			25
+#define DIV_BUFFERSIZE			2
+
 #define EBATBASE			1000
 #define ENOPEAK				(EBATBASE + 1)
 #define EONLYDC				(EBATBASE + 2)
@@ -130,6 +135,14 @@ enum _bat_op_mode {
 	MODE_LAST
 };
 
+enum latency_state {
+	LATENCY_STATE_COMPLETE_FAILURE = -1,
+	LATENCY_STATE_COMPLETE_SUCCESS = 0,
+	LATENCY_STATE_MEASURE_FOR_1_SECOND,
+	LATENCY_STATE_PLAY_AND_LISTEN,
+	LATENCY_STATE_WAITING,
+};
+
 struct pcm {
 	unsigned int card_tiny;
 	unsigned int device_tiny;
@@ -151,6 +164,20 @@ struct sin_generator {
 	float magnitude;
 };
 
+struct roundtrip_latency {
+	int number;
+	enum latency_state state;
+	float result[LATENCY_TEST_NUMBER];
+	int final_result;
+	int samples;
+	float sum;
+	int threshold;
+	int error;
+	bool is_capturing;
+	bool is_playing;
+	bool xrun_error;
+};
+
 struct bat {
 	unsigned int rate;		/* sampling rate */
 	int channels;			/* nb of channels */
@@ -169,9 +196,11 @@ struct bat {
 	char *logarg;			/* path name of log file */
 	char *debugplay;		/* path name to store playback signal */
 	bool standalone;		/* enable to bypass analysis */
+	bool roundtriplatency;		/* enable round trip latency */
 
 	struct pcm playback;
 	struct pcm capture;
+	struct roundtrip_latency latency;
 
 	unsigned int periods_played;
 	unsigned int periods_total;
diff --git a/bat/latencytest.c b/bat/latencytest.c
new file mode 100644
index 0000000..fae191c
--- /dev/null
+++ b/bat/latencytest.c
@@ -0,0 +1,242 @@
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
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+
+#include "common.h"
+#include "bat-signal.h"
+#include "gettext.h"
+
+/* How one measurement step works:
+   - Listen and measure the average loudness of the environment for 1 second.
+   - Create a threshold value 16 decibels higher than the average loudness.
+   - Begin playing a ~1000 Hz sine wave and start counting the samples elapsed.
+   - Stop counting and playing if the input's loudness is higher than the
+     threshold, as the output wave is probably coming back.
+   - Calculate the round trip audio latency value in milliseconds. */
+
+static float sumaudio(struct bat *bat, short int *buffer, int frames)
+{
+	float sum = 0;
+	int n = 0;
+
+	while (frames) {
+		frames--;
+
+		for (n = 0; n < bat->channels; n++) {
+			sum += abs(buffer[0]);
+			buffer++;
+		}
+	}
+
+	sum = sum / bat->channels;
+
+	return sum;
+}
+
+static void play_and_listen(struct bat *bat, void *buffer, int frames)
+{
+	int averageinput;
+	int n = 0;
+	float sum = 0;
+	float max = 0;
+	float min = 100000.0f;
+	short int *input;
+	int num = bat->latency.number;
+
+	averageinput = (int) (sumaudio(bat, buffer, frames) / frames);
+
+	/* The signal is above threshold
+	   So our sine wave comes back on the input */
+	if (averageinput > bat->latency.threshold) {
+		input = buffer;
+
+		/* Check the location when it became loud enough */
+		while (n < frames) {
+			if (*input++ > bat->latency.threshold)
+				break;
+			*input += bat->channels;
+			n++;
+		}
+
+		/* Now we get the total round trip latency*/
+		bat->latency.samples += n;
+
+		/* Expect at least 1 buffer of round trip latency. */
+		if (bat->latency.samples > frames) {
+			bat->latency.result[num - 1] =
+				(float) bat->latency.samples * 1000 / bat->rate;
+			fprintf(bat->log,
+					 _("Test%d, round trip latency %dms\n"),
+					num,
+					(int) bat->latency.result[num - 1]);
+
+			for (n = 0; n < num; n++) {
+				if (bat->latency.result[n] > max)
+					max = bat->latency.result[n];
+				if (bat->latency.result[n] < min)
+					min = bat->latency.result[n];
+				sum += bat->latency.result[n];
+			}
+
+			/* The maximum is higher than the minimum's double */
+			if (max / min > 2.0f) {
+				bat->latency.state =
+					LATENCY_STATE_COMPLETE_FAILURE;
+				bat->latency.is_capturing = false;
+				return;
+
+			/* Final results */
+			} else if (num == LATENCY_TEST_NUMBER) {
+				bat->latency.final_result =
+					(int) (sum / LATENCY_TEST_NUMBER);
+				fprintf(bat->log,
+					_("Final round trip latency: %dms\n"),
+					bat->latency.final_result);
+
+				bat->latency.state =
+					LATENCY_STATE_COMPLETE_SUCCESS;
+				bat->latency.is_capturing = false;
+				return;
+
+			/* Next step */
+			} else
+				bat->latency.state = LATENCY_STATE_WAITING;
+
+			bat->latency.number++;
+
+		} else
+			/* Happens when an early noise comes in */
+			bat->latency.state = LATENCY_STATE_WAITING;
+
+	} else {
+		/* Still listening */
+		bat->latency.samples += frames;
+
+		/* Do not listen to more than a second
+		   Maybe too much background noise */
+		if (bat->latency.samples > bat->rate) {
+			bat->latency.error++;
+
+			if (bat->latency.error > LATENCY_TEST_NUMBER) {
+				fprintf(bat->err,
+					_("Could not detect signal."));
+				fprintf(bat->err,
+					_("Too much background noise?\n"));
+				bat->latency.state =
+					LATENCY_STATE_COMPLETE_FAILURE;
+				bat->latency.is_capturing = false;
+				return;
+			}
+
+			/* let's start over */
+			bat->latency.state = LATENCY_STATE_WAITING;
+		}
+	}
+
+	return;
+}
+
+static void calculate_threshold(struct bat *bat)
+{
+	float average;
+	float reference;
+
+	/* Calculate the average loudness of the environment and create
+	   a threshold value 16 decibels higher than the average loudness */
+	average = bat->latency.sum / bat->latency.samples / 32767.0f;
+	reference = 20.0f * log10f(average) + 16.0f;
+	bat->latency.threshold = (int) (powf(10.0f, reference / 20.0f)
+						* 32767.0f);
+}
+
+void roundtrip_latency_init(struct bat *bat)
+{
+	bat->latency.number = 1;
+	bat->latency.state = LATENCY_STATE_MEASURE_FOR_1_SECOND;
+	bat->latency.final_result = 0;
+	bat->latency.samples = 0;
+	bat->latency.sum = 0;
+	bat->latency.threshold = 0;
+	bat->latency.is_capturing = false;
+	bat->latency.is_playing = false;
+	bat->latency.error = 0;
+	bat->latency.xrun_error = false;
+	bat->format = BAT_PCM_FORMAT_S16_LE;
+	bat->frames = LATENCY_TEST_TIME_LIMIT * bat->rate;
+	bat->periods_played = 0;
+}
+
+int handleinput(struct bat *bat, void *buffer, int frames)
+{
+	switch (bat->latency.state) {
+	/* Measuring average loudness for 1 second */
+	case LATENCY_STATE_MEASURE_FOR_1_SECOND:
+		bat->latency.sum += sumaudio(bat, buffer, frames);
+		bat->latency.samples += frames;
+
+		/* 1 second elapsed */
+		if (bat->latency.samples >= bat->rate) {
+			calculate_threshold(bat);
+			bat->latency.state = LATENCY_STATE_PLAY_AND_LISTEN;
+			bat->latency.samples = 0;
+			bat->latency.sum = 0;
+		}
+		break;
+
+	/* Playing sine wave and listening if it comes back */
+	case LATENCY_STATE_PLAY_AND_LISTEN:
+		play_and_listen(bat, buffer, frames);
+		break;
+
+	/* Waiting 1 second */
+	case LATENCY_STATE_WAITING:
+		bat->latency.samples += frames;
+
+		if (bat->latency.samples > bat->rate) {
+			/* 1 second elapsed, start over */
+			bat->latency.samples = 0;
+			bat->latency.state = LATENCY_STATE_MEASURE_FOR_1_SECOND;
+		}
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+int handleoutput(struct bat *bat, void *buffer, int bytes, int frames)
+{
+	int err = 0;
+
+	/* If capture completed, terminate the playback */
+	if (bat->periods_played * frames > 2 * bat->rate
+			&& bat->latency.is_capturing == false)
+		return bat->latency.state;
+
+	if (bat->latency.state == LATENCY_STATE_PLAY_AND_LISTEN)
+		err = generate_sine_wave(bat, frames, buffer);
+	else
+		/* Output silence */
+		memset(buffer, 0, bytes);
+
+	return err;
+}
diff --git a/bat/latencytest.h b/bat/latencytest.h
new file mode 100644
index 0000000..be5e661
--- /dev/null
+++ b/bat/latencytest.h
@@ -0,0 +1,17 @@
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
+void roundtrip_latency_init(struct bat *);
+int handleinput(struct bat *, void *, int);
+int handleoutput(struct bat *, void *, int, int);
diff --git a/bat/tinyalsa.c b/bat/tinyalsa.c
index a19dd90..f1c20fa 100644
--- a/bat/tinyalsa.c
+++ b/bat/tinyalsa.c
@@ -27,6 +27,7 @@
 
 #include "common.h"
 #include "tinyalsa.h"
+#include "latencytest.h"
 
 struct format_map_table {
 	enum _bat_pcm_format format_bat;
@@ -156,6 +157,40 @@ exit:
 }
 
 /**
+ * Process output data for latency test
+ */
+static int latencytest_process_output(struct bat *bat, struct pcm *pcm,
+		void *buffer, int bytes)
+{
+	int err = 0;
+	int frames = bytes / bat->frame_size;
+
+	fprintf(bat->log, _("Play sample with %d frames buffer\n"), frames);
+
+	bat->latency.is_playing = true;
+
+	while (1) {
+		/* generate output data */
+		err = handleoutput(bat, buffer, bytes, frames);
+		if (err != 0)
+			break;
+
+		err = pcm_write(pcm, buffer, bytes);
+		if (err != 0)
+			break;
+
+		if (bat->latency.state == LATENCY_STATE_COMPLETE_SUCCESS)
+			break;
+
+		bat->periods_played++;
+	}
+
+	bat->latency.is_playing = false;
+
+	return err;
+}
+
+/**
  * Play sample
  */
 static int play_sample(struct bat *bat, struct pcm *pcm,
@@ -322,7 +357,10 @@ void *playback_tinyalsa(struct bat *bat)
 		}
 	}
 
-	err = play_sample(bat, pcm, buffer, bufbytes);
+	if (bat->roundtriplatency)
+		err = latencytest_process_output(bat, pcm, buffer, bufbytes);
+	else
+		err = play_sample(bat, pcm, buffer, bufbytes);
 	if (err < 0) {
 		retval_play = err;
 		goto exit4;
@@ -385,6 +423,56 @@ static int capture_sample(struct bat *bat, struct pcm *pcm,
 }
 
 /**
+ * Process input data for latency test
+ */
+static int latencytest_process_input(struct bat *bat, struct pcm *pcm,
+		void *buffer, unsigned int bytes)
+{
+	int err = 0;
+	FILE *fp = NULL;
+	unsigned int bytes_read = 0;
+	unsigned int bytes_count = bat->frames * bat->frame_size;
+
+	remove(bat->capture.file);
+	fp = fopen(bat->capture.file, "wb");
+	err = -errno;
+	if (fp == NULL) {
+		fprintf(bat->err, _("Cannot open file: %s %d\n"),
+				bat->capture.file, err);
+		return err;
+	}
+	/* leave space for file header */
+	if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
+		err = -errno;
+		fclose(fp);
+		return err;
+	}
+
+	bat->latency.is_capturing = true;
+
+	while (bytes_read < bytes_count && !pcm_read(pcm, buffer, bytes)) {
+		if (fwrite(buffer, 1, bytes, fp) != bytes)
+			break;
+
+		err = handleinput(bat, buffer, bytes / bat->frame_size);
+		if (err != 0)
+			break;
+
+		if (bat->latency.is_playing == false)
+			break;
+
+		bytes_read += bytes;
+	}
+
+	bat->latency.is_capturing = false;
+
+	err = update_wav_header(bat, fp, bytes_read);
+
+	fclose(fp);
+	return err;
+}
+
+/**
  * Record
  */
 void *record_tinyalsa(struct bat *bat)
@@ -441,7 +529,10 @@ void *record_tinyalsa(struct bat *bat)
 	pthread_cleanup_push(free, buffer);
 
 	fprintf(bat->log, _("Recording ...\n"));
-	err = capture_sample(bat, pcm, buffer, bufbytes);
+	if (bat->roundtriplatency)
+		err = latencytest_process_input(bat, pcm, buffer, bufbytes);
+	else
+		err = capture_sample(bat, pcm, buffer, bufbytes);
 	if (err != 0) {
 		retval_record = err;
 		goto exit3;
-- 
1.7.9.5
