From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Update TDM usage to be more
	flexible" to the asoc tree
Date: Thu, 14 Feb 2019 14:51:07 +0000 (GMT)
Message-ID: <20190214145107.979521126F78@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2817E2673E2
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 15:51:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Update TDM usage to be more flexible

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 541ccdc113f000d51858ee7e135889e4096a3316 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Thu, 14 Feb 2019 10:13:30 +0000
Subject: [PATCH] ASoC: da7219: Update TDM usage to be more flexible

The previous implementatation was restrictive with regards to
BCLK rates for slave mode where the driver would not allow rates
the codec couldn't provide itself as clock master. The codec
is able to automatically determine and handle whatever rate is
provided so this restriction isn't necessary for slave mode. The
code was also flawed with regards to setting of the frame offset
as using rx_mask to explicitly set the offset has the knock on
effect of impacting the min and max channels for the codec, in
soc_pcm_hw_params() through the call to
soc_pcm_codec_params_fixup().

With this update, the driver now only limits frame size if codec
is clock master, and dynamically determines the BCLK offset
relating to WCLK using the tx_mask for slot offset along with the
slot width provided.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 80 +++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c599aa9f609b..121a8190f93e 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1391,8 +1391,10 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 {
 	struct snd_soc_component *component = dai->component;
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
-	u8 dai_bclks_per_wclk;
-	__le16 offset;
+	unsigned int ch_mask;
+	u8 dai_bclks_per_wclk, slot_offset;
+	u16 offset;
+	__le16 dai_offset;
 	u32 frame_size;
 
 	/* No channels enabled so disable TDM */
@@ -1405,51 +1407,63 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	}
 
 	/* Check we have valid slots */
-	if (fls(tx_mask) > DA7219_DAI_TDM_MAX_SLOTS) {
-		dev_err(component->dev, "Invalid number of slots, max = %d\n",
+	slot_offset = ffs(tx_mask) - 1;
+	ch_mask = (tx_mask >> slot_offset);
+	if (fls(ch_mask) > DA7219_DAI_TDM_MAX_SLOTS) {
+		dev_err(component->dev,
+			"Invalid number of slots, max = %d\n",
 			DA7219_DAI_TDM_MAX_SLOTS);
 		return -EINVAL;
 	}
 
-	/* Check we have a valid offset given */
-	if (rx_mask > DA7219_DAI_OFFSET_MAX) {
-		dev_err(component->dev, "Invalid slot offset, max = %d\n",
-			DA7219_DAI_OFFSET_MAX);
+	/*
+	 * Ensure we have a valid offset into the frame, based on slot width
+	 * and slot offset of first slot we're interested in.
+	 */
+	offset = slot_offset * slot_width;
+	if (offset > DA7219_DAI_OFFSET_MAX) {
+		dev_err(component->dev, "Invalid frame offset %d\n", offset);
 		return -EINVAL;
 	}
 
-	/* Calculate & validate frame size based on slot info provided. */
-	frame_size = slots * slot_width;
-	switch (frame_size) {
-	case 32:
-		dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
-		break;
-	case 64:
-		dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
-		break;
-	case 128:
-		dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_128;
-		break;
-	case 256:
-		dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_256;
-		break;
-	default:
-		dev_err(component->dev, "Invalid frame size %d\n", frame_size);
-		return -EINVAL;
-	}
+	/*
+	 * If we're master, calculate & validate frame size based on slot info
+	 * provided as we have a limited set of rates available.
+	 */
+	if (da7219->master) {
+		frame_size = slots * slot_width;
+		switch (frame_size) {
+		case 32:
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
+			break;
+		case 64:
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
+			break;
+		case 128:
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_128;
+			break;
+		case 256:
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_256;
+			break;
+		default:
+			dev_err(component->dev, "Invalid frame size %d\n",
+				frame_size);
+			return -EINVAL;
+		}
 
-	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-			    DA7219_DAI_BCLKS_PER_WCLK_MASK,
-			    dai_bclks_per_wclk);
+		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+				DA7219_DAI_BCLKS_PER_WCLK_MASK,
+				dai_bclks_per_wclk);
+	}
 
-	offset = cpu_to_le16(rx_mask);
+	dai_offset = cpu_to_le16(offset);
 	regmap_bulk_write(da7219->regmap, DA7219_DAI_OFFSET_LOWER,
-			  &offset, sizeof(offset));
+			  &dai_offset, sizeof(dai_offset));
 
 	snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
 			    DA7219_DAI_TDM_CH_EN_MASK |
 			    DA7219_DAI_TDM_MODE_EN_MASK,
-			    (tx_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
+			    (ch_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
 			    DA7219_DAI_TDM_MODE_EN_MASK);
 
 	da7219->tdm_en = true;
-- 
2.20.1
