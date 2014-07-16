From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Disable AIF TX/RX before configuring it
Date: Wed, 16 Jul 2014 13:10:39 +0100
Message-ID: <20140716121029.GA22222@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If we don't disable the AIF TX/RX then we may fall into a
situation where the new AIF settings are ignored by the device.
For example, this problem manifests when switching between
different sample rates.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index fb30c82..270e7ad 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1249,6 +1249,7 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	int tdm_width = arizona->tdm_width[dai->id - 1];
 	int tdm_slots = arizona->tdm_slots[dai->id - 1];
 	int bclk, lrclk, wl, frame, bclk_target;
+	unsigned int aif_tx_state, aif_rx_state;
 
 	if (params_rate(params) % 8000)
 		rates = &arizona_44k1_bclk_rates[0];
@@ -1299,9 +1300,18 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	wl = snd_pcm_format_width(params_format(params));
 	frame = wl << ARIZONA_AIF1TX_WL_SHIFT | wl;
 
+	/* Save AIF TX/RX state */
+	aif_tx_state = snd_soc_read(codec, base + ARIZONA_AIF_TX_ENABLES);
+	aif_rx_state = snd_soc_read(codec, base + ARIZONA_AIF_RX_ENABLES);
+	/* Disable AIF TX/RX before configuring it */
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_TX_ENABLES,
+			    0xff, 0x0);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_RX_ENABLES,
+			    0xff, 0x0);
+
 	ret = arizona_hw_params_rate(substream, params, dai);
 	if (ret != 0)
-		return ret;
+		goto restore_aif;
 
 	regmap_update_bits_async(arizona->regmap,
 				 base + ARIZONA_AIF_BCLK_CTRL,
@@ -1320,7 +1330,13 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 			   ARIZONA_AIF1RX_WL_MASK |
 			   ARIZONA_AIF1RX_SLOT_LEN_MASK, frame);
 
-	return 0;
+restore_aif:
+	/* Restore AIF TX/RX state */
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_TX_ENABLES,
+			    0xff, aif_tx_state);
+	snd_soc_update_bits(codec, base + ARIZONA_AIF_RX_ENABLES,
+			    0xff, aif_rx_state);
+	return ret;
 }
 
 static const char *arizona_dai_clk_str(int clk_id)
-- 
1.7.2.5
