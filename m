From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/30] ALSA: dice: Add new functions for
	constraints of PCM parameters
Date: Sat, 29 Nov 2014 00:59:18 +0900
Message-ID: <1417190379-4172-10-git-send-email-o-takashi@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FE432604DB
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:59:51 +0100 (CET)
In-Reply-To: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds a new functions and some arrangement for PCM restriction.
This arrangement is due to the number of channels which each Dice device has.

I note that minimum number for period becomes 2, instead of 1 because its PCM
functionality has SNDRV_PCM_INFO_BATCH, this means that the driver uses double
(or more) buffering so the minimum number for period should be 2.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-pcm.c | 109 ++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 44 deletions(-)

diff --git a/sound/firewire/dice/dice-pcm.c b/sound/firewire/dice/dice-pcm.c
index deacb53..2e531bd 100644
--- a/sound/firewire/dice/dice-pcm.c
+++ b/sound/firewire/dice/dice-pcm.c
@@ -67,71 +67,92 @@ static int dice_channels_constraint(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(c, &channels);
 }
 
-
-static int pcm_open(struct snd_pcm_substream *substream)
+static void limit_channels_and_rates(struct snd_dice *dice,
+				     struct snd_pcm_runtime *runtime,
+				     unsigned int *pcm_channels)
 {
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
+	struct snd_pcm_hardware *hw = &runtime->hw;
+	unsigned int i, rate, mode;
 
-	err = snd_dice_stream_lock_try(dice);
-	if (err < 0)
-		goto error;
-
-	runtime->hw = hardware;
+	hw->channels_min = UINT_MAX;
+	hw->channels_max = 0;
 
 	for (i = 0; i < ARRAY_SIZE(snd_dice_rates); ++i) {
-		if (dice->clock_caps & (1 << i))
-			runtime->hw.rates |=
-				snd_pcm_rate_to_rate_bit(snd_dice_rates[i]);
+		rate = snd_dice_rates[i];
+		if (snd_dice_stream_get_rate_mode(dice, rate, &mode) < 0)
+			continue;
+		hw->rates |= snd_pcm_rate_to_rate_bit(rate);
+
+		if (pcm_channels[mode] == 0)
+			continue;
+		hw->channels_min = min(hw->channels_min, pcm_channels[mode]);
+		hw->channels_max = max(hw->channels_max, pcm_channels[mode]);
 	}
+
 	snd_pcm_limit_hw_rates(runtime);
+}
 
-	for (i = 0; i < 3; ++i) {
-		if (dice->rx_channels[i]) {
-			runtime->hw.channels_min = min(runtime->hw.channels_min,
-						       dice->rx_channels[i]);
-			runtime->hw.channels_max = max(runtime->hw.channels_max,
-						       dice->rx_channels[i]);
-		}
-	}
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
+static int init_hw_info(struct snd_dice *dice,
+			struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_hardware *hw = &runtime->hw;
+	int err;
+
+	hw->info = SNDRV_PCM_INFO_MMAP |
+		   SNDRV_PCM_INFO_MMAP_VALID |
+		   SNDRV_PCM_INFO_BATCH |
+		   SNDRV_PCM_INFO_INTERLEAVED |
+		   SNDRV_PCM_INFO_BLOCK_TRANSFER;
+	hw->formats = AMDTP_OUT_PCM_FORMAT_BITS;
+
+	limit_channels_and_rates(dice, runtime, dice->rx_channels);
+	limit_period_and_buffer(hw);
 
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				  dice_rate_constraint, dice,
 				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
-		goto err_lock;
+		goto end;
 	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				  dice_channels_constraint, dice,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
-		goto err_lock;
+		goto end;
 
 	err = amdtp_stream_add_pcm_hw_constraints(&dice->rx_stream, runtime);
-	if (err < 0)
-		goto err_lock;
+end:
+	return err;
+}
 
-	return 0;
+static int pcm_open(struct snd_pcm_substream *substream)
+{
+	struct snd_dice *dice = substream->private_data;
+	int err;
 
-err_lock:
+	err = snd_dice_stream_lock_try(dice);
+	if (err < 0)
+		goto end;
+
+	err = init_hw_info(dice, substream);
+	if (err < 0)
+		goto err_locked;
+end:
+	return err;
+err_locked:
 	snd_dice_stream_lock_release(dice);
-error:
 	return err;
 }
 
-- 
2.1.0
