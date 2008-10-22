From: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>
Subject: [PATCH 2/3] saa7146: Emagic Audiowerk8 low-level ALSA
	driver
Date: Thu, 23 Oct 2008 00:04:59 +0200
Message-ID: <48FFA38B.1020403@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail18.bluewin.ch (mail18.bluewin.ch [195.186.19.64])
	by alsa0.perex.cz (Postfix) with ESMTP id C26B0103841
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 00:04:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

From: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>

Low-level ALSA driver for Emagic Audiowerk8 sound card.
Project page: http://sourceforge.net/projects/aw8-alsa
Built and tested with Vanilla 2.6.25.16

Signed-off-by: Matthias Nyffenegger <matthias.nyffenegger@bluewin.ch>
---
This is a request for submission to ALSA-tree.



diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/README.txt 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/README.txt
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/README.txt	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/README.txt	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1 @@
+See sourceforge.net project "Audiowerk8 ALSA driver" (aw8-alsa) Wiki for more information.
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/Makefile 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/Makefile
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/Makefile	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,8 @@
+# Makefile for Audiowerk module.
+# run command in source directory:
+# 	make -C /usr/src/linux M=`pwd` modules modules_install
+
+EXTRA_CFLAGS := -DSAA7146_SUBSYS_LOG_TAG=\"AW8\"
+obj-m := snd-aw8.o
+snd-aw8-objs := saa7146i2c.o saa7146i2s.o saa7146audio.o aw8.o aw8alsa.o
+
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/aw8alsa.c 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/aw8alsa.c
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/aw8alsa.c	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/aw8alsa.c	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,826 @@
+/*
+ *  Emagic Audiowerk ALSA driver
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include "log.h"
+#include "saa7146audio.h"
+#include "aw8.h"
+
+/* From Takashi Iwai's "Writing an ALSA Driver" developer guide */
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
+
+/*
+ * Module info
+ */
+MODULE_AUTHOR("Matthias Nyffenegger matthias.nyffenegger[AT]bluewin.ch");
+MODULE_DESCRIPTION(AW_MODULE_DESCRIPTION);
+MODULE_LICENSE("GPL");
+MODULE_VERSION("0:0.2");
+
+/**
+ * Module parameter 'input_type': select capture input digital or analog
+ * 				(default)
+ */
+int input_type;
+module_param(input_type, int, 0444);
+MODULE_PARM_DESC(input_type, "0=analog (default), 1=digital");
+
+#define PCM_0	0
+
+/**
+ * The ALSA 'chip' data structure.
+ */
+struct awalsa_t {
+	/* the alsa related stuff */
+	struct snd_card *card;
+	struct snd_pcm *pcm_0;
+	struct snd_pcm_substream *pcm_in_substreams[MAX_IN_AUDIO_STREAMS];
+	struct snd_pcm_substream *pcm_out_substreams[MAX_OUT_AUDIO_STREAMS];
+	/* the SAA7146A stuff */
+	struct saa7146audio chipaudio;
+	struct audio_stream *in_streams[MAX_IN_AUDIO_STREAMS];
+	struct audio_stream *out_streams[MAX_OUT_AUDIO_STREAMS];
+	/*/ the PCI stuff */
+	struct pci_dev *pci;
+	int irq;
+	/* other useful things */
+	spinlock_t isr_lock;
+};
+
+static int snd_aw_substream_open(struct snd_pcm_substream *substream, int in);
+static int snd_aw_substream_close(struct snd_pcm_substream *substream, int in);
+static int snd_aw_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *hw_params);
+static int snd_aw_pcm_hw_free(struct snd_pcm_substream *substream);
+static int snd_aw_pcm_prepare_substream(struct snd_pcm_substream *substream,
+					int in);
+static int snd_aw_pcm_trigger_substream(struct snd_pcm_substream *substream,
+					int cmd, int in);
+static snd_pcm_uframes_t snd_aw_pcm_pointer_substream(
+					struct snd_pcm_substream *substream,
+					int in);
+
+/**
+ *
+ * ALSA capture stream definitions and callbacks
+ *
+ */
+static struct snd_pcm_hardware snd_aw_capture_hw = {
+	.info =	(SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S16_BE |
+			SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S32_BE),
+	.rates = AW_PCM_RATE,
+	.rate_min = AW_FS_MIN,
+	.rate_max = AW_FS_MAX,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 16384,
+	.period_bytes_min = 64, /* HW restriction, see SAA7146A spec p.24 */
+	.period_bytes_max = 8192,
+	.periods_min = 2,
+	.periods_max = 2,
+};
+
+/**
+ * ALSA capture stream open callback.
+ */
+static int snd_aw_capture_open(struct snd_pcm_substream *substream)
+{
+	return snd_aw_substream_open(substream, 1);
+}
+
+/**
+ * ALSA capture stream close callback.
+ */
+static int snd_aw_capture_close(struct snd_pcm_substream *substream)
+{
+	return snd_aw_substream_close(substream, 1);
+}
+
+/**
+ * Module scoped helper: converts alsa to Audiowerk capture sample format.
+ */
+static enum aw_formats alsa_2_aw_capture_format(snd_pcm_format_t fmt)
+{
+	switch (fmt) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		return fmt_s16_2le;
+	case SNDRV_PCM_FORMAT_S16_BE:
+		return fmt_s16_2be;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		return fmt_s18_4le;
+	case SNDRV_PCM_FORMAT_S32_BE:
+		return fmt_s18_4be;
+	default:
+		LOG_ERROR("Unsupported capture format %d", fmt);
+		return fmt_s16_2le;
+	}
+}
+
+/**
+ * ALSA capture stream prepare callback.
+ * Be careful that this callback will be called many times at each set up.
+ */
+static int snd_aw_pcm_prepare_capture(struct snd_pcm_substream *substream)
+{
+	return snd_aw_pcm_prepare_substream(substream, 1);
+}
+
+/**
+ * ALSA capture stream trigger callback. [atomic].
+ */
+static int snd_aw_pcm_trigger_capture(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	return snd_aw_pcm_trigger_substream(substream, cmd, 1);
+}
+
+/**
+ * ALSA capture stream hw-buffer pointer callback. [atomic]
+ */
+static snd_pcm_uframes_t snd_aw_pcm_pointer_capture(
+					struct snd_pcm_substream *substream)
+{
+	return snd_aw_pcm_pointer_substream(substream, 1);
+}
+
+/**
+ * ALSA capture stream callback operations.
+ */
+static struct snd_pcm_ops snd_aw_capture_ops = {
+	.open =        snd_aw_capture_open,
+	.close =       snd_aw_capture_close,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_aw_pcm_hw_params,
+	.hw_free =     snd_aw_pcm_hw_free,
+	.prepare =     snd_aw_pcm_prepare_capture,
+	.trigger =     snd_aw_pcm_trigger_capture,
+	.pointer =     snd_aw_pcm_pointer_capture,
+};
+
+/**
+ *
+ * ALSA playback stream definitions and callbacks
+ *
+ */
+static struct snd_pcm_hardware snd_aw_playback_hw = {
+	.info = (SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S16_BE |
+			SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S32_BE),
+	.rates = AW_PCM_RATE,
+	.rate_min = AW_FS_MIN,
+	.rate_max = AW_FS_MAX,
+	.channels_min = 2,
+	.channels_max = AW_MAX_PLAYBACK_CHANNELS_PER_STREAM,
+	.buffer_bytes_max = 16384,
+	.period_bytes_min = 64, /* HW restriction, see SAA7146A spec p.24 */
+	.period_bytes_max = 8192,
+	.periods_min = 2,
+	.periods_max = 2,
+};
+
+/**
+ * ALSA playback stream open callback.
+ */
+static int snd_aw_playback_open(struct snd_pcm_substream *substream)
+{
+	return snd_aw_substream_open(substream, 0);
+}
+
+/**
+ * ALSA playback stream close callback.
+ */
+static int snd_aw_playback_close(struct snd_pcm_substream *substream)
+{
+	return snd_aw_substream_close(substream, 0);
+}
+
+/**
+ * Module scoped helper: converts alsa to Audiowerk playback sample format.
+ */
+static enum aw_formats alsa_2_aw_playback_format(snd_pcm_format_t fmt)
+{
+	switch (fmt) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		return fmt_s16_2le;
+	case SNDRV_PCM_FORMAT_S16_BE:
+		return fmt_s16_2be;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		return fmt_s20_4le;
+	case SNDRV_PCM_FORMAT_S32_BE:
+		return fmt_s20_4be;
+	default:
+		LOG_ERROR("Unsupported playback format %d", fmt);
+		return fmt_s16_2le;
+	}
+}
+
+/**
+ * ALSA playback stream prepare callback.
+ * Be careful that this callback will be called many times at each set up.
+ */
+static int snd_aw_pcm_prepare_playback(struct snd_pcm_substream *substream)
+{
+	return snd_aw_pcm_prepare_substream(substream, 0);
+}
+
+/**
+ * ALSA playback stream trigger callback. [atomic].
+ */
+static int snd_aw_pcm_trigger_playback(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	return snd_aw_pcm_trigger_substream(substream, cmd, 0);
+}
+
+/**
+ * ALSA playback stream hw-buffer pointer callback. [atomic].
+ */
+static snd_pcm_uframes_t snd_aw_pcm_pointer_playback(
+					struct snd_pcm_substream *substream)
+{
+	return snd_aw_pcm_pointer_substream(substream, 0);
+}
+
+/**
+ * ALSA playback stream callback operations.
+ */
+static struct snd_pcm_ops snd_aw_playback_ops = {
+	.open =        snd_aw_playback_open,
+	.close =       snd_aw_playback_close,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_aw_pcm_hw_params,
+	.hw_free =     snd_aw_pcm_hw_free,
+	.prepare =     snd_aw_pcm_prepare_playback,
+	.trigger =     snd_aw_pcm_trigger_playback,
+	.pointer =     snd_aw_pcm_pointer_playback,
+};
+
+static int snd_aw_substream_open(struct snd_pcm_substream *substream, int in)
+{
+	struct awalsa_t *awalsa = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int device = substream->pcm->device;
+	struct snd_pcm_substream **alsa_pcm_substreams = NULL;
+
+	if (device != PCM_0) {
+		LOG_ERROR("Invalid device index=%d", device);
+		return -EINVAL;
+	}
+	alsa_pcm_substreams =
+		(in ? awalsa->pcm_in_substreams : awalsa->pcm_out_substreams);
+	if (alsa_pcm_substreams[substream->number] != NULL) {
+		LOG_WARN("%s substream %d already open",
+			(in ? "Capture" : "Playback"), substream->number);
+		return -EAGAIN;
+	}
+	/* Remember substream for interrupt handler where we are given the chip
+	   instance only. */
+	alsa_pcm_substreams[substream->number] = substream;
+	runtime->hw = (in ? snd_aw_capture_hw : snd_aw_playback_hw);
+	return 0;
+}
+
+static int snd_aw_substream_close(struct snd_pcm_substream *substream, int in)
+{
+	struct awalsa_t *awalsa = snd_pcm_substream_chip(substream);
+	int device = substream->pcm->device;
+	struct snd_pcm_substream **alsa_pcm_substreams = NULL;
+	struct audio_stream **saa7146_streams = NULL;
+
+	if (device != PCM_0) {
+		LOG_ERROR("Invalid device index=%d", device);
+		return -EINVAL;
+	}
+	alsa_pcm_substreams =
+		(in ? awalsa->pcm_in_substreams : awalsa->pcm_out_substreams);
+	saa7146_streams = (in ? awalsa->in_streams : awalsa->out_streams);
+	alsa_pcm_substreams[substream->number] = NULL;
+	if (saa7146_streams[substream->number] != NULL) {
+		saa7146_stream_unprepare(&awalsa->chipaudio,
+				saa7146_streams[substream->number]);
+	}
+	return 0;
+}
+
+/**
+ * ALSA stream hw_params callback.
+ */
+static int snd_aw_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *hw_params)
+{
+	int err = 0;
+	int device = substream->pcm->device;
+
+	if (device != PCM_0) {
+		LOG_ERROR("Invalid device index=%d", device);
+		return -EINVAL;
+	}
+	err = snd_pcm_lib_malloc_pages(substream,
+						params_buffer_bytes(hw_params));
+	if (err < 0) {
+		LOG_ERROR("snd_pcm_lib_malloc_pages ERROR=%d", err);
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * ALSA stream hw_free callback.
+ */
+static int snd_aw_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	int err = 0;
+	int device = substream->pcm->device;
+
+	if (device != PCM_0) {
+		LOG_ERROR("Invalid device index=%d", device);
+		return -EINVAL;
+	}
+	err = snd_pcm_lib_free_pages(substream);
+	if (err < 0) {
+		LOG_ERROR("snd_pcm_lib_free_pages ERROR=%d", err);
+		return err;
+	}
+	return 0;
+}
+
+static int snd_aw_pcm_prepare_substream(struct snd_pcm_substream *substream,
+					int in)
+{
+	struct awalsa_t *awalsa = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct audio_stream **saa7146_streams = NULL;
+	struct audio_stream *stream = NULL;
+	int device = substream->pcm->device;
+	enum aw_formats fmt = fmt_s16_2le;
+
+	if (device != PCM_0) {
+		LOG_ERROR("Invalid device index=%d", device);
+		return -EINVAL;
+	}
+	fmt = (in ? alsa_2_aw_capture_format(runtime->format) :
+				alsa_2_aw_playback_format(runtime->format));
+	saa7146_streams = (in ? awalsa->in_streams : awalsa->out_streams);
+	/* as this function may be called many times we must clean up first */
+	if (saa7146_streams[substream->number] != NULL) {
+		saa7146_stream_unprepare(&awalsa->chipaudio,
+				saa7146_streams[substream->number]);
+	}
+	/* try to prepare a new stream with the given parameters */
+	if (in) {
+		stream = saa7146_stream_prepare_capture(&awalsa->chipaudio,
+			substream->number,
+			runtime->dma_addr, /* stream buffer phys. base addr. */
+			2 * snd_pcm_lib_period_bytes(substream), /* buf size */
+			runtime->channels,
+			((fmt == fmt_s16_2le || fmt == fmt_s16_2be) ? 2 : 4),
+			((fmt == fmt_s16_2le || fmt == fmt_s18_4le) ? le : be));
+	} else {
+		stream = saa7146_stream_prepare_playback(&awalsa->chipaudio,
+			substream->number,
+			runtime->dma_addr, /* stream buffer phys. base addr */
+			2 * snd_pcm_lib_period_bytes(substream), /* buf size */
+			runtime->channels,
+			((fmt == fmt_s16_2le || fmt == fmt_s16_2be) ? 2 : 4),
+			((fmt == fmt_s16_2le || fmt == fmt_s20_4le) ? le : be));
+	}
+	if (stream == NULL)
+		return -EINVAL;
+	saa7146_streams[substream->number] = stream;
+	if (aw8_set_samplerate(&awalsa->chipaudio.chipi2s.chip,	runtime->rate)
+									!= 0)
+		return -EINVAL;
+	return 0;
+}
+
+static int snd_aw_pcm_trigger_substream(struct snd_pcm_substream *substream,
+					int cmd, int in)
+{
+	struct awalsa_t *awalsa = snd_pcm_substream_chip(substream);
+	int device = substream->pcm->device;
+	struct audio_stream **saa7146_streams = NULL;
+
+	if (device != PCM_0) {
+		LOG_ERROR("Invalid device index=%d", device);
+		return -EINVAL;
+	}
+	saa7146_streams = (in ? awalsa->in_streams : awalsa->out_streams);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		saa7146_stream_start(&awalsa->chipaudio,
+					saa7146_streams[substream->number]);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		saa7146_stream_stop(&awalsa->chipaudio,
+					saa7146_streams[substream->number]);
+		break;
+	default:
+		LOG_ERROR("Unknown trigger command=%d", cmd);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static snd_pcm_uframes_t snd_aw_pcm_pointer_substream(
+					struct snd_pcm_substream *substream,
+					int in)
+{
+	struct awalsa_t *awalsa = snd_pcm_substream_chip(substream);
+	struct audio_stream **saa7146_streams = NULL;
+	unsigned long hw_ptr = 0;
+	snd_pcm_uframes_t frames;
+	int device = substream->pcm->device;
+
+	if (device != PCM_0) {
+		LOG_ERROR("Invalid device index=%d", device);
+		return -EINVAL;
+	}
+	saa7146_streams = (in ? awalsa->in_streams : awalsa->out_streams);
+	hw_ptr = saa7146_stream_get_hw_pointer(&awalsa->chipaudio,
+				saa7146_streams[substream->number]);
+	frames =  bytes_to_frames(substream->runtime,
+			hw_ptr - (size_t)(substream->runtime->dma_addr));
+	return frames;
+}
+
+/**
+ *
+ * ALSA device initialization
+ *
+ */
+
+/**
+ * ALSA Setup 1 PCM device:
+ *   AW8 substreams: 1 capture /2 playback (1 analog/digital, 1 analog)
+ *   AW2 substreams: 1 capture /2 playback (1 analog, 1 digital)
+ */
+static int __devinit snd_aw_new_pcm(struct awalsa_t *awalsa)
+{
+	struct snd_pcm *pcm;
+	int err;
+	int pages = 0;
+
+	/* create the pcm device */
+	err = snd_pcm_new(awalsa->card, "SAA7146A", /* device ID string */
+					PCM_0, /* device index */
+					2, /* playback substreams AW2/8 */
+					1, /* capture substreams AW2/8 */
+					&pcm);
+	if (err != 0) {
+		LOG_ERROR("snd_pcm_new ERROR=%d", err);
+		return err;
+	}
+	pcm->private_data = awalsa;
+	strcpy(pcm->name, "Multichannel Capture/Playback");
+	awalsa->pcm_0 = pcm;
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_aw_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_aw_capture_ops);
+	LOG_INFO("PCM device [Multichannel Capture/Playback]"
+						" successfully created");
+	/* Pre-allocation 128k of dma buffer */
+	pages = 1 << ((17 - PAGE_SHIFT > 0) ? 17 - PAGE_SHIFT : 0);
+	err = snd_pcm_lib_preallocate_pages_for_all(pcm,
+						SNDRV_DMA_TYPE_DEV,
+						snd_dma_pci_data(awalsa->pci),
+						pages * PAGE_SIZE,
+						pages * PAGE_SIZE);
+	if (err != 0) {
+		LOG_ERROR("snd_pcm_lib_preallocate_pages_for_all"
+							" ERROR=%d", err);
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * ALSA Interrupt Service Routine.
+ */
+static irqreturn_t snd_aw_interrupt(int irq, void *dev_id)
+{
+	struct awalsa_t *awalsa = dev_id;
+	uint32_t isr = 0;
+
+	/* lock isr - block other interrupts */
+	spin_lock(awalsa->isr_lock);
+	isr = saa7146_read(&awalsa->chipaudio.chipi2s.chip, ISR);
+	/* was it one of SAA7146A (remember we might share irq line ..) */
+	if (!isr) {
+		spin_unlock(awalsa->isr_lock);
+		return IRQ_NONE;
+	}
+	/* clear all interrupts */
+	saa7146_write(&awalsa->chipaudio.chipi2s.chip, ISR, isr);
+	if (isr & A1_in && awalsa->pcm_in_substreams[0] != NULL)
+		snd_pcm_period_elapsed(awalsa->pcm_in_substreams[0]);
+	if (isr & A1_out && awalsa->pcm_out_substreams[0] != NULL)
+		snd_pcm_period_elapsed(awalsa->pcm_out_substreams[0]);
+	if (isr & A2_out && awalsa->pcm_out_substreams[1] != NULL)
+		snd_pcm_period_elapsed(awalsa->pcm_out_substreams[1]);
+	spin_unlock(awalsa->isr_lock);
+	return IRQ_HANDLED;
+}
+
+/**
+ * ALSA chip-specific destructor.
+ * (see "PCI Resource Managements")
+ */
+static int snd_aw_free(struct awalsa_t *awalsa)
+{
+	struct saa7146i2s *chipi2s = &awalsa->chipaudio.chipi2s;
+
+	/* disable hardware here if any */
+	aw_exit(chipi2s);
+	if (awalsa->irq >= 0)
+		free_irq(awalsa->irq, (void *)awalsa);
+	if (chipi2s->chip.iobase_virt)
+		iounmap(chipi2s->chip.iobase_virt);
+	pci_release_regions(awalsa->pci);
+	pci_disable_device(awalsa->pci);
+	kfree(awalsa);
+	return 0;
+}
+
+/**
+ * ALSA component-destructor.
+ * (see "Management of Cards and Components")
+ */
+static int snd_aw_dev_free(struct snd_device *device)
+{
+	snd_aw_free(device->device_data);
+	return 0;
+}
+
+/**
+ * ALSA chip-specific constructor.
+ * (see "Management of Cards and Components")
+ */
+static int __devinit snd_aw_create(struct snd_card *card,
+					struct pci_dev *pci,
+					struct awalsa_t **rchip)
+{
+	static struct snd_device_ops ops = {
+		.dev_free = snd_aw_dev_free,
+	};
+	int err;
+	struct awalsa_t *awalsa;
+	*rchip = NULL;
+
+	/* Initialize the PCI entry: This function switches the device 'on'.
+	   In some cases, IRQ and I/O range is assigned. */
+	err = pci_enable_device(pci);
+	if (err != 0) {
+		LOG_ERROR("pci_enable_device ERROR=%d", err);
+		return err;
+	}
+	pci_set_master(pci);
+	err = pci_set_dma_mask(pci, DMA_32BIT_MASK);
+	if (err != 0) {
+		LOG_ERROR("pci_set_dma_mask ERROR=%d", err);
+		goto snd_aw_create_exit0;
+	}
+	err = pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK);
+	if (err != 0) {
+		LOG_ERROR("pci_set_consistent_dma_mask ERROR=%d", err);
+		goto snd_aw_create_exit0;
+	}
+	awalsa = kzalloc(sizeof(*awalsa), GFP_KERNEL);
+	if (awalsa == NULL) {
+		LOG_ERROR("Could not allocate memory");
+		err = -ENOMEM;
+		goto snd_aw_create_exit0;
+	}
+	awalsa->card = card;
+	awalsa->pci = pci;
+	awalsa->irq = -1;
+	spin_lock_init(&awalsa->isr_lock);
+	/* (1) PCI resource allocation */
+	err = pci_request_regions(pci, "SAA7146A");
+	if (err != 0) {
+		LOG_ERROR("pci_request_regions ERROR=%d", err);
+		goto snd_aw_create_exit1;
+	}
+	/* Get the device's registers physical base address. The device register
+	   space is not available for access by the driver now; it has to be
+	   mapped to a virtual memory space first. */
+	awalsa->chipaudio.chipi2s.chip.iobase_phys = pci_resource_start(pci, 0);
+	awalsa->chipaudio.chipi2s.chip.iolen = pci_resource_len(pci, 0);
+	/* Map device registers to virtual memory. 'nocache' means that we don't
+	   want the device's registers to be read-cached by the CPU (e.g. as a
+	   result of compiler optimizations). This is important since the CPU
+	   does not necessarily know when a register value has changed (unless
+	   this was by a write action of the driver). */
+	awalsa->chipaudio.chipi2s.chip.iobase_virt =
+		ioremap_nocache(awalsa->chipaudio.chipi2s.chip.iobase_phys,
+				awalsa->chipaudio.chipi2s.chip.iolen);
+	err = request_irq(pci->irq, snd_aw_interrupt, IRQF_DISABLED|IRQF_SHARED,
+						"SAA7146A", (void *)awalsa);
+	if (err != 0) {
+		LOG_ERROR("Cannot grab irq %d, ERROR=%d", pci->irq, err);
+		err = -EBUSY;
+		goto snd_aw_create_exit2;
+	}
+	awalsa->irq = pci->irq;
+	/* (2) initialization of the chip hardware */
+	if (aw_init(&awalsa->chipaudio.chipi2s, input_type) != 0)
+		goto snd_aw_create_exit2;
+	/* (3) create alsa device */
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, awalsa, &ops);
+	if (err	< 0) {
+		LOG_ERROR("snd_device_new ERROR=%d", err);
+		goto snd_aw_create_exit2;
+	}
+	snd_card_set_dev(card, &pci->dev);
+	*rchip = awalsa;
+	return 0;
+snd_aw_create_exit2:
+	snd_aw_free(awalsa);
+	return err;
+snd_aw_create_exit1:
+	kfree(awalsa);
+snd_aw_create_exit0:
+	pci_disable_device(pci);
+	return err;
+}
+
+/**
+ * ALSA device constructor -- see "Constructor" sub-section in Takashi Iwai's
+ * "Writing an ALSA Driver" developer guide.
+ */
+static int __devinit snd_aw_probe(struct pci_dev *pci,
+				const struct pci_device_id *pci_id)
+{
+	static int dev;
+	int err;
+	struct snd_card *card;
+	struct awalsa_t *awalsa;
+
+	/* (1) */
+	if (dev >= SNDRV_CARDS) {
+		LOG_ERROR("No device available ERROR=%d", -ENODEV);
+		return -ENODEV;
+	}
+	if (!enable[dev]) {
+		dev++;
+		LOG_ERROR("No device entry ERROR=%d", -ENOENT);
+		return -ENOENT;
+	}
+	/* (2) */
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (card == NULL) {
+		LOG_ERROR("snd_card_new ERROR=%d", -ENOMEM);
+		return -ENOMEM;
+	}
+	/* (3) */
+	err = snd_aw_create(card, pci, &awalsa);
+	if (err < 0) {
+		LOG_ERROR("snd_aw_create ERROR=%d", err);
+		goto snd_aw_probe_exit0;
+	}
+	/* (4) */
+	strcpy(card->driver, "SAA7146A");
+	strcpy(card->shortname, AW_CARD_SHORT_NAME);
+	sprintf(card->longname,
+		"%s at 0x%lx [%i] irq %i",
+		card->shortname,
+		awalsa->chipaudio.chipi2s.chip.iobase_phys,
+		awalsa->chipaudio.chipi2s.chip.iolen,
+		awalsa->irq);
+	LOG_INFO("card-info[%s]", card->longname);
+	/* (5) */
+	err = snd_aw_new_pcm(awalsa);
+	if (err != 0) {
+		LOG_ERROR("snd_aw_new_pcm ERROR=%d", err);
+		goto snd_aw_probe_exit0;
+	}
+	/* (6) */
+	err = snd_card_register(card);
+	if (err < 0) {
+		LOG_ERROR("snd_card_register ERROR=%d", err);
+		goto snd_aw_probe_exit0;
+	}
+	/* (7) */
+	pci_set_drvdata(pci, card);
+	dev++;
+	return 0;
+snd_aw_probe_exit0:
+	snd_card_free(card);
+	return err;
+}
+
+/**
+ * ALSA device destructor -- see "Destructor" sub-section
+ */
+static void __devexit snd_aw_remove(struct pci_dev *pci)
+{
+	snd_card_free(pci_get_drvdata(pci));
+	pci_set_drvdata(pci, NULL);
+}
+
+/**
+ *
+ * PCI specific stuff
+ *
+ */
+
+/**
+ * Organisation of EEPROM of the SAA7146A:
+ * The data of the subsystem ID and the subsystem vendor ID is organized in
+ * the EEPROM in the following order:
+ *
+ * EE-Addr	Value 				Configuration Space Addr.
+ * ---------------------------------------------------------------------
+ * 00 		Subsys ID (high byte) 		2C, bits: 31 - 24
+ * 01 		Subsys ID (low byte)		2C, bits: 23 - 16
+ * 02 		Subsys Vendor ID (high byte) 	2C, bits: 15 -  8
+ * 03 		Subsys Vendor ID (low byte) 	2C, bits:  7 -  0
+ * 04 		Max_Lat 			3C, bits: 31 - 24
+ * 05 		Min_Gnt 			3C, bits: 23 - 16
+ *
+ * For AW8 Subsys ID and Subsys Vendor ID are 0xFF on my card.
+ * For AW2 Subsys ID and Subsys Vendor ID are 0x00 on my card.
+ */
+
+static struct pci_device_id snd_aw_ids[] = {
+	{ PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_PHILIPS_SAA7146,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, snd_aw_ids);
+
+/**
+ * pci_driver definition.
+ */
+static struct pci_driver driver = {
+	.name = AW_DRIVER_NAME,
+	.id_table = snd_aw_ids,
+	.probe = snd_aw_probe,
+	.remove = __devexit_p(snd_aw_remove),
+};
+
+/**
+ * initialization of the module.
+ */
+static int __init alsa_card_aw_init(void)
+{
+	int err;
+
+	err = pci_register_driver(&driver);
+	if (err != 0) {
+		LOG_ERROR("pci_register_driver ERROR=%d", err);
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * clean up the module.
+ */
+static void __exit alsa_card_aw_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
+module_init(alsa_card_aw_init)
+module_exit(alsa_card_aw_exit)
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/aw8.c 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/aw8.c
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/aw8.c	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/aw8.c	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,185 @@
+/*
+ *  Emagic Audiowerk specific functions
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *  Based on GPLed Emagic Audiowerk8 Windows driver provided by Martijn Sipkema.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#include <linux/types.h>
+#include <linux/sched.h>
+#include "log.h"
+#include "saa7146.h"
+#include "saa7146i2s.h"
+#include "saa7146i2c.h"
+#include "aw8.h"
+
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+#define SLEEP_DIGIN	100 /* wait [ms] after switching input type adc/daio */
+#define GPIO_0		GPIO_CTRL
+#define MASK_GPIO_HI	0x50
+#define MASK_GPIO_LO	0x40
+#define SLEEP_PLL	500 /* wait [ms] after setting new fs */
+#define PLL_DEVICE_ADDR	0x62 /* I2C device address of AW8 PLL chip */
+#define PLL_FREF	1000 /* reference frequency for PLL */
+
+/**
+ * TODO: Description
+ */
+enum aw_input_types {analog, digital};
+
+/* forward declarations */
+static int aw8_device_init(struct saa7146i2s *chipi2s);
+static void switch_input(struct saa7146reg *chip, enum aw_input_types type);
+
+/**
+ * see aw8.h
+ */
+int aw_init(struct saa7146i2s *chipi2s, int input_type)
+{
+	int err = 0;
+
+	saa7146_write(&chipi2s->chip, IER, 0); /* disable all interrupts */
+	saa7146_write(&chipi2s->chip, MC1, MRST_N<<16); /* reset SAA7146 */
+	/* setup PCI arbitration ctrl (see SAA7146 spec. page 31 for details):
+	   o 8DW burst for all FIFOs
+	   o 8DW (empty DWs in FIFO) threshold for OUT-FIFOs
+	   o 8DW (valid DWs in FIFO) threshold for IN-FIFOs
+	   0x0e0e0e0e => xxx0 1110 xxx0 1110 xxx0 1110 xxx0 1110 */
+	saa7146_write(&chipi2s->chip, PCI_BT_A, 0x0e0e0e0e);
+	/* enable SAA7146 audio pins */
+	saa7146_write(&chipi2s->chip, MC1, (EAP<<16 | EAP));
+	/* setup audio clock source (from EMagic GPL driver) */
+	saa7146_write(&chipi2s->chip, ACON2, ((0UL<<27) | /* A1_CLKSRC: BCLK1 */
+					(1UL<<22) | /* A2_CLKSRC: BCLK1 */
+					(0UL<<21) | /* INVERT_BCLK1 */
+					(0UL<<20) | /* INVERT_BCLK2 */
+					(1UL<<19) | /* BCLK1_OEN: input */
+					(0UL<<18))); /* BCLK2_OEN: output */
+	/* init ACON1: WS1-4 to output active low */
+	chipi2s->acon1 = 0x0000cccc;
+	saa7146_write(&chipi2s->chip, ACON1, chipi2s->acon1);
+	if (input_type)
+		aw_switch_input_daio(&chipi2s->chip);
+	else
+		aw_switch_input_adc(&chipi2s->chip);
+	if (saa7146_i2s_init_audio_interface(chipi2s, a1, 4, 8) != 0
+		|| saa7146_i2s_init_audio_interface(chipi2s, a2, 4, 8) != 0)
+		return -1;
+	err = aw8_device_init(chipi2s);
+	/* enable interrupts */
+	saa7146_write(&chipi2s->chip, IER, (A1_out | A2_out | A1_in));
+	return err;
+}
+
+/**
+ * see aw8.h
+ */
+void aw_exit(struct saa7146i2s *chipi2s)
+{
+	saa7146_write(&chipi2s->chip, IER, 0); /* disable all interrupts */
+	saa7146_write(&chipi2s->chip, MC1, (MRST_N<<16)); /* reset SAA7146 */
+}
+
+/**
+ * see aw8.h
+ */
+void aw_switch_input_adc(struct saa7146reg *chip)
+{
+	switch_input(chip, analog);
+}
+
+/**
+ * see aw8.h
+ */
+void aw_switch_input_daio(struct saa7146reg *chip)
+{
+	switch_input(chip, digital);
+}
+
+/**
+ * see aw8.h
+ * Details regarding implementation see project wiki.
+ */
+int aw8_set_samplerate(struct saa7146reg *chip, unsigned int fs)
+{
+	uint32_t counter = 0;
+	uint8_t fs_prg_seq[4];
+
+	fs = fs > AW_FS_MAX ? AW_FS_MAX : fs;
+	fs = fs < AW_FS_MIN ? AW_FS_MIN : fs;
+	/* init TSA6060 counter */
+	counter = (256 * fs * 4) / PLL_FREF;
+	fs_prg_seq[0] = counter << 1;
+	fs_prg_seq[1] = counter >> 7;
+	fs_prg_seq[2] = (counter >> 15 & 0x03) | 0x18;
+	fs_prg_seq[3] = 0;
+	if (saa7146_i2c_write(chip, bps_10k, PLL_DEVICE_ADDR, NULL, 0,
+							fs_prg_seq, 4) < 4)
+		return -1;
+	return 0;
+}
+
+/**
+ * A1:				A2:
+ * analog in: WS0/SD4
+ * analog/digital out: WS1/SD0	analog out: WS3/SD1
+ * analog out: WS2/SD2		analog out: WS4/SD3
+ */
+static int aw8_device_init(struct saa7146i2s *chipi2s)
+{
+	if (saa7146_i2s_init_device(chipi2s, a1, in, ws0, sd4_i_a1) != 0
+		|| saa7146_i2s_init_device(chipi2s, a1, out, ws1, sd0_o_a1) != 0
+		|| saa7146_i2s_init_device(chipi2s, a1,	out, ws2, sd2_io_ax)
+									!= 0
+		|| saa7146_i2s_init_device(chipi2s, a2, out, ws3, sd1_io_ax)
+									!= 0
+		|| saa7146_i2s_init_device(chipi2s, a2, out, ws4, sd3_io_ax)
+									!= 0)
+		return -1;
+	return 0;
+}
+
+/**
+ * TODO: Description
+ */
+static void switch_input(struct saa7146reg *chip, enum aw_input_types type)
+{
+	/* From EMagic driver...
+	// Switch SAA7146 to safe mode
+	setreg(chip, ACON1, 0L);
+	setreg(chip, ACON2, (12L<<27) |	// A1 bitclock == ACLK/384
+			(12L<<22) |	// A2 bitclock == ACLK/384
+			( 1L<<19));	// BCLK1 is input
+	setreg(chip, MC1, 0x7fff0000); // Disable audio i/f
+	setreg(chip, A_TIME_SLOT1, (1L<<TSL_EOS));
+	setreg(chip, A_TIME_SLOT2, (1L<<TSL_EOS));
+	*/
+	if (type == analog) {
+		saa7146_write(chip, GPIO_0, MASK_GPIO_HI);
+		/* wait until relais is switched and PLL is locked */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(MAX(1, SLEEP_PLL*HZ/1000));
+	} else {
+		saa7146_write(chip, GPIO_0, MASK_GPIO_LO);
+		/* wait until relais is switched and digital-in is synced. */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(MAX(1, SLEEP_DIGIN*HZ/1000));
+	}
+	/* From EMagic driver...
+	SetReg(MC1, 0x7fff0200, true); // Enable audio i/f
+	*/
+}
+
diff -uprN ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/aw8.h 
../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/aw8.h
--- ../alsa-driver-1.0.17/alsa-kernel/pci/saa7146/aw8.h	1970-01-01 01:00:00.000000000 +0100
+++ ../alsa-driver-1.0.17.mod/alsa-kernel/pci/saa7146/aw8.h	2008-10-22 23:34:05.000000000 +0200
@@ -0,0 +1,80 @@
+/*
+ *  Emagic Audiowerk specific functions
+ *  Copyright (c) 2006- by M. Nyffenegger <matthias.nyffenegger[AT]bluewin.ch>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+#ifndef AUDIOWERK_H_
+#define AUDIOWERK_H_
+
+#include <linux/types.h>
+#include "saa7146.h"
+#include "saa7146i2s.h"
+
+# define AW_MODULE_DESCRIPTION	"Emagic Audiowerk 8 Driver"
+# define AW_CARD_SHORT_NAME	"Audiowerk 8"
+# define AW_DRIVER_NAME	"SAA7146A Audiowerk 8"
+# define AW_PCM_RATE		SNDRV_PCM_RATE_CONTINUOUS
+# define AW_FS_MIN	25000 /* fs lower limit for DAC TDA1305 (ADC 18kHz) */
+# define AW_FS_MAX	48000 /* fs upper limit for DAC TDA1305 (ADC 50kHz) */
+# define AW_MAX_PLAYBACK_CHANNELS_PER_STREAM	4
+
+/**
+ * Audiwerk sampling formats.
+ */
+enum aw_formats {fmt_s16_2le, fmt_s16_2be, fmt_s18_4le, fmt_s18_4be,
+		fmt_s20_4le, fmt_s20_4be};
+
+/**
+ * TODO: description
+ */
+int aw_init(struct saa7146i2s *chipi2s, int input_type);
+
+/**
+ * TODO: description
+ */
+void aw_exit(struct saa7146i2s *chipi2s);
+
+/**
+ * Switches the Audiowerk input to analog.
+ * There are two sysclock generators, switched via a relais on GPIO-0:
+ * 	o TSA 6060 PLL for analog input
+ * 	o TDA 1315 digital input
+ * @param chip Used for hardware access over PCI bus.
+ */
+void aw_switch_input_adc(struct saa7146reg *chip);
+
+/**
+ * Switches the Audiowerk input to digital.
+ * There are two sysclock generators, switched via a relais on GPIO-0:
+ * 	o TSA 6060 PLL for analog input
+ * 	o TDA 1315 digital input
+ * @param chip Used for hardware access over PCI bus.
+ */
+void aw_switch_input_daio(struct saa7146reg *chip);
+
+/**
+ * Set sample rate on AW8.
+ * AW8 supports continuous fs shared by all substreams -> last call to
+ * aw8_set_samplerate() wins.
+ * @param chip Used for hardware access over PCI bus.
+ * @param fs sampling frequency (25-48kHz).
+ * @return 0 in case of success or -1 in case of failure.
+ */
+int aw8_set_samplerate(struct saa7146reg *chip, unsigned int fs);
+
+#endif /*AUDIOWERK_H_*/
