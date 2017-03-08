From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 8/8] ASoC: rt5665: enable TDM if more than 2
	channels
Date: Wed, 8 Mar 2017 19:05:36 +0800
Message-ID: <1488971136-19100-8-git-send-email-bardliao@realtek.com>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id EF779266927
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:05:53 +0100 (CET)
In-Reply-To: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

TDM is necessary for more than 2 channels. And there is no control bit
to specify which slots are using. Machine driver will not need to call
snd_soc_dai_set_tdm_slot if we do it in rt5665_hw_params.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 114 ++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 52148fc..25acdb36 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -3967,6 +3967,62 @@ static const struct snd_soc_dapm_route rt5665_dapm_routes[] = {
 	{"PDMR", NULL, "PDM R Playback"},
 };
 
+static int rt5665_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int val = 0;
+
+	if (rx_mask || tx_mask)
+		val |= RT5665_I2S1_MODE_TDM;
+
+	switch (slots) {
+	case 4:
+		val |= RT5665_TDM_IN_CH_4;
+		val |= RT5665_TDM_OUT_CH_4;
+		break;
+	case 6:
+		val |= RT5665_TDM_IN_CH_6;
+		val |= RT5665_TDM_OUT_CH_6;
+		break;
+	case 8:
+		val |= RT5665_TDM_IN_CH_8;
+		val |= RT5665_TDM_OUT_CH_8;
+		break;
+	case 2:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (slot_width) {
+	case 20:
+		val |= RT5665_TDM_IN_LEN_20;
+		val |= RT5665_TDM_OUT_LEN_20;
+		break;
+	case 24:
+		val |= RT5665_TDM_IN_LEN_24;
+		val |= RT5665_TDM_OUT_LEN_24;
+		break;
+	case 32:
+		val |= RT5665_TDM_IN_LEN_32;
+		val |= RT5665_TDM_OUT_LEN_32;
+		break;
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, RT5665_TDM_CTRL_1,
+		RT5665_I2S1_MODE_MASK | RT5665_TDM_IN_CH_MASK |
+		RT5665_TDM_OUT_CH_MASK | RT5665_TDM_IN_LEN_MASK |
+		RT5665_TDM_OUT_LEN_MASK, val);
+
+	return 0;
+}
+
+
 static int rt5665_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -4013,6 +4069,9 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 	switch (dai->id) {
 	case RT5665_AIF1_1:
 	case RT5665_AIF1_2:
+		if (params_channels(params) > 2)
+			rt5665_set_tdm_slot(dai, 0xf, 0xf,
+				params_channels(params), params_width(params));
 		mask_clk = RT5665_I2S_PD1_MASK;
 		val_clk = pre_div << RT5665_I2S_PD1_SFT;
 		snd_soc_update_bits(codec, RT5665_I2S1_SDP,
@@ -4229,61 +4288,6 @@ static int rt5665_set_codec_pll(struct snd_soc_codec *codec, int pll_id,
 	return 0;
 }
 
-static int rt5665_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-			unsigned int rx_mask, int slots, int slot_width)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	unsigned int val = 0;
-
-	if (rx_mask || tx_mask)
-		val |= RT5665_I2S1_MODE_TDM;
-
-	switch (slots) {
-	case 4:
-		val |= RT5665_TDM_IN_CH_4;
-		val |= RT5665_TDM_OUT_CH_4;
-		break;
-	case 6:
-		val |= RT5665_TDM_IN_CH_6;
-		val |= RT5665_TDM_OUT_CH_6;
-		break;
-	case 8:
-		val |= RT5665_TDM_IN_CH_8;
-		val |= RT5665_TDM_OUT_CH_8;
-		break;
-	case 2:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (slot_width) {
-	case 20:
-		val |= RT5665_TDM_IN_LEN_20;
-		val |= RT5665_TDM_OUT_LEN_20;
-		break;
-	case 24:
-		val |= RT5665_TDM_IN_LEN_24;
-		val |= RT5665_TDM_OUT_LEN_24;
-		break;
-	case 32:
-		val |= RT5665_TDM_IN_LEN_32;
-		val |= RT5665_TDM_OUT_LEN_32;
-		break;
-	case 16:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	snd_soc_update_bits(codec, RT5665_TDM_CTRL_1,
-		RT5665_I2S1_MODE_MASK | RT5665_TDM_IN_CH_MASK |
-		RT5665_TDM_OUT_CH_MASK | RT5665_TDM_IN_LEN_MASK |
-		RT5665_TDM_OUT_LEN_MASK, val);
-
-	return 0;
-}
-
 static int rt5665_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 {
 	struct snd_soc_codec *codec = dai->codec;
-- 
2.7.4
