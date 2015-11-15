From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/8] ALSA: dice: limit to current sampling
	transfer frequency
Date: Sun, 15 Nov 2015 18:25:29 +0900
Message-ID: <1447579536-4459-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 796C426062C
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:25:41 +0100 (CET)
In-Reply-To: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

ALSA PCM core has a functionality for rule of parameters for PCM substream.
Typically, when userspace opens PCM character device, each driver adds its
own rule to PCM substream, according to design of devices. When the
userspace executes hw_params ioctl with favorable attributes, the actual
attributes are calculated with the given attributes and rules.

Currently, ALSA Dice driver has the rule between channels and rates, while
Dice hardware design doesn't allow drivers to retrieve all of combinations
of them in advance. Dice devices allows drivers to get current sampling
transfer frequency, the number of multi bit linear audio data channels and
MIDI conformant data channels in an data block of an AMDTP packet.

This commit purges the rule and limit PCM substreams to current sampling
transfer frequency, following to the hardware design.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c | 172 ++++++++---------------------------------
 1 file changed, 33 insertions(+), 139 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 9b34319..eaaabf0 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -9,99 +9,42 @@
 
 #include "dice.h"
 
-static int dice_rate_constraint(struct snd_pcm_hw_params *params,
-				struct snd_pcm_hw_rule *rule)
-{
-	struct snd_pcm_substream *substream = rule->private;
-	struct snd_dice *dice = substream->private_data;
-
-	const struct snd_interval *c =
-		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_interval *r =
-		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval rates = {
-		.min = UINT_MAX, .max = 0, .integer = 1
-	};
-	unsigned int i, rate, mode, *pcm_channels;
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		pcm_channels = dice->tx_channels;
-	else
-		pcm_channels = dice->rx_channels;
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
-	struct snd_pcm_substream *substream = rule->private;
-	struct snd_dice *dice = substream->private_data;
-
-	const struct snd_interval *r =
-		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *c =
-		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_interval channels = {
-		.min = UINT_MAX, .max = 0, .integer = 1
-	};
-	unsigned int i, rate, mode, *pcm_channels;
-
-	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
-		pcm_channels = dice->tx_channels;
-	else
-		pcm_channels = dice->rx_channels;
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
-static void limit_channels_and_rates(struct snd_dice *dice,
-				     struct snd_pcm_runtime *runtime,
-				     unsigned int *pcm_channels)
+static int limit_channels_and_rates(struct snd_dice *dice,
+				    struct snd_pcm_runtime *runtime,
+				    struct amdtp_stream *stream)
 {
 	struct snd_pcm_hardware *hw = &runtime->hw;
-	unsigned int i, rate, mode;
+	unsigned int rate;
+	__be32 reg[2];
+	int err;
 
-	hw->channels_min = UINT_MAX;
-	hw->channels_max = 0;
+	/*
+	 * Retrieve current Multi Bit Linear Audio data channel and limit to
+	 * it.
+	 */
+	if (stream == &dice->tx_stream) {
+		err = snd_dice_transaction_read_tx(dice, TX_NUMBER_AUDIO,
+						   reg, sizeof(reg));
+	} else {
+		err = snd_dice_transaction_read_rx(dice, RX_NUMBER_AUDIO,
+						   reg, sizeof(reg));
+	}
+	if (err < 0)
+		return err;
 
-	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
-		rate = snd_dice_rates[i];
-		if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
-			continue;
-		hw->rates |= snd_pcm_rate_to_rate_bit(rate);
+	hw->channels_min = hw->channels_max = be32_to_cpu(reg[0]);
 
-		if (pcm_channels[mode] == 0)
-			continue;
-		hw->channels_min = min(hw->channels_min, pcm_channels[mode]);
-		hw->channels_max = max(hw->channels_max, pcm_channels[mode]);
-	}
+	/* Retrieve current sampling transfer frequency and limit to it. */
+	err = snd_dice_transaction_get_rate(dice, &rate);
+	if (err < 0)
+		return err;
 
+	hw->rates = snd_pcm_rate_to_rate_bit(rate);
+	hw->rate_min = rate;
+	hw->rate_max = rate;
 	snd_pcm_limit_hw_rates(runtime);
+
+	return 0;
 }
 
 static void limit_period_and_buffer(struct snd_pcm_hardware *hw)
@@ -122,7 +65,6 @@ static int init_hw_info(struct snd_dice *dice,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
 	struct amdtp_stream *stream;
-	unsigned int *pcm_channels;
 	int err;
 
 	hw->info = SNDRV_PCM_INFO_MMAP |
@@ -135,37 +77,22 @@ static int init_hw_info(struct snd_dice *dice,
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		hw->formats = AM824_IN_PCM_FORMAT_BITS;
 		stream = &dice->tx_stream;
-		pcm_channels = dice->tx_channels;
 	} else {
 		hw->formats = AM824_OUT_PCM_FORMAT_BITS;
 		stream = &dice->rx_stream;
-		pcm_channels = dice->rx_channels;
 	}
 
-	limit_channels_and_rates(dice, runtime, pcm_channels);
-	limit_period_and_buffer(hw);
-
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				  dice_rate_constraint, substream,
-				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	err = limit_channels_and_rates(dice, runtime, stream);
 	if (err < 0)
-		goto end;
-	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				  dice_channels_constraint, substream,
-				  SNDRV_PCM_HW_PARAM_RATE, -1);
-	if (err < 0)
-		goto end;
+		return err;
+	limit_period_and_buffer(hw);
 
-	err = amdtp_am824_add_pcm_hw_constraints(stream, runtime);
-end:
-	return err;
+	return amdtp_am824_add_pcm_hw_constraints(stream, runtime);
 }
 
 static int pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
-	unsigned int source, rate;
-	bool internal;
 	int err;
 
 	err = snd_dice_stream_lock_try(dice);
@@ -176,39 +103,6 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto err_locked;
 
-	err = snd_dice_transaction_get_clock_source(dice, &source);
-	if (err < 0)
-		goto err_locked;
-	switch (source) {
-	case CLOCK_SOURCE_AES1:
-	case CLOCK_SOURCE_AES2:
-	case CLOCK_SOURCE_AES3:
-	case CLOCK_SOURCE_AES4:
-	case CLOCK_SOURCE_AES_ANY:
-	case CLOCK_SOURCE_ADAT:
-	case CLOCK_SOURCE_TDIF:
-	case CLOCK_SOURCE_WC:
-		internal = false;
-		break;
-	default:
-		internal = true;
-		break;
-	}
-
-	/*
-	 * When source of clock is not internal or any PCM streams are running,
-	 * available sampling rate is limited at current sampling rate.
-	 */
-	if (!internal ||
-	    amdtp_stream_pcm_running(&dice->tx_stream) ||
-	    amdtp_stream_pcm_running(&dice->rx_stream)) {
-		err = snd_dice_transaction_get_rate(dice, &rate);
-		if (err < 0)
-			goto err_locked;
-		substream->runtime->hw.rate_min = rate;
-		substream->runtime->hw.rate_max = rate;
-	}
-
 	snd_pcm_set_sync(substream);
 end:
 	return err;
-- 
2.5.0
