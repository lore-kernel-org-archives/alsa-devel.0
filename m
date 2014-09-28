From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/13] ALSA: dice: Split PCM functionality into
	a file
Date: Mon, 29 Sep 2014 00:58:15 +0900
Message-ID: <1411919903-10981-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2026F260596
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 17:58:50 +0200 (CEST)
In-Reply-To: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds a file and move some codes related to PCM functionality.

Currently PCM playback is supported. PCM capture will be supported in followed
commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/Makefile   |   2 +-
 sound/firewire/dice/dice-pcm.c | 294 +++++++++++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice.c     | 288 +---------------------------------------
 sound/firewire/dice/dice.h     |   2 +
 4 files changed, 298 insertions(+), 288 deletions(-)
 create mode 100644 sound/firewire/dice/dice-pcm.c

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 867864c..1ddaeca 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,2 +1,2 @@
-snd-dice-objs := dice-transaction.o dice-stream.o dice.o
+snd-dice-objs := dice-transaction.o dice-stream.o dice-pcm.o dice.o
 obj-m += snd-dice.o
diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
new file mode 100644
index 0000000..beff320
--- /dev/null
+++ b/sound/firewire/dice/dice-pcm.c
@@ -0,0 +1,294 @@
+/*
+ * dice_pcm.c - a part of driver for DICE based devices
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) 2014 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "dice.h"
+
+static int dice_rate_constraint(struct snd_pcm_hw_params *params,
+				struct snd_pcm_hw_rule *rule)
+{
+	struct snd_dice *dice = rule->private;
+
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval rates = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i, rate, mode, *pcm_channels = dice->rx_channels;
+
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
+		rate = snd_dice_rates[i];
+		if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
+			continue;
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
+static int dice_channels_constraint(struct snd_pcm_hw_params *params,
+				    struct snd_pcm_hw_rule *rule)
+{
+	struct snd_dice *dice = rule->private;
+
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval channels = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int i, rate, mode, *pcm_channels = dice->rx_channels;
+
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
+		rate = snd_dice_rates[i];
+		if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
+			continue;
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
+
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	static const struct snd_pcm_hardware hardware = {
+		.info = SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_BATCH |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_BLOCK_TRANSFER,
+		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
+		.channels_min = UINT_MAX,
+		.channels_max = 0,
+		.buffer_bytes_max = 16 * 1024 * 1024,
+		.period_bytes_min = 1,
+		.period_bytes_max = UINT_MAX,
+		.periods_min = 1,
+		.periods_max = UINT_MAX,
+	};
+	struct snd_dice *dice = substream->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int i;
+	int err;
+
+	err = snd_dice_stream_lock_try(dice);
+	if (err < 0)
+		goto error;
+
+	runtime->hw = hardware;
+
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i)
+		if (dice->clock_caps & (1 << i))
+			runtime->hw.rates |=
+				snd_pcm_rate_to_rate_bit(snd_dice_rates[i]);
+	snd_pcm_limit_hw_rates(runtime);
+
+	for (i = 0; i < 3; ++i)
+		if (dice->rx_channels[i]) {
+			runtime->hw.channels_min = min(runtime->hw.channels_min,
+						       dice->rx_channels[i]);
+			runtime->hw.channels_max = max(runtime->hw.channels_max,
+						       dice->rx_channels[i]);
+		}
+
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  dice_rate_constraint, dice,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		goto err_lock;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  dice_channels_constraint, dice,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		goto err_lock;
+
+	err = amdtp_stream_add_pcm_hw_constraints(&dice->rx_stream, runtime);
+	if (err < 0)
+		goto err_lock;
+
+	return 0;
+
+err_lock:
+	snd_dice_stream_lock_release(dice);
+error:
+	return err;
+}
+
+static int pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+
+	snd_dice_stream_lock_release(dice);
+
+	return 0;
+}
+
+static int playback_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_dice *dice = substream->private_data;
+	unsigned int mode, rate, channels, i;
+	int err;
+
+	mutex_lock(&dice->mutex);
+	snd_dice_stream_stop(dice);
+	mutex_unlock(&dice->mutex);
+
+	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
+					       params_buffer_bytes(hw_params));
+	if (err < 0)
+		return err;
+
+	rate = params_rate(hw_params);
+	err = snd_dice_transaction_set_rate(dice, rate);
+	if (err < 0)
+		return err;
+
+	if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
+		return err;
+
+	/*
+	 * At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
+	 * one data block of AMDTP packet. Thus sampling transfer frequency is
+	 * a half of PCM sampling frequency, i.e. PCM frames at 192.0 kHz are
+	 * transferred on AMDTP packets at 96 kHz. Two successive samples of a
+	 * channel are stored consecutively in the packet. This quirk is called
+	 * as 'Dual Wire'.
+	 * For this quirk, blocking mode is required and PCM buffer size should
+	 * be aligned to SYT_INTERVAL.
+	 */
+	channels = params_channels(hw_params);
+	if (mode > 1) {
+		if (channels > AMDTP_MAX_CHANNELS_FOR_PCM / 2) {
+			err = -ENOSYS;
+			return err;
+		}
+
+		rate /= 2;
+		channels *= 2;
+		dice->rx_stream.double_pcm_frames = true;
+	} else {
+		dice->rx_stream.double_pcm_frames = false;
+	}
+
+	amdtp_stream_set_parameters(&dice->rx_stream, rate, channels,
+				    dice->rx_midi_ports[mode]);
+	if (mode > 1) {
+		channels /= 2;
+
+		for (i = 0; i < channels; i++) {
+			dice->rx_stream.pcm_positions[i] = i * 2;
+			dice->rx_stream.pcm_positions[i + channels] = i * 2 + 1;
+		}
+	}
+
+	amdtp_stream_set_pcm_format(&dice->rx_stream,
+				    params_format(hw_params));
+
+	return 0;
+}
+
+static int playback_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+
+	mutex_lock(&dice->mutex);
+	snd_dice_stream_stop(dice);
+	mutex_unlock(&dice->mutex);
+
+	return snd_pcm_lib_free_vmalloc_buffer(substream);
+}
+
+static int playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+	int err;
+
+	mutex_lock(&dice->mutex);
+
+	if (amdtp_streaming_error(&dice->rx_stream))
+		snd_dice_stream_stop_packets(dice);
+
+	err = snd_dice_stream_start(dice);
+	if (err < 0) {
+		mutex_unlock(&dice->mutex);
+		return err;
+	}
+
+	mutex_unlock(&dice->mutex);
+
+	amdtp_stream_pcm_prepare(&dice->rx_stream);
+
+	return 0;
+}
+
+static int playback_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_dice *dice = substream->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		amdtp_stream_pcm_trigger(&dice->rx_stream, substream);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		amdtp_stream_pcm_trigger(&dice->rx_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t playback_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+
+	return amdtp_stream_pcm_pointer(&dice->rx_stream);
+}
+
+int snd_dice_create_pcm(struct snd_dice *dice)
+{
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
+	err = snd_pcm_new(dice->card, "DICE", 0, 1, 0, &pcm);
+	if (err < 0)
+		return err;
+	pcm->private_data = dice;
+	strcpy(pcm->name, dice->card->shortname);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &playback_ops);
+
+	return 0;
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index cc88a12..bce4652 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -11,292 +11,6 @@ MODULE_DESCRIPTION("DICE driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
-static int dice_rate_constraint(struct snd_pcm_hw_params *params,
-				struct snd_pcm_hw_rule *rule)
-{
-	struct snd_dice *dice = rule->private;
-
-	const struct snd_interval *c =
-		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_interval *r =
-		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval rates = {
-		.min = UINT_MAX, .max = 0, .integer = 1
-	};
-	unsigned int i, rate, mode, *pcm_channels = dice->rx_channels;
-
-	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
-		rate = snd_dice_rates[i];
-		if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
-			continue;
-
-		if (!snd_interval_test(c, pcm_channels[mode]))
-			continue;
-
-		rates.min = min(rates.min, rate);
-		rates.max = max(rates.max, rate);
-	}
-
-	return snd_interval_refine(r, &rates);
-}
-
-static int dice_channels_constraint(struct snd_pcm_hw_params *params,
-				    struct snd_pcm_hw_rule *rule)
-{
-	struct snd_dice *dice = rule->private;
-
-	const struct snd_interval *r =
-		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *c =
-		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_interval channels = {
-		.min = UINT_MAX, .max = 0, .integer = 1
-	};
-	unsigned int i, rate, mode, *pcm_channels = dice->rx_channels;
-
-	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
-		rate = snd_dice_rates[i];
-		if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
-			continue;
-
-		if (!snd_interval_test(r, rate))
-			continue;
-
-		channels.min = min(channels.min, pcm_channels[mode]);
-		channels.max = max(channels.max, pcm_channels[mode]);
-	}
-
-	return snd_interval_refine(c, &channels);
-}
-
-static int dice_open(struct snd_pcm_substream *substream)
-{
-	static const struct snd_pcm_hardware hardware = {
-		.info = SNDRV_PCM_INFO_MMAP |
-			SNDRV_PCM_INFO_MMAP_VALID |
-			SNDRV_PCM_INFO_BATCH |
-			SNDRV_PCM_INFO_INTERLEAVED |
-			SNDRV_PCM_INFO_BLOCK_TRANSFER,
-		.formats = AMDTP_OUT_PCM_FORMAT_BITS,
-		.channels_min = UINT_MAX,
-		.channels_max = 0,
-		.buffer_bytes_max = 16 * 1024 * 1024,
-		.period_bytes_min = 1,
-		.period_bytes_max = UINT_MAX,
-		.periods_min = 1,
-		.periods_max = UINT_MAX,
-	};
-	struct snd_dice *dice = substream->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	unsigned int i;
-	int err;
-
-	err = snd_dice_stream_lock_try(dice);
-	if (err < 0)
-		goto error;
-
-	runtime->hw = hardware;
-
-	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i)
-		if (dice->clock_caps & (1 << i))
-			runtime->hw.rates |=
-				snd_pcm_rate_to_rate_bit(snd_dice_rates[i]);
-	snd_pcm_limit_hw_rates(runtime);
-
-	for (i = 0; i < 3; ++i)
-		if (dice->rx_channels[i]) {
-			runtime->hw.channels_min = min(runtime->hw.channels_min,
-						       dice->rx_channels[i]);
-			runtime->hw.channels_max = max(runtime->hw.channels_max,
-						       dice->rx_channels[i]);
-		}
-
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				  dice_rate_constraint, dice,
-				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
-	if (err < 0)
-		goto err_lock;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				  dice_channels_constraint, dice,
-				  SNDRV_PCM_HW_PARAM_RATE, -1);
-	if (err < 0)
-		goto err_lock;
-
-	err = amdtp_stream_add_pcm_hw_constraints(&dice->rx_stream, runtime);
-	if (err < 0)
-		goto err_lock;
-
-	return 0;
-
-err_lock:
-	snd_dice_stream_lock_release(dice);
-error:
-	return err;
-}
-
-static int dice_close(struct snd_pcm_substream *substream)
-{
-	struct snd_dice *dice = substream->private_data;
-
-	snd_dice_stream_lock_release(dice);
-
-	return 0;
-}
-
-static int dice_hw_params(struct snd_pcm_substream *substream,
-			  struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_dice *dice = substream->private_data;
-	unsigned int mode, rate, channels, i;
-	int err;
-
-	mutex_lock(&dice->mutex);
-	snd_dice_stream_stop(dice);
-	mutex_unlock(&dice->mutex);
-
-	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
-					       params_buffer_bytes(hw_params));
-	if (err < 0)
-		return err;
-
-	rate = params_rate(hw_params);
-	err = snd_dice_transaction_set_rate(dice, rate);
-	if (err < 0)
-		return err;
-
-	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
-	if (err < 0)
-		return err;
-
-	/*
-	 * At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
-	 * one data block of AMDTP packet. Thus sampling transfer frequency is
-	 * a half of PCM sampling frequency, i.e. PCM frames at 192.0 kHz are
-	 * transferred on AMDTP packets at 96 kHz. Two successive samples of a
-	 * channel are stored consecutively in the packet. This quirk is called
-	 * as 'Dual Wire'.
-	 * For this quirk, blocking mode is required and PCM buffer size should
-	 * be aligned to SYT_INTERVAL.
-	 */
-	channels = params_channels(hw_params);
-	if (mode > 1) {
-		if (channels > AMDTP_MAX_CHANNELS_FOR_PCM / 2) {
-			err = -ENOSYS;
-			return err;
-		}
-
-		rate /= 2;
-		channels *= 2;
-		dice->rx_stream.double_pcm_frames = true;
-	} else {
-		dice->rx_stream.double_pcm_frames = false;
-	}
-
-	amdtp_stream_set_parameters(&dice->rx_stream, rate, channels,
-				    dice->rx_midi_ports[mode]);
-	if (mode > 4) {
-		channels /= 2;
-
-		for (i = 0; i < channels; i++) {
-			dice->rx_stream.pcm_positions[i] = i * 2;
-			dice->rx_stream.pcm_positions[i + channels] = i * 2 + 1;
-		}
-	}
-
-	amdtp_stream_set_pcm_format(&dice->rx_stream,
-				    params_format(hw_params));
-
-	return 0;
-}
-
-static int dice_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_dice *dice = substream->private_data;
-
-	mutex_lock(&dice->mutex);
-	snd_dice_stream_stop(dice);
-	mutex_unlock(&dice->mutex);
-
-	return snd_pcm_lib_free_vmalloc_buffer(substream);
-}
-
-static int dice_prepare(struct snd_pcm_substream *substream)
-{
-	struct snd_dice *dice = substream->private_data;
-	int err;
-
-	mutex_lock(&dice->mutex);
-
-	if (amdtp_streaming_error(&dice->rx_stream))
-		snd_dice_stream_stop_packets(dice);
-
-	err = snd_dice_stream_start(dice);
-	if (err < 0) {
-		mutex_unlock(&dice->mutex);
-		return err;
-	}
-
-	mutex_unlock(&dice->mutex);
-
-	amdtp_stream_pcm_prepare(&dice->rx_stream);
-
-	return 0;
-}
-
-static int dice_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_dice *dice = substream->private_data;
-	struct snd_pcm_substream *pcm;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		pcm = substream;
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		pcm = NULL;
-		break;
-	default:
-		return -EINVAL;
-	}
-	amdtp_stream_pcm_trigger(&dice->rx_stream, pcm);
-
-	return 0;
-}
-
-static snd_pcm_uframes_t dice_pointer(struct snd_pcm_substream *substream)
-{
-	struct snd_dice *dice = substream->private_data;
-
-	return amdtp_stream_pcm_pointer(&dice->rx_stream);
-}
-
-static int dice_create_pcm(struct snd_dice *dice)
-{
-	static struct snd_pcm_ops ops = {
-		.open      = dice_open,
-		.close     = dice_close,
-		.ioctl     = snd_pcm_lib_ioctl,
-		.hw_params = dice_hw_params,
-		.hw_free   = dice_hw_free,
-		.prepare   = dice_prepare,
-		.trigger   = dice_trigger,
-		.pointer   = dice_pointer,
-		.page      = snd_pcm_lib_get_vmalloc_page,
-		.mmap      = snd_pcm_lib_mmap_vmalloc,
-	};
-	struct snd_pcm *pcm;
-	int err;
-
-	err = snd_pcm_new(dice->card, "DICE", 0, 1, 0, &pcm);
-	if (err < 0)
-		return err;
-	pcm->private_data = dice;
-	strcpy(pcm->name, dice->card->shortname);
-	pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->ops = &ops;
-
-	return 0;
-}
-
 static long dice_hwdep_read(struct snd_hwdep *hwdep, char __user *buf,
 			    long count, loff_t *offset)
 {
@@ -978,7 +692,7 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	dice_card_strings(dice);
 
-	err = dice_create_pcm(dice);
+	err = snd_dice_create_pcm(dice);
 	if (err < 0)
 		goto error;
 
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index ca4090d..4d9e55b 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -171,4 +171,6 @@ void snd_dice_stream_update(struct snd_dice *dice);
 int snd_dice_stream_lock_try(struct snd_dice *dice);
 void snd_dice_stream_lock_release(struct snd_dice *dice);
 
+int snd_dice_create_pcm(struct snd_dice *dice);
+
 #endif
-- 
1.9.1
