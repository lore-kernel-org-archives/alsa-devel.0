From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/4] ASoC: rt5645: Redefine format config for
	rt5650
Date: Fri, 27 Mar 2015 20:16:43 +0800
Message-ID: <1427458603-772-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 59FA8265A6C
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 13:17:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, jason.ym.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

rt5650 and rt5645 use different register bits for format configuration.
This patch modifies rt5645_hw_params and rt5645_set_dai_fmt to support
both codecs.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
Mark,

I am think if we should use different codec driver for rt5645 and
rt5650. In fact, they are different Die. What do you think?

---
---
 sound/soc/codecs/rt5645.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4c384a1..0133c8c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2049,7 +2049,7 @@ static int rt5645_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val_len = 0, val_clk, mask_clk;
+	unsigned int val_len = 0, val_clk, mask_clk, dl_sft;
 	int pre_div, bclk_ms, frame_size;
 
 	rt5645->lrck[dai->id] = params_rate(params);
@@ -2063,6 +2063,16 @@ static int rt5645_hw_params(struct snd_pcm_substream *substream,
 		dev_err(codec->dev, "Unsupported frame size: %d\n", frame_size);
 		return -EINVAL;
 	}
+
+	switch (rt5645->codec_type) {
+	case CODEC_TYPE_RT5650:
+		dl_sft = 4;
+		break;
+	default:
+		dl_sft = 2;
+		break;
+	}
+
 	bclk_ms = frame_size > 32;
 	rt5645->bclk[dai->id] = rt5645->lrck[dai->id] * (32 << bclk_ms);
 
@@ -2075,13 +2085,13 @@ static int rt5645_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		break;
 	case 20:
-		val_len |= RT5645_I2S_DL_20;
+		val_len = 0x1;
 		break;
 	case 24:
-		val_len |= RT5645_I2S_DL_24;
+		val_len = 0x2;
 		break;
 	case 8:
-		val_len |= RT5645_I2S_DL_8;
+		val_len = 0x3;
 		break;
 	default:
 		return -EINVAL;
@@ -2093,7 +2103,7 @@ static int rt5645_hw_params(struct snd_pcm_substream *substream,
 		val_clk = bclk_ms << RT5645_I2S_BCLK_MS1_SFT |
 			pre_div << RT5645_I2S_PD1_SFT;
 		snd_soc_update_bits(codec, RT5645_I2S1_SDP,
-			RT5645_I2S_DL_MASK, val_len);
+			(0x3 << dl_sft), (val_len << dl_sft));
 		snd_soc_update_bits(codec, RT5645_ADDA_CLK1, mask_clk, val_clk);
 		break;
 	case  RT5645_AIF2:
@@ -2101,7 +2111,7 @@ static int rt5645_hw_params(struct snd_pcm_substream *substream,
 		val_clk = bclk_ms << RT5645_I2S_BCLK_MS2_SFT |
 			pre_div << RT5645_I2S_PD2_SFT;
 		snd_soc_update_bits(codec, RT5645_I2S2_SDP,
-			RT5645_I2S_DL_MASK, val_len);
+			(0x3 << dl_sft), (val_len << dl_sft));
 		snd_soc_update_bits(codec, RT5645_ADDA_CLK1, mask_clk, val_clk);
 		break;
 	default:
@@ -2116,7 +2126,16 @@ static int rt5645_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
-	unsigned int reg_val = 0;
+	unsigned int reg_val = 0, pol_sft;
+
+	switch (rt5645->codec_type) {
+	case CODEC_TYPE_RT5650:
+		pol_sft = 8;
+		break;
+	default:
+		pol_sft = 7;
+		break;
+	}
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -2134,7 +2153,7 @@ static int rt5645_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		reg_val |= RT5645_I2S_BP_INV;
+		reg_val |= (1 << pol_sft);
 		break;
 	default:
 		return -EINVAL;
@@ -2158,12 +2177,12 @@ static int rt5645_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	switch (dai->id) {
 	case RT5645_AIF1:
 		snd_soc_update_bits(codec, RT5645_I2S1_SDP,
-			RT5645_I2S_MS_MASK | RT5645_I2S_BP_MASK |
+			RT5645_I2S_MS_MASK | (1 << pol_sft) |
 			RT5645_I2S_DF_MASK, reg_val);
 		break;
 	case RT5645_AIF2:
 		snd_soc_update_bits(codec, RT5645_I2S2_SDP,
-			RT5645_I2S_MS_MASK | RT5645_I2S_BP_MASK |
+			RT5645_I2S_MS_MASK | (1 << pol_sft) |
 			RT5645_I2S_DF_MASK, reg_val);
 		break;
 	default:
-- 
1.8.1.1.439.g50a6b54
