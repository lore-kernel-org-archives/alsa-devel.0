From: han.lu@intel.com
Subject: [PATCH V3 6/6] alsabat: add tinyalsa support
Date: Wed, 23 Mar 2016 15:52:47 +0800
Message-ID: <0c6a2f2440bbf0a1502eb201315aedc7b8c31a47.1458718230.git.han.lu@intel.com>
References: <cover.1458718230.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id B9704261A2C
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 08:51:27 +0100 (CET)
In-Reply-To: <cover.1458718230.git.han.lu@intel.com>
In-Reply-To: <cover.1458718230.git.han.lu@intel.com>
References: <cover.1458718230.git.han.lu@intel.com>
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

Use "configure --enable-alsabat-backend-tiny" for alsabat to use
tinyalsa as backend lib. On a system that has both ALSA and tinyalsa
installed, alsabat will use ALSA library by default.
The intention is for alsabat to run on tinyalsa platforms such as
Android or some Internet of Things(IoT) devices.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/Makefile.am b/bat/Makefile.am
index 712f5bf..24e3eb8 100644
--- a/bat/Makefile.am
+++ b/bat/Makefile.am
@@ -7,13 +7,11 @@ alsabat_SOURCES = \
 	bat.c \
 	common.c \
 	signal.c \
-	convert.c \
-	alsa.c
+	convert.c
 
 noinst_HEADERS = \
 	common.h \
 	bat-signal.h \
-	alsa.h \
 	convert.h
 
 if HAVE_LIBFFTW3
@@ -21,6 +19,14 @@ alsabat_SOURCES += analyze.c
 noinst_HEADERS += analyze.h
 endif
 
+if HAVE_LIBTINYALSA
+alsabat_SOURCES += tinyalsa.c
+noinst_HEADERS += tinyalsa.h
+else
+alsabat_SOURCES += alsa.c
+noinst_HEADERS += alsa.h
+endif
+
 AM_CPPFLAGS = \
 	      -Wall -I$(top_srcdir)/include
 
diff --git a/bat/alsabat.1 b/bat/alsabat.1
index 5f41669..3f9b767 100644
--- a/bat/alsabat.1
+++ b/bat/alsabat.1
@@ -33,6 +33,9 @@ analog loopback :-
 
 https://source.android.com/devices/audio/loopback.html
 
+If tinyalsa is installed in system, user can choose tinyalsa as backend lib
+of alsabat, with configure option "--enable-alsabat-backend-tiny".
+
 .SH OPTIONS
 .TP
 \fI\-h, \-\-help\fP
diff --git a/bat/bat.c b/bat/bat.c
index f10c647..e824065 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -31,7 +31,11 @@
 
 #include "common.h"
 
+#ifdef HAVE_LIBTINYALSA
+#include "tinyalsa.h"
+#else
 #include "alsa.h"
+#endif
 #include "convert.h"
 #ifdef HAVE_LIBFFTW3
 #include "analyze.h"
@@ -301,7 +305,6 @@ static void set_defaults(struct bat *bat)
 
 	/* Set default values */
 	bat->rate = 44100;
-	bat->channels = 1;
 	bat->frame_size = 2;
 	bat->sample_size = 2;
 	bat->format = BAT_PCM_FORMAT_S16_LE;
@@ -315,8 +318,15 @@ static void set_defaults(struct bat *bat)
 	bat->capture.device = NULL;
 	bat->buf = NULL;
 	bat->local = false;
+#ifdef HAVE_LIBTINYALSA
+	bat->channels = 2;
+	bat->playback.fct = &playback_tinyalsa;
+	bat->capture.fct = &record_tinyalsa;
+#else
+	bat->channels = 1;
 	bat->playback.fct = &playback_alsa;
 	bat->capture.fct = &record_alsa;
+#endif
 	bat->playback.mode = MODE_LOOPBACK;
 	bat->capture.mode = MODE_LOOPBACK;
 	bat->period_is_limited = false;
diff --git a/bat/common.h b/bat/common.h
index ed33d51..b789af5 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -125,6 +125,8 @@ enum _bat_op_mode {
 };
 
 struct pcm {
+	unsigned int card_tiny;
+	unsigned int device_tiny;
 	char *device;
 	char *file;
 	enum _bat_op_mode mode;
diff --git a/bat/tinyalsa.c b/bat/tinyalsa.c
new file mode 100644
index 0000000..ea5f848
--- /dev/null
+++ b/bat/tinyalsa.c
@@ -0,0 +1,460 @@
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
+#include <stdlib.h>
+#include <pthread.h>
+#include <errno.h>
+
+#include <tinyalsa/asoundlib.h>
+
+#include "aconfig.h"
+#include "gettext.h"
+
+#include "common.h"
+#include "tinyalsa.h"
+
+struct format_map_table {
+	enum _bat_pcm_format format_bat;
+	enum pcm_format format_tiny;
+};
+
+static struct format_map_table map_tables[] = {
+	{ BAT_PCM_FORMAT_S16_LE, PCM_FORMAT_S16_LE },
+	{ BAT_PCM_FORMAT_S32_LE, PCM_FORMAT_S32_LE },
+	{ BAT_PCM_FORMAT_MAX, },
+};
+
+static int format_convert(struct bat *bat, struct pcm_config *config)
+{
+	struct format_map_table *t = map_tables;
+
+	for (; t->format_bat != BAT_PCM_FORMAT_MAX; t++) {
+		if (t->format_bat == bat->format) {
+			config->format = t->format_tiny;
+			return 0;
+		}
+	}
+	fprintf(bat->err, _("Invalid format!\n"));
+	return -EINVAL;
+}
+
+static int init_config(struct bat *bat, struct pcm_config *config)
+{
+	config->channels = bat->channels;
+	config->rate = bat->rate;
+	config->period_size = 1024;
+	config->period_count = 4;
+	config->start_threshold = 0;
+	config->stop_threshold = 0;
+	config->silence_threshold = 0;
+
+	return format_convert(bat, config);
+}
+
+/**
+ * Called when thread is finished
+ */
+static void close_handle(void *handle)
+{
+	struct pcm *pcm = handle;
+
+	if (NULL != pcm)
+		pcm_close(pcm);
+}
+
+/**
+ * Check that a parameter is inside bounds
+ */
+static int check_param(struct bat *bat, struct pcm_params *params,
+		unsigned int param, unsigned int value,
+		char *param_name, char *param_unit)
+{
+	unsigned int min;
+	unsigned int max;
+	int ret = 0;
+
+	min = pcm_params_get_min(params, param);
+	if (value < min) {
+		fprintf(bat->err,
+			_("%s is %u%s, device only supports >= %u%s!\n"),
+			param_name, value, param_unit, min, param_unit);
+		ret = -EINVAL;
+	}
+
+	max = pcm_params_get_max(params, param);
+	if (value > max) {
+		fprintf(bat->err,
+			_("%s is %u%s, device only supports <= %u%s!\n"),
+			param_name, value, param_unit, max, param_unit);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * Check all parameters
+ */
+static int check_playback_params(struct bat *bat,
+		struct pcm_config *config)
+{
+	struct pcm_params *params;
+	unsigned int card = bat->playback.card_tiny;
+	unsigned int device = bat->playback.device_tiny;
+	int err = 0;
+
+	params = pcm_params_get(card, device, PCM_OUT);
+	if (params == NULL) {
+		fprintf(bat->err, _("Unable to open PCM device %u!\n"),
+				device);
+		return -EINVAL;
+	}
+
+	err = check_param(bat, params, PCM_PARAM_RATE,
+			config->rate, "Sample rate", "Hz");
+	if (err < 0)
+		goto exit;
+	err = check_param(bat, params, PCM_PARAM_CHANNELS,
+			config->channels, "Sample", " channels");
+	if (err < 0)
+		goto exit;
+	err = check_param(bat, params, PCM_PARAM_SAMPLE_BITS,
+			bat->sample_size * 8, "Bitrate", " bits");
+	if (err < 0)
+		goto exit;
+	err = check_param(bat, params, PCM_PARAM_PERIOD_SIZE,
+			config->period_size, "Period size", "Hz");
+	if (err < 0)
+		goto exit;
+	err = check_param(bat, params, PCM_PARAM_PERIODS,
+			config->period_count, "Period count", "Hz");
+	if (err < 0)
+		goto exit;
+
+exit:
+	pcm_params_free(params);
+
+	return err;
+}
+
+/**
+ * Play sample
+ */
+static int play_sample(struct bat *bat, struct pcm *pcm,
+		void *buffer, int bytes)
+{
+	int err = 0;
+	int frames = bytes / bat->frame_size;
+	FILE *fp = NULL;
+	int bytes_total = 0;
+
+	if (bat->debugplay) {
+		fp = fopen(bat->debugplay, "wb");
+		err = -errno;
+		if (fp == NULL) {
+			fprintf(bat->err, _("Cannot open file: %s %d\n"),
+					bat->debugplay, err);
+			return err;
+		}
+		/* leave space for file header */
+		if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
+			err = -errno;
+			fclose(fp);
+			return err;
+		}
+	}
+
+	while (1) {
+		err = generate_input_data(bat, buffer, bytes, frames);
+		if (err != 0)
+			break;
+
+		if (bat->debugplay) {
+			if (fwrite(buffer, 1, bytes, fp) != bytes) {
+				err = -EIO;
+				break;
+			}
+			bytes_total += bytes;
+		}
+
+		bat->periods_played++;
+		if (bat->period_is_limited
+				&& bat->periods_played >= bat->periods_total)
+			break;
+
+		err = pcm_write(pcm, buffer, bytes);
+		if (err != 0)
+			break;
+	}
+
+	if (bat->debugplay) {
+		update_wav_header(bat, fp, bytes_total);
+		fclose(fp);
+	}
+	return err;
+}
+
+static int get_tiny_device(struct bat *bat, char *alsa_device,
+		unsigned int *tiny_card, unsigned int *tiny_device)
+{
+	char *tmp1, *tmp2, *tmp3;
+
+	if (alsa_device == NULL)
+		goto fail;
+
+	tmp1 = strchr(alsa_device, ':');
+	if (tmp1 == NULL)
+		goto fail;
+
+	tmp3 = tmp1 + 1;
+	tmp2 = strchr(tmp3, ',');
+	if (tmp2 == NULL)
+		goto fail;
+
+	tmp1 = tmp2 + 1;
+	*tiny_device = atoi(tmp1);
+	*tmp2 = '\0';
+	*tiny_card = atoi(tmp3);
+	*tmp2 = ',';
+
+	return 0;
+fail:
+	fprintf(bat->err, _("Invalid tiny device: %s\n"), alsa_device);
+	return -EINVAL;
+}
+
+/**
+ * Play
+ */
+void *playback_tinyalsa(struct bat *bat)
+{
+	int err = 0;
+	struct pcm_config config;
+	struct pcm *pcm = NULL;
+	void *buffer = NULL;
+	int bufbytes;
+
+	fprintf(bat->log, _("Entering playback thread (tinyalsa).\n"));
+
+	retval_play = 0;
+
+	/* init device */
+	err = get_tiny_device(bat, bat->playback.device,
+			&bat->playback.card_tiny,
+			&bat->playback.device_tiny);
+	if (err < 0) {
+		retval_play = err;
+		goto exit1;
+	}
+
+	/* init config */
+	err = init_config(bat, &config);
+	if (err < 0) {
+		retval_play = err;
+		goto exit1;
+	}
+
+	/* check param before open device */
+	err = check_playback_params(bat, &config);
+	if (err < 0) {
+		retval_play = err;
+		goto exit1;
+	}
+
+	/* open device */
+	pcm = pcm_open(bat->playback.card_tiny, bat->playback.device_tiny,
+			PCM_OUT, &config);
+	if (!pcm || !pcm_is_ready(pcm)) {
+		fprintf(bat->err, _("Unable to open PCM device %u (%s)!\n"),
+				bat->playback.device_tiny, pcm_get_error(pcm));
+		retval_play = -EINVAL;
+		goto exit1;
+	}
+
+	/* init buffer */
+	bufbytes = pcm_frames_to_bytes(pcm, pcm_get_buffer_size(pcm));
+	buffer = malloc(bufbytes);
+	if (!buffer) {
+		retval_play = -ENOMEM;
+		goto exit2;
+	}
+
+	/* init playback source */
+	if (bat->playback.file == NULL) {
+		fprintf(bat->log, _("Playing generated audio sine wave"));
+		bat->sinus_duration == 0 ?
+			fprintf(bat->log, _(" endlessly\n")) :
+			fprintf(bat->log, _("\n"));
+	} else {
+		fprintf(bat->log, _("Playing input audio file: %s\n"),
+				bat->playback.file);
+		bat->fp = fopen(bat->playback.file, "rb");
+		err = -errno;
+		if (bat->fp == NULL) {
+			fprintf(bat->err, _("Cannot open file: %s %d\n"),
+					bat->playback.file, err);
+			retval_play = err;
+			goto exit3;
+		}
+		/* Skip header */
+		err = read_wav_header(bat, bat->playback.file, bat->fp, true);
+		if (err != 0) {
+			retval_play = err;
+			goto exit4;
+		}
+	}
+
+	err = play_sample(bat, pcm, buffer, bufbytes);
+	if (err < 0) {
+		retval_play = err;
+		goto exit4;
+	}
+
+exit4:
+	if (bat->playback.file)
+		fclose(bat->fp);
+exit3:
+	free(buffer);
+exit2:
+	pcm_close(pcm);
+exit1:
+	pthread_exit(&retval_play);
+}
+
+/**
+ * Capture sample
+ */
+static int capture_sample(struct bat *bat, struct pcm *pcm,
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
+	while (bytes_read < bytes_count && !pcm_read(pcm, buffer, bytes)) {
+		if (fwrite(buffer, 1, bytes, fp) != bytes)
+			break;
+
+		bytes_read += bytes;
+
+		bat->periods_played++;
+
+		if (bat->period_is_limited
+				&& bat->periods_played >= bat->periods_total)
+			break;
+	}
+
+	err = update_wav_header(bat, fp, bytes_read);
+
+	fclose(fp);
+	return err;
+}
+
+/**
+ * Record
+ */
+void *record_tinyalsa(struct bat *bat)
+{
+	int err = 0;
+	struct pcm_config config;
+	struct pcm *pcm;
+	void *buffer;
+	unsigned int bufbytes;
+
+	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
+
+	fprintf(bat->log, _("Entering capture thread (tinyalsa).\n"));
+
+	retval_record = 0;
+
+	/* init device */
+	err = get_tiny_device(bat, bat->capture.device,
+			&bat->capture.card_tiny,
+			&bat->capture.device_tiny);
+	if (err < 0) {
+		retval_record = err;
+		goto exit1;
+	}
+
+	/* init config */
+	err = init_config(bat, &config);
+	if (err < 0) {
+		retval_record = err;
+		goto exit1;
+	}
+
+	/* open device */
+	pcm = pcm_open(bat->capture.card_tiny, bat->capture.device_tiny,
+			PCM_IN, &config);
+	if (!pcm || !pcm_is_ready(pcm)) {
+		fprintf(bat->err, _("Unable to open PCM device (%s)!\n"),
+				pcm_get_error(pcm));
+		retval_record = -EINVAL;
+		goto exit1;
+	}
+
+	/* init buffer */
+	bufbytes = pcm_frames_to_bytes(pcm, pcm_get_buffer_size(pcm));
+	buffer = malloc(bufbytes);
+	if (!buffer) {
+		retval_record = -ENOMEM;
+		goto exit2;
+	}
+
+	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
+	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
+	pthread_cleanup_push(close_handle, pcm);
+	pthread_cleanup_push(free, buffer);
+
+	fprintf(bat->log, _("Recording ...\n"));
+	err = capture_sample(bat, pcm, buffer, bufbytes);
+	if (err != 0) {
+		retval_record = err;
+		goto exit3;
+	}
+
+	/* Normally we will never reach this part of code (unless error in
+	 * previous call) (before exit3) as this thread will be cancelled
+	 *  by end of play thread. Except in single line mode. */
+	pthread_cleanup_pop(0);
+	pthread_cleanup_pop(0);
+	pthread_exit(&retval_record);
+
+exit3:
+	free(buffer);
+exit2:
+	pcm_close(pcm);
+exit1:
+	pthread_exit(&retval_record);
+}
diff --git a/bat/tinyalsa.h b/bat/tinyalsa.h
new file mode 100644
index 0000000..60f78f7
--- /dev/null
+++ b/bat/tinyalsa.h
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
+void *playback_tinyalsa(struct bat *);
+void *record_tinyalsa(struct bat *);
diff --git a/configure.ac b/configure.ac
index d712872..e86561b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -58,6 +58,16 @@ AM_CONDITIONAL(HAVE_UCM, test "$have_ucm" = "yes")
 AM_CONDITIONAL(HAVE_TOPOLOGY, test "$have_topology" = "yes")
 AM_CONDITIONAL(HAVE_SAMPLERATE, test "$have_samplerate" = "yes")
 
+dnl Use tinyalsa
+alsabat_backend_tiny=
+AC_ARG_ENABLE(alsabat_backend_tiny,
+    AS_HELP_STRING([--enable-alsabat-backend-tiny], [Use tinyalsa for alsabat backend]),
+    [case "${enableval}" in
+      yes) alsabat_backend_tiny=true ;;
+      no) alsabat_backend_tiny=false ;;
+      *) AC_MSG_ERROR(bad value ${enableval} for --enable-alsabat-backend-tiny) ;;
+    esac],[alsabat_backend_tiny=false])
+
 dnl Disable bat
 bat=
 if test "$have_pcm" = "yes"; then
@@ -82,6 +92,12 @@ if test x$bat = xtrue; then
   dnl Check for libfftw3
   have_libfftw3="yes"
   AC_CHECK_LIB([fftw3], [fftw_malloc], , [have_libfftw3="no"])
+  dnl Check for libtinyalsa
+  have_libtinyalsa=
+  if test x$alsabat_backend_tiny = xtrue; then
+    have_libtinyalsa="yes"
+    AC_CHECK_LIB([tinyalsa], [pcm_open], , [have_libtinyalsa="no"])
+  fi
   AC_CHECK_LIB([m], [sqrtf], , [AC_MSG_ERROR([Error: Need sqrtf])])
   AC_CHECK_LIB([pthread], [pthread_create], , [AC_MSG_ERROR([Error: need PTHREAD library])])
   FFTW_CFLAGS="$CFLAGS"
@@ -95,6 +111,7 @@ if test x$bat = xtrue; then
 
 fi
 AM_CONDITIONAL(HAVE_LIBFFTW3, test "$have_libfftw3" = "yes")
+AM_CONDITIONAL(HAVE_LIBTINYALSA, test "$have_libtinyalsa" = "yes")
 
 dnl Check for librt
 LIBRT=""
-- 
2.5.0
