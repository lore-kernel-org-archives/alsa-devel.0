From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 22/37] ALSA: firewire-tascam: add PCM
	functionality
Date: Sat, 11 Jul 2015 23:12:33 +0900
Message-ID: <1436623968-10780-23-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EDD12605AE
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:06 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds PCM functionality to transmit/receive PCM samples.

When one of PCM substreams are running or external clock source is
selected, current sampling rate is used. Else, the sampling rate is
changed as an userspace application requests.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/Makefile     |   2 +-
 sound/firewire/tascam/tascam-pcm.c | 295 +++++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.c     |   4 +
 sound/firewire/tascam/tascam.h     |   2 +
 4 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/tascam/tascam-pcm.c

diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
index 3be9434..84391ac 100644
--- a/sound/firewire/tascam/Makefile
+++ b/sound/firewire/tascam/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-tascam-objs := tascam-proc.o amdtp-tascam.o tascam-stream.o \
-			    tascam.o
+			    tascam-pcm.o tascam.o
 obj-m += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/tascam-pcm.c b/sound/firewire/tascam/tascam-pcm.c
new file mode 100644
index 0000000..b1bdb9f
--- /dev/null
+++ b/sound/firewire/tascam/tascam-pcm.c
@@ -0,0 +1,295 @@
+/*
+ * tascam-pcm.c - a part of driver for TASCAM FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "tascam.h"
+
+static void set_buffer_params(struct snd_pcm_hardware *hw)
+{
+	hw->period_bytes_min = 4 * hw->channels_min;
+	hw->period_bytes_max = hw->period_bytes_min * 2048;
+	hw->buffer_bytes_max = hw->period_bytes_max * 2;
+
+	hw->periods_min = 2;
+	hw->periods_max = UINT_MAX;
+}
+
+static int pcm_init_hw_params(struct snd_tscm *tscm,
+			      struct snd_pcm_substream *substream)
+{
+	static const struct snd_pcm_hardware hardware = {
+		.info = SNDRV_PCM_INFO_BATCH |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_JOINT_DUPLEX |
+			SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_MMAP_VALID,
+		.rates = SNDRV_PCM_RATE_44100 |
+			 SNDRV_PCM_RATE_48000 |
+			 SNDRV_PCM_RATE_88200 |
+			 SNDRV_PCM_RATE_96000,
+		.rate_min = 44100,
+		.rate_max = 96000,
+		.channels_min = 10,
+		.channels_max = 18,
+	};
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int pcm_channels;
+	int err;
+
+	runtime->hw = hardware;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S32;
+		pcm_channels = tscm->spec->pcm_capture_analog_channels;
+		if (tscm->spec->has_adat)
+			pcm_channels += 8;
+		if (tscm->spec->has_spdif)
+			pcm_channels += 2;
+		runtime->hw.channels_min =
+					runtime->hw.channels_max = pcm_channels;
+	} else {
+		runtime->hw.formats =
+				SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_S32;
+		pcm_channels = tscm->spec->pcm_playback_analog_channels;
+		if (tscm->spec->has_adat)
+			pcm_channels += 8;
+		if (tscm->spec->has_spdif)
+			pcm_channels += 2;
+		runtime->hw.channels_min =
+					runtime->hw.channels_max = pcm_channels;
+	}
+
+	set_buffer_params(&runtime->hw);
+
+	/* Deliver 24bit data */
+	err = snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	if (err < 0)
+		goto end;
+
+	/* 16 packets are handled in one callback. This is for safe. */
+	err = snd_pcm_hw_constraint_minmax(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+					   5000, UINT_MAX);
+end:
+	return err;
+}
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_tscm *tscm = substream->private_data;
+	enum snd_tscm_clock clock;
+	unsigned int rate;
+	int err;
+
+	err = pcm_init_hw_params(tscm, substream);
+	if (err < 0)
+		return err;
+
+	err = snd_tscm_stream_get_clock(tscm, &clock);
+	if ((clock != SND_TSCM_CLOCK_INTERNAL) |
+	    amdtp_stream_pcm_running(&tscm->rx_stream) |
+	    amdtp_stream_pcm_running(&tscm->tx_stream)) {
+		err = snd_tscm_stream_get_rate(tscm, &rate);
+		if (err < 0)
+			return err;
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
+	}
+
+	snd_pcm_set_sync(substream);
+
+	return err;
+}
+
+static int pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int pcm_capture_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_tscm *tscm = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&tscm->mutex);
+		tscm->substreams_counter++;
+		mutex_unlock(&tscm->mutex);
+	}
+	amdtp_tscm_set_pcm_format(&tscm->tx_stream, params_format(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+static int pcm_playback_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_tscm *tscm = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&tscm->mutex);
+		tscm->substreams_counter++;
+		mutex_unlock(&tscm->mutex);
+	}
+	amdtp_tscm_set_pcm_format(&tscm->rx_stream, params_format(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+
+static int pcm_capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_tscm *tscm = substream->private_data;
+
+	mutex_lock(&tscm->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		tscm->substreams_counter--;
+
+	snd_tscm_stream_stop_duplex(tscm);
+
+	mutex_unlock(&tscm->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+static int pcm_playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_tscm *tscm = substream->private_data;
+
+	mutex_lock(&tscm->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		tscm->substreams_counter--;
+
+	snd_tscm_stream_stop_duplex(tscm);
+
+	mutex_unlock(&tscm->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int pcm_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_tscm *tscm = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	mutex_lock(&tscm->mutex);
+
+	err = snd_tscm_stream_start_duplex(tscm, runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&tscm->tx_stream);
+
+	mutex_unlock(&tscm->mutex);
+
+	return err;
+}
+static int pcm_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_tscm *tscm = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	mutex_lock(&tscm->mutex);
+
+	err = snd_tscm_stream_start_duplex(tscm, runtime->rate);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&tscm->rx_stream);
+
+	mutex_unlock(&tscm->mutex);
+
+	return err;
+}
+
+static int pcm_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_tscm *tscm = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&tscm->tx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&tscm->tx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+static int pcm_playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_tscm *tscm = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&tscm->rx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&tscm->rx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t pcm_capture_pointer(struct snd_pcm_substream *sbstrm)
+{
+	struct snd_tscm *tscm = sbstrm->private_data;
+
+	return amdtp_stream_pcm_pointer(&tscm->tx_stream);
+}
+static snd_pcm_uframes_t pcm_playback_pointer(struct snd_pcm_substream *sbstrm)
+{
+	struct snd_tscm *tscm = sbstrm->private_data;
+
+	return amdtp_stream_pcm_pointer(&tscm->rx_stream);
+}
+
+static struct snd_pcm_ops pcm_capture_ops = {
+	.open		= pcm_open,
+	.close		= pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= pcm_capture_hw_params,
+	.hw_free	= pcm_capture_hw_free,
+	.prepare	= pcm_capture_prepare,
+	.trigger	= pcm_capture_trigger,
+	.pointer	= pcm_capture_pointer,
+	.page		= snd_pcm_lib_get_vmalloc_page,
+};
+static struct snd_pcm_ops pcm_playback_ops = {
+	.open		= pcm_open,
+	.close		= pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= pcm_playback_hw_params,
+	.hw_free	= pcm_playback_hw_free,
+	.prepare	= pcm_playback_prepare,
+	.trigger	= pcm_playback_trigger,
+	.pointer	= pcm_playback_pointer,
+	.page		= snd_pcm_lib_get_vmalloc_page,
+	.mmap		= snd_pcm_lib_mmap_vmalloc,
+};
+
+int snd_tscm_create_pcm_devices(struct snd_tscm *tscm)
+{
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(tscm->card, tscm->card->driver, 0, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+
+	pcm->private_data = tscm;
+	snprintf(pcm->name, sizeof(pcm->name),
+		 "%s PCM", tscm->card->shortname);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_capture_ops);
+
+	return 0;
+}
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
index c56b0a4..ca3af62 100644
--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -131,6 +131,10 @@ static int snd_tscm_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	err = snd_tscm_create_pcm_devices(tscm);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
index 729c9c8..feaf7e1 100644
--- a/sound/firewire/tascam/tascam.h
+++ b/sound/firewire/tascam/tascam.h
@@ -95,3 +95,5 @@ int snd_tscm_stream_start_duplex(struct snd_tscm *tscm, unsigned int rate);
 void snd_tscm_stream_stop_duplex(struct snd_tscm *tscm);
 
 void snd_tscm_proc_init(struct snd_tscm *tscm);
+
+int snd_tscm_create_pcm_devices(struct snd_tscm *tscm);
-- 
2.1.4
