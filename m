From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] ASoC: da7219: Update TDM usage to be more
	flexible
Date: Wed, 13 Feb 2019 17:47:33 +0000
Message-ID: <be6aa7bea4d091367951f328467f6ff755aaab97.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B8BF5267418
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 09:45:13 +0100 (CET)
In-Reply-To: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/da7219.c | 80 ++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 7dbecf3..be606e3 100644
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
1.9.1
