From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/13] ALSA: dice: Split stream functionality
	into a file
Date: Mon, 29 Sep 2014 00:58:14 +0900
Message-ID: <1411919903-10981-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1411919903-10981-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 93274260594
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 17:58:49 +0200 (CEST)
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

This commit adds a file with some helper functions for streaming, and move some
codes into the file with some arrangements.

Well-known CMP is not used to start/stop streams for Dice chipset. It's
achieved by writing to specific address. We call this way as 'enable'.
When devices are 'enabled', streaming starts in registered isochronous channel.
Some helper functions are already implemented in previous commit.

Basically, the stream is compliant to IEC 61883-6, so-called as AMDTP. But Dice
has a specific quirk, so called-as 'Dual Wire'. This quirk is applied at
176.4/192.0kHz. In this mode, each packet includes double number of events than
number in the specification, and stream runs at a half of sampling rate.

There is another quirk at bus reset. Dice chipset handles drivers' request but
don't re-enable streaming. So stream should be stopped.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/Makefile      |   2 +-
 sound/firewire/dice/dice-stream.c | 206 ++++++++++++++++++++++++++
 sound/firewire/dice/dice.c        | 295 +++++++++-----------------------------
 sound/firewire/dice/dice.h        |  14 ++
 4 files changed, 288 insertions(+), 229 deletions(-)
 create mode 100644 sound/firewire/dice/dice-stream.c

diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 9f473cb..867864c 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,2 +1,2 @@
-snd-dice-objs := dice-transaction.o dice.o
+snd-dice-objs := dice-transaction.o dice-stream.o dice.o
 obj-m += snd-dice.o
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
new file mode 100644
index 0000000..ba8fe8d
--- /dev/null
+++ b/sound/firewire/dice/dice-stream.c
@@ -0,0 +1,206 @@
+/*
+ * dice_stream.c - a part of driver for DICE based devices
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) 2014 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "dice.h"
+
+const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
+	/* mode 0 */
+	[0] =  32000,
+	[1] =  44100,
+	[2] =  48000,
+	/* mode 1 */
+	[3] =  88200,
+	[4] =  96000,
+	/* mode 2 */
+	[5] = 176400,
+	[6] = 192000,
+};
+
+int snd_dice_stream_get_rate_mode(struct snd_dice *dice, unsigned int rate,
+				  unsigned int *mode)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); i++) {
+		if (!(dice->clock_caps & BIT(i)))
+			continue;
+		if (snd_dice_rates[i] == rate) {
+			*mode = (i - 1) / 2;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+int snd_dice_stream_start_packets(struct snd_dice *dice)
+{
+	int err;
+
+	if (amdtp_stream_running(&dice->rx_stream))
+		return 0;
+
+	err = amdtp_stream_start(&dice->rx_stream, dice->rx_resources.channel,
+				 fw_parent_device(dice->unit)->max_speed);
+	if (err < 0)
+		return err;
+
+	err = snd_dice_transaction_set_enable(dice);
+	if (err < 0) {
+		amdtp_stream_stop(&dice->rx_stream);
+		return err;
+	}
+
+	return 0;
+}
+
+int snd_dice_stream_start(struct snd_dice *dice)
+{
+	__be32 channel;
+	int err;
+
+	if (!dice->rx_resources.allocated) {
+		err = fw_iso_resources_allocate(&dice->rx_resources,
+				amdtp_stream_get_max_payload(&dice->rx_stream),
+				fw_parent_device(dice->unit)->max_speed);
+		if (err < 0)
+			goto error;
+
+		channel = cpu_to_be32(dice->rx_resources.channel);
+		err = snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
+						    &channel, 4);
+		if (err < 0)
+			goto err_resources;
+	}
+
+	err = snd_dice_stream_start_packets(dice);
+	if (err < 0)
+		goto err_rx_channel;
+
+	return 0;
+
+err_rx_channel:
+	channel = cpu_to_be32((u32)-1);
+	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
+err_resources:
+	fw_iso_resources_free(&dice->rx_resources);
+error:
+	return err;
+}
+
+void snd_dice_stream_stop_packets(struct snd_dice *dice)
+{
+	if (amdtp_stream_running(&dice->rx_stream)) {
+		snd_dice_transaction_clear_enable(dice);
+		amdtp_stream_stop(&dice->rx_stream);
+	}
+}
+
+void snd_dice_stream_stop(struct snd_dice *dice)
+{
+	__be32 channel;
+
+	snd_dice_stream_stop_packets(dice);
+
+	if (!dice->rx_resources.allocated)
+		return;
+
+	channel = cpu_to_be32((u32)-1);
+	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
+
+	fw_iso_resources_free(&dice->rx_resources);
+}
+
+int snd_dice_stream_init(struct snd_dice *dice)
+{
+	int err;
+
+	err = fw_iso_resources_init(&dice->rx_resources, dice->unit);
+	if (err < 0)
+		goto end;
+	dice->rx_resources.channels_mask = 0x00000000ffffffffuLL;
+
+	err = amdtp_stream_init(&dice->rx_stream, dice->unit, AMDTP_OUT_STREAM,
+				CIP_BLOCKING);
+	if (err < 0)
+		goto error;
+
+	err = snd_dice_transaction_set_clock_source(dice, CLOCK_SOURCE_ARX1);
+	if (err < 0)
+		goto error;
+end:
+	return err;
+error:
+	amdtp_stream_destroy(&dice->rx_stream);
+	fw_iso_resources_destroy(&dice->rx_resources);
+	return err;
+}
+
+void snd_dice_stream_destroy(struct snd_dice *dice)
+{
+	amdtp_stream_pcm_abort(&dice->rx_stream);
+	snd_dice_stream_stop(dice);
+	amdtp_stream_destroy(&dice->rx_stream);
+	fw_iso_resources_destroy(&dice->rx_resources);
+}
+
+void snd_dice_stream_update(struct snd_dice *dice)
+{
+	/*
+	 * On a bus reset, the DICE firmware disables streaming and then goes
+	 * off contemplating its own navel for hundreds of milliseconds before
+	 * it can react to any of our attempts to reenable streaming. This
+	 * means that we lose synchronization anyway, so we force our streams
+	 * to stop so that the application can restart them in an orderly
+	 * manner.
+	 */
+	amdtp_stream_pcm_abort(&dice->rx_stream);
+	snd_dice_stream_stop_packets(dice);
+	fw_iso_resources_update(&dice->rx_resources);
+}
+
+static void dice_lock_changed(struct snd_dice *dice)
+{
+	dice->dev_lock_changed = true;
+	wake_up(&dice->hwdep_wait);
+}
+
+int snd_dice_stream_lock_try(struct snd_dice *dice)
+{
+	int err;
+
+	spin_lock_irq(&dice->lock);
+
+	if (dice->dev_lock_count < 0) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (dice->dev_lock_count++ == 0)
+		dice_lock_changed(dice);
+	err = 0;
+
+out:
+	spin_unlock_irq(&dice->lock);
+
+	return err;
+}
+
+void snd_dice_stream_lock_release(struct snd_dice *dice)
+{
+	spin_lock_irq(&dice->lock);
+
+	if (WARN_ON(dice->dev_lock_count <= 0))
+		goto out;
+
+	if (--dice->dev_lock_count == 0)
+		dice_lock_changed(dice);
+
+out:
+	spin_unlock_irq(&dice->lock);
+}
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 890dcb4..cc88a12 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -11,127 +11,62 @@ MODULE_DESCRIPTION("DICE driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
-const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT] = {
-	/* mode 0 */
-	[0] =  32000,
-	[1] =  44100,
-	[2] =  48000,
-	/* mode 1 */
-	[3] =  88200,
-	[4] =  96000,
-	/* mode 2 */
-	[5] = 176400,
-	[6] = 192000,
-};
-
-static unsigned int rate_to_index(unsigned int rate)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i)
-		if (snd_dice_rates[i] == rate)
-			return i;
-
-	return 0;
-}
-
-static unsigned int rate_index_to_mode(unsigned int rate_index)
-{
-	return ((int)rate_index - 1) / 2;
-}
-
-static void dice_lock_changed(struct snd_dice *dice)
-{
-	dice->dev_lock_changed = true;
-	wake_up(&dice->hwdep_wait);
-}
-
-static int dice_try_lock(struct snd_dice *dice)
-{
-	int err;
-
-	spin_lock_irq(&dice->lock);
-
-	if (dice->dev_lock_count < 0) {
-		err = -EBUSY;
-		goto out;
-	}
-
-	if (dice->dev_lock_count++ == 0)
-		dice_lock_changed(dice);
-	err = 0;
-
-out:
-	spin_unlock_irq(&dice->lock);
-
-	return err;
-}
-
-static void dice_unlock(struct snd_dice *dice)
-{
-	spin_lock_irq(&dice->lock);
-
-	if (WARN_ON(dice->dev_lock_count <= 0))
-		goto out;
-
-	if (--dice->dev_lock_count == 0)
-		dice_lock_changed(dice);
-
-out:
-	spin_unlock_irq(&dice->lock);
-}
-
 static int dice_rate_constraint(struct snd_pcm_hw_params *params,
 				struct snd_pcm_hw_rule *rule)
 {
 	struct snd_dice *dice = rule->private;
-	const struct snd_interval *channels =
+
+	const struct snd_interval *c =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_interval *rate =
+	struct snd_interval *r =
 		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval allowed_rates = {
+	struct snd_interval rates = {
 		.min = UINT_MAX, .max = 0, .integer = 1
 	};
-	unsigned int i, mode;
+	unsigned int i, rate, mode, *pcm_channels = dice->rx_channels;
 
 	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
-		mode = rate_index_to_mode(i);
-		if ((dice->clock_caps & (1 << i)) &&
-		    snd_interval_test(channels, dice->rx_channels[mode])) {
-			allowed_rates.min = min(allowed_rates.min,
-						snd_dice_rates[i]);
-			allowed_rates.max = max(allowed_rates.max,
-						snd_dice_rates[i]);
-		}
+		rate = snd_dice_rates[i];
+		if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
+			continue;
+
+		if (!snd_interval_test(c, pcm_channels[mode]))
+			continue;
+
+		rates.min = min(rates.min, rate);
+		rates.max = max(rates.max, rate);
 	}
 
-	return snd_interval_refine(rate, &allowed_rates);
+	return snd_interval_refine(r, &rates);
 }
 
 static int dice_channels_constraint(struct snd_pcm_hw_params *params,
 				    struct snd_pcm_hw_rule *rule)
 {
 	struct snd_dice *dice = rule->private;
-	const struct snd_interval *rate =
+
+	const struct snd_interval *r =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels =
+	struct snd_interval *c =
 		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_interval allowed_channels = {
+	struct snd_interval channels = {
 		.min = UINT_MAX, .max = 0, .integer = 1
 	};
-	unsigned int i, mode;
+	unsigned int i, rate, mode, *pcm_channels = dice->rx_channels;
 
-	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i)
-		if ((dice->clock_caps & (1 << i)) &&
-		    snd_interval_test(rate, snd_dice_rates[i])) {
-			mode = rate_index_to_mode(i);
-			allowed_channels.min = min(allowed_channels.min,
-						   dice->rx_channels[mode]);
-			allowed_channels.max = max(allowed_channels.max,
-						   dice->rx_channels[mode]);
-		}
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
 
-	return snd_interval_refine(channels, &allowed_channels);
+	return snd_interval_refine(c, &channels);
 }
 
 static int dice_open(struct snd_pcm_substream *substream)
@@ -156,7 +91,7 @@ static int dice_open(struct snd_pcm_substream *substream)
 	unsigned int i;
 	int err;
 
-	err = dice_try_lock(dice);
+	err = snd_dice_stream_lock_try(dice);
 	if (err < 0)
 		goto error;
 
@@ -194,7 +129,7 @@ static int dice_open(struct snd_pcm_substream *substream)
 	return 0;
 
 err_lock:
-	dice_unlock(dice);
+	snd_dice_stream_lock_release(dice);
 error:
 	return err;
 }
@@ -203,98 +138,20 @@ static int dice_close(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
 
-	dice_unlock(dice);
-
-	return 0;
-}
-
-static int dice_stream_start_packets(struct snd_dice *dice)
-{
-	int err;
-
-	if (amdtp_stream_running(&dice->rx_stream))
-		return 0;
-
-	err = amdtp_stream_start(&dice->rx_stream, dice->rx_resources.channel,
-				 fw_parent_device(dice->unit)->max_speed);
-	if (err < 0)
-		return err;
-
-	err = snd_dice_transaction_set_enable(dice);
-	if (err < 0) {
-		amdtp_stream_stop(&dice->rx_stream);
-		return err;
-	}
-
-	return 0;
-}
-
-static int dice_stream_start(struct snd_dice *dice)
-{
-	__be32 channel;
-	int err;
-
-	if (!dice->rx_resources.allocated) {
-		err = fw_iso_resources_allocate(&dice->rx_resources,
-				amdtp_stream_get_max_payload(&dice->rx_stream),
-				fw_parent_device(dice->unit)->max_speed);
-		if (err < 0)
-			goto error;
-
-		channel = cpu_to_be32(dice->rx_resources.channel);
-		err = snd_dice_transaction_write_tx(dice, TX_ISOCHRONOUS,
-						    &channel, 4);
-		if (err < 0)
-			goto err_resources;
-	}
-
-	err = dice_stream_start_packets(dice);
-	if (err < 0)
-		goto err_rx_channel;
+	snd_dice_stream_lock_release(dice);
 
 	return 0;
-
-err_rx_channel:
-	channel = cpu_to_be32((u32)-1);
-	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
-err_resources:
-	fw_iso_resources_free(&dice->rx_resources);
-error:
-	return err;
-}
-
-static void dice_stream_stop_packets(struct snd_dice *dice)
-{
-	if (amdtp_stream_running(&dice->rx_stream)) {
-		snd_dice_transaction_clear_enable(dice);
-		amdtp_stream_stop(&dice->rx_stream);
-	}
-}
-
-static void dice_stream_stop(struct snd_dice *dice)
-{
-	__be32 channel;
-
-	dice_stream_stop_packets(dice);
-
-	if (!dice->rx_resources.allocated)
-		return;
-
-	channel = cpu_to_be32((u32)-1);
-	snd_dice_transaction_write_rx(dice, RX_ISOCHRONOUS, &channel, 4);
-
-	fw_iso_resources_free(&dice->rx_resources);
 }
 
 static int dice_hw_params(struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_dice *dice = substream->private_data;
-	unsigned int rate_index, mode, rate, channels, i;
+	unsigned int mode, rate, channels, i;
 	int err;
 
 	mutex_lock(&dice->mutex);
-	dice_stream_stop(dice);
+	snd_dice_stream_stop(dice);
 	mutex_unlock(&dice->mutex);
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -307,6 +164,10 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		return err;
 
+	err = snd_dice_stream_get_rate_mode(dice, rate, &mode);
+	if (err < 0)
+		return err;
+
 	/*
 	 * At 176.4/192.0 kHz, Dice has a quirk to transfer two PCM frames in
 	 * one data block of AMDTP packet. Thus sampling transfer frequency is
@@ -318,8 +179,7 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 	 * be aligned to SYT_INTERVAL.
 	 */
 	channels = params_channels(hw_params);
-	rate_index = rate_to_index(rate);
-	if (rate_index > 4) {
+	if (mode > 1) {
 		if (channels > AMDTP_MAX_CHANNELS_FOR_PCM / 2) {
 			err = -ENOSYS;
 			return err;
@@ -332,10 +192,9 @@ static int dice_hw_params(struct snd_pcm_substream *substream,
 		dice->rx_stream.double_pcm_frames = false;
 	}
 
-	mode = rate_index_to_mode(rate_index);
 	amdtp_stream_set_parameters(&dice->rx_stream, rate, channels,
 				    dice->rx_midi_ports[mode]);
-	if (rate_index > 4) {
+	if (mode > 4) {
 		channels /= 2;
 
 		for (i = 0; i < channels; i++) {
@@ -355,7 +214,7 @@ static int dice_hw_free(struct snd_pcm_substream *substream)
 	struct snd_dice *dice = substream->private_data;
 
 	mutex_lock(&dice->mutex);
-	dice_stream_stop(dice);
+	snd_dice_stream_stop(dice);
 	mutex_unlock(&dice->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
@@ -369,9 +228,9 @@ static int dice_prepare(struct snd_pcm_substream *substream)
 	mutex_lock(&dice->mutex);
 
 	if (amdtp_streaming_error(&dice->rx_stream))
-		dice_stream_stop_packets(dice);
+		snd_dice_stream_stop_packets(dice);
 
-	err = dice_stream_start(dice);
+	err = snd_dice_stream_start(dice);
 	if (err < 0) {
 		mutex_unlock(&dice->mutex);
 		return err;
@@ -966,31 +825,37 @@ end:
 	return err;
 }
 
-static int highest_supported_mode_rate(struct snd_dice *dice, unsigned int mode)
+static int highest_supported_mode_rate(struct snd_dice *dice,
+				       unsigned int mode, unsigned int *rate)
 {
-	int i;
+	unsigned int i, m;
 
-	for (i = ARRAY_SIZE(snd_dice_rates) - 1; i >= 0; --i)
-		if ((dice->clock_caps & (1 << i)) &&
-		    rate_index_to_mode(i) == mode)
-			return i;
+	for (i = ARRAY_SIZE(snd_dice_rates); i > 0; i--) {
+		*rate = snd_dice_rates[i - 1];
+		if (snd_dice_stream_get_rate_mode(dice, *rate, &m) < 0)
+			continue;
+		if (mode == m)
+			break;
+	}
+	if (i == 0)
+		return -EINVAL;
 
-	return -1;
+	return 0;
 }
 
 static int dice_read_mode_params(struct snd_dice *dice, unsigned int mode)
 {
 	__be32 values[2];
-	int rate_index, err;
+	unsigned int rate;
+	int err;
 
-	rate_index = highest_supported_mode_rate(dice, mode);
-	if (rate_index < 0) {
+	if (highest_supported_mode_rate(dice, mode, &rate) < 0) {
 		dice->rx_channels[mode] = 0;
 		dice->rx_midi_ports[mode] = 0;
 		return 0;
 	}
 
-	err = snd_dice_transaction_set_rate(dice, snd_dice_rates[rate_index]);
+	err = snd_dice_transaction_set_rate(dice, rate);
 	if (err < 0)
 		return err;
 
@@ -1113,10 +978,6 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	dice_card_strings(dice);
 
-	err = snd_dice_transaction_set_clock_source(dice, CLOCK_SOURCE_ARX1);
-	if (err < 0)
-		goto error;
-
 	err = dice_create_pcm(dice);
 	if (err < 0)
 		goto error;
@@ -1127,22 +988,13 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	dice_create_proc(dice);
 
-	err = fw_iso_resources_init(&dice->rx_resources, unit);
+	err = snd_dice_stream_init(dice);
 	if (err < 0)
 		goto error;
-	dice->rx_resources.channels_mask = 0x00000000ffffffffuLL;
-
-	err = amdtp_stream_init(&dice->rx_stream, unit, AMDTP_OUT_STREAM,
-				CIP_BLOCKING);
-	if (err < 0) {
-		fw_iso_resources_destroy(&dice->rx_resources);
-		goto error;
-	}
 
 	err = snd_card_register(card);
 	if (err < 0) {
-		amdtp_stream_destroy(&dice->rx_stream);
-		fw_iso_resources_destroy(&dice->rx_resources);
+		snd_dice_stream_destroy(dice);
 		goto error;
 	}
 
@@ -1158,13 +1010,11 @@ static void dice_remove(struct fw_unit *unit)
 {
 	struct snd_dice *dice = dev_get_drvdata(&unit->device);
 
-	amdtp_stream_pcm_abort(&dice->rx_stream);
-
 	snd_card_disconnect(dice->card);
 
 	mutex_lock(&dice->mutex);
 
-	dice_stream_stop(dice);
+	snd_dice_stream_destroy(dice);
 
 	mutex_unlock(&dice->mutex);
 
@@ -1183,20 +1033,9 @@ static void dice_bus_reset(struct fw_unit *unit)
 	}
 	dice->global_enabled = false;
 
-	/*
-	 * On a bus reset, the DICE firmware disables streaming and then goes
-	 * off contemplating its own navel for hundreds of milliseconds before
-	 * it can react to any of our attempts to reenable streaming.  This
-	 * means that we lose synchronization anyway, so we force our streams
-	 * to stop so that the application can restart them in an orderly
-	 * manner.
-	 */
-	amdtp_stream_pcm_abort(&dice->rx_stream);
-
 	mutex_lock(&dice->mutex);
 
-	dice_stream_stop_packets(dice);
-	fw_iso_resources_update(&dice->rx_resources);
+	snd_dice_stream_stop_packets(dice);
 
 	mutex_unlock(&dice->mutex);
 }
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index c756e62..ca4090d 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -157,4 +157,18 @@ void snd_dice_transaction_destroy(struct snd_dice *dice);
 #define SND_DICE_RATES_COUNT	7
 extern const unsigned int snd_dice_rates[SND_DICE_RATES_COUNT];
 
+int snd_dice_stream_get_rate_mode(struct snd_dice *dice,
+				  unsigned int rate, unsigned int *mode);
+
+int snd_dice_stream_start_packets(struct snd_dice *dice);
+int snd_dice_stream_start(struct snd_dice *dice);
+void snd_dice_stream_stop_packets(struct snd_dice *dice);
+void snd_dice_stream_stop(struct snd_dice *dice);
+int snd_dice_stream_init(struct snd_dice *dice);
+void snd_dice_stream_destroy(struct snd_dice *dice);
+void snd_dice_stream_update(struct snd_dice *dice);
+
+int snd_dice_stream_lock_try(struct snd_dice *dice);
+void snd_dice_stream_lock_release(struct snd_dice *dice);
+
 #endif
-- 
1.9.1
