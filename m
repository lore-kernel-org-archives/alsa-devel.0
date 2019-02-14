From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 1/2] ASoC: da7219: Add support for master mode BCLK rate
 adjustment
Date: Thu, 14 Feb 2019 10:13:29 +0000
Message-ID: <2a1ae702cb3cfb9029e04b69d68f9c9d0e92dbf5.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550138803.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Previously the driver would default the BCLK periods per WCLK to
64, to cover all possible non-TDM scenarios when the codec was
DAI clock master. However some devices require a lower BCLK rate
to operate correctly so with this in mind, this commit updates
the code to be more dynamic, with BCLK rate now based on SR and
word length provided to hw_params().

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219.c | 36 ++++++++++++++++++++++++++----------
 sound/soc/codecs/da7219.h |  1 +
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index b1df4bb..c599aa9 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1376,11 +1376,7 @@ static int da7219_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	/* By default 64 BCLKs per WCLK is supported */
-	dai_clk_mode |= DA7219_DAI_BCLKS_PER_WCLK_64;
-
 	snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-			    DA7219_DAI_BCLKS_PER_WCLK_MASK |
 			    DA7219_DAI_CLK_POL_MASK | DA7219_DAI_WCLK_POL_MASK,
 			    dai_clk_mode);
 	snd_soc_component_update_bits(component, DA7219_DAI_CTRL, DA7219_DAI_FORMAT_MASK,
@@ -1399,14 +1395,12 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	__le16 offset;
 	u32 frame_size;
 
-	/* No channels enabled so disable TDM, revert to 64-bit frames */
+	/* No channels enabled so disable TDM */
 	if (!tx_mask) {
 		snd_soc_component_update_bits(component, DA7219_DAI_TDM_CTRL,
 				    DA7219_DAI_TDM_CH_EN_MASK |
 				    DA7219_DAI_TDM_MODE_EN_MASK, 0);
-		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
-				    DA7219_DAI_BCLKS_PER_WCLK_MASK,
-				    DA7219_DAI_BCLKS_PER_WCLK_64);
+		da7219->tdm_en = false;
 		return 0;
 	}
 
@@ -1458,6 +1452,8 @@ static int da7219_set_dai_tdm_slot(struct snd_soc_dai *dai,
 			    (tx_mask << DA7219_DAI_TDM_CH_EN_SHIFT) |
 			    DA7219_DAI_TDM_MODE_EN_MASK);
 
+	da7219->tdm_en = true;
+
 	return 0;
 }
 
@@ -1466,10 +1462,13 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
-	u8 dai_ctrl = 0, fs;
+	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
+	u8 dai_ctrl = 0, dai_bclks_per_wclk = 0, fs;
 	unsigned int channels;
+	int word_len = params_width(params);
+	int frame_size;
 
-	switch (params_width(params)) {
+	switch (word_len) {
 	case 16:
 		dai_ctrl |= DA7219_DAI_WORD_LENGTH_S16_LE;
 		break;
@@ -1533,6 +1532,23 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/*
+	 * If we're master, then we have a limited set of BCLK rates we
+	 * support. For slave mode this isn't the case and the codec can detect
+	 * the BCLK rate automatically.
+	 */
+	if (da7219->master && !da7219->tdm_en) {
+		frame_size = word_len * 2;
+		if (frame_size <= 32)
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_32;
+		else
+			dai_bclks_per_wclk = DA7219_DAI_BCLKS_PER_WCLK_64;
+
+		snd_soc_component_update_bits(component, DA7219_DAI_CLK_MODE,
+					      DA7219_DAI_BCLKS_PER_WCLK_MASK,
+					      dai_bclks_per_wclk);
+	}
+
 	snd_soc_component_update_bits(component, DA7219_DAI_CTRL,
 			    DA7219_DAI_WORD_LENGTH_MASK |
 			    DA7219_DAI_CH_NUM_MASK,
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 366cf46..018819c 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -830,6 +830,7 @@ struct da7219_priv {
 	int clk_src;
 
 	bool master;
+	bool tdm_en;
 	bool alc_en;
 	bool micbias_on_event;
 	unsigned int mic_pga_delay;
-- 
1.9.1
