From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 12/13] ALSA: dice: use cache for PCM
	constraints and rules
Date: Wed,  2 May 2018 19:16:50 +0900
Message-ID: <20180502101651.26173-13-o-takashi@sakamocchi.jp>
References: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D1590266F44
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 12:17:46 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id w129so5970306pfd.3
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 03:17:46 -0700 (PDT)
In-Reply-To: <20180502101651.26173-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In former commits, proxy structure gets members for cache of stream
formats. The cache allows to apply correct constraints and rules to
runtime of PCM substream. They allows userspace applications to change
current sampling transmission frequency.

This commit uses the cacher for the PCM constraints and rules.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c | 227 ++++++++++++++++++++++++++++++-----------
 1 file changed, 170 insertions(+), 57 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index 7cb9e9713ac3..08a173170d52 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -9,43 +9,115 @@
 
 #include "dice.h"
 
+static int dice_rate_constraint(struct snd_pcm_hw_params *params,
+				struct snd_pcm_hw_rule *rule)
+{
+	struct snd_pcm_substream *substream = rule->private;
+	struct snd_dice *dice = substream->private_data;
+	unsigned int index = substream->pcm->device;
+
+	const struct snd_interval *c =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval *r =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval rates = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int *pcm_channels;
+	enum snd_dice_rate_mode mode;
+	unsigned int i, rate;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		pcm_channels = dice->tx_pcm_chs[index];
+	else
+		pcm_channels = dice->rx_pcm_chs[index];
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
+	struct snd_pcm_substream *substream = rule->private;
+	struct snd_dice *dice = substream->private_data;
+	unsigned int index = substream->pcm->device;
+
+	const struct snd_interval *r =
+		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *c =
+		hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_interval channels = {
+		.min = UINT_MAX, .max = 0, .integer = 1
+	};
+	unsigned int *pcm_channels;
+	enum snd_dice_rate_mode mode;
+	unsigned int i, rate;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		pcm_channels = dice->tx_pcm_chs[index];
+	else
+		pcm_channels = dice->rx_pcm_chs[index];
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
 static int limit_channels_and_rates(struct snd_dice *dice,
 				    struct snd_pcm_runtime *runtime,
 				    enum amdtp_stream_direction dir,
-				    unsigned int index, unsigned int size)
+				    unsigned int index)
 {
 	struct snd_pcm_hardware *hw = &runtime->hw;
-	struct amdtp_stream *stream;
-	unsigned int rate;
-	__be32 reg;
-	int err;
-
-	/*
-	 * Retrieve current Multi Bit Linear Audio data channel and limit to
-	 * it.
-	 */
-	if (dir == AMDTP_IN_STREAM) {
-		stream = &dice->tx_stream[index];
-		err = snd_dice_transaction_read_tx(dice,
-				size * index + TX_NUMBER_AUDIO,
-				&reg, sizeof(reg));
-	} else {
-		stream = &dice->rx_stream[index];
-		err = snd_dice_transaction_read_rx(dice,
-				size * index + RX_NUMBER_AUDIO,
-				&reg, sizeof(reg));
+	unsigned int *pcm_channels;
+	unsigned int i;
+
+	if (dir == AMDTP_IN_STREAM)
+		pcm_channels = dice->tx_pcm_chs[index];
+	else
+		pcm_channels = dice->rx_pcm_chs[index];
+
+	hw->channels_min = UINT_MAX;
+	hw->channels_max = 0;
+
+	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
+		enum snd_dice_rate_mode mode;
+		unsigned int rate, channels;
+
+		rate = snd_dice_rates[i];
+		if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
+			continue;
+		hw->rates |= snd_pcm_rate_to_rate_bit(rate);
+
+		channels = pcm_channels[mode];
+		if (channels == 0)
+			continue;
+		hw->channels_min = min(hw->channels_min, channels);
+		hw->channels_max = max(hw->channels_max, channels);
 	}
-	if (err < 0)
-		return err;
-
-	hw->channels_min = hw->channels_max = be32_to_cpu(reg);
-
-	/* Retrieve current sampling transfer frequency and limit to it. */
-	err = snd_dice_transaction_get_rate(dice, &rate);
-	if (err < 0)
-		return err;
 
-	hw->rates = snd_pcm_rate_to_rate_bit(rate);
 	snd_pcm_limit_hw_rates(runtime);
 
 	return 0;
@@ -56,36 +128,34 @@ static int init_hw_info(struct snd_dice *dice,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
+	unsigned int index = substream->pcm->device;
 	enum amdtp_stream_direction dir;
 	struct amdtp_stream *stream;
-	__be32 reg[2];
-	unsigned int count, size;
 	int err;
 
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		hw->formats = AM824_IN_PCM_FORMAT_BITS;
 		dir = AMDTP_IN_STREAM;
-		stream = &dice->tx_stream[substream->pcm->device];
-		err = snd_dice_transaction_read_tx(dice, TX_NUMBER, reg,
-						   sizeof(reg));
+		stream = &dice->tx_stream[index];
 	} else {
 		hw->formats = AM824_OUT_PCM_FORMAT_BITS;
 		dir = AMDTP_OUT_STREAM;
-		stream = &dice->rx_stream[substream->pcm->device];
-		err = snd_dice_transaction_read_rx(dice, RX_NUMBER, reg,
-						   sizeof(reg));
+		stream = &dice->rx_stream[index];
 	}
 
+	err = limit_channels_and_rates(dice, substream->runtime, dir,
+				       index);
 	if (err < 0)
 		return err;
 
-	count = min_t(unsigned int, be32_to_cpu(reg[0]), MAX_STREAMS);
-	if (substream->pcm->device >= count)
-		return -ENXIO;
-
-	size = be32_to_cpu(reg[1]) * 4;
-	err = limit_channels_and_rates(dice, substream->runtime, dir,
-				       substream->pcm->device, size);
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  dice_rate_constraint, substream,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  dice_channels_constraint, substream,
+				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		return err;
 
@@ -95,6 +165,8 @@ static int init_hw_info(struct snd_dice *dice,
 static int pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_dice *dice = substream->private_data;
+	unsigned int source;
+	bool internal;
 	int err;
 
 	err = snd_dice_stream_lock_try(dice);
@@ -105,6 +177,43 @@ static int pcm_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto err_locked;
 
+	err = snd_dice_transaction_get_clock_source(dice, &source);
+	if (err < 0)
+		goto err_locked;
+	switch (source) {
+	case CLOCK_SOURCE_AES1:
+	case CLOCK_SOURCE_AES2:
+	case CLOCK_SOURCE_AES3:
+	case CLOCK_SOURCE_AES4:
+	case CLOCK_SOURCE_AES_ANY:
+	case CLOCK_SOURCE_ADAT:
+	case CLOCK_SOURCE_TDIF:
+	case CLOCK_SOURCE_WC:
+		internal = false;
+		break;
+	default:
+		internal = true;
+		break;
+	}
+
+	/*
+	 * When source of clock is not internal or any PCM streams are running,
+	 * available sampling rate is limited at current sampling rate.
+	 */
+	if (!internal ||
+	    amdtp_stream_pcm_running(&dice->tx_stream[0]) ||
+	    amdtp_stream_pcm_running(&dice->tx_stream[1]) ||
+	    amdtp_stream_pcm_running(&dice->rx_stream[0]) ||
+	    amdtp_stream_pcm_running(&dice->rx_stream[1])) {
+		unsigned int rate;
+
+		err = snd_dice_transaction_get_rate(dice, &rate);
+		if (err < 0)
+			goto err_locked;
+		substream->runtime->hw.rate_min = rate;
+		substream->runtime->hw.rate_max = rate;
+	}
+
 	snd_pcm_set_sync(substream);
 end:
 	return err;
@@ -318,7 +427,6 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 		.page      = snd_pcm_lib_get_vmalloc_page,
 		.mmap      = snd_pcm_lib_mmap_vmalloc,
 	};
-	__be32 reg;
 	struct snd_pcm *pcm;
 	unsigned int i, max_capture, max_playback, capture, playback;
 	int err;
@@ -327,18 +435,23 @@ int snd_dice_create_pcm(struct snd_dice *dice)
 	if (dice->force_two_pcms) {
 		max_capture = max_playback = 2;
 	} else {
+		int j;
 		max_capture = max_playback = 0;
-		err = snd_dice_transaction_read_tx(dice, TX_NUMBER, &reg,
-						   sizeof(reg));
-		if (err < 0)
-			return err;
-		max_capture = min_t(unsigned int, be32_to_cpu(reg), MAX_STREAMS);
-
-		err = snd_dice_transaction_read_rx(dice, RX_NUMBER, &reg,
-						   sizeof(reg));
-		if (err < 0)
-			return err;
-		max_playback = min_t(unsigned int, be32_to_cpu(reg), MAX_STREAMS);
+		for (i = 0; i < MAX_STREAMS; ++i) {
+			for (j = 0; j < SND_DICE_RATE_MODE_COUNT; ++j) {
+				if (dice->tx_pcm_chs[i][j] > 0) {
+					++max_capture;
+					break;
+				}
+			}
+
+			for (j = 0; j < SND_DICE_RATE_MODE_COUNT; ++j) {
+				if (dice->rx_pcm_chs[i][j] > 0) {
+					++max_playback;
+					break;
+				}
+			}
+		}
 	}
 
 	for (i = 0; i < MAX_STREAMS; i++) {
-- 
2.14.1
