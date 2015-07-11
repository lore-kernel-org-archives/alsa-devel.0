From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 35/37] ALSA: firewire-motu: add PCM
	functionality
Date: Sat, 11 Jul 2015 23:12:46 +0900
Message-ID: <1436623968-10780-36-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F4062605D6
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:07 +0200 (CEST)
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

The number of data chunks for PCM samples should not be changed
during snd_pcm_open() to snd_pcm_hw_params(), for correct result
of matching PCM substream format.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile   |   2 +-
 sound/firewire/motu/motu-pcm.c | 385 +++++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.c     |   4 +
 sound/firewire/motu/motu.h     |   2 +
 4 files changed, 392 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/motu/motu-pcm.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index de6ca3b..c1c9888 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-motu-objs := amdtp-motu.o motu-stream.o motu-transaction.o \
-			  motu-proc.o motu.o
+			  motu-proc.o motu-pcm.o motu.o
 obj-m += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu-pcm.c b/sound/firewire/motu/motu-pcm.c
new file mode 100644
index 0000000..b6c201f
--- /dev/null
+++ b/sound/firewire/motu/motu-pcm.c
@@ -0,0 +1,385 @@
+/*
+ * motu-pcm.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "motu.h"
+
+static int motu_rate_constraint(struct snd_pcm_hw_params *params,
+				struct snd_pcm_hw_rule *rule)
+{
+	struct snd_pcm_substream *substream = rule->private;
+	struct snd_motu *motu = substream->private_data;
+
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval rates = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i, rate, mode, *pcm_channels;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		pcm_channels = motu->tx_pcm_channels;
+	else
+		pcm_channels = motu->rx_pcm_channels;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_rates); ++i) {
+		rate = snd_motu_rates[i];
+		mode = i / 2;
+
+		if (!snd_interval_test(c, pcm_channels[mode]))
+			continue;
+
+		rates.min = min(rates.min, rate);
+		rates.max = max(rates.max, rate);
+	}
+
+	return snd_interval_refine(r, &rates);
+}
+
+static int motu_channels_constraint(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_pcm_substream *substream = rule->private;
+	struct snd_motu *motu = substream->private_data;
+
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval channels = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i, rate, mode, *pcm_channels;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		pcm_channels = motu->tx_pcm_channels;
+	else
+		pcm_channels = motu->rx_pcm_channels;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_rates); ++i) {
+		rate = snd_motu_rates[i];
+		mode = i / 2;
+
+		if (!snd_interval_test(r, rate))
+			continue;
+
+		channels.min = min(channels.min, pcm_channels[mode]);
+		channels.max = max(channels.max, pcm_channels[mode]);
+	}
+
+	return snd_interval_refine(c, &channels);
+}
+
+static void limit_channels_and_rates(struct snd_motu *motu,
+				     struct snd_pcm_runtime *runtime,
+				     unsigned int *pcm_channels)
+{
+	struct snd_pcm_hardware *hw = &runtime->hw;
+	unsigned int i, rate, mode;
+
+	hw->channels_min = UINT_MAX;
+	hw->channels_max = 0;
+
+	for (i = 0; i < ARRAY_SIZE(snd_motu_rates); ++i) {
+		rate = snd_motu_rates[i];
+		mode = i / 2;
+		if (pcm_channels[mode] == 0)
+			continue;
+
+		hw->rates |= snd_pcm_rate_to_rate_bit(rate);
+		hw->channels_min = min(hw->channels_min, pcm_channels[mode]);
+		hw->channels_max = max(hw->channels_max, pcm_channels[mode]);
+	}
+
+	snd_pcm_limit_hw_rates(runtime);
+}
+
+static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
+{
+	hw->periods_min = 2;			/* SNDRV_PCM_INFO_BATCH */
+	hw->periods_max = UINT_MAX;
+
+	hw->period_bytes_min = 4 * hw->channels_max;    /* byte for a frame */
+
+	/* Just to prevent from allocating much pages. */
+	hw->period_bytes_max = hw->period_bytes_min * 2048;
+	hw->buffer_bytes_max = hw->period_bytes_max * hw->periods_min;
+}
+
+static int init_hw_info(struct snd_motu *motu,
+			struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_hardware *hw = &runtime->hw;
+	struct amdtp_stream *stream;
+	unsigned int *pcm_channels;
+	int err;
+
+	hw->info = SNDRV_PCM_INFO_MMAP |
+		   SNDRV_PCM_INFO_MMAP_VALID |
+		   SNDRV_PCM_INFO_BATCH |
+		   SNDRV_PCM_INFO_INTERLEAVED |
+		   SNDRV_PCM_INFO_JOINT_DUPLEX |
+		   SNDRV_PCM_INFO_BLOCK_TRANSFER;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		hw->formats = SNDRV_PCM_FMTBIT_S32;
+		stream = &motu->tx_stream;
+		pcm_channels = motu->tx_pcm_channels;
+	} else {
+		hw->formats = SNDRV_PCM_FMTBIT_S32 |
+			      SNDRV_PCM_FMTBIT_S16;
+		stream = &motu->rx_stream;
+		pcm_channels = motu->rx_pcm_channels;
+	}
+
+	limit_channels_and_rates(motu, runtime, pcm_channels);
+	limit_period_and_buffer(hw);
+
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  motu_rate_constraint, substream,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  motu_channels_constraint, substream,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		return err;
+
+	return amdtp_stream_add_pcm_hw_constraints(stream, runtime);
+}
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+	enum snd_motu_clock src;
+	unsigned int rate;
+	int err;
+
+	mutex_lock(&motu->mutex);
+
+	err = snd_motu_stream_update_current_channels(motu);
+	if (err < 0)
+		goto end;
+
+	err = init_hw_info(motu, substream);
+	if (err < 0)
+		goto end;
+
+	err = snd_motu_stream_get_clock(motu, &src);
+	if (err < 0)
+		goto end;
+
+	/*
+	 * When source of clock is not internal or any PCM streams are running,
+	 * available sampling rate is limited at current sampling rate.
+	 */
+	if (src != SND_MOTU_CLOCK_INTERNAL || src != SND_MOTU_CLOCK_INTERNAL ||
+	    amdtp_stream_pcm_running(&motu->tx_stream) ||
+	    amdtp_stream_pcm_running(&motu->rx_stream)) {
+		err = snd_motu_stream_get_rate(motu, &rate);
+		if (err < 0)
+			goto end;
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
+	}
+
+	snd_pcm_set_sync(substream);
+end:
+	mutex_unlock(&motu->mutex);
+
+	return err;
+}
+
+static int pcm_close(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int capture_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&motu->mutex);
+		motu->substreams_counter++;
+		mutex_unlock(&motu->mutex);
+	}
+
+	amdtp_motu_set_pcm_format(&motu->tx_stream, params_format(hw_params));
+
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+static int playback_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN) {
+		mutex_lock(&motu->mutex);
+		motu->substreams_counter++;
+		mutex_unlock(&motu->mutex);
+	}
+
+	amdtp_motu_set_pcm_format(&motu->rx_stream, params_format(hw_params));
+
+	return snd_pcm_lib_alloc_vmalloc_buffer(substream,
+						params_buffer_bytes(hw_params));
+}
+
+static int capture_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	mutex_lock(&motu->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		motu->substreams_counter--;
+
+	snd_motu_stream_stop_duplex(motu);
+
+	mutex_unlock(&motu->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	mutex_lock(&motu->mutex);
+
+	if (substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
+		motu->substreams_counter--;
+
+	snd_motu_stream_stop_duplex(motu);
+
+	mutex_unlock(&motu->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+	int err;
+
+	mutex_lock(&motu->mutex);
+	err = snd_motu_stream_start_duplex(motu, substream->runtime->rate);
+	mutex_unlock(&motu->mutex);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&motu->tx_stream);
+
+	return 0;
+}
+static int playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+	int err;
+
+	mutex_lock(&motu->mutex);
+	err = snd_motu_stream_start_duplex(motu, substream->runtime->rate);
+	mutex_unlock(&motu->mutex);
+	if (err >= 0)
+		amdtp_stream_pcm_prepare(&motu->rx_stream);
+
+	return err;
+}
+
+static int capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&motu->tx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&motu->tx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&motu->rx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&motu->rx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t capture_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	return amdtp_stream_pcm_pointer(&motu->tx_stream);
+}
+static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_motu *motu = substream->private_data;
+
+	return amdtp_stream_pcm_pointer(&motu->rx_stream);
+}
+
+int snd_motu_create_pcm_devices(struct snd_motu *motu)
+{
+	static struct snd_pcm_ops capture_ops = {
+		.open      = pcm_open,
+		.close     = pcm_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = capture_hw_params,
+		.hw_free   = capture_hw_free,
+		.prepare   = capture_prepare,
+		.trigger   = capture_trigger,
+		.pointer   = capture_pointer,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
+	static struct snd_pcm_ops playback_ops = {
+		.open      = pcm_open,
+		.close     = pcm_close,
+		.ioctl     = snd_pcm_lib_ioctl,
+		.hw_params = playback_hw_params,
+		.hw_free   = playback_hw_free,
+		.prepare   = playback_prepare,
+		.trigger   = playback_trigger,
+		.pointer   = playback_pointer,
+		.page      = snd_pcm_lib_get_vmalloc_page,
+		.mmap      = snd_pcm_lib_mmap_vmalloc,
+	};
+	struct snd_pcm *pcm;
+	int err;
+
+	err = snd_pcm_new(motu->card, "MOTU", 0, 1, 1, &pcm);
+	if (err < 0)
+		return err;
+	pcm->private_data = motu;
+	strcpy(pcm->name, motu->card->shortname);
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &capture_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+
+	return 0;
+}
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 5717854..5deb592 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -78,6 +78,10 @@ static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	snd_motu_proc_init(motu);
 
+	err = snd_motu_create_pcm_devices(motu);
+	if (err < 0)
+		goto error;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index 8486dd8..50c19a5 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -108,4 +108,6 @@ void snd_motu_transaction_unregister(struct snd_motu *motu);
 
 void snd_motu_proc_init(struct snd_motu *motu);
 
+int snd_motu_create_pcm_devices(struct snd_motu *motu);
+
 #endif
-- 
2.1.4
