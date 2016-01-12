From: han.lu@intel.com
Subject: [PATCH 1/1] alsabat: rename to avoid naming conflict
Date: Tue, 12 Jan 2016 11:06:24 +0800
Message-ID: <1452567984-18047-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E5E842604D5
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 04:05:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, bernard.gautier@intel.com, joerg.steffens@bareos.com, clemens@ladisch.de, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

alsa-utils as well as bareos-bat (as well a some Bacula packages)
all contain a program called /usr/bin/bat, which causes conflicts on
various distributions ("basic audio tester" vs "bareos administration
tool"("bacula administration tool")).
Rename to avoid conflict.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/.gitignore b/.gitignore
index 59633c9..822be08 100644
--- a/.gitignore
+++ b/.gitignore
@@ -24,6 +24,7 @@ ABOUT-NLS
 *~
 .deps
 
+alsabat/alsabat
 alsactl/alsactl
 alsactl/alsactl_init.7
 alsactl/alsa-state.service
@@ -36,7 +37,6 @@ amixer/amixer
 aplay/aplay
 aplay/arecord
 aplay/arecord.1
-bat/bat
 iecset/iecset
 seq/aconnect/aconnect
 seq/aplaymidi/aplaymidi
diff --git a/Makefile.am b/Makefile.am
index 3d24b87..b996b8f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -18,8 +18,8 @@ SUBDIRS += aplay iecset speaker-test
 if ALSALOOP
 SUBDIRS += alsaloop
 endif
-if BAT
-SUBDIRS += bat
+if ALSABAT
+SUBDIRS += alsabat
 endif
 endif
 if HAVE_SEQ
diff --git a/alsabat/Makefile.am b/alsabat/Makefile.am
new file mode 100644
index 0000000..ab56c19
--- /dev/null
+++ b/alsabat/Makefile.am
@@ -0,0 +1,24 @@
+bin_PROGRAMS = alsabat
+man_MANS = alsabat.1
+
+EXTRA_DIST = alsabat.1
+
+alsabat_SOURCES = \
+	alsabat.c \
+	common.c \
+	analyze.c \
+	signal.c \
+	convert.c \
+	alsa.c
+
+noinst_HEADERS = \
+	common.h \
+	bat-signal.h \
+	alsa.h \
+	convert.h \
+	analyze.h
+
+AM_CPPFLAGS = \
+	      -Wall -I$(top_srcdir)/include
+
+alsabat_LDADD = @FFTW_LIB@
diff --git a/alsabat/alsa.c b/alsabat/alsa.c
new file mode 100644
index 0000000..5eaa25b
--- /dev/null
+++ b/alsabat/alsa.c
@@ -0,0 +1,604 @@
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
+#include <string.h>
+#include <stdbool.h>
+#include <math.h>
+#include <stdint.h>
+#include <pthread.h>
+
+#include <alsa/asoundlib.h>
+
+#include "aconfig.h"
+#include "gettext.h"
+
+#include "common.h"
+#include "alsa.h"
+#include "bat-signal.h"
+
+struct pcm_container {
+	snd_pcm_t *handle;
+	snd_pcm_uframes_t period_size;
+	snd_pcm_uframes_t buffer_size;
+	snd_pcm_format_t format;
+	unsigned short channels;
+	size_t period_bytes;
+	size_t sample_bits;
+	size_t frame_bits;
+	char *buffer;
+};
+
+static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
+{
+	snd_pcm_hw_params_t *params;
+	unsigned int buffer_time = 0;
+	unsigned int period_time = 0;
+	unsigned int rate;
+	int err;
+	const char *device_name = snd_pcm_name(sndpcm->handle);
+
+	/* Allocate a hardware parameters object. */
+	snd_pcm_hw_params_alloca(&params);
+
+	/* Fill it in with default values. */
+	err = snd_pcm_hw_params_any(sndpcm->handle, params);
+	if (err < 0) {
+		fprintf(bat->err, _("Set parameter to device error: "));
+		fprintf(bat->err, _("default params: %s: %s(%d)\n"),
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+
+	/* Set access mode */
+	err = snd_pcm_hw_params_set_access(sndpcm->handle, params,
+			SND_PCM_ACCESS_RW_INTERLEAVED);
+	if (err < 0) {
+		fprintf(bat->err, _("Set parameter to device error: "));
+		fprintf(bat->err, _("access type: %s: %s(%d)\n"),
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+
+	/* Set format */
+	err = snd_pcm_hw_params_set_format(sndpcm->handle, params, bat->format);
+	if (err < 0) {
+		fprintf(bat->err, _("Set parameter to device error: "));
+		fprintf(bat->err, _("PCM format: %d %s: %s(%d)\n"),
+				bat->format,
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+
+	/* Set channels */
+	err = snd_pcm_hw_params_set_channels(sndpcm->handle,
+			params, bat->channels);
+	if (err < 0) {
+		fprintf(bat->err, _("Set parameter to device error: "));
+		fprintf(bat->err, _("channel number: %d %s: %s(%d)\n"),
+				bat->channels,
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+
+	/* Set sampling rate */
+	rate = bat->rate;
+	err = snd_pcm_hw_params_set_rate_near(sndpcm->handle,
+			params, &bat->rate,
+			0);
+	if (err < 0) {
+		fprintf(bat->err, _("Set parameter to device error: "));
+		fprintf(bat->err, _("sample rate: %d %s: %s(%d)\n"),
+				bat->rate,
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+	if ((float) rate * (1 + RATE_RANGE) < bat->rate
+			|| (float) rate * (1 - RATE_RANGE) > bat->rate) {
+		fprintf(bat->err, _("Invalid parameters: sample rate: "));
+		fprintf(bat->err, _("requested %dHz, got %dHz\n"),
+				rate, bat->rate);
+		return -EINVAL;
+	}
+
+	if (snd_pcm_hw_params_get_buffer_time_max(params,
+			&buffer_time, 0) < 0) {
+		fprintf(bat->err, _("Get parameter from device error: "));
+		fprintf(bat->err, _("buffer time: %d %s: %s(%d)\n"),
+				buffer_time,
+				device_name, snd_strerror(err), err);
+		return -EINVAL;
+	}
+
+	if (buffer_time > MAX_BUFFERTIME)
+		buffer_time = MAX_BUFFERTIME;
+
+	period_time = buffer_time / DIV_BUFFERTIME;
+
+	/* Set buffer time and period time */
+	err = snd_pcm_hw_params_set_buffer_time_near(sndpcm->handle, params,
+			&buffer_time, 0);
+	if (err < 0) {
+		fprintf(bat->err, _("Set parameter to device error: "));
+		fprintf(bat->err, _("buffer time: %d %s: %s(%d)\n"),
+				buffer_time,
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+
+	err = snd_pcm_hw_params_set_period_time_near(sndpcm->handle, params,
+			&period_time, 0);
+	if (err < 0) {
+		fprintf(bat->err, _("Set parameter to device error: "));
+		fprintf(bat->err, _("period time: %d %s: %s(%d)\n"),
+				period_time,
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+
+	/* Write the parameters to the driver */
+	if (snd_pcm_hw_params(sndpcm->handle, params) < 0) {
+		fprintf(bat->err, _("Set parameter to device error: "));
+		fprintf(bat->err, _("hw params: %s: %s(%d)\n"),
+				device_name, snd_strerror(err), err);
+		return -EINVAL;
+	}
+
+	err = snd_pcm_hw_params_get_period_size(params,
+			&sndpcm->period_size, 0);
+	if (err < 0) {
+		fprintf(bat->err, _("Get parameter from device error: "));
+		fprintf(bat->err, _("period size: %zd %s: %s(%d)\n"),
+				sndpcm->period_size,
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+
+	err = snd_pcm_hw_params_get_buffer_size(params, &sndpcm->buffer_size);
+	if (err < 0) {
+		fprintf(bat->err, _("Get parameter from device error: "));
+		fprintf(bat->err, _("buffer size: %zd %s: %s(%d)\n"),
+				sndpcm->buffer_size,
+				device_name, snd_strerror(err), err);
+		return err;
+	}
+
+	if (sndpcm->period_size == sndpcm->buffer_size) {
+		fprintf(bat->err, _("Invalid parameters: can't use period "));
+		fprintf(bat->err, _("equal to buffer size (%zd)\n"),
+				sndpcm->period_size);
+		return -EINVAL;
+	}
+
+	err = snd_pcm_format_physical_width(bat->format);
+	if (err < 0) {
+		fprintf(bat->err, _("Invalid parameters: "));
+		fprintf(bat->err, _("snd_pcm_format_physical_width: %d\n"),
+				err);
+		return err;
+	}
+	sndpcm->sample_bits = err;
+
+	sndpcm->frame_bits = sndpcm->sample_bits * bat->channels;
+
+	/* Calculate the period bytes */
+	sndpcm->period_bytes = sndpcm->period_size * sndpcm->frame_bits / 8;
+	sndpcm->buffer = (char *) malloc(sndpcm->period_bytes);
+	if (sndpcm->buffer == NULL) {
+		fprintf(bat->err, _("Not enough memory: size=%zd\n"),
+				sndpcm->period_bytes);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Generate buffer to be played either from input file or from generated data
+ * Return value
+ * <0 error
+ * 0 ok
+ * >0 break
+ */
+static int generate_input_data(struct pcm_container *sndpcm, int bytes,
+		struct bat *bat)
+{
+	int err;
+	static int load;
+	int frames = bytes * 8 / sndpcm->frame_bits;
+
+	if (bat->playback.file != NULL) {
+		/* From input file */
+		load = 0;
+
+		while (1) {
+			err = fread(sndpcm->buffer + load, 1,
+					bytes - load, bat->fp);
+			if (0 == err) {
+				if (feof(bat->fp)) {
+					fprintf(bat->log,
+							_("End of playing.\n"));
+					return 1;
+				}
+			} else if (err < bytes - load) {
+				if (ferror(bat->fp)) {
+					fprintf(bat->err, _("Read file error"));
+					fprintf(bat->err, _(": %d\n"), err);
+					return -EIO;
+				}
+				load += err;
+			} else {
+				break;
+			}
+		}
+	} else {
+		/* Generate sine wave */
+		if ((bat->sinus_duration) && (load > bat->sinus_duration))
+			return 1;
+
+		err = generate_sine_wave(bat, frames, (void *)sndpcm->buffer);
+		if (err != 0)
+			return err;
+
+		load += frames;
+	}
+
+	return 0;
+}
+
+static int write_to_pcm(const struct pcm_container *sndpcm,
+		int frames, struct bat *bat)
+{
+	int err;
+	int offset = 0;
+	int remain = frames;
+
+	while (remain > 0) {
+		err = snd_pcm_writei(sndpcm->handle, sndpcm->buffer + offset,
+				remain);
+		if (err == -EAGAIN || (err >= 0 && err < frames)) {
+			snd_pcm_wait(sndpcm->handle, 500);
+		} else if (err == -EPIPE) {
+			fprintf(bat->err, _("Underrun: %s(%d)\n"),
+					snd_strerror(err), err);
+			snd_pcm_prepare(sndpcm->handle);
+		} else if (err < 0) {
+			fprintf(bat->err, _("Write PCM device error: %s(%d)\n"),
+					snd_strerror(err), err);
+			return err;
+		}
+
+		if (err > 0) {
+			remain -= err;
+			offset += err * sndpcm->frame_bits / 8;
+		}
+	}
+
+	return 0;
+}
+
+static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
+{
+	int err;
+	int bytes = sndpcm->period_bytes; /* playback buffer size */
+	int frames = bytes * 8 / sndpcm->frame_bits; /* frame count */
+	FILE *fp = NULL;
+	struct wav_container wav;
+	int bytes_total = 0;
+
+	if (bat->debugplay) {
+		fp = fopen(bat->debugplay, "wb");
+		if (fp == NULL) {
+			fprintf(bat->err, _("Cannot open file for capture: "));
+			fprintf(bat->err, _("%s %d\n"), bat->debugplay, -errno);
+			return -errno;
+		}
+		/* leave space for wav header */
+		err = fseek(fp, sizeof(wav), SEEK_SET);
+		if (err != 0) {
+			fprintf(bat->err, _("Seek file error: %d %d\n"),
+					err, -errno);
+			return -errno;
+		}
+	}
+
+	while (1) {
+		err = generate_input_data(sndpcm, bytes, bat);
+		if (err < 0)
+			return err;
+		else if (err > 0)
+			break;
+
+		if (bat->debugplay) {
+			err = fwrite(sndpcm->buffer, 1, bytes, fp);
+			if (err != bytes) {
+				fprintf(bat->err, _("Write file error: "));
+				fprintf(bat->err, _("%s(%d)\n"),
+						snd_strerror(err), err);
+				return -EIO;
+			}
+			bytes_total += bytes;
+		}
+
+		bat->periods_played++;
+		if (bat->period_is_limited
+				&& bat->periods_played >= bat->periods_total)
+			break;
+
+		err = write_to_pcm(sndpcm, frames, bat);
+		if (err != 0)
+			return err;
+	}
+
+	if (bat->debugplay) {
+		/* update wav header */
+		prepare_wav_info(&wav, bat);
+		wav.chunk.length = bytes_total;
+		wav.header.length = (wav.chunk.length) + sizeof(wav.chunk)
+			+ sizeof(wav.format) + sizeof(wav.header) - 8;
+
+		rewind(fp);
+		err = write_wav_header(fp, &wav, bat);
+		if (err != 0) {
+			fprintf(bat->err, _("Write file error: %s %s(%d)\n"),
+					bat->debugplay, snd_strerror(err), err);
+			return err;
+		}
+		fclose(fp);
+	}
+
+	snd_pcm_drain(sndpcm->handle);
+
+	return 0;
+}
+
+/**
+ * Play
+ */
+void *playback_alsa(struct bat *bat)
+{
+	int err = 0;
+	struct pcm_container sndpcm;
+
+	fprintf(bat->log, _("Entering playback thread (ALSA).\n"));
+
+	retval_play = 0;
+	memset(&sndpcm, 0, sizeof(sndpcm));
+
+	if (bat->playback.device == NULL) {
+		fprintf(bat->err, _("No PCM device for playback: exit\n"));
+		retval_play = 1;
+		goto exit1;
+	}
+
+	err = snd_pcm_open(&sndpcm.handle, bat->playback.device,
+			SND_PCM_STREAM_PLAYBACK, 0);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot open PCM playback device: "));
+		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
+		retval_play = 1;
+		goto exit1;
+	}
+
+	err = set_snd_pcm_params(bat, &sndpcm);
+	if (err != 0) {
+		retval_play = 1;
+		goto exit2;
+	}
+
+	if (bat->playback.file == NULL) {
+		fprintf(bat->log, _("Playing generated audio sine wave"));
+		bat->sinus_duration == 0 ?
+			fprintf(bat->log, _(" endlessly\n")) :
+			fprintf(bat->log, _("\n"));
+	} else {
+		fprintf(bat->log, _("Playing input audio file: %s\n"),
+				bat->playback.file);
+		bat->fp = fopen(bat->playback.file, "rb");
+		if (bat->fp == NULL) {
+			fprintf(bat->err, _("Cannot open file for capture: "));
+			fprintf(bat->err, _("%s %d\n"),
+					bat->playback.file, -errno);
+			retval_play = 1;
+			goto exit3;
+		}
+		/* Skip header */
+		err = read_wav_header(bat, bat->playback.file, bat->fp, true);
+		if (err != 0) {
+			retval_play = 1;
+			goto exit4;
+		}
+	}
+
+	err = write_to_pcm_loop(&sndpcm, bat);
+	if (err != 0) {
+		retval_play = 1;
+		goto exit4;
+	}
+
+exit4:
+	if (bat->playback.file)
+		fclose(bat->fp);
+exit3:
+	free(sndpcm.buffer);
+exit2:
+	snd_pcm_close(sndpcm.handle);
+exit1:
+	pthread_exit(&retval_play);
+}
+
+static int read_from_pcm(struct pcm_container *sndpcm,
+		int frames, struct bat *bat)
+{
+	int err = 0;
+	int offset = 0;
+	int remain = frames;
+
+	while (remain > 0) {
+		err = snd_pcm_readi(sndpcm->handle,
+				sndpcm->buffer + offset, remain);
+		if (err == -EAGAIN || (err >= 0 && err < remain)) {
+			snd_pcm_wait(sndpcm->handle, 500);
+		} else if (err == -EPIPE) {
+			snd_pcm_prepare(sndpcm->handle);
+			fprintf(bat->err, _("Overrun: %s(%d)\n"),
+					snd_strerror(err), err);
+		} else if (err < 0) {
+			fprintf(bat->err, _("Read PCM device error: %s(%d)\n"),
+					snd_strerror(err), err);
+			return err;
+		}
+
+		if (err > 0) {
+			remain -= err;
+			offset += err * sndpcm->frame_bits / 8;
+		}
+	}
+
+	return 0;
+}
+
+static int read_from_pcm_loop(FILE *fp, int count,
+		struct pcm_container *sndpcm, struct bat *bat)
+{
+	int err = 0;
+	int size, frames;
+	int remain = count;
+
+	while (remain > 0) {
+		size = (remain <= sndpcm->period_bytes) ?
+			remain : sndpcm->period_bytes;
+		frames = size * 8 / sndpcm->frame_bits;
+
+		/* read a chunk from pcm device */
+		err = read_from_pcm(sndpcm, frames, bat);
+		if (err != 0)
+			return err;
+
+		/* write the chunk to file */
+		err = fwrite(sndpcm->buffer, 1, size, fp);
+		if (err != size) {
+			fprintf(bat->err, _("Write file error: %s(%d)\n"),
+					snd_strerror(err), err);
+			return -EIO;
+		}
+		remain -= size;
+		bat->periods_played++;
+
+		if (bat->period_is_limited
+				&& bat->periods_played >= bat->periods_total)
+			break;
+	}
+
+	return 0;
+}
+
+static void pcm_cleanup(void *p)
+{
+	snd_pcm_close(p);
+}
+
+static void file_cleanup(void *p)
+{
+	fclose(p);
+}
+
+/**
+ * Record
+ */
+void *record_alsa(struct bat *bat)
+{
+	int err = 0;
+	FILE *fp = NULL;
+	struct pcm_container sndpcm;
+	struct wav_container wav;
+	int count;
+
+	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
+
+	fprintf(bat->log, _("Entering capture thread (ALSA).\n"));
+
+	retval_record = 0;
+	memset(&sndpcm, 0, sizeof(sndpcm));
+
+	if (bat->capture.device == NULL) {
+		fprintf(bat->err, _("No PCM device for capture: exit\n"));
+		retval_record = 1;
+		goto exit1;
+	}
+
+	err = snd_pcm_open(&sndpcm.handle, bat->capture.device,
+			SND_PCM_STREAM_CAPTURE, 0);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot open PCM capture device: "));
+		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
+		retval_record = 1;
+		goto exit1;
+	}
+
+	err = set_snd_pcm_params(bat, &sndpcm);
+	if (err != 0) {
+		retval_record = 1;
+		goto exit2;
+	}
+
+	remove(bat->capture.file);
+	fp = fopen(bat->capture.file, "w+");
+	if (fp == NULL) {
+		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
+				bat->capture.file, -errno);
+		retval_record = 1;
+		goto exit3;
+	}
+
+	prepare_wav_info(&wav, bat);
+
+	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
+	pthread_cleanup_push(pcm_cleanup, sndpcm.handle);
+	pthread_cleanup_push(free, sndpcm.buffer);
+	pthread_cleanup_push(file_cleanup, fp);
+
+	err = write_wav_header(fp, &wav, bat);
+	if (err != 0) {
+		retval_record = 1;
+		goto exit4;
+	}
+
+	count = wav.chunk.length;
+	fprintf(bat->log, _("Recording ...\n"));
+	err = read_from_pcm_loop(fp, count, &sndpcm, bat);
+	if (err != 0) {
+		retval_record = 1;
+		goto exit4;
+	}
+
+	/* Normally we will never reach this part of code (before fail_exit) as
+	   this thread will be cancelled by end of play thread. */
+	pthread_cleanup_pop(0);
+	pthread_cleanup_pop(0);
+	pthread_cleanup_pop(0);
+
+	snd_pcm_drain(sndpcm.handle);
+
+exit4:
+	fclose(fp);
+exit3:
+	free(sndpcm.buffer);
+exit2:
+	snd_pcm_close(sndpcm.handle);
+exit1:
+	pthread_exit(&retval_record);
+}
diff --git a/alsabat/alsa.h b/alsabat/alsa.h
new file mode 100644
index 0000000..d5c9972
--- /dev/null
+++ b/alsabat/alsa.h
@@ -0,0 +1,20 @@
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
+extern int retval_play;
+extern int retval_record;
+
+void *playback_alsa(struct bat *);
+void *record_alsa(struct bat *);
diff --git a/alsabat/alsabat.1 b/alsabat/alsabat.1
new file mode 100644
index 0000000..93df210
--- /dev/null
+++ b/alsabat/alsabat.1
@@ -0,0 +1,159 @@
+.TH ALSABAT 1 "20th October 2015"
+.SH NAME
+alsabat \- command\-line sound tester for ALSA sound card driver
+
+.SH SYNOPSIS
+\fBalsabat\fP [\fIflags\fP]
+
+.SH DESCRIPTION
+\fBALSABAT(ALSA Basic Audio Tester)\fP is a simple command\-line utility
+intended to help automate audio driver and sound server testing with little
+human interaction. ALSABAT can be used to test audio quality, stress test
+features and test audio before and after PM state changes.
+
+ALSABAT's design is relatively simple. ALSABAT plays an audio stream and
+captures the same stream in either a digital or analog loop back. It then
+compares the captured stream using a FFT to the original to determine if
+the test case passes or fails.
+
+ALSABAT can either run wholly on the target machine being tested (standalone
+mode) or can run as a client/server mode where by bat client runs on the
+target and runs as a server on a separate tester machine. The client/server
+mode still requires some manual interaction for synchronization, but this
+is actively being developed for future releases.
+
+The hardware testing configuration may require the use of an analog cable
+connecting target to tester machines or a cable to create an analog
+loopback if no loopback mode is not available on the sound hardware that
+is being tested.
+An analog loopback cable can be used to connect the "line in" to "line out"
+jacks to create a loopback. If only headphone and mic jacks (or combo jack)
+are available then the following simple circuit can be used to create an
+analog loopback :-
+
+https://source.android.com/devices/audio/loopback.html
+
+.SH OPTIONS
+.TP
+\fI\-h, \-\-help\fP
+Help: show syntax.
+.TP
+\fI\-D\fP
+Select sound card to be tested by name.
+.TP
+\fI\-P\fP
+Select the playback PCM device.
+.TP
+\fI\-C\fP
+Select the capture PCM device.
+.TP
+\fI\-f\fP
+Sample format
+.br
+Recognized sample formats are: U8 S16_LE S24_3LE S32_LE
+.br
+Some of these may not be available on selected hardware
+.br
+The available format shortcuts are:
+.nf
+\-f cd (16 bit little endian, 44100, stereo) [\-f S16_LE \-c2 \-r44100]
+\-f dat (16 bit little endian, 48000, stereo) [\-f S16_LE \-c2 \-r48000]
+.fi
+If no format is given S16_LE is used.
+.TP
+\fI\-c\fP
+The number of channels. The default is one channel.
+Valid values at the moment are 1 or 2.
+.TP
+\fI\-r\fP
+Sampling rate in Hertz. The default rate is 44100 Hertz.
+Valid values depends on hardware support.
+.TP
+\fI\-n\fP
+Duration of generated signal.
+The value could be either of the two forms:
+.br
+1. Decimal integer, means number of frames;
+.br
+2. Floating point with suffix 's', means number of seconds.
+.br
+The default is 2 seconds.
+.TP
+\fI\-k\fP
+Sigma k value for analysis.
+.br
+The analysis function reads data from WAV file, run FFT against the data
+to get magnitude of frequency vectors, and then calculates the average
+value and standard deviation of frequency vectors. After that, we define
+a threshold:
+.br
+threshold = k * standard_deviation + mean_value
+.br
+Frequencies with amplitude larger than threshold will be recognized as a
+peak, and the frequency with largest peak value will be recognized as a
+detected frequency.
+.br
+ALSABAT then compares the detected frequency to target frequency, to decide
+if the detecting passes or fails.
+.br
+The default value is 3.0.
+.TP
+\fI\-F\fP
+Target frequency for signal generation and analysis, in Hertz.
+The default is 997.0 Hertz.
+Valid range is (DC_THRESHOLD, 40% * Sampling rate).
+.TP
+\fI\-p\fP
+Total number of periods to play or capture.
+.TP
+\fI\-\-log=#\fP
+Write stderr and stdout output to this log file.
+.TP
+\fI\-\-file=#\fP
+Input WAV file for playback.
+.TP
+\fI\-\-saveplay=#\fP
+Target WAV file to save capture test content.
+.TP
+\fI\-\-local\fP
+Internal loopback mode.
+Playback, capture and analysis internal to ALSABAT only. This is intended for
+developers to test new ALSABAT features as no audio is routed outside of
+ALSABAT.
+
+.SH EXAMPLES
+
+.TP
+\fBbat \-P plughw:0,0 \-C plughw:0,0 \-c 2 \-f S32_LE \-F 250\fR
+Generate and play a sine wave of 250 Hertz with 2 channel and S32_LE format,
+and then capture and analyze.
+
+.TP
+\fBbat \-P plughw:0,0 \-C plughw:0,0 \-\-file 500Hz.wav\fR
+Play the RIFF WAV file "500Hz.wav" which contains 500 Hertz waveform LPCM
+data, and then capture and analyze.
+
+.SH RETURN VALUE
+.br
+On success, returns 0.
+.br
+If no peak be detected, returns -1001;
+.br
+If only DC be detected, returns -1002;
+.br
+If peak frequency does not match with the target frequency, returns -1003.
+
+.SH SEE ALSO
+\fB
+aplay(1)
+\fP
+
+.SH BUGS
+Currently only support RIFF WAV format with PCM data. Please report any bugs to
+the alsa-devel mailing list.
+
+.SH AUTHOR
+\fBbat\fP is by Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bernard Gautier
+<bernard.gautier@intel.com> and Han Lu <han.lu@intel.com>.
+This document is by Liam Girdwood <liam.r.girdwood@linux.intel.com> and Han Lu
+<han.lu@intel.com>.
diff --git a/alsabat/alsabat.c b/alsabat/alsabat.c
new file mode 100644
index 0000000..ddb60b7
--- /dev/null
+++ b/alsabat/alsabat.c
@@ -0,0 +1,610 @@
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
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <errno.h>
+#include <pthread.h>
+#include <getopt.h>
+#include <math.h>
+#include <limits.h>
+#include <locale.h>
+
+#include "aconfig.h"
+#include "gettext.h"
+#include "version.h"
+
+#include "common.h"
+
+#include "alsa.h"
+#include "convert.h"
+#include "analyze.h"
+
+static int get_duration(struct bat *bat)
+{
+	float duration_f;
+	long duration_i;
+	char *ptrf, *ptri;
+
+	duration_f = strtof(bat->narg, &ptrf);
+	if (duration_f == HUGE_VALF || duration_f == -HUGE_VALF
+			|| (duration_f == 0.0 && errno != 0))
+		goto err_exit;
+
+	duration_i = strtol(bat->narg, &ptri, 10);
+	if (duration_i == LONG_MAX || duration_i == LONG_MIN)
+		goto err_exit;
+
+	if (*ptrf == 's')
+		bat->frames = duration_f * bat->rate;
+	else if (*ptri == 0)
+		bat->frames = duration_i;
+	else
+		bat->frames = -1;
+
+	if (bat->frames <= 0 || bat->frames > MAX_FRAMES) {
+		fprintf(bat->err, _("Invalid duration. Range: (0, %d(%fs))\n"),
+				MAX_FRAMES, (double)MAX_FRAMES / bat->rate);
+		return -EINVAL;
+	}
+
+	return 0;
+
+err_exit:
+	fprintf(bat->err, _("Duration overflow/underflow: %d\n"), -errno);
+
+	return -errno;
+}
+
+static void get_sine_frequencies(struct bat *bat, char *freq)
+{
+	char *tmp1;
+
+	tmp1 = strchr(freq, ':');
+	if (tmp1 == NULL) {
+		bat->target_freq[1] = bat->target_freq[0] = atof(optarg);
+	} else {
+		*tmp1 = '\0';
+		bat->target_freq[0] = atof(optarg);
+		bat->target_freq[1] = atof(tmp1 + 1);
+	}
+}
+
+static void get_format(struct bat *bat, char *optarg)
+{
+	if (strcasecmp(optarg, "cd") == 0) {
+		bat->format = SND_PCM_FORMAT_S16_LE;
+		bat->rate = 44100;
+		bat->channels = 2;
+	} else if (strcasecmp(optarg, "dat") == 0) {
+		bat->format = SND_PCM_FORMAT_S16_LE;
+		bat->rate = 48000;
+		bat->channels = 2;
+	} else {
+		bat->format = snd_pcm_format_value(optarg);
+		if (bat->format == SND_PCM_FORMAT_UNKNOWN) {
+			fprintf(bat->err, _("wrong extended format '%s'\n"),
+					optarg);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	switch (bat->format) {
+	case SND_PCM_FORMAT_U8:
+		bat->sample_size = 1;
+		break;
+	case SND_PCM_FORMAT_S16_LE:
+		bat->sample_size = 2;
+		break;
+	case SND_PCM_FORMAT_S24_3LE:
+		bat->sample_size = 3;
+		break;
+	case SND_PCM_FORMAT_S32_LE:
+		bat->sample_size = 4;
+		break;
+	default:
+		fprintf(bat->err, _("unsupported format: %d\n"), bat->format);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static inline int thread_wait_completion(struct bat *bat,
+		pthread_t id, int **val)
+{
+	int err;
+
+	err = pthread_join(id, (void **) val);
+	if (err)
+		pthread_cancel(id);
+
+	return err;
+}
+
+/* loopback test where we play sine wave and capture the same sine wave */
+static void test_loopback(struct bat *bat)
+{
+	pthread_t capture_id, playback_id;
+	int err;
+	int *thread_result_capture, *thread_result_playback;
+
+	/* start playback */
+	err = pthread_create(&playback_id, NULL,
+			(void *) bat->playback.fct, bat);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot create playback thread: %d\n"),
+				err);
+		exit(EXIT_FAILURE);
+	}
+
+	/* TODO: use a pipe to signal stream start etc - i.e. to sync threads */
+	/* Let some time for playing something before capturing */
+	usleep(CAPTURE_DELAY * 1000);
+
+	/* start capture */
+	err = pthread_create(&capture_id, NULL, (void *) bat->capture.fct, bat);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot create capture thread: %d\n"), err);
+		pthread_cancel(playback_id);
+		exit(EXIT_FAILURE);
+	}
+
+	/* wait for playback to complete */
+	err = thread_wait_completion(bat, playback_id, &thread_result_playback);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot join playback thread: %d\n"), err);
+		free(thread_result_playback);
+		pthread_cancel(capture_id);
+		exit(EXIT_FAILURE);
+	}
+
+	/* check playback status */
+	if (*thread_result_playback != 0) {
+		fprintf(bat->err, _("Exit playback thread fail: %d\n"),
+				*thread_result_playback);
+		pthread_cancel(capture_id);
+		exit(EXIT_FAILURE);
+	} else {
+		fprintf(bat->log, _("Playback completed.\n"));
+	}
+
+	/* now stop and wait for capture to finish */
+	pthread_cancel(capture_id);
+	err = thread_wait_completion(bat, capture_id, &thread_result_capture);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot join capture thread: %d\n"), err);
+		free(thread_result_capture);
+		exit(EXIT_FAILURE);
+	}
+
+	/* check capture status */
+	if (*thread_result_capture != 0) {
+		fprintf(bat->err, _("Exit capture thread fail: %d\n"),
+				*thread_result_capture);
+		exit(EXIT_FAILURE);
+	} else {
+		fprintf(bat->log, _("Capture completed.\n"));
+	}
+}
+
+/* single ended playback only test */
+static void test_playback(struct bat *bat)
+{
+	pthread_t playback_id;
+	int err;
+	int *thread_result;
+
+	/* start playback */
+	err = pthread_create(&playback_id, NULL,
+			(void *) bat->playback.fct, bat);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot create playback thread: %d\n"),
+				err);
+		exit(EXIT_FAILURE);
+	}
+
+	/* wait for playback to complete */
+	err = thread_wait_completion(bat, playback_id, &thread_result);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot join playback thread: %d\n"), err);
+		free(thread_result);
+		exit(EXIT_FAILURE);
+	}
+
+	/* check playback status */
+	if (*thread_result != 0) {
+		fprintf(bat->err, _("Exit playback thread fail: %d\n"),
+				*thread_result);
+		exit(EXIT_FAILURE);
+	} else {
+		fprintf(bat->log, _("Playback completed.\n"));
+	}
+}
+
+/* single ended capture only test */
+static void test_capture(struct bat *bat)
+{
+	pthread_t capture_id;
+	int err;
+	int *thread_result;
+
+	/* start capture */
+	err = pthread_create(&capture_id, NULL, (void *) bat->capture.fct, bat);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot create capture thread: %d\n"), err);
+		exit(EXIT_FAILURE);
+	}
+
+	/* TODO: stop capture */
+
+	/* wait for capture to complete */
+	err = thread_wait_completion(bat, capture_id, &thread_result);
+	if (err != 0) {
+		fprintf(bat->err, _("Cannot join capture thread: %d\n"), err);
+		free(thread_result);
+		exit(EXIT_FAILURE);
+	}
+
+	/* check playback status */
+	if (*thread_result != 0) {
+		fprintf(bat->err, _("Exit capture thread fail: %d\n"),
+				*thread_result);
+		exit(EXIT_FAILURE);
+	} else {
+		fprintf(bat->log, _("Capture completed.\n"));
+	}
+}
+
+static void usage(struct bat *bat)
+{
+	fprintf(bat->log,
+_("Usage: alsabat [-options]...\n"
+"\n"
+"  -h, --help             this help\n"
+"  -D                     pcm device for both playback and capture\n"
+"  -P                     pcm device for playback\n"
+"  -C                     pcm device for capture\n"
+"  -f                     sample format\n"
+"  -c                     number of channels\n"
+"  -r                     sampling rate\n"
+"  -n                     frames to playback or capture\n"
+"  -k                     parameter for frequency detecting threshold\n"
+"  -F                     target frequency\n"
+"  -p                     total number of periods to play/capture\n"
+"      --log=#            file that both stdout and strerr redirecting to\n"
+"      --file=#           file for playback\n"
+"      --saveplay=#       file that storing playback content, for debug\n"
+"      --local            internal loop, set to bypass pcm hardware devices\n"
+));
+	fprintf(bat->log, _("Recognized sample formats are: %s %s %s %s\n"),
+			snd_pcm_format_name(SND_PCM_FORMAT_U8),
+			snd_pcm_format_name(SND_PCM_FORMAT_S16_LE),
+			snd_pcm_format_name(SND_PCM_FORMAT_S24_3LE),
+			snd_pcm_format_name(SND_PCM_FORMAT_S32_LE));
+	fprintf(bat->log, _("The available format shotcuts are:\n"));
+	fprintf(bat->log, _("-f cd (16 bit little endian, 44100, stereo)\n"));
+	fprintf(bat->log, _("-f dat (16 bit little endian, 48000, stereo)\n"));
+}
+
+static void set_defaults(struct bat *bat)
+{
+	memset(bat, 0, sizeof(struct bat));
+
+	/* Set default values */
+	bat->rate = 44100;
+	bat->channels = 1;
+	bat->frame_size = 2;
+	bat->sample_size = 2;
+	bat->format = SND_PCM_FORMAT_S16_LE;
+	bat->convert_float_to_sample = convert_float_to_int16;
+	bat->convert_sample_to_double = convert_int16_to_double;
+	bat->frames = bat->rate * 2;
+	bat->target_freq[0] = 997.0;
+	bat->target_freq[1] = 997.0;
+	bat->sigma_k = 3.0;
+	bat->playback.device = NULL;
+	bat->capture.device = NULL;
+	bat->buf = NULL;
+	bat->local = false;
+	bat->playback.fct = &playback_alsa;
+	bat->capture.fct = &record_alsa;
+	bat->playback.mode = MODE_LOOPBACK;
+	bat->capture.mode = MODE_LOOPBACK;
+	bat->period_is_limited = false;
+	bat->log = stdout;
+	bat->err = stderr;
+}
+
+static void parse_arguments(struct bat *bat, int argc, char *argv[])
+{
+	int c, option_index;
+	static const char short_options[] = "D:P:C:f:n:F:c:r:s:k:p:lth";
+	static const struct option long_options[] = {
+		{"help",     0, 0, 'h'},
+		{"log",      1, 0, OPT_LOG},
+		{"file",     1, 0, OPT_READFILE},
+		{"saveplay", 1, 0, OPT_SAVEPLAY},
+		{"local",    0, 0, OPT_LOCAL},
+		{0, 0, 0, 0}
+	};
+
+	while ((c = getopt_long(argc, argv, short_options, long_options,
+					&option_index)) != -1) {
+		switch (c) {
+		case OPT_LOG:
+			bat->logarg = optarg;
+			break;
+		case OPT_READFILE:
+			bat->playback.file = optarg;
+			break;
+		case OPT_SAVEPLAY:
+			bat->debugplay = optarg;
+			break;
+		case OPT_LOCAL:
+			bat->local = true;
+			break;
+		case 'D':
+			if (bat->playback.device == NULL)
+				bat->playback.device = optarg;
+			if (bat->capture.device == NULL)
+				bat->capture.device = optarg;
+			break;
+		case 'P':
+			if (bat->capture.mode == MODE_SINGLE)
+				bat->capture.mode = MODE_LOOPBACK;
+			else
+				bat->playback.mode = MODE_SINGLE;
+			bat->playback.device = optarg;
+			break;
+		case 'C':
+			if (bat->playback.mode == MODE_SINGLE)
+				bat->playback.mode = MODE_LOOPBACK;
+			else
+				bat->capture.mode = MODE_SINGLE;
+			bat->capture.device = optarg;
+			break;
+		case 'n':
+			bat->narg = optarg;
+			break;
+		case 'F':
+			get_sine_frequencies(bat, optarg);
+			break;
+		case 'c':
+			bat->channels = atoi(optarg);
+			break;
+		case 'r':
+			bat->rate = atoi(optarg);
+			break;
+		case 'f':
+			get_format(bat, optarg);
+			break;
+		case 'k':
+			bat->sigma_k = atof(optarg);
+			break;
+		case 'p':
+			bat->periods_total = atoi(optarg);
+			bat->period_is_limited = true;
+			break;
+		case 'h':
+		default:
+			usage(bat);
+			exit(EXIT_SUCCESS);
+		}
+	}
+}
+
+static int validate_options(struct bat *bat)
+{
+	int c;
+	float freq_low, freq_high;
+
+	/* check if we have an input file for local mode */
+	if ((bat->local == true) && (bat->capture.file == NULL)) {
+		fprintf(bat->err, _("no input file for local testing\n"));
+		return -EINVAL;
+	}
+
+	/* check supported channels */
+	if (bat->channels > MAX_CHANNELS || bat->channels < MIN_CHANNELS) {
+		fprintf(bat->err, _("%d channels not supported\n"),
+				bat->channels);
+		return -EINVAL;
+	}
+
+	/* check single ended is in either playback or capture - not both */
+	if ((bat->playback.mode == MODE_SINGLE)
+			&& (bat->capture.mode == MODE_SINGLE)) {
+		fprintf(bat->err, _("single ended mode is simplex\n"));
+		return -EINVAL;
+	}
+
+	/* check sine wave frequency range */
+	freq_low = DC_THRESHOLD;
+	freq_high = bat->rate * RATE_FACTOR;
+	for (c = 0; c < bat->channels; c++) {
+		if (bat->target_freq[c] < freq_low
+				|| bat->target_freq[c] > freq_high) {
+			fprintf(bat->err, _("sine wave frequency out of"));
+			fprintf(bat->err, _(" range: (%.1f, %.1f)\n"),
+				freq_low, freq_high);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int bat_init(struct bat *bat)
+{
+	int err = 0;
+	char name[] = TEMP_RECORD_FILE_NAME;
+
+	/* Determine logging to a file or stdout and stderr */
+	if (bat->logarg) {
+		bat->log = NULL;
+		bat->log = fopen(bat->logarg, "wb");
+		if (bat->log == NULL) {
+			fprintf(bat->err, _("Cannot open file for capture:"));
+			fprintf(bat->err, _(" %s %d\n"),
+					bat->logarg, -errno);
+			return -errno;
+		}
+		bat->err = bat->log;
+	}
+
+	/* Determine duration of playback and/or capture */
+	if (bat->narg) {
+		err = get_duration(bat);
+		if (err < 0)
+			return err;
+	}
+
+	/* Determine capture file */
+	if (bat->local) {
+		bat->capture.file = bat->playback.file;
+	} else {
+		/* create temp file for sound record and analysis */
+		err = mkstemp(name);
+		if (err == -1) {
+			fprintf(bat->err, _("Fail to create record file: %d\n"),
+					-errno);
+			return -errno;
+		}
+		/* store file name which is dynamically created */
+		bat->capture.file = strdup(name);
+		if (bat->capture.file == NULL)
+			return -errno;
+		/* close temp file */
+		close(err);
+	}
+
+	/* Initial for playback */
+	if (bat->playback.file == NULL) {
+		/* No input file so we will generate our own sine wave */
+		if (bat->frames) {
+			if (bat->playback.mode == MODE_SINGLE) {
+				/* Play nb of frames given by -n argument */
+				bat->sinus_duration = bat->frames;
+			} else {
+				/* Play CAPTURE_DELAY msec +
+				 * 150% of the nb of frames to be analyzed */
+				bat->sinus_duration = bat->rate *
+						CAPTURE_DELAY / 1000;
+				bat->sinus_duration +=
+						(bat->frames + bat->frames / 2);
+			}
+		} else {
+			/* Special case where we want to generate a sine wave
+			 * endlessly without capturing */
+			bat->sinus_duration = 0;
+			bat->playback.mode = MODE_SINGLE;
+		}
+	} else {
+		bat->fp = fopen(bat->playback.file, "rb");
+		if (bat->fp == NULL) {
+			fprintf(bat->err, _("Cannot open file for playback:"));
+			fprintf(bat->err, _(" %s %d\n"),
+					bat->playback.file, -errno);
+			return -errno;
+		}
+		err = read_wav_header(bat, bat->playback.file, bat->fp, false);
+		fclose(bat->fp);
+		if (err != 0)
+			return err;
+	}
+
+	bat->frame_size = bat->sample_size * bat->channels;
+
+	/* Set conversion functions */
+	switch (bat->sample_size) {
+	case 1:
+		bat->convert_float_to_sample = convert_float_to_uint8;
+		bat->convert_sample_to_double = convert_uint8_to_double;
+		break;
+	case 2:
+		bat->convert_float_to_sample = convert_float_to_int16;
+		bat->convert_sample_to_double = convert_int16_to_double;
+		break;
+	case 3:
+		bat->convert_float_to_sample = convert_float_to_int24;
+		bat->convert_sample_to_double = convert_int24_to_double;
+		break;
+	case 4:
+		bat->convert_float_to_sample = convert_float_to_int32;
+		bat->convert_sample_to_double = convert_int32_to_double;
+		break;
+	default:
+		fprintf(bat->err, _("Invalid PCM format: size=%d\n"),
+				bat->sample_size);
+		return -EINVAL;
+	}
+
+	return err;
+}
+
+int main(int argc, char *argv[])
+{
+	struct bat bat;
+	int err = 0;
+
+	set_defaults(&bat);
+
+#ifdef ENABLE_NLS
+	setlocale(LC_ALL, "");
+	textdomain(PACKAGE);
+#endif
+
+	fprintf(bat.log, _("%s version %s\n\n"), PACKAGE_NAME, PACKAGE_VERSION);
+
+	parse_arguments(&bat, argc, argv);
+
+	err = bat_init(&bat);
+	if (err < 0)
+		goto out;
+
+	err = validate_options(&bat);
+	if (err < 0)
+		goto out;
+
+	/* single line playback thread: playback only, no capture */
+	if (bat.playback.mode == MODE_SINGLE) {
+		test_playback(&bat);
+		goto out;
+	}
+
+	/* single line capture thread: capture only, no playback */
+	if (bat.capture.mode == MODE_SINGLE) {
+		test_capture(&bat);
+		goto analyze;
+	}
+
+	/* loopback thread: playback and capture in a loop */
+	if (bat.local == false)
+		test_loopback(&bat);
+
+analyze:
+	err = analyze_capture(&bat);
+out:
+	fprintf(bat.log, _("\nReturn value is %d\n"), err);
+
+	if (bat.logarg)
+		fclose(bat.log);
+	if (!bat.local)
+		free(bat.capture.file);
+
+	return err;
+}
diff --git a/alsabat/analyze.c b/alsabat/analyze.c
new file mode 100644
index 0000000..60e2d1c
--- /dev/null
+++ b/alsabat/analyze.c
@@ -0,0 +1,314 @@
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
+#include <stdlib.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <stdint.h>
+
+#include <math.h>
+#include <fftw3.h>
+
+#include "aconfig.h"
+#include "gettext.h"
+
+#include "common.h"
+
+static void check_amplitude(struct bat *bat, double *buf)
+{
+	double sum, average, amplitude;
+	int i, percent;
+
+	/* calculate average value */
+	for (i = 0, sum = 0.0; i < bat->frames; i++)
+		sum += buf[i];
+	average = sum / bat->frames;
+
+	/* calculate peak-to-average amplitude */
+	for (i = 0, sum = 0.0; i < bat->frames; i++)
+		sum += abs(buf[i] - average);
+	amplitude = sum / bat->frames * M_PI / 2.0;
+
+	/* calculate amplitude percentage against full range */
+	percent = amplitude * 100 / ((1 << ((bat->sample_size << 3) - 1)) - 1);
+
+	fprintf(bat->log, _("Amplitude: %.1f; Percentage: [%d]\n"),
+			amplitude, percent);
+	if (percent < 0)
+		fprintf(bat->err, _("ERROR: Amplitude can't be negative!\n"));
+	else if (percent < 1)
+		fprintf(bat->err, _("WARNING: Signal too weak!\n"));
+	else if (percent > 100)
+		fprintf(bat->err, _("WARNING: Signal overflow!\n"));
+}
+
+/**
+ *
+ * @return 0 if peak detected at right frequency,
+ *         1 if peak detected somewhere else
+ *         2 if DC detected
+ */
+int check_peak(struct bat *bat, struct analyze *a, int end, int peak, float hz,
+		float mean, float p, int channel, int start)
+{
+	int err;
+	float hz_peak = (float) (peak) * hz;
+	float delta_rate = DELTA_RATE * bat->target_freq[channel];
+	float delta_HZ = DELTA_HZ;
+	float tolerance = (delta_rate > delta_HZ) ? delta_rate : delta_HZ;
+
+	fprintf(bat->log, _("Detected peak at %2.2f Hz of %2.2f dB\n"), hz_peak,
+			10.0 * log10(a->mag[peak] / mean));
+	fprintf(bat->log, _(" Total %3.1f dB from %2.2f to %2.2f Hz\n"),
+			10.0 * log10(p / mean), start * hz, end * hz);
+
+	if (hz_peak < DC_THRESHOLD) {
+		fprintf(bat->err, _(" WARNING: Found low peak %2.2f Hz,"),
+				hz_peak);
+		fprintf(bat->err, _(" very close to DC\n"));
+		err = FOUND_DC;
+	} else if (hz_peak < bat->target_freq[channel] - tolerance) {
+		fprintf(bat->err, _(" FAIL: Peak freq too low %2.2f Hz\n"),
+				hz_peak);
+		err = FOUND_WRONG_PEAK;
+	} else if (hz_peak > bat->target_freq[channel] + tolerance) {
+		fprintf(bat->err, _(" FAIL: Peak freq too high %2.2f Hz\n"),
+				hz_peak);
+		err = FOUND_WRONG_PEAK;
+	} else {
+		fprintf(bat->log, _(" PASS: Peak detected"));
+		fprintf(bat->log, _(" at target frequency\n"));
+		err = 0;
+	}
+
+	return err;
+}
+
+/**
+ * Search for main frequencies in fft results and compare it to target
+ */
+static int check(struct bat *bat, struct analyze *a, int channel)
+{
+	float hz = 1.0 / ((float) bat->frames / (float) bat->rate);
+	float mean = 0.0, t, sigma = 0.0, p = 0.0;
+	int i, start = -1, end = -1, peak = 0, signals = 0;
+	int err = 0, N = bat->frames / 2;
+
+	/* calculate mean */
+	for (i = 0; i < N; i++)
+		mean += a->mag[i];
+	mean /= (float) N;
+
+	/* calculate standard deviation */
+	for (i = 0; i < N; i++) {
+		t = a->mag[i] - mean;
+		t *= t;
+		sigma += t;
+	}
+	sigma /= (float) N;
+	sigma = sqrtf(sigma);
+
+	/* clip any data less than k sigma + mean */
+	for (i = 0; i < N; i++) {
+		if (a->mag[i] > mean + bat->sigma_k * sigma) {
+
+			/* find peak start points */
+			if (start == -1) {
+				start = peak = end = i;
+				signals++;
+			} else {
+				if (a->mag[i] > a->mag[peak])
+					peak = i;
+				end = i;
+			}
+			p += a->mag[i];
+		} else if (start != -1) {
+			/* Check if peak is as expected */
+			err |= check_peak(bat, a, end, peak, hz, mean,
+					p, channel, start);
+			end = start = -1;
+			if (signals == MAX_PEAKS)
+				break;
+		}
+	}
+	if (signals == 0)
+		err = -ENOPEAK; /* No peak detected */
+	else if ((err == FOUND_DC) && (signals == 1))
+		err = -EONLYDC; /* Only DC detected */
+	else if ((err & FOUND_WRONG_PEAK) == FOUND_WRONG_PEAK)
+		err = -EBADPEAK; /* Bad peak detected */
+	else
+		err = 0; /* Correct peak detected */
+
+	fprintf(bat->log, _("Detected at least %d signal(s) in total\n"),
+			signals);
+
+	return err;
+}
+
+static void calc_magnitude(struct bat *bat, struct analyze *a, int N)
+{
+	double r2, i2;
+	int i;
+
+	for (i = 1; i < N / 2; i++) {
+		r2 = a->out[i] * a->out[i];
+		i2 = a->out[N - i] * a->out[N - i];
+
+		a->mag[i] = sqrtf(r2 + i2);
+	}
+	a->mag[0] = 0.0;
+}
+
+static int find_and_check_harmonics(struct bat *bat, struct analyze *a,
+		int channel)
+{
+	fftw_plan p;
+	int err = -ENOMEM, N = bat->frames;
+
+	/* Allocate FFT buffers */
+	a->in = (double *) fftw_malloc(sizeof(double) * bat->frames);
+	if (a->in == NULL)
+		goto out1;
+
+	a->out = (double *) fftw_malloc(sizeof(double) * bat->frames);
+	if (a->out == NULL)
+		goto out2;
+
+	a->mag = (double *) fftw_malloc(sizeof(double) * bat->frames);
+	if (a->mag == NULL)
+		goto out3;
+
+	/* create FFT plan */
+	p = fftw_plan_r2r_1d(N, a->in, a->out, FFTW_R2HC,
+			FFTW_MEASURE | FFTW_PRESERVE_INPUT);
+	if (p == NULL)
+		goto out4;
+
+	/* convert source PCM to doubles */
+	bat->convert_sample_to_double(a->buf, a->in, bat->frames);
+
+	/* check amplitude */
+	check_amplitude(bat, a->in);
+
+	/* run FFT */
+	fftw_execute(p);
+
+	/* FFT out is real and imaginary numbers - calc magnitude for each */
+	calc_magnitude(bat, a, N);
+
+	/* check data */
+	err = check(bat, a, channel);
+
+	fftw_destroy_plan(p);
+
+out4:
+	fftw_free(a->mag);
+out3:
+	fftw_free(a->out);
+out2:
+	fftw_free(a->in);
+out1:
+	return err;
+}
+
+/**
+ * Convert interleaved samples from channels in samples from a single channel
+ */
+static int reorder_data(struct bat *bat)
+{
+	char *p, *new_bat_buf;
+	int ch, i, j;
+
+	if (bat->channels == 1)
+		return 0; /* No need for reordering */
+
+	p = malloc(bat->frames * bat->frame_size);
+	new_bat_buf = p;
+	if (p == NULL)
+		return -ENOMEM;
+
+	for (ch = 0; ch < bat->channels; ch++) {
+		for (j = 0; j < bat->frames; j++) {
+			for (i = 0; i < bat->sample_size; i++) {
+				*p++ = ((char *) (bat->buf))[j * bat->frame_size
+						+ ch * bat->sample_size + i];
+			}
+		}
+	}
+
+	free(bat->buf);
+	bat->buf = new_bat_buf;
+
+	return 0;
+}
+
+int analyze_capture(struct bat *bat)
+{
+	int err = 0;
+	size_t items;
+	int c;
+	struct analyze a;
+
+	fprintf(bat->log, _("\nBAT analysis: signal has %d frames at %d Hz,"),
+			bat->frames, bat->rate);
+	fprintf(bat->log, _(" %d channels, %d bytes per sample.\n"),
+			bat->channels, bat->sample_size);
+
+	bat->buf = malloc(bat->frames * bat->frame_size);
+	if (bat->buf == NULL)
+		return -ENOMEM;
+
+	bat->fp = fopen(bat->capture.file, "rb");
+	if (bat->fp == NULL) {
+		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
+				bat->capture.file, -errno);
+		err = -errno;
+		goto exit1;
+	}
+
+	/* Skip header */
+	err = read_wav_header(bat, bat->capture.file, bat->fp, true);
+	if (err != 0)
+		goto exit2;
+
+	items = fread(bat->buf, bat->frame_size, bat->frames, bat->fp);
+	if (items != bat->frames) {
+		err = -EIO;
+		goto exit2;
+	}
+
+	err = reorder_data(bat);
+	if (err != 0)
+		goto exit2;
+
+	for (c = 0; c < bat->channels; c++) {
+		fprintf(bat->log, _("\nChannel %i - "), c + 1);
+		fprintf(bat->log, _("Checking for target frequency %2.2f Hz\n"),
+				bat->target_freq[c]);
+		a.buf = bat->buf +
+				c * bat->frames * bat->frame_size
+				/ bat->channels;
+		err = find_and_check_harmonics(bat, &a, c);
+	}
+
+exit2:
+	fclose(bat->fp);
+exit1:
+	free(bat->buf);
+
+	return err;
+}
diff --git a/alsabat/analyze.h b/alsabat/analyze.h
new file mode 100644
index 0000000..3fd03d4
--- /dev/null
+++ b/alsabat/analyze.h
@@ -0,0 +1,16 @@
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
+int analyze_capture(struct bat *);
diff --git a/alsabat/bat-signal.h b/alsabat/bat-signal.h
new file mode 100644
index 0000000..a295517
--- /dev/null
+++ b/alsabat/bat-signal.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2015 Caleb Crome
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
+/*
+ * Here's a generic sine wave generator that will work indefinitely
+ * for any frequency.
+ *
+ * Note:  the state & phasor are stored as doubles (and updated as
+ * doubles) because after a million samples the magnitude drifts a
+ * bit.  If we really need floats, it can be done with periodic
+ * renormalization of the state_real+state_imag magnitudes.
+ */
+
+int sin_generator_init(struct sin_generator *, float, float, float);
+float sin_generator_next_sample(struct sin_generator *);
+void sin_generator_vfill(struct sin_generator *, float *, int);
+int generate_sine_wave(struct bat *, int, void *);
diff --git a/alsabat/common.c b/alsabat/common.c
new file mode 100644
index 0000000..798b00b
--- /dev/null
+++ b/alsabat/common.c
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
diff --git a/alsabat/common.h b/alsabat/common.h
new file mode 100644
index 0000000..c04452d
--- /dev/null
+++ b/alsabat/common.h
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
+#define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav.XXXXXX"
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
diff --git a/alsabat/convert.c b/alsabat/convert.c
new file mode 100644
index 0000000..dcbe912
--- /dev/null
+++ b/alsabat/convert.c
@@ -0,0 +1,113 @@
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
+#include <stdint.h>
+
+void convert_uint8_to_double(void *buf, double *val, int samples)
+{
+	int i;
+
+	for (i = 0; i < samples; i++)
+		val[i] = ((uint8_t *) buf)[i];
+}
+
+void convert_int16_to_double(void *buf, double *val, int samples)
+{
+	int i;
+
+	for (i = 0; i < samples; i++)
+		val[i] = ((int16_t *) buf)[i];
+}
+
+void convert_int24_to_double(void *buf, double *val, int samples)
+{
+	int i;
+	int32_t tmp;
+
+	for (i = 0; i < samples; i++) {
+		tmp = ((uint8_t *) buf)[i * 3 + 2] << 24;
+		tmp |= ((uint8_t *) buf)[i * 3 + 1] << 16;
+		tmp |= ((uint8_t *) buf)[i * 3] << 8;
+		tmp >>= 8;
+		val[i] = tmp;
+	}
+}
+
+void convert_int32_to_double(void *buf, double *val, int samples)
+{
+	int i;
+
+	for (i = 0; i < samples; i++)
+		val[i] = ((int32_t *) buf)[i];
+}
+
+void convert_float_to_uint8(float *val, void *buf, int samples, int channels)
+{
+	int i, c, idx;
+
+	for (i = 0; i < samples; i++) {
+		for (c = 0; c < channels; c++) {
+			idx = i * channels + c;
+			((uint8_t *) buf)[idx] = (uint8_t) val[idx];
+		}
+	}
+}
+
+void convert_float_to_int16(float *val, void *buf, int samples, int channels)
+{
+	int i, c, idx;
+
+	for (i = 0; i < samples; i++) {
+		for (c = 0; c < channels; c++) {
+			idx = i * channels + c;
+			((int16_t *) buf)[idx] = (int16_t) val[idx];
+		}
+	}
+}
+
+void convert_float_to_int24(float *val, void *buf, int samples, int channels)
+{
+	int i, c, idx_f, idx_i;
+	int32_t val_f_i;
+
+	for (i = 0; i < samples; i++) {
+		for (c = 0; c < channels; c++) {
+			idx_f = i * channels + c;
+			idx_i = 3 * idx_f;
+			val_f_i = (int32_t) val[idx_f];
+			((int8_t *) buf)[idx_i + 0] =
+				(int8_t) (val_f_i & 0xff);
+			((int8_t *) buf)[idx_i + 1] =
+				(int8_t) ((val_f_i >> 8) & 0xff);
+			((int8_t *) buf)[idx_i + 2] =
+				(int8_t) ((val_f_i >> 16) & 0xff);
+		}
+	}
+}
+
+void convert_float_to_int32(float *val, void *buf, int samples, int channels)
+{
+	int i, c, idx;
+
+	for (i = 0; i < samples; i++) {
+		for (c = 0; c < channels; c++) {
+			idx = i * channels + c;
+			((int32_t *) buf)[idx] = (int32_t) val[idx];
+		}
+	}
+}
diff --git a/alsabat/convert.h b/alsabat/convert.h
new file mode 100644
index 0000000..28828ba
--- /dev/null
+++ b/alsabat/convert.h
@@ -0,0 +1,23 @@
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
+void convert_uint8_to_double(void *, double *, int);
+void convert_int16_to_double(void *, double *, int);
+void convert_int24_to_double(void *, double *, int);
+void convert_int32_to_double(void *, double *, int);
+void convert_float_to_uint8(float *, void *, int, int);
+void convert_float_to_int16(float *, void *, int, int);
+void convert_float_to_int24(float *, void *, int, int);
+void convert_float_to_int32(float *, void *, int, int);
diff --git a/alsabat/signal.c b/alsabat/signal.c
new file mode 100644
index 0000000..d342d00
--- /dev/null
+++ b/alsabat/signal.c
@@ -0,0 +1,184 @@
+/*
+ * Copyright (C) 2015 Caleb Crome
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
+/*
+ * This is a general purpose sine wave generator that will stay stable
+ * for a long time, and with a little renormalization, could stay stay
+ * stable indefinitely
+ */
+
+#include <stdio.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <math.h>
+#include <stdint.h>
+#include <stdbool.h>
+
+#include "gettext.h"
+#include "common.h"
+#include "signal.h"
+
+/*
+ * Initialize the sine wave generator.
+ * sin_generator:  gets initialized by this call.
+ * frequency:      the frequency for the sine wave.  must be < 0.5*sample_rate
+ * sample_rate:    the sample rate...
+ * returns 0 on success, -1 on error.
+ */
+int sin_generator_init(struct sin_generator *sg, float magnitude,
+		float frequency, float sample_rate)
+{
+	/* angular frequency:  cycles/sec / (samp/sec) * rad/cycle = rad/samp */
+	float w = frequency / sample_rate * 2 * M_PI;
+
+	if (frequency >= sample_rate / 2)
+		return -1;
+	sg->phasor_real = cos(w);
+	sg->phasor_imag = sin(w);
+	sg->magnitude   = magnitude;
+	sg->state_real  = 0.0;
+	sg->state_imag  = magnitude;
+	sg->frequency = frequency;
+	sg->sample_rate = sample_rate;
+	return 0;
+}
+
+/*
+ * Generates the next sample in the sine wave.
+ * should be much faster than calling a sin function
+ * if it's inlined and optimized.
+ *
+ * returns the next value.  no possibility of error.
+ */
+float sin_generator_next_sample(struct sin_generator *sg)
+{
+	/* get shorthand to pointers */
+	const double pr = sg->phasor_real;
+	const double pi = sg->phasor_imag;
+	const double sr = sg->state_real;
+	const double si = sg->state_imag;
+	/* step the phasor -- complex multiply */
+	sg->state_real = sr * pr - si * pi;
+	sg->state_imag = sr * pi + pr * si;
+	/* return the input value so sine wave starts at exactly 0.0 */
+	return sr;
+}
+
+/* fills a vector with a sine wave */
+void sin_generator_vfill(struct sin_generator *sg, float *buf, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		*buf++ = sin_generator_next_sample(sg);
+}
+
+static int reorder(struct bat *bat, float *val, int frames)
+{
+	float *new_buf = NULL;
+	int i, c, bytes;
+
+	bytes = frames * bat->channels * sizeof(float);
+
+	new_buf = (float *) malloc(bytes);
+	if (new_buf == NULL) {
+		fprintf(bat->err, _("Not enough memory.\n"));
+		return -ENOMEM;
+	}
+
+	memcpy(new_buf, val, bytes);
+	for (i = 0; i < frames; i++)
+		for (c = 0; c < bat->channels; c++)
+			val[i * bat->channels + c] =
+				new_buf[c * frames + i];
+	free(new_buf);
+
+	return 0;
+}
+
+static int adjust_waveform(struct bat *bat, float *val, int frames)
+{
+	int i, nsamples, max;
+	float factor, offset = 0.0;
+
+	switch (bat->format) {
+	case SND_PCM_FORMAT_U8:
+		max = INT8_MAX;
+		offset = max;	/* shift for unsigned format */
+		break;
+	case SND_PCM_FORMAT_S16_LE:
+		max  = INT16_MAX;
+		break;
+	case SND_PCM_FORMAT_S24_3LE:
+		max = (1 << 23) - 1;
+		break;
+	case SND_PCM_FORMAT_S32_LE:
+		max = INT32_MAX;
+		break;
+	default:
+		fprintf(bat->err, _("Invalid PCM format: %s\n"),
+				snd_pcm_format_name(bat->format));
+		return -EINVAL;
+	}
+
+	factor = max * RANGE_FACTOR;
+	nsamples = bat->channels * frames;
+
+	for (i = 0; i < nsamples; i++)
+		val[i] = val[i] * factor + offset;
+
+	return 0;
+}
+
+int generate_sine_wave(struct bat *bat, int frames, void *buf)
+{
+	int err = 0;
+	int c, nsamples;
+	float *sinus_f = NULL;
+	static struct sin_generator sg[MAX_CHANNELS];
+
+	nsamples = bat->channels * frames;
+	sinus_f = (float *) malloc(nsamples * sizeof(float));
+	if (sinus_f == NULL) {
+		fprintf(bat->err, _("Not enough memory.\n"));
+		return -ENOMEM;
+	}
+
+	for (c = 0; c < bat->channels; c++) {
+		/* initialize static struct at the first time */
+		if (sg[c].frequency != bat->target_freq[c])
+			sin_generator_init(&sg[c], 1.0, bat->target_freq[c],
+					bat->rate);
+		/* fill buffer for each channel */
+		sin_generator_vfill(&sg[c], sinus_f + c * frames, frames);
+	}
+
+	/* reorder samples to interleaved mode */
+	err = reorder(bat, sinus_f, frames);
+	if (err != 0)
+		return err;
+
+	/* adjust amplitude and offset of waveform */
+	err = adjust_waveform(bat, sinus_f, frames);
+	if (err != 0)
+		return err;
+
+	bat->convert_float_to_sample(sinus_f, buf, frames, bat->channels);
+
+	free(sinus_f);
+
+	return 0;
+}
diff --git a/bat/Makefile.am b/bat/Makefile.am
deleted file mode 100644
index f0dc5ab..0000000
--- a/bat/Makefile.am
+++ /dev/null
@@ -1,24 +0,0 @@
-bin_PROGRAMS = bat
-man_MANS = bat.1
-
-EXTRA_DIST = bat.1
-
-bat_SOURCES = \
-	bat.c \
-	common.c \
-	analyze.c \
-	signal.c \
-	convert.c \
-	alsa.c
-
-noinst_HEADERS = \
-	common.h \
-	bat-signal.h \
-	alsa.h \
-	convert.h \
-	analyze.h
-
-AM_CPPFLAGS = \
-	      -Wall -I$(top_srcdir)/include
-
-bat_LDADD = @FFTW_LIB@
diff --git a/bat/alsa.c b/bat/alsa.c
deleted file mode 100644
index 5eaa25b..0000000
--- a/bat/alsa.c
+++ /dev/null
@@ -1,604 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdbool.h>
-#include <math.h>
-#include <stdint.h>
-#include <pthread.h>
-
-#include <alsa/asoundlib.h>
-
-#include "aconfig.h"
-#include "gettext.h"
-
-#include "common.h"
-#include "alsa.h"
-#include "bat-signal.h"
-
-struct pcm_container {
-	snd_pcm_t *handle;
-	snd_pcm_uframes_t period_size;
-	snd_pcm_uframes_t buffer_size;
-	snd_pcm_format_t format;
-	unsigned short channels;
-	size_t period_bytes;
-	size_t sample_bits;
-	size_t frame_bits;
-	char *buffer;
-};
-
-static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
-{
-	snd_pcm_hw_params_t *params;
-	unsigned int buffer_time = 0;
-	unsigned int period_time = 0;
-	unsigned int rate;
-	int err;
-	const char *device_name = snd_pcm_name(sndpcm->handle);
-
-	/* Allocate a hardware parameters object. */
-	snd_pcm_hw_params_alloca(&params);
-
-	/* Fill it in with default values. */
-	err = snd_pcm_hw_params_any(sndpcm->handle, params);
-	if (err < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("default params: %s: %s(%d)\n"),
-				device_name, snd_strerror(err), err);
-		return err;
-	}
-
-	/* Set access mode */
-	err = snd_pcm_hw_params_set_access(sndpcm->handle, params,
-			SND_PCM_ACCESS_RW_INTERLEAVED);
-	if (err < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("access type: %s: %s(%d)\n"),
-				device_name, snd_strerror(err), err);
-		return err;
-	}
-
-	/* Set format */
-	err = snd_pcm_hw_params_set_format(sndpcm->handle, params, bat->format);
-	if (err < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("PCM format: %d %s: %s(%d)\n"),
-				bat->format,
-				device_name, snd_strerror(err), err);
-		return err;
-	}
-
-	/* Set channels */
-	err = snd_pcm_hw_params_set_channels(sndpcm->handle,
-			params, bat->channels);
-	if (err < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("channel number: %d %s: %s(%d)\n"),
-				bat->channels,
-				device_name, snd_strerror(err), err);
-		return err;
-	}
-
-	/* Set sampling rate */
-	rate = bat->rate;
-	err = snd_pcm_hw_params_set_rate_near(sndpcm->handle,
-			params, &bat->rate,
-			0);
-	if (err < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("sample rate: %d %s: %s(%d)\n"),
-				bat->rate,
-				device_name, snd_strerror(err), err);
-		return err;
-	}
-	if ((float) rate * (1 + RATE_RANGE) < bat->rate
-			|| (float) rate * (1 - RATE_RANGE) > bat->rate) {
-		fprintf(bat->err, _("Invalid parameters: sample rate: "));
-		fprintf(bat->err, _("requested %dHz, got %dHz\n"),
-				rate, bat->rate);
-		return -EINVAL;
-	}
-
-	if (snd_pcm_hw_params_get_buffer_time_max(params,
-			&buffer_time, 0) < 0) {
-		fprintf(bat->err, _("Get parameter from device error: "));
-		fprintf(bat->err, _("buffer time: %d %s: %s(%d)\n"),
-				buffer_time,
-				device_name, snd_strerror(err), err);
-		return -EINVAL;
-	}
-
-	if (buffer_time > MAX_BUFFERTIME)
-		buffer_time = MAX_BUFFERTIME;
-
-	period_time = buffer_time / DIV_BUFFERTIME;
-
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
-
-	err = snd_pcm_hw_params_set_period_time_near(sndpcm->handle, params,
-			&period_time, 0);
-	if (err < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("period time: %d %s: %s(%d)\n"),
-				period_time,
-				device_name, snd_strerror(err), err);
-		return err;
-	}
-
-	/* Write the parameters to the driver */
-	if (snd_pcm_hw_params(sndpcm->handle, params) < 0) {
-		fprintf(bat->err, _("Set parameter to device error: "));
-		fprintf(bat->err, _("hw params: %s: %s(%d)\n"),
-				device_name, snd_strerror(err), err);
-		return -EINVAL;
-	}
-
-	err = snd_pcm_hw_params_get_period_size(params,
-			&sndpcm->period_size, 0);
-	if (err < 0) {
-		fprintf(bat->err, _("Get parameter from device error: "));
-		fprintf(bat->err, _("period size: %zd %s: %s(%d)\n"),
-				sndpcm->period_size,
-				device_name, snd_strerror(err), err);
-		return err;
-	}
-
-	err = snd_pcm_hw_params_get_buffer_size(params, &sndpcm->buffer_size);
-	if (err < 0) {
-		fprintf(bat->err, _("Get parameter from device error: "));
-		fprintf(bat->err, _("buffer size: %zd %s: %s(%d)\n"),
-				sndpcm->buffer_size,
-				device_name, snd_strerror(err), err);
-		return err;
-	}
-
-	if (sndpcm->period_size == sndpcm->buffer_size) {
-		fprintf(bat->err, _("Invalid parameters: can't use period "));
-		fprintf(bat->err, _("equal to buffer size (%zd)\n"),
-				sndpcm->period_size);
-		return -EINVAL;
-	}
-
-	err = snd_pcm_format_physical_width(bat->format);
-	if (err < 0) {
-		fprintf(bat->err, _("Invalid parameters: "));
-		fprintf(bat->err, _("snd_pcm_format_physical_width: %d\n"),
-				err);
-		return err;
-	}
-	sndpcm->sample_bits = err;
-
-	sndpcm->frame_bits = sndpcm->sample_bits * bat->channels;
-
-	/* Calculate the period bytes */
-	sndpcm->period_bytes = sndpcm->period_size * sndpcm->frame_bits / 8;
-	sndpcm->buffer = (char *) malloc(sndpcm->period_bytes);
-	if (sndpcm->buffer == NULL) {
-		fprintf(bat->err, _("Not enough memory: size=%zd\n"),
-				sndpcm->period_bytes);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-/*
- * Generate buffer to be played either from input file or from generated data
- * Return value
- * <0 error
- * 0 ok
- * >0 break
- */
-static int generate_input_data(struct pcm_container *sndpcm, int bytes,
-		struct bat *bat)
-{
-	int err;
-	static int load;
-	int frames = bytes * 8 / sndpcm->frame_bits;
-
-	if (bat->playback.file != NULL) {
-		/* From input file */
-		load = 0;
-
-		while (1) {
-			err = fread(sndpcm->buffer + load, 1,
-					bytes - load, bat->fp);
-			if (0 == err) {
-				if (feof(bat->fp)) {
-					fprintf(bat->log,
-							_("End of playing.\n"));
-					return 1;
-				}
-			} else if (err < bytes - load) {
-				if (ferror(bat->fp)) {
-					fprintf(bat->err, _("Read file error"));
-					fprintf(bat->err, _(": %d\n"), err);
-					return -EIO;
-				}
-				load += err;
-			} else {
-				break;
-			}
-		}
-	} else {
-		/* Generate sine wave */
-		if ((bat->sinus_duration) && (load > bat->sinus_duration))
-			return 1;
-
-		err = generate_sine_wave(bat, frames, (void *)sndpcm->buffer);
-		if (err != 0)
-			return err;
-
-		load += frames;
-	}
-
-	return 0;
-}
-
-static int write_to_pcm(const struct pcm_container *sndpcm,
-		int frames, struct bat *bat)
-{
-	int err;
-	int offset = 0;
-	int remain = frames;
-
-	while (remain > 0) {
-		err = snd_pcm_writei(sndpcm->handle, sndpcm->buffer + offset,
-				remain);
-		if (err == -EAGAIN || (err >= 0 && err < frames)) {
-			snd_pcm_wait(sndpcm->handle, 500);
-		} else if (err == -EPIPE) {
-			fprintf(bat->err, _("Underrun: %s(%d)\n"),
-					snd_strerror(err), err);
-			snd_pcm_prepare(sndpcm->handle);
-		} else if (err < 0) {
-			fprintf(bat->err, _("Write PCM device error: %s(%d)\n"),
-					snd_strerror(err), err);
-			return err;
-		}
-
-		if (err > 0) {
-			remain -= err;
-			offset += err * sndpcm->frame_bits / 8;
-		}
-	}
-
-	return 0;
-}
-
-static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
-{
-	int err;
-	int bytes = sndpcm->period_bytes; /* playback buffer size */
-	int frames = bytes * 8 / sndpcm->frame_bits; /* frame count */
-	FILE *fp = NULL;
-	struct wav_container wav;
-	int bytes_total = 0;
-
-	if (bat->debugplay) {
-		fp = fopen(bat->debugplay, "wb");
-		if (fp == NULL) {
-			fprintf(bat->err, _("Cannot open file for capture: "));
-			fprintf(bat->err, _("%s %d\n"), bat->debugplay, -errno);
-			return -errno;
-		}
-		/* leave space for wav header */
-		err = fseek(fp, sizeof(wav), SEEK_SET);
-		if (err != 0) {
-			fprintf(bat->err, _("Seek file error: %d %d\n"),
-					err, -errno);
-			return -errno;
-		}
-	}
-
-	while (1) {
-		err = generate_input_data(sndpcm, bytes, bat);
-		if (err < 0)
-			return err;
-		else if (err > 0)
-			break;
-
-		if (bat->debugplay) {
-			err = fwrite(sndpcm->buffer, 1, bytes, fp);
-			if (err != bytes) {
-				fprintf(bat->err, _("Write file error: "));
-				fprintf(bat->err, _("%s(%d)\n"),
-						snd_strerror(err), err);
-				return -EIO;
-			}
-			bytes_total += bytes;
-		}
-
-		bat->periods_played++;
-		if (bat->period_is_limited
-				&& bat->periods_played >= bat->periods_total)
-			break;
-
-		err = write_to_pcm(sndpcm, frames, bat);
-		if (err != 0)
-			return err;
-	}
-
-	if (bat->debugplay) {
-		/* update wav header */
-		prepare_wav_info(&wav, bat);
-		wav.chunk.length = bytes_total;
-		wav.header.length = (wav.chunk.length) + sizeof(wav.chunk)
-			+ sizeof(wav.format) + sizeof(wav.header) - 8;
-
-		rewind(fp);
-		err = write_wav_header(fp, &wav, bat);
-		if (err != 0) {
-			fprintf(bat->err, _("Write file error: %s %s(%d)\n"),
-					bat->debugplay, snd_strerror(err), err);
-			return err;
-		}
-		fclose(fp);
-	}
-
-	snd_pcm_drain(sndpcm->handle);
-
-	return 0;
-}
-
-/**
- * Play
- */
-void *playback_alsa(struct bat *bat)
-{
-	int err = 0;
-	struct pcm_container sndpcm;
-
-	fprintf(bat->log, _("Entering playback thread (ALSA).\n"));
-
-	retval_play = 0;
-	memset(&sndpcm, 0, sizeof(sndpcm));
-
-	if (bat->playback.device == NULL) {
-		fprintf(bat->err, _("No PCM device for playback: exit\n"));
-		retval_play = 1;
-		goto exit1;
-	}
-
-	err = snd_pcm_open(&sndpcm.handle, bat->playback.device,
-			SND_PCM_STREAM_PLAYBACK, 0);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot open PCM playback device: "));
-		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
-		retval_play = 1;
-		goto exit1;
-	}
-
-	err = set_snd_pcm_params(bat, &sndpcm);
-	if (err != 0) {
-		retval_play = 1;
-		goto exit2;
-	}
-
-	if (bat->playback.file == NULL) {
-		fprintf(bat->log, _("Playing generated audio sine wave"));
-		bat->sinus_duration == 0 ?
-			fprintf(bat->log, _(" endlessly\n")) :
-			fprintf(bat->log, _("\n"));
-	} else {
-		fprintf(bat->log, _("Playing input audio file: %s\n"),
-				bat->playback.file);
-		bat->fp = fopen(bat->playback.file, "rb");
-		if (bat->fp == NULL) {
-			fprintf(bat->err, _("Cannot open file for capture: "));
-			fprintf(bat->err, _("%s %d\n"),
-					bat->playback.file, -errno);
-			retval_play = 1;
-			goto exit3;
-		}
-		/* Skip header */
-		err = read_wav_header(bat, bat->playback.file, bat->fp, true);
-		if (err != 0) {
-			retval_play = 1;
-			goto exit4;
-		}
-	}
-
-	err = write_to_pcm_loop(&sndpcm, bat);
-	if (err != 0) {
-		retval_play = 1;
-		goto exit4;
-	}
-
-exit4:
-	if (bat->playback.file)
-		fclose(bat->fp);
-exit3:
-	free(sndpcm.buffer);
-exit2:
-	snd_pcm_close(sndpcm.handle);
-exit1:
-	pthread_exit(&retval_play);
-}
-
-static int read_from_pcm(struct pcm_container *sndpcm,
-		int frames, struct bat *bat)
-{
-	int err = 0;
-	int offset = 0;
-	int remain = frames;
-
-	while (remain > 0) {
-		err = snd_pcm_readi(sndpcm->handle,
-				sndpcm->buffer + offset, remain);
-		if (err == -EAGAIN || (err >= 0 && err < remain)) {
-			snd_pcm_wait(sndpcm->handle, 500);
-		} else if (err == -EPIPE) {
-			snd_pcm_prepare(sndpcm->handle);
-			fprintf(bat->err, _("Overrun: %s(%d)\n"),
-					snd_strerror(err), err);
-		} else if (err < 0) {
-			fprintf(bat->err, _("Read PCM device error: %s(%d)\n"),
-					snd_strerror(err), err);
-			return err;
-		}
-
-		if (err > 0) {
-			remain -= err;
-			offset += err * sndpcm->frame_bits / 8;
-		}
-	}
-
-	return 0;
-}
-
-static int read_from_pcm_loop(FILE *fp, int count,
-		struct pcm_container *sndpcm, struct bat *bat)
-{
-	int err = 0;
-	int size, frames;
-	int remain = count;
-
-	while (remain > 0) {
-		size = (remain <= sndpcm->period_bytes) ?
-			remain : sndpcm->period_bytes;
-		frames = size * 8 / sndpcm->frame_bits;
-
-		/* read a chunk from pcm device */
-		err = read_from_pcm(sndpcm, frames, bat);
-		if (err != 0)
-			return err;
-
-		/* write the chunk to file */
-		err = fwrite(sndpcm->buffer, 1, size, fp);
-		if (err != size) {
-			fprintf(bat->err, _("Write file error: %s(%d)\n"),
-					snd_strerror(err), err);
-			return -EIO;
-		}
-		remain -= size;
-		bat->periods_played++;
-
-		if (bat->period_is_limited
-				&& bat->periods_played >= bat->periods_total)
-			break;
-	}
-
-	return 0;
-}
-
-static void pcm_cleanup(void *p)
-{
-	snd_pcm_close(p);
-}
-
-static void file_cleanup(void *p)
-{
-	fclose(p);
-}
-
-/**
- * Record
- */
-void *record_alsa(struct bat *bat)
-{
-	int err = 0;
-	FILE *fp = NULL;
-	struct pcm_container sndpcm;
-	struct wav_container wav;
-	int count;
-
-	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
-
-	fprintf(bat->log, _("Entering capture thread (ALSA).\n"));
-
-	retval_record = 0;
-	memset(&sndpcm, 0, sizeof(sndpcm));
-
-	if (bat->capture.device == NULL) {
-		fprintf(bat->err, _("No PCM device for capture: exit\n"));
-		retval_record = 1;
-		goto exit1;
-	}
-
-	err = snd_pcm_open(&sndpcm.handle, bat->capture.device,
-			SND_PCM_STREAM_CAPTURE, 0);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot open PCM capture device: "));
-		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
-		retval_record = 1;
-		goto exit1;
-	}
-
-	err = set_snd_pcm_params(bat, &sndpcm);
-	if (err != 0) {
-		retval_record = 1;
-		goto exit2;
-	}
-
-	remove(bat->capture.file);
-	fp = fopen(bat->capture.file, "w+");
-	if (fp == NULL) {
-		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
-				bat->capture.file, -errno);
-		retval_record = 1;
-		goto exit3;
-	}
-
-	prepare_wav_info(&wav, bat);
-
-	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
-	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
-	pthread_cleanup_push(pcm_cleanup, sndpcm.handle);
-	pthread_cleanup_push(free, sndpcm.buffer);
-	pthread_cleanup_push(file_cleanup, fp);
-
-	err = write_wav_header(fp, &wav, bat);
-	if (err != 0) {
-		retval_record = 1;
-		goto exit4;
-	}
-
-	count = wav.chunk.length;
-	fprintf(bat->log, _("Recording ...\n"));
-	err = read_from_pcm_loop(fp, count, &sndpcm, bat);
-	if (err != 0) {
-		retval_record = 1;
-		goto exit4;
-	}
-
-	/* Normally we will never reach this part of code (before fail_exit) as
-	   this thread will be cancelled by end of play thread. */
-	pthread_cleanup_pop(0);
-	pthread_cleanup_pop(0);
-	pthread_cleanup_pop(0);
-
-	snd_pcm_drain(sndpcm.handle);
-
-exit4:
-	fclose(fp);
-exit3:
-	free(sndpcm.buffer);
-exit2:
-	snd_pcm_close(sndpcm.handle);
-exit1:
-	pthread_exit(&retval_record);
-}
diff --git a/bat/alsa.h b/bat/alsa.h
deleted file mode 100644
index d5c9972..0000000
--- a/bat/alsa.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-extern int retval_play;
-extern int retval_record;
-
-void *playback_alsa(struct bat *);
-void *record_alsa(struct bat *);
diff --git a/bat/analyze.c b/bat/analyze.c
deleted file mode 100644
index 60e2d1c..0000000
--- a/bat/analyze.c
+++ /dev/null
@@ -1,314 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <stdbool.h>
-#include <stdint.h>
-
-#include <math.h>
-#include <fftw3.h>
-
-#include "aconfig.h"
-#include "gettext.h"
-
-#include "common.h"
-
-static void check_amplitude(struct bat *bat, double *buf)
-{
-	double sum, average, amplitude;
-	int i, percent;
-
-	/* calculate average value */
-	for (i = 0, sum = 0.0; i < bat->frames; i++)
-		sum += buf[i];
-	average = sum / bat->frames;
-
-	/* calculate peak-to-average amplitude */
-	for (i = 0, sum = 0.0; i < bat->frames; i++)
-		sum += abs(buf[i] - average);
-	amplitude = sum / bat->frames * M_PI / 2.0;
-
-	/* calculate amplitude percentage against full range */
-	percent = amplitude * 100 / ((1 << ((bat->sample_size << 3) - 1)) - 1);
-
-	fprintf(bat->log, _("Amplitude: %.1f; Percentage: [%d]\n"),
-			amplitude, percent);
-	if (percent < 0)
-		fprintf(bat->err, _("ERROR: Amplitude can't be negative!\n"));
-	else if (percent < 1)
-		fprintf(bat->err, _("WARNING: Signal too weak!\n"));
-	else if (percent > 100)
-		fprintf(bat->err, _("WARNING: Signal overflow!\n"));
-}
-
-/**
- *
- * @return 0 if peak detected at right frequency,
- *         1 if peak detected somewhere else
- *         2 if DC detected
- */
-int check_peak(struct bat *bat, struct analyze *a, int end, int peak, float hz,
-		float mean, float p, int channel, int start)
-{
-	int err;
-	float hz_peak = (float) (peak) * hz;
-	float delta_rate = DELTA_RATE * bat->target_freq[channel];
-	float delta_HZ = DELTA_HZ;
-	float tolerance = (delta_rate > delta_HZ) ? delta_rate : delta_HZ;
-
-	fprintf(bat->log, _("Detected peak at %2.2f Hz of %2.2f dB\n"), hz_peak,
-			10.0 * log10(a->mag[peak] / mean));
-	fprintf(bat->log, _(" Total %3.1f dB from %2.2f to %2.2f Hz\n"),
-			10.0 * log10(p / mean), start * hz, end * hz);
-
-	if (hz_peak < DC_THRESHOLD) {
-		fprintf(bat->err, _(" WARNING: Found low peak %2.2f Hz,"),
-				hz_peak);
-		fprintf(bat->err, _(" very close to DC\n"));
-		err = FOUND_DC;
-	} else if (hz_peak < bat->target_freq[channel] - tolerance) {
-		fprintf(bat->err, _(" FAIL: Peak freq too low %2.2f Hz\n"),
-				hz_peak);
-		err = FOUND_WRONG_PEAK;
-	} else if (hz_peak > bat->target_freq[channel] + tolerance) {
-		fprintf(bat->err, _(" FAIL: Peak freq too high %2.2f Hz\n"),
-				hz_peak);
-		err = FOUND_WRONG_PEAK;
-	} else {
-		fprintf(bat->log, _(" PASS: Peak detected"));
-		fprintf(bat->log, _(" at target frequency\n"));
-		err = 0;
-	}
-
-	return err;
-}
-
-/**
- * Search for main frequencies in fft results and compare it to target
- */
-static int check(struct bat *bat, struct analyze *a, int channel)
-{
-	float hz = 1.0 / ((float) bat->frames / (float) bat->rate);
-	float mean = 0.0, t, sigma = 0.0, p = 0.0;
-	int i, start = -1, end = -1, peak = 0, signals = 0;
-	int err = 0, N = bat->frames / 2;
-
-	/* calculate mean */
-	for (i = 0; i < N; i++)
-		mean += a->mag[i];
-	mean /= (float) N;
-
-	/* calculate standard deviation */
-	for (i = 0; i < N; i++) {
-		t = a->mag[i] - mean;
-		t *= t;
-		sigma += t;
-	}
-	sigma /= (float) N;
-	sigma = sqrtf(sigma);
-
-	/* clip any data less than k sigma + mean */
-	for (i = 0; i < N; i++) {
-		if (a->mag[i] > mean + bat->sigma_k * sigma) {
-
-			/* find peak start points */
-			if (start == -1) {
-				start = peak = end = i;
-				signals++;
-			} else {
-				if (a->mag[i] > a->mag[peak])
-					peak = i;
-				end = i;
-			}
-			p += a->mag[i];
-		} else if (start != -1) {
-			/* Check if peak is as expected */
-			err |= check_peak(bat, a, end, peak, hz, mean,
-					p, channel, start);
-			end = start = -1;
-			if (signals == MAX_PEAKS)
-				break;
-		}
-	}
-	if (signals == 0)
-		err = -ENOPEAK; /* No peak detected */
-	else if ((err == FOUND_DC) && (signals == 1))
-		err = -EONLYDC; /* Only DC detected */
-	else if ((err & FOUND_WRONG_PEAK) == FOUND_WRONG_PEAK)
-		err = -EBADPEAK; /* Bad peak detected */
-	else
-		err = 0; /* Correct peak detected */
-
-	fprintf(bat->log, _("Detected at least %d signal(s) in total\n"),
-			signals);
-
-	return err;
-}
-
-static void calc_magnitude(struct bat *bat, struct analyze *a, int N)
-{
-	double r2, i2;
-	int i;
-
-	for (i = 1; i < N / 2; i++) {
-		r2 = a->out[i] * a->out[i];
-		i2 = a->out[N - i] * a->out[N - i];
-
-		a->mag[i] = sqrtf(r2 + i2);
-	}
-	a->mag[0] = 0.0;
-}
-
-static int find_and_check_harmonics(struct bat *bat, struct analyze *a,
-		int channel)
-{
-	fftw_plan p;
-	int err = -ENOMEM, N = bat->frames;
-
-	/* Allocate FFT buffers */
-	a->in = (double *) fftw_malloc(sizeof(double) * bat->frames);
-	if (a->in == NULL)
-		goto out1;
-
-	a->out = (double *) fftw_malloc(sizeof(double) * bat->frames);
-	if (a->out == NULL)
-		goto out2;
-
-	a->mag = (double *) fftw_malloc(sizeof(double) * bat->frames);
-	if (a->mag == NULL)
-		goto out3;
-
-	/* create FFT plan */
-	p = fftw_plan_r2r_1d(N, a->in, a->out, FFTW_R2HC,
-			FFTW_MEASURE | FFTW_PRESERVE_INPUT);
-	if (p == NULL)
-		goto out4;
-
-	/* convert source PCM to doubles */
-	bat->convert_sample_to_double(a->buf, a->in, bat->frames);
-
-	/* check amplitude */
-	check_amplitude(bat, a->in);
-
-	/* run FFT */
-	fftw_execute(p);
-
-	/* FFT out is real and imaginary numbers - calc magnitude for each */
-	calc_magnitude(bat, a, N);
-
-	/* check data */
-	err = check(bat, a, channel);
-
-	fftw_destroy_plan(p);
-
-out4:
-	fftw_free(a->mag);
-out3:
-	fftw_free(a->out);
-out2:
-	fftw_free(a->in);
-out1:
-	return err;
-}
-
-/**
- * Convert interleaved samples from channels in samples from a single channel
- */
-static int reorder_data(struct bat *bat)
-{
-	char *p, *new_bat_buf;
-	int ch, i, j;
-
-	if (bat->channels == 1)
-		return 0; /* No need for reordering */
-
-	p = malloc(bat->frames * bat->frame_size);
-	new_bat_buf = p;
-	if (p == NULL)
-		return -ENOMEM;
-
-	for (ch = 0; ch < bat->channels; ch++) {
-		for (j = 0; j < bat->frames; j++) {
-			for (i = 0; i < bat->sample_size; i++) {
-				*p++ = ((char *) (bat->buf))[j * bat->frame_size
-						+ ch * bat->sample_size + i];
-			}
-		}
-	}
-
-	free(bat->buf);
-	bat->buf = new_bat_buf;
-
-	return 0;
-}
-
-int analyze_capture(struct bat *bat)
-{
-	int err = 0;
-	size_t items;
-	int c;
-	struct analyze a;
-
-	fprintf(bat->log, _("\nBAT analysis: signal has %d frames at %d Hz,"),
-			bat->frames, bat->rate);
-	fprintf(bat->log, _(" %d channels, %d bytes per sample.\n"),
-			bat->channels, bat->sample_size);
-
-	bat->buf = malloc(bat->frames * bat->frame_size);
-	if (bat->buf == NULL)
-		return -ENOMEM;
-
-	bat->fp = fopen(bat->capture.file, "rb");
-	if (bat->fp == NULL) {
-		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
-				bat->capture.file, -errno);
-		err = -errno;
-		goto exit1;
-	}
-
-	/* Skip header */
-	err = read_wav_header(bat, bat->capture.file, bat->fp, true);
-	if (err != 0)
-		goto exit2;
-
-	items = fread(bat->buf, bat->frame_size, bat->frames, bat->fp);
-	if (items != bat->frames) {
-		err = -EIO;
-		goto exit2;
-	}
-
-	err = reorder_data(bat);
-	if (err != 0)
-		goto exit2;
-
-	for (c = 0; c < bat->channels; c++) {
-		fprintf(bat->log, _("\nChannel %i - "), c + 1);
-		fprintf(bat->log, _("Checking for target frequency %2.2f Hz\n"),
-				bat->target_freq[c]);
-		a.buf = bat->buf +
-				c * bat->frames * bat->frame_size
-				/ bat->channels;
-		err = find_and_check_harmonics(bat, &a, c);
-	}
-
-exit2:
-	fclose(bat->fp);
-exit1:
-	free(bat->buf);
-
-	return err;
-}
diff --git a/bat/analyze.h b/bat/analyze.h
deleted file mode 100644
index 3fd03d4..0000000
--- a/bat/analyze.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-int analyze_capture(struct bat *);
diff --git a/bat/bat-signal.h b/bat/bat-signal.h
deleted file mode 100644
index a295517..0000000
--- a/bat/bat-signal.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2015 Caleb Crome
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-/*
- * Here's a generic sine wave generator that will work indefinitely
- * for any frequency.
- *
- * Note:  the state & phasor are stored as doubles (and updated as
- * doubles) because after a million samples the magnitude drifts a
- * bit.  If we really need floats, it can be done with periodic
- * renormalization of the state_real+state_imag magnitudes.
- */
-
-int sin_generator_init(struct sin_generator *, float, float, float);
-float sin_generator_next_sample(struct sin_generator *);
-void sin_generator_vfill(struct sin_generator *, float *, int);
-int generate_sine_wave(struct bat *, int, void *);
diff --git a/bat/bat.1 b/bat/bat.1
deleted file mode 100644
index e00fc27..0000000
--- a/bat/bat.1
+++ /dev/null
@@ -1,158 +0,0 @@
-.TH BAT 1 "20th October 2015"
-.SH NAME
-bat \- command\-line sound tester for ALSA sound card driver
-
-.SH SYNOPSIS
-\fBbat\fP [\fIflags\fP]
-
-.SH DESCRIPTION
-\fBBAT(Basic Audio Tester)\fP is a simple command\-line utility intended
-to help automate audio driver and sound server testing with little human
-interaction. BAT can be used to test audio quality, stress test features
-and test audio before and after PM state changes.
-
-BAT's design is relatively simple. BAT plays an audio stream and captures
-the same stream in either a digital or analog loop back. It then compares
-the captured stream using a FFT to the original to determine if the test
-case passes or fails.
-
-BAT can either run wholly on the target machine being tested (standalone
-mode) or can run as a client/server mode where by bat client runs on the
-target and runs as a server on a separate tester machine. The client/server
-mode still requires some manual interaction for synchronization, but this
-is actively being developed for future releases.
-
-The hardware testing configuration may require the use of an analog cable
-connecting target to tester machines or a cable to create an analog
-loopback if no loopback mode is not available on the sound hardware that
-is being tested.
-An analog loopback cable can be used to connect the "line in" to "line out"
-jacks to create a loopback. If only headphone and mic jacks (or combo jack)
-are available then the following simple circuit can be used to create an
-analog loopback :-
-
-https://source.android.com/devices/audio/loopback.html
-
-.SH OPTIONS
-.TP
-\fI\-h, \-\-help\fP
-Help: show syntax.
-.TP
-\fI\-D\fP
-Select sound card to be tested by name.
-.TP
-\fI\-P\fP
-Select the playback PCM device.
-.TP
-\fI\-C\fP
-Select the capture PCM device.
-.TP
-\fI\-f\fP
-Sample format
-.br
-Recognized sample formats are: U8 S16_LE S24_3LE S32_LE
-.br
-Some of these may not be available on selected hardware
-.br
-The available format shortcuts are:
-.nf
-\-f cd (16 bit little endian, 44100, stereo) [\-f S16_LE \-c2 \-r44100]
-\-f dat (16 bit little endian, 48000, stereo) [\-f S16_LE \-c2 \-r48000]
-.fi
-If no format is given S16_LE is used.
-.TP
-\fI\-c\fP
-The number of channels. The default is one channel.
-Valid values at the moment are 1 or 2.
-.TP
-\fI\-r\fP
-Sampling rate in Hertz. The default rate is 44100 Hertz.
-Valid values depends on hardware support.
-.TP
-\fI\-n\fP
-Duration of generated signal.
-The value could be either of the two forms:
-.br
-1. Decimal integer, means number of frames;
-.br
-2. Floating point with suffix 's', means number of seconds.
-.br
-The default is 2 seconds.
-.TP
-\fI\-k\fP
-Sigma k value for analysis.
-.br
-The analysis function reads data from WAV file, run FFT against the data
-to get magnitude of frequency vectors, and then calculates the average
-value and standard deviation of frequency vectors. After that, we define
-a threshold:
-.br
-threshold = k * standard_deviation + mean_value
-.br
-Frequencies with amplitude larger than threshold will be recognized as a
-peak, and the frequency with largest peak value will be recognized as a
-detected frequency.
-.br
-BAT then compares the detected frequency to target frequency, to decide
-if the detecting passes or fails.
-.br
-The default value is 3.0.
-.TP
-\fI\-F\fP
-Target frequency for signal generation and analysis, in Hertz.
-The default is 997.0 Hertz.
-Valid range is (DC_THRESHOLD, 40% * Sampling rate).
-.TP
-\fI\-p\fP
-Total number of periods to play or capture.
-.TP
-\fI\-\-log=#\fP
-Write stderr and stdout output to this log file.
-.TP
-\fI\-\-file=#\fP
-Input WAV file for playback.
-.TP
-\fI\-\-saveplay=#\fP
-Target WAV file to save capture test content.
-.TP
-\fI\-\-local\fP
-Internal loopback mode.
-Playback, capture and analysis internal to BAT only. This is intended for
-developers to test new BAT features as no audio is routed outside of BAT.
-
-.SH EXAMPLES
-
-.TP
-\fBbat \-P plughw:0,0 \-C plughw:0,0 \-c 2 \-f S32_LE \-F 250\fR
-Generate and play a sine wave of 250 Hertz with 2 channel and S32_LE format,
-and then capture and analyze.
-
-.TP
-\fBbat \-P plughw:0,0 \-C plughw:0,0 \-\-file 500Hz.wav\fR
-Play the RIFF WAV file "500Hz.wav" which contains 500 Hertz waveform LPCM
-data, and then capture and analyze.
-
-.SH RETURN VALUE
-.br
-On success, returns 0.
-.br
-If no peak be detected, returns -1001;
-.br
-If only DC be detected, returns -1002;
-.br
-If peak frequency does not match with the target frequency, returns -1003.
-
-.SH SEE ALSO
-\fB
-aplay(1)
-\fP
-
-.SH BUGS
-Currently only support RIFF WAV format with PCM data. Please report any bugs to
-the alsa-devel mailing list.
-
-.SH AUTHOR
-\fBbat\fP is by Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bernard Gautier
-<bernard.gautier@intel.com> and Han Lu <han.lu@intel.com>.
-This document is by Liam Girdwood <liam.r.girdwood@linux.intel.com> and Han Lu
-<han.lu@intel.com>.
diff --git a/bat/bat.c b/bat/bat.c
deleted file mode 100644
index 086b9fa..0000000
--- a/bat/bat.c
+++ /dev/null
@@ -1,610 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <string.h>
-#include <errno.h>
-#include <pthread.h>
-#include <getopt.h>
-#include <math.h>
-#include <limits.h>
-#include <locale.h>
-
-#include "aconfig.h"
-#include "gettext.h"
-#include "version.h"
-
-#include "common.h"
-
-#include "alsa.h"
-#include "convert.h"
-#include "analyze.h"
-
-static int get_duration(struct bat *bat)
-{
-	float duration_f;
-	long duration_i;
-	char *ptrf, *ptri;
-
-	duration_f = strtof(bat->narg, &ptrf);
-	if (duration_f == HUGE_VALF || duration_f == -HUGE_VALF
-			|| (duration_f == 0.0 && errno != 0))
-		goto err_exit;
-
-	duration_i = strtol(bat->narg, &ptri, 10);
-	if (duration_i == LONG_MAX || duration_i == LONG_MIN)
-		goto err_exit;
-
-	if (*ptrf == 's')
-		bat->frames = duration_f * bat->rate;
-	else if (*ptri == 0)
-		bat->frames = duration_i;
-	else
-		bat->frames = -1;
-
-	if (bat->frames <= 0 || bat->frames > MAX_FRAMES) {
-		fprintf(bat->err, _("Invalid duration. Range: (0, %d(%fs))\n"),
-				MAX_FRAMES, (double)MAX_FRAMES / bat->rate);
-		return -EINVAL;
-	}
-
-	return 0;
-
-err_exit:
-	fprintf(bat->err, _("Duration overflow/underflow: %d\n"), -errno);
-
-	return -errno;
-}
-
-static void get_sine_frequencies(struct bat *bat, char *freq)
-{
-	char *tmp1;
-
-	tmp1 = strchr(freq, ':');
-	if (tmp1 == NULL) {
-		bat->target_freq[1] = bat->target_freq[0] = atof(optarg);
-	} else {
-		*tmp1 = '\0';
-		bat->target_freq[0] = atof(optarg);
-		bat->target_freq[1] = atof(tmp1 + 1);
-	}
-}
-
-static void get_format(struct bat *bat, char *optarg)
-{
-	if (strcasecmp(optarg, "cd") == 0) {
-		bat->format = SND_PCM_FORMAT_S16_LE;
-		bat->rate = 44100;
-		bat->channels = 2;
-	} else if (strcasecmp(optarg, "dat") == 0) {
-		bat->format = SND_PCM_FORMAT_S16_LE;
-		bat->rate = 48000;
-		bat->channels = 2;
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
-		bat->sample_size = 1;
-		break;
-	case SND_PCM_FORMAT_S16_LE:
-		bat->sample_size = 2;
-		break;
-	case SND_PCM_FORMAT_S24_3LE:
-		bat->sample_size = 3;
-		break;
-	case SND_PCM_FORMAT_S32_LE:
-		bat->sample_size = 4;
-		break;
-	default:
-		fprintf(bat->err, _("unsupported format: %d\n"), bat->format);
-		exit(EXIT_FAILURE);
-	}
-}
-
-static inline int thread_wait_completion(struct bat *bat,
-		pthread_t id, int **val)
-{
-	int err;
-
-	err = pthread_join(id, (void **) val);
-	if (err)
-		pthread_cancel(id);
-
-	return err;
-}
-
-/* loopback test where we play sine wave and capture the same sine wave */
-static void test_loopback(struct bat *bat)
-{
-	pthread_t capture_id, playback_id;
-	int err;
-	int *thread_result_capture, *thread_result_playback;
-
-	/* start playback */
-	err = pthread_create(&playback_id, NULL,
-			(void *) bat->playback.fct, bat);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot create playback thread: %d\n"),
-				err);
-		exit(EXIT_FAILURE);
-	}
-
-	/* TODO: use a pipe to signal stream start etc - i.e. to sync threads */
-	/* Let some time for playing something before capturing */
-	usleep(CAPTURE_DELAY * 1000);
-
-	/* start capture */
-	err = pthread_create(&capture_id, NULL, (void *) bat->capture.fct, bat);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot create capture thread: %d\n"), err);
-		pthread_cancel(playback_id);
-		exit(EXIT_FAILURE);
-	}
-
-	/* wait for playback to complete */
-	err = thread_wait_completion(bat, playback_id, &thread_result_playback);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot join playback thread: %d\n"), err);
-		free(thread_result_playback);
-		pthread_cancel(capture_id);
-		exit(EXIT_FAILURE);
-	}
-
-	/* check playback status */
-	if (*thread_result_playback != 0) {
-		fprintf(bat->err, _("Exit playback thread fail: %d\n"),
-				*thread_result_playback);
-		pthread_cancel(capture_id);
-		exit(EXIT_FAILURE);
-	} else {
-		fprintf(bat->log, _("Playback completed.\n"));
-	}
-
-	/* now stop and wait for capture to finish */
-	pthread_cancel(capture_id);
-	err = thread_wait_completion(bat, capture_id, &thread_result_capture);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot join capture thread: %d\n"), err);
-		free(thread_result_capture);
-		exit(EXIT_FAILURE);
-	}
-
-	/* check capture status */
-	if (*thread_result_capture != 0) {
-		fprintf(bat->err, _("Exit capture thread fail: %d\n"),
-				*thread_result_capture);
-		exit(EXIT_FAILURE);
-	} else {
-		fprintf(bat->log, _("Capture completed.\n"));
-	}
-}
-
-/* single ended playback only test */
-static void test_playback(struct bat *bat)
-{
-	pthread_t playback_id;
-	int err;
-	int *thread_result;
-
-	/* start playback */
-	err = pthread_create(&playback_id, NULL,
-			(void *) bat->playback.fct, bat);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot create playback thread: %d\n"),
-				err);
-		exit(EXIT_FAILURE);
-	}
-
-	/* wait for playback to complete */
-	err = thread_wait_completion(bat, playback_id, &thread_result);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot join playback thread: %d\n"), err);
-		free(thread_result);
-		exit(EXIT_FAILURE);
-	}
-
-	/* check playback status */
-	if (*thread_result != 0) {
-		fprintf(bat->err, _("Exit playback thread fail: %d\n"),
-				*thread_result);
-		exit(EXIT_FAILURE);
-	} else {
-		fprintf(bat->log, _("Playback completed.\n"));
-	}
-}
-
-/* single ended capture only test */
-static void test_capture(struct bat *bat)
-{
-	pthread_t capture_id;
-	int err;
-	int *thread_result;
-
-	/* start capture */
-	err = pthread_create(&capture_id, NULL, (void *) bat->capture.fct, bat);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot create capture thread: %d\n"), err);
-		exit(EXIT_FAILURE);
-	}
-
-	/* TODO: stop capture */
-
-	/* wait for capture to complete */
-	err = thread_wait_completion(bat, capture_id, &thread_result);
-	if (err != 0) {
-		fprintf(bat->err, _("Cannot join capture thread: %d\n"), err);
-		free(thread_result);
-		exit(EXIT_FAILURE);
-	}
-
-	/* check playback status */
-	if (*thread_result != 0) {
-		fprintf(bat->err, _("Exit capture thread fail: %d\n"),
-				*thread_result);
-		exit(EXIT_FAILURE);
-	} else {
-		fprintf(bat->log, _("Capture completed.\n"));
-	}
-}
-
-static void usage(struct bat *bat)
-{
-	fprintf(bat->log,
-_("Usage: bat [-options]...\n"
-"\n"
-"  -h, --help             this help\n"
-"  -D                     pcm device for both playback and capture\n"
-"  -P                     pcm device for playback\n"
-"  -C                     pcm device for capture\n"
-"  -f                     sample format\n"
-"  -c                     number of channels\n"
-"  -r                     sampling rate\n"
-"  -n                     frames to playback or capture\n"
-"  -k                     parameter for frequency detecting threshold\n"
-"  -F                     target frequency\n"
-"  -p                     total number of periods to play/capture\n"
-"      --log=#            file that both stdout and strerr redirecting to\n"
-"      --file=#           file for playback\n"
-"      --saveplay=#       file that storing playback content, for debug\n"
-"      --local            internal loop, set to bypass pcm hardware devices\n"
-));
-	fprintf(bat->log, _("Recognized sample formats are: %s %s %s %s\n"),
-			snd_pcm_format_name(SND_PCM_FORMAT_U8),
-			snd_pcm_format_name(SND_PCM_FORMAT_S16_LE),
-			snd_pcm_format_name(SND_PCM_FORMAT_S24_3LE),
-			snd_pcm_format_name(SND_PCM_FORMAT_S32_LE));
-	fprintf(bat->log, _("The available format shotcuts are:\n"));
-	fprintf(bat->log, _("-f cd (16 bit little endian, 44100, stereo)\n"));
-	fprintf(bat->log, _("-f dat (16 bit little endian, 48000, stereo)\n"));
-}
-
-static void set_defaults(struct bat *bat)
-{
-	memset(bat, 0, sizeof(struct bat));
-
-	/* Set default values */
-	bat->rate = 44100;
-	bat->channels = 1;
-	bat->frame_size = 2;
-	bat->sample_size = 2;
-	bat->format = SND_PCM_FORMAT_S16_LE;
-	bat->convert_float_to_sample = convert_float_to_int16;
-	bat->convert_sample_to_double = convert_int16_to_double;
-	bat->frames = bat->rate * 2;
-	bat->target_freq[0] = 997.0;
-	bat->target_freq[1] = 997.0;
-	bat->sigma_k = 3.0;
-	bat->playback.device = NULL;
-	bat->capture.device = NULL;
-	bat->buf = NULL;
-	bat->local = false;
-	bat->playback.fct = &playback_alsa;
-	bat->capture.fct = &record_alsa;
-	bat->playback.mode = MODE_LOOPBACK;
-	bat->capture.mode = MODE_LOOPBACK;
-	bat->period_is_limited = false;
-	bat->log = stdout;
-	bat->err = stderr;
-}
-
-static void parse_arguments(struct bat *bat, int argc, char *argv[])
-{
-	int c, option_index;
-	static const char short_options[] = "D:P:C:f:n:F:c:r:s:k:p:lth";
-	static const struct option long_options[] = {
-		{"help",     0, 0, 'h'},
-		{"log",      1, 0, OPT_LOG},
-		{"file",     1, 0, OPT_READFILE},
-		{"saveplay", 1, 0, OPT_SAVEPLAY},
-		{"local",    0, 0, OPT_LOCAL},
-		{0, 0, 0, 0}
-	};
-
-	while ((c = getopt_long(argc, argv, short_options, long_options,
-					&option_index)) != -1) {
-		switch (c) {
-		case OPT_LOG:
-			bat->logarg = optarg;
-			break;
-		case OPT_READFILE:
-			bat->playback.file = optarg;
-			break;
-		case OPT_SAVEPLAY:
-			bat->debugplay = optarg;
-			break;
-		case OPT_LOCAL:
-			bat->local = true;
-			break;
-		case 'D':
-			if (bat->playback.device == NULL)
-				bat->playback.device = optarg;
-			if (bat->capture.device == NULL)
-				bat->capture.device = optarg;
-			break;
-		case 'P':
-			if (bat->capture.mode == MODE_SINGLE)
-				bat->capture.mode = MODE_LOOPBACK;
-			else
-				bat->playback.mode = MODE_SINGLE;
-			bat->playback.device = optarg;
-			break;
-		case 'C':
-			if (bat->playback.mode == MODE_SINGLE)
-				bat->playback.mode = MODE_LOOPBACK;
-			else
-				bat->capture.mode = MODE_SINGLE;
-			bat->capture.device = optarg;
-			break;
-		case 'n':
-			bat->narg = optarg;
-			break;
-		case 'F':
-			get_sine_frequencies(bat, optarg);
-			break;
-		case 'c':
-			bat->channels = atoi(optarg);
-			break;
-		case 'r':
-			bat->rate = atoi(optarg);
-			break;
-		case 'f':
-			get_format(bat, optarg);
-			break;
-		case 'k':
-			bat->sigma_k = atof(optarg);
-			break;
-		case 'p':
-			bat->periods_total = atoi(optarg);
-			bat->period_is_limited = true;
-			break;
-		case 'h':
-		default:
-			usage(bat);
-			exit(EXIT_SUCCESS);
-		}
-	}
-}
-
-static int validate_options(struct bat *bat)
-{
-	int c;
-	float freq_low, freq_high;
-
-	/* check if we have an input file for local mode */
-	if ((bat->local == true) && (bat->capture.file == NULL)) {
-		fprintf(bat->err, _("no input file for local testing\n"));
-		return -EINVAL;
-	}
-
-	/* check supported channels */
-	if (bat->channels > MAX_CHANNELS || bat->channels < MIN_CHANNELS) {
-		fprintf(bat->err, _("%d channels not supported\n"),
-				bat->channels);
-		return -EINVAL;
-	}
-
-	/* check single ended is in either playback or capture - not both */
-	if ((bat->playback.mode == MODE_SINGLE)
-			&& (bat->capture.mode == MODE_SINGLE)) {
-		fprintf(bat->err, _("single ended mode is simplex\n"));
-		return -EINVAL;
-	}
-
-	/* check sine wave frequency range */
-	freq_low = DC_THRESHOLD;
-	freq_high = bat->rate * RATE_FACTOR;
-	for (c = 0; c < bat->channels; c++) {
-		if (bat->target_freq[c] < freq_low
-				|| bat->target_freq[c] > freq_high) {
-			fprintf(bat->err, _("sine wave frequency out of"));
-			fprintf(bat->err, _(" range: (%.1f, %.1f)\n"),
-				freq_low, freq_high);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-static int bat_init(struct bat *bat)
-{
-	int err = 0;
-	char name[] = TEMP_RECORD_FILE_NAME;
-
-	/* Determine logging to a file or stdout and stderr */
-	if (bat->logarg) {
-		bat->log = NULL;
-		bat->log = fopen(bat->logarg, "wb");
-		if (bat->log == NULL) {
-			fprintf(bat->err, _("Cannot open file for capture:"));
-			fprintf(bat->err, _(" %s %d\n"),
-					bat->logarg, -errno);
-			return -errno;
-		}
-		bat->err = bat->log;
-	}
-
-	/* Determine duration of playback and/or capture */
-	if (bat->narg) {
-		err = get_duration(bat);
-		if (err < 0)
-			return err;
-	}
-
-	/* Determine capture file */
-	if (bat->local) {
-		bat->capture.file = bat->playback.file;
-	} else {
-		/* create temp file for sound record and analysis */
-		err = mkstemp(name);
-		if (err == -1) {
-			fprintf(bat->err, _("Fail to create record file: %d\n"),
-					-errno);
-			return -errno;
-		}
-		/* store file name which is dynamically created */
-		bat->capture.file = strdup(name);
-		if (bat->capture.file == NULL)
-			return -errno;
-		/* close temp file */
-		close(err);
-	}
-
-	/* Initial for playback */
-	if (bat->playback.file == NULL) {
-		/* No input file so we will generate our own sine wave */
-		if (bat->frames) {
-			if (bat->playback.mode == MODE_SINGLE) {
-				/* Play nb of frames given by -n argument */
-				bat->sinus_duration = bat->frames;
-			} else {
-				/* Play CAPTURE_DELAY msec +
-				 * 150% of the nb of frames to be analyzed */
-				bat->sinus_duration = bat->rate *
-						CAPTURE_DELAY / 1000;
-				bat->sinus_duration +=
-						(bat->frames + bat->frames / 2);
-			}
-		} else {
-			/* Special case where we want to generate a sine wave
-			 * endlessly without capturing */
-			bat->sinus_duration = 0;
-			bat->playback.mode = MODE_SINGLE;
-		}
-	} else {
-		bat->fp = fopen(bat->playback.file, "rb");
-		if (bat->fp == NULL) {
-			fprintf(bat->err, _("Cannot open file for playback:"));
-			fprintf(bat->err, _(" %s %d\n"),
-					bat->playback.file, -errno);
-			return -errno;
-		}
-		err = read_wav_header(bat, bat->playback.file, bat->fp, false);
-		fclose(bat->fp);
-		if (err != 0)
-			return err;
-	}
-
-	bat->frame_size = bat->sample_size * bat->channels;
-
-	/* Set conversion functions */
-	switch (bat->sample_size) {
-	case 1:
-		bat->convert_float_to_sample = convert_float_to_uint8;
-		bat->convert_sample_to_double = convert_uint8_to_double;
-		break;
-	case 2:
-		bat->convert_float_to_sample = convert_float_to_int16;
-		bat->convert_sample_to_double = convert_int16_to_double;
-		break;
-	case 3:
-		bat->convert_float_to_sample = convert_float_to_int24;
-		bat->convert_sample_to_double = convert_int24_to_double;
-		break;
-	case 4:
-		bat->convert_float_to_sample = convert_float_to_int32;
-		bat->convert_sample_to_double = convert_int32_to_double;
-		break;
-	default:
-		fprintf(bat->err, _("Invalid PCM format: size=%d\n"),
-				bat->sample_size);
-		return -EINVAL;
-	}
-
-	return err;
-}
-
-int main(int argc, char *argv[])
-{
-	struct bat bat;
-	int err = 0;
-
-	set_defaults(&bat);
-
-#ifdef ENABLE_NLS
-	setlocale(LC_ALL, "");
-	textdomain(PACKAGE);
-#endif
-
-	fprintf(bat.log, _("%s version %s\n\n"), PACKAGE_NAME, PACKAGE_VERSION);
-
-	parse_arguments(&bat, argc, argv);
-
-	err = bat_init(&bat);
-	if (err < 0)
-		goto out;
-
-	err = validate_options(&bat);
-	if (err < 0)
-		goto out;
-
-	/* single line playback thread: playback only, no capture */
-	if (bat.playback.mode == MODE_SINGLE) {
-		test_playback(&bat);
-		goto out;
-	}
-
-	/* single line capture thread: capture only, no playback */
-	if (bat.capture.mode == MODE_SINGLE) {
-		test_capture(&bat);
-		goto analyze;
-	}
-
-	/* loopback thread: playback and capture in a loop */
-	if (bat.local == false)
-		test_loopback(&bat);
-
-analyze:
-	err = analyze_capture(&bat);
-out:
-	fprintf(bat.log, _("\nReturn value is %d\n"), err);
-
-	if (bat.logarg)
-		fclose(bat.log);
-	if (!bat.local)
-		free(bat.capture.file);
-
-	return err;
-}
diff --git a/bat/common.c b/bat/common.c
deleted file mode 100644
index 798b00b..0000000
--- a/bat/common.c
+++ /dev/null
@@ -1,198 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <stdio.h>
-#include <stddef.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <errno.h>
-
-#include "aconfig.h"
-#include "gettext.h"
-
-#include "common.h"
-#include "alsa.h"
-
-int retval_play;
-int retval_record;
-
-/* update chunk_fmt data to bat */
-static int update_fmt_to_bat(struct bat *bat, struct chunk_fmt *fmt)
-{
-	bat->channels = fmt->channels;
-	bat->rate = fmt->sample_rate;
-	bat->sample_size = fmt->sample_length / 8;
-	if (bat->sample_size > 4) {
-		fprintf(bat->err, _("Invalid format: sample size=%d\n"),
-				bat->sample_size);
-		return -EINVAL;
-	}
-	bat->frame_size = fmt->blocks_align;
-
-	return 0;
-}
-
-/* calculate frames and update to bat */
-static int update_frames_to_bat(struct bat *bat,
-		struct wav_chunk_header *header, FILE *fp)
-{
-	/* The number of analyzed captured frames is arbitrarily set to half of
-	   the number of frames of the wav file or the number of frames of the
-	   wav file when doing direct analysis (--local) */
-	bat->frames = header->length / bat->frame_size;
-	if (!bat->local)
-		bat->frames /= 2;
-
-	return 0;
-}
-
-static int read_chunk_fmt(struct bat *bat, char *file, FILE *fp, bool skip,
-		struct wav_chunk_header *header)
-{
-	size_t err;
-	int header_skip;
-	struct chunk_fmt chunk_fmt;
-
-	err = fread(&chunk_fmt, sizeof(chunk_fmt), 1, fp);
-	if (err != 1) {
-		fprintf(bat->err, _("Read chunk fmt error: %s:%zd\n"),
-				file, err);
-		return -EIO;
-	}
-	/* If the format header is larger, skip the rest */
-	header_skip = header->length - sizeof(chunk_fmt);
-	if (header_skip > 0) {
-		err = fseek(fp, header_skip, SEEK_CUR);
-		if (err == -1) {
-			fprintf(bat->err, _("Seek fmt header error: %s:%zd\n"),
-					file, err);
-			return -EINVAL;
-		}
-	}
-	/* If the file is opened for playback, update BAT data;
-	   If the file is opened for analysis, no update */
-	if (skip == false) {
-		err = update_fmt_to_bat(bat, &chunk_fmt);
-		if (err != 0)
-			return err;
-	}
-
-	return 0;
-}
-
-int read_wav_header(struct bat *bat, char *file, FILE *fp, bool skip)
-{
-	struct wav_header riff_wave_header;
-	struct wav_chunk_header chunk_header;
-	int more_chunks = 1;
-	size_t err;
-
-	/* Read header of RIFF wav file */
-	err = fread(&riff_wave_header, sizeof(riff_wave_header), 1, fp);
-	if (err != 1) {
-		fprintf(bat->err, _("Read header error: %s:%zd\n"), file, err);
-		return -EIO;
-	}
-	if ((riff_wave_header.magic != WAV_RIFF)
-			|| (riff_wave_header.type != WAV_WAVE)) {
-		fprintf(bat->err, _("%s is not a riff/wave file\n"), file);
-		return -EINVAL;
-	}
-
-	/* Read chunks in RIFF wav file */
-	do {
-		err = fread(&chunk_header, sizeof(chunk_header), 1, fp);
-		if (err != 1) {
-			fprintf(bat->err, _("Read chunk header error: "));
-			fprintf(bat->err, _("%s:%zd\n"), file, err);
-			return -EIO;
-		}
-
-		switch (chunk_header.type) {
-		case WAV_FMT:
-			/* WAV_FMT chunk, read and analyze */
-			err = read_chunk_fmt(bat, file, fp, skip,
-					&chunk_header);
-			if (err != 0)
-				return err;
-			break;
-		case WAV_DATA:
-			/* WAV_DATA chunk, break looping */
-			/* If the file is opened for playback, update BAT data;
-			   If the file is opened for analysis, no update */
-			if (skip == false) {
-				err = update_frames_to_bat(bat, &chunk_header,
-						fp);
-				if (err != 0)
-					return err;
-			}
-			/* Stop looking for chunks */
-			more_chunks = 0;
-			break;
-		default:
-			/* Unknown chunk, skip bytes */
-			err = fseek(fp, chunk_header.length, SEEK_CUR);
-			if (err == -1) {
-				fprintf(bat->err, _("Fail to skip unknown"));
-				fprintf(bat->err, _(" chunk of %s:%zd\n"),
-						file, err);
-				return -EINVAL;
-			}
-		}
-	} while (more_chunks);
-
-	return 0;
-}
-
-void prepare_wav_info(struct wav_container *wav, struct bat *bat)
-{
-	wav->header.magic = WAV_RIFF;
-	wav->header.type = WAV_WAVE;
-	wav->format.magic = WAV_FMT;
-	wav->format.fmt_size = 16;
-	wav->format.format = WAV_FORMAT_PCM;
-	wav->format.channels = bat->channels;
-	wav->format.sample_rate = bat->rate;
-	wav->format.sample_length = bat->sample_size * 8;
-	wav->format.blocks_align = bat->channels * bat->sample_size;
-	wav->format.bytes_p_second = wav->format.blocks_align * bat->rate;
-	wav->chunk.length = bat->frames * bat->frame_size;
-	wav->chunk.type = WAV_DATA;
-	wav->header.length = (wav->chunk.length) + sizeof(wav->chunk)
-			+ sizeof(wav->format) + sizeof(wav->header) - 8;
-}
-
-int write_wav_header(FILE *fp, struct wav_container *wav, struct bat *bat)
-{
-	int err = 0;
-
-	err = fwrite(&wav->header, 1, sizeof(wav->header), fp);
-	if (err != sizeof(wav->header)) {
-		fprintf(bat->err, _("Write file error: header %d\n"), err);
-		return -EIO;
-	}
-	err = fwrite(&wav->format, 1, sizeof(wav->format), fp);
-	if (err != sizeof(wav->format)) {
-		fprintf(bat->err, _("Write file error: format %d\n"), err);
-		return -EIO;
-	}
-	err = fwrite(&wav->chunk, 1, sizeof(wav->chunk), fp);
-	if (err != sizeof(wav->chunk)) {
-		fprintf(bat->err, _("Write file error: chunk %d\n"), err);
-		return -EIO;
-	}
-
-	return 0;
-}
diff --git a/bat/common.h b/bat/common.h
deleted file mode 100644
index c04452d..0000000
--- a/bat/common.h
+++ /dev/null
@@ -1,176 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <alsa/asoundlib.h>
-
-#define TEMP_RECORD_FILE_NAME		"/tmp/bat.wav.XXXXXX"
-
-#define OPT_BASE			300
-#define OPT_LOG				(OPT_BASE + 1)
-#define OPT_READFILE			(OPT_BASE + 2)
-#define OPT_SAVEPLAY			(OPT_BASE + 3)
-#define OPT_LOCAL			(OPT_BASE + 4)
-
-#define COMPOSE(a, b, c, d)		((a) | ((b)<<8) | ((c)<<16) | ((d)<<24))
-#define WAV_RIFF			COMPOSE('R', 'I', 'F', 'F')
-#define WAV_WAVE			COMPOSE('W', 'A', 'V', 'E')
-#define WAV_FMT				COMPOSE('f', 'm', 't', ' ')
-#define WAV_DATA			COMPOSE('d', 'a', 't', 'a')
-#define WAV_FORMAT_PCM			1	/* PCM WAVE file encoding */
-
-#define MAX_CHANNELS			2
-#define MIN_CHANNELS			1
-#define MAX_PEAKS			10
-#define MAX_FRAMES			(10 * 1024 * 1024)
-/* Given in ms */
-#define CAPTURE_DELAY			500
-/* signal frequency should be less than samplerate * RATE_FACTOR */
-#define RATE_FACTOR			0.4
-/* valid range of samplerate: (1 - RATE_RANGE, 1 + RATE_RANGE) * samplerate */
-#define RATE_RANGE			0.05
-/* Given in us */
-#define MAX_BUFFERTIME			500000
-/* devide factor, was 4, changed to 8 to remove reduce capture overrun */
-#define DIV_BUFFERTIME			8
-/* margin to avoid sign inversion when generate sine wav */
-#define RANGE_FACTOR			0.95
-
-#define EBATBASE			1000
-#define ENOPEAK				(EBATBASE + 1)
-#define EONLYDC				(EBATBASE + 2)
-#define EBADPEAK			(EBATBASE + 3)
-
-#define DC_THRESHOLD			7.01
-
-/* tolerance of detected peak = max (DELTA_HZ, DELTA_RATE * target_freq).
- * If DELTA_RATE is too high, BAT may not be able to recognize negative result;
- * if too low, BAT may be too sensitive and results in uncecessary failure. */
-#define DELTA_RATE			0.005
-#define DELTA_HZ			1
-
-#define FOUND_DC			(1<<1)
-#define FOUND_WRONG_PEAK		(1<<0)
-
-struct wav_header {
-	unsigned int magic; /* 'RIFF' */
-	unsigned int length; /* file len */
-	unsigned int type; /* 'WAVE' */
-};
-
-struct wav_chunk_header {
-	unsigned int type; /* 'data' */
-	unsigned int length; /* sample count */
-};
-
-struct wav_fmt {
-	unsigned int magic; /* 'FMT '*/
-	unsigned int fmt_size; /* 16 or 18 */
-	unsigned short format; /* see WAV_FMT_* */
-	unsigned short channels;
-	unsigned int sample_rate; /* Frequency of sample */
-	unsigned int bytes_p_second;
-	unsigned short blocks_align; /* sample size; 1 or 2 bytes */
-	unsigned short sample_length; /* 8, 12 or 16 bit */
-};
-
-struct chunk_fmt {
-	unsigned short format; /* see WAV_FMT_* */
-	unsigned short channels;
-	unsigned int sample_rate; /* Frequency of sample */
-	unsigned int bytes_p_second;
-	unsigned short blocks_align; /* sample size; 1 or 2 bytes */
-	unsigned short sample_length; /* 8, 12 or 16 bit */
-};
-
-struct wav_container {
-	struct wav_header header;
-	struct wav_fmt format;
-	struct wav_chunk_header chunk;
-};
-
-struct bat;
-
-enum _bat_op_mode {
-	MODE_UNKNOWN = -1,
-	MODE_SINGLE = 0,
-	MODE_LOOPBACK,
-	MODE_LAST
-};
-
-struct pcm {
-	char *device;
-	char *file;
-	enum _bat_op_mode mode;
-	void *(*fct)(struct bat *);
-};
-
-struct sin_generator;
-
-struct sin_generator {
-	double state_real;
-	double state_imag;
-	double phasor_real;
-	double phasor_imag;
-	float frequency;
-	float sample_rate;
-	float magnitude;
-};
-
-struct bat {
-	unsigned int rate;		/* sampling rate */
-	int channels;			/* nb of channels */
-	int frames;			/* nb of frames */
-	int frame_size;			/* size of frame */
-	int sample_size;		/* size of sample */
-	snd_pcm_format_t format;	/* PCM format */
-
-	float sigma_k;			/* threshold for peak detection */
-	float target_freq[MAX_CHANNELS];
-
-	int sinus_duration;		/* number of frames for playback */
-	char *narg;			/* argument string of duration */
-	char *logarg;			/* path name of log file */
-	char *debugplay;		/* path name to store playback signal */
-
-	struct pcm playback;
-	struct pcm capture;
-
-	unsigned int periods_played;
-	unsigned int periods_total;
-	bool period_is_limited;
-
-	FILE *fp;
-
-	FILE *log;
-	FILE *err;
-
-	void (*convert_sample_to_double)(void *, double *, int);
-	void (*convert_float_to_sample)(float *, void *, int, int);
-
-	void *buf;			/* PCM Buffer */
-
-	bool local;			/* true for internal test */
-};
-
-struct analyze {
-	void *buf;
-	double *in;
-	double *out;
-	double *mag;
-};
-
-void prepare_wav_info(struct wav_container *, struct bat *);
-int read_wav_header(struct bat *, char *, FILE *, bool);
-int write_wav_header(FILE *, struct wav_container *, struct bat *);
diff --git a/bat/convert.c b/bat/convert.c
deleted file mode 100644
index dcbe912..0000000
--- a/bat/convert.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <stdio.h>
-#include <stddef.h>
-#include <stdlib.h>
-#include <stdint.h>
-
-void convert_uint8_to_double(void *buf, double *val, int samples)
-{
-	int i;
-
-	for (i = 0; i < samples; i++)
-		val[i] = ((uint8_t *) buf)[i];
-}
-
-void convert_int16_to_double(void *buf, double *val, int samples)
-{
-	int i;
-
-	for (i = 0; i < samples; i++)
-		val[i] = ((int16_t *) buf)[i];
-}
-
-void convert_int24_to_double(void *buf, double *val, int samples)
-{
-	int i;
-	int32_t tmp;
-
-	for (i = 0; i < samples; i++) {
-		tmp = ((uint8_t *) buf)[i * 3 + 2] << 24;
-		tmp |= ((uint8_t *) buf)[i * 3 + 1] << 16;
-		tmp |= ((uint8_t *) buf)[i * 3] << 8;
-		tmp >>= 8;
-		val[i] = tmp;
-	}
-}
-
-void convert_int32_to_double(void *buf, double *val, int samples)
-{
-	int i;
-
-	for (i = 0; i < samples; i++)
-		val[i] = ((int32_t *) buf)[i];
-}
-
-void convert_float_to_uint8(float *val, void *buf, int samples, int channels)
-{
-	int i, c, idx;
-
-	for (i = 0; i < samples; i++) {
-		for (c = 0; c < channels; c++) {
-			idx = i * channels + c;
-			((uint8_t *) buf)[idx] = (uint8_t) val[idx];
-		}
-	}
-}
-
-void convert_float_to_int16(float *val, void *buf, int samples, int channels)
-{
-	int i, c, idx;
-
-	for (i = 0; i < samples; i++) {
-		for (c = 0; c < channels; c++) {
-			idx = i * channels + c;
-			((int16_t *) buf)[idx] = (int16_t) val[idx];
-		}
-	}
-}
-
-void convert_float_to_int24(float *val, void *buf, int samples, int channels)
-{
-	int i, c, idx_f, idx_i;
-	int32_t val_f_i;
-
-	for (i = 0; i < samples; i++) {
-		for (c = 0; c < channels; c++) {
-			idx_f = i * channels + c;
-			idx_i = 3 * idx_f;
-			val_f_i = (int32_t) val[idx_f];
-			((int8_t *) buf)[idx_i + 0] =
-				(int8_t) (val_f_i & 0xff);
-			((int8_t *) buf)[idx_i + 1] =
-				(int8_t) ((val_f_i >> 8) & 0xff);
-			((int8_t *) buf)[idx_i + 2] =
-				(int8_t) ((val_f_i >> 16) & 0xff);
-		}
-	}
-}
-
-void convert_float_to_int32(float *val, void *buf, int samples, int channels)
-{
-	int i, c, idx;
-
-	for (i = 0; i < samples; i++) {
-		for (c = 0; c < channels; c++) {
-			idx = i * channels + c;
-			((int32_t *) buf)[idx] = (int32_t) val[idx];
-		}
-	}
-}
diff --git a/bat/convert.h b/bat/convert.h
deleted file mode 100644
index 28828ba..0000000
--- a/bat/convert.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-void convert_uint8_to_double(void *, double *, int);
-void convert_int16_to_double(void *, double *, int);
-void convert_int24_to_double(void *, double *, int);
-void convert_int32_to_double(void *, double *, int);
-void convert_float_to_uint8(float *, void *, int, int);
-void convert_float_to_int16(float *, void *, int, int);
-void convert_float_to_int24(float *, void *, int, int);
-void convert_float_to_int32(float *, void *, int, int);
diff --git a/bat/signal.c b/bat/signal.c
deleted file mode 100644
index 8026a35..0000000
--- a/bat/signal.c
+++ /dev/null
@@ -1,182 +0,0 @@
-/*
- * Copyright (C) 2015 Caleb Crome
- * Copyright (C) 2013-2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-/*
- * This is a general purpose sine wave generator that will stay stable
- * for a long time, and with a little renormalization, could stay stay
- * stable indefinitely
- */
-
-#include <stdio.h>
-#include <stddef.h>
-#include <stdlib.h>
-#include <math.h>
-#include <stdint.h>
-#include <stdbool.h>
-
-#include "gettext.h"
-#include "common.h"
-#include "signal.h"
-
-/*
- * Initialize the sine wave generator.
- * sin_generator:  gets initialized by this call.
- * frequency:      the frequency for the sine wave.  must be < 0.5*sample_rate
- * sample_rate:    the sample rate...
- * returns 0 on success, -1 on error.
- */
-int sin_generator_init(struct sin_generator *sg, float magnitude,
-		float frequency, float sample_rate)
-{
-	/* angular frequency:  cycles/sec / (samp/sec) * rad/cycle = rad/samp */
-	float w = frequency / sample_rate * 2 * M_PI;
-	if (frequency >= sample_rate / 2)
-		return -1;
-	sg->phasor_real = cos(w);
-	sg->phasor_imag = sin(w);
-	sg->magnitude   = magnitude;
-	sg->state_real  = 0.0;
-	sg->state_imag  = magnitude;
-	sg->frequency = frequency;
-	sg->sample_rate = sample_rate;
-	return 0;
-}
-
-/*
- * Generates the next sample in the sine wave.
- * should be much faster than calling a sin function
- * if it's inlined and optimized.
- *
- * returns the next value.  no possibility of error.
- */
-float sin_generator_next_sample(struct sin_generator *sg)
-{
-	/* get shorthand to pointers */
-	const double pr = sg->phasor_real;
-	const double pi = sg->phasor_imag;
-	const double sr = sg->state_real;
-	const double si = sg->state_imag;
-	/* step the phasor -- complex multiply */
-	sg->state_real = sr * pr - si * pi;
-	sg->state_imag = sr * pi + pr * si;
-	/* return the input value so sine wave starts at exactly 0.0 */
-	return sr;
-}
-
-/* fills a vector with a sine wave */
-void sin_generator_vfill(struct sin_generator *sg, float *buf, int n)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		*buf++ = sin_generator_next_sample(sg);
-}
-
-static int reorder(struct bat *bat, float *val, int frames)
-{
-	float *new_buf = NULL;
-	int i, c, bytes;
-
-	bytes = frames * bat->channels * sizeof(float);
-
-	new_buf = (float *) malloc(bytes);
-	if (new_buf == NULL) {
-		fprintf(bat->err, _("Not enough memory.\n"));
-		return -ENOMEM;
-	}
-
-	memcpy(new_buf, val, bytes);
-	for (i = 0; i < frames; i++)
-		for (c = 0; c < bat->channels; c++)
-			val[i * bat->channels + c] =
-				new_buf[c * frames + i];
-	free(new_buf);
-
-	return 0;
-}
-
-static int adjust_waveform(struct bat *bat, float *val, int frames)
-{
-	int i, nsamples, max;
-	float factor, offset = 0.0;
-
-	switch (bat->format) {
-	case SND_PCM_FORMAT_U8:
-		max = INT8_MAX;
-		offset = max;	/* shift for unsigned format */
-		break;
-	case SND_PCM_FORMAT_S16_LE:
-		max  = INT16_MAX;
-		break;
-	case SND_PCM_FORMAT_S24_3LE:
-		max = (1 << 23) - 1;
-		break;
-	case SND_PCM_FORMAT_S32_LE:
-		max = INT32_MAX;
-		break;
-	default:
-		fprintf(bat->err, _("Invalid PCM format: %s\n"),
-				snd_pcm_format_name(bat->format));
-		return -EINVAL;
-	}
-
-	factor = max * RANGE_FACTOR;
-	nsamples = bat->channels * frames;
-
-	for (i = 0; i < nsamples; i++)
-		val[i] = val[i] * factor + offset;
-
-	return 0;
-}
-
-int generate_sine_wave(struct bat *bat, int frames, void *buf)
-{
-	int err = 0;
-	int c, nsamples;
-	float *sinus_f = NULL;
-	static struct sin_generator sg[MAX_CHANNELS];
-
-	nsamples = bat->channels * frames;
-	sinus_f = (float *) malloc(nsamples * sizeof(float));
-	if (sinus_f == NULL) {
-		fprintf(bat->err, _("Not enough memory.\n"));
-		return -ENOMEM;
-	}
-
-	for (c = 0; c < bat->channels; c++) {
-		/* initialize static struct at the first time */
-		if (sg[c].frequency != bat->target_freq[c])
-			sin_generator_init(&sg[c], 1.0, bat->target_freq[c],
-					bat->rate);
-		/* fill buffer for each channel */
-		sin_generator_vfill(&sg[c], sinus_f + c * frames, frames);
-	}
-
-	/* reorder samples to interleaved mode */
-	err = reorder(bat, sinus_f, frames);
-	if (err != 0)
-		return err;
-
-	/* adjust amplitude and offset of waveform */
-	err = adjust_waveform(bat, sinus_f, frames);
-	if (err != 0)
-		return err;
-
-	bat->convert_float_to_sample(sinus_f, buf, frames, bat->channels);
-
-	free(sinus_f);
-
-	return 0;
-}
diff --git a/configure.ac b/configure.ac
index bdb133c..8f3be98 100644
--- a/configure.ac
+++ b/configure.ac
@@ -49,20 +49,20 @@ AM_CONDITIONAL(HAVE_UCM, test "$have_ucm" = "yes")
 AM_CONDITIONAL(HAVE_TOPOLOGY, test "$have_topology" = "yes")
 AM_CONDITIONAL(HAVE_SAMPLERATE, test "$have_samplerate" = "yes")
 
-dnl Disable bat
-bat=
+dnl Disable alsabat
+alsabat=
 if test "$have_pcm" = "yes"; then
-AC_ARG_ENABLE(bat,
-     AS_HELP_STRING([--disable-bat], [Disable bat compilation]),
+AC_ARG_ENABLE(alsabat,
+     AS_HELP_STRING([--disable-alsabat], [Disable alsabat compilation]),
      [case "${enableval}" in
-       yes) bat=true ;;
-       no)  bat=false ;;
-       *) AC_MSG_ERROR(bad value ${enableval} for --enable-bat) ;;
-     esac],[bat=true])
+       yes) alsabat=true ;;
+       no)  alsabat=false ;;
+       *) AC_MSG_ERROR(bad value ${enableval} for --enable-alsabat) ;;
+     esac],[alsabat=true])
 fi
-AM_CONDITIONAL(BAT, test x$bat = xtrue)
+AM_CONDITIONAL(ALSABAT, test x$alsabat = xtrue)
 
-if test x$bat = xtrue; then
+if test x$alsabat = xtrue; then
 
   saved_CFLAGS="$CFLAGS"
   saved_LDFLAGS="$LDFLAGS"
@@ -382,7 +382,7 @@ AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  m4/Makefile po/Makefile.in \
 	  alsaconf/alsaconf alsaconf/Makefile \
 	  alsaconf/po/Makefile \
-	  alsaucm/Makefile topology/Makefile bat/Makefile \
+	  alsaucm/Makefile topology/Makefile alsabat/Makefile \
 	  aplay/Makefile include/Makefile iecset/Makefile utils/Makefile \
 	  utils/alsa-utils.spec seq/Makefile seq/aconnect/Makefile \
 	  seq/aplaymidi/Makefile seq/aseqdump/Makefile seq/aseqnet/Makefile \
-- 
2.5.0
