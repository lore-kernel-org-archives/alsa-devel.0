From: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/3] ASoC: mediatek: mt8183: tdm hw support tdm out and 8ch
 i2s out
Date: Sat, 24 Aug 2019 12:37:24 +0800
Message-ID: <1566621445-26989-3-git-send-email-jiaxin.yu@mediatek.com>
References: <1566621445-26989-1-git-send-email-jiaxin.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1566621445-26989-1-git-send-email-jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eason.yen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch refined tdm driver code, and allow tdm hw to support two
configurations in machine driver to output tdm signal or i2s signal.

Signed-off-by: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c    | 175 ++++++++++++++----
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   |   3 +
 2 files changed, 144 insertions(+), 34 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c b/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
index 8983d54a9b67..d34cabdbf889 100644
--- a/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
@@ -15,13 +15,30 @@
 struct mtk_afe_tdm_priv {
 	int bck_id;
 	int bck_rate;
-
+	int tdm_out_mode;
+	int bck_invert;
+	int lck_invert;
 	int mclk_id;
 	int mclk_multiple; /* according to sample rate */
 	int mclk_rate;
 	int mclk_apll;
 };
 
+enum {
+	TDM_OUT_I2S = 0,
+	TDM_OUT_TDM = 1,
+};
+
+enum {
+	TDM_BCK_NON_INV = 0,
+	TDM_BCK_INV = 1,
+};
+
+enum {
+	TDM_LCK_NON_INV = 0,
+	TDM_LCK_INV = 1,
+};
+
 enum {
 	TDM_WLEN_16_BIT = 1,
 	TDM_WLEN_32_BIT = 2,
@@ -93,6 +110,25 @@ static unsigned int get_tdm_ch(unsigned int ch)
 	}
 }
 
+static unsigned int get_tdm_ch_fixup(unsigned int channels)
+{
+	if (channels > 4)
+		return 8;
+	else if (channels > 2)
+		return 4;
+	else
+		return 2;
+}
+
+static unsigned int get_tdm_ch_per_sdata(unsigned int mode,
+					 unsigned int channels)
+{
+	if (mode == TDM_OUT_TDM)
+		return get_tdm_ch_fixup(channels);
+	else
+		return 2;
+}
+
 /* interconnection */
 enum {
 	HDMI_CONN_CH0 = 0,
@@ -433,8 +469,11 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 	struct mt8183_afe_private *afe_priv = afe->platform_priv;
 	int tdm_id = dai->id;
 	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[tdm_id];
+	unsigned int tdm_out_mode = tdm_priv->tdm_out_mode;
 	unsigned int rate = params_rate(params);
 	unsigned int channels = params_channels(params);
+	unsigned int out_channels_per_sdata =
+		get_tdm_ch_per_sdata(tdm_out_mode, channels);
 	snd_pcm_format_t format = params_format(params);
 	unsigned int tdm_con = 0;
 
@@ -448,7 +487,7 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 
 	/* calculate bck */
 	tdm_priv->bck_rate = rate *
-			     channels *
+			     out_channels_per_sdata *
 			     snd_pcm_format_physical_width(format);
 
 	if (tdm_priv->bck_rate > tdm_priv->mclk_rate)
@@ -461,50 +500,70 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 		 __func__,
 		 tdm_id, rate, channels, format,
 		 tdm_priv->mclk_rate, tdm_priv->bck_rate);
+	dev_info(afe->dev, "%s(), out_channels_per_sdata = %d\n",
+		 __func__, out_channels_per_sdata);
 
 	/* set tdm */
-	tdm_con = 1 << BCK_INVERSE_SFT;
-	tdm_con |= 1 << LRCK_INVERSE_SFT;
-	tdm_con |= 1 << DELAY_DATA_SFT;
+	if (tdm_priv->bck_invert)
+		tdm_con |= 1 << BCK_INVERSE_SFT;
+
+	if (tdm_priv->lck_invert)
+		tdm_con |= 1 << LRCK_INVERSE_SFT;
+
+	if (tdm_priv->tdm_out_mode == TDM_OUT_I2S) {
+		tdm_con |= 1 << DELAY_DATA_SFT;
+		tdm_con |= get_tdm_lrck_width(format) << LRCK_TDM_WIDTH_SFT;
+	} else if (tdm_priv->tdm_out_mode == TDM_OUT_TDM) {
+		tdm_con |= 0 << DELAY_DATA_SFT;
+		tdm_con |= 0 << LRCK_TDM_WIDTH_SFT;
+	}
+
 	tdm_con |= 1 << LEFT_ALIGN_SFT;
 	tdm_con |= get_tdm_wlen(format) << WLEN_SFT;
-	tdm_con |= get_tdm_ch(channels) << CHANNEL_NUM_SFT;
+	tdm_con |= get_tdm_ch(out_channels_per_sdata) << CHANNEL_NUM_SFT;
 	tdm_con |= get_tdm_channel_bck(format) << CHANNEL_BCK_CYCLES_SFT;
-	tdm_con |= get_tdm_lrck_width(format) << LRCK_TDM_WIDTH_SFT;
 	regmap_write(afe->regmap, AFE_TDM_CON1, tdm_con);
 
-	switch (channels) {
-	case 1:
-	case 2:
+	if (out_channels_per_sdata == 2) {
+		switch (channels) {
+		case 1:
+		case 2:
+			tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
+			tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT1_SFT;
+			tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT2_SFT;
+			tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
+			break;
+		case 3:
+		case 4:
+			tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
+			tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
+			tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT2_SFT;
+			tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
+			break;
+		case 5:
+		case 6:
+			tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
+			tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
+			tdm_con |= TDM_CH_START_O34_O35 << ST_CH_PAIR_SOUT2_SFT;
+			tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
+			break;
+		case 7:
+		case 8:
+			tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
+			tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
+			tdm_con |= TDM_CH_START_O34_O35 << ST_CH_PAIR_SOUT2_SFT;
+			tdm_con |= TDM_CH_START_O36_O37 << ST_CH_PAIR_SOUT3_SFT;
+			break;
+		default:
+			tdm_con = 0;
+		}
+	} else {
 		tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
 		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT1_SFT;
 		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT2_SFT;
 		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
-		break;
-	case 3:
-	case 4:
-		tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
-		tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
-		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT2_SFT;
-		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
-		break;
-	case 5:
-	case 6:
-		tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
-		tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
-		tdm_con |= TDM_CH_START_O34_O35 << ST_CH_PAIR_SOUT2_SFT;
-		tdm_con |= TDM_CH_ZERO << ST_CH_PAIR_SOUT3_SFT;
-		break;
-	case 7:
-	case 8:
-		tdm_con = TDM_CH_START_O30_O31 << ST_CH_PAIR_SOUT0_SFT;
-		tdm_con |= TDM_CH_START_O32_O33 << ST_CH_PAIR_SOUT1_SFT;
-		tdm_con |= TDM_CH_START_O34_O35 << ST_CH_PAIR_SOUT2_SFT;
-		tdm_con |= TDM_CH_START_O36_O37 << ST_CH_PAIR_SOUT3_SFT;
-		break;
-	default:
-		tdm_con = 0;
 	}
+
 	regmap_write(afe->regmap, AFE_TDM_CON2, tdm_con);
 
 	regmap_update_bits(afe->regmap, AFE_HDMI_OUT_CON0,
@@ -573,10 +632,58 @@ static int mtk_dai_tdm_set_sysclk(struct snd_soc_dai *dai,
 	return mtk_dai_tdm_cal_mclk(afe, tdm_priv, freq);
 }
 
+static int mtk_dai_tdm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dai->dev);
+	struct mt8183_afe_private *afe_priv = afe->platform_priv;
+	struct mtk_afe_tdm_priv *tdm_priv = afe_priv->dai_priv[dai->id];
+
+	if (!tdm_priv) {
+		dev_warn(afe->dev, "%s(), tdm_priv == NULL", __func__);
+		return -EINVAL;
+	}
+
+	/* DAI mode*/
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		tdm_priv->tdm_out_mode = TDM_OUT_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		tdm_priv->tdm_out_mode = TDM_OUT_TDM;
+		break;
+	default:
+		tdm_priv->tdm_out_mode = TDM_OUT_I2S;
+	}
+
+	/* DAI clock inversion*/
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		tdm_priv->bck_invert = TDM_BCK_NON_INV;
+		tdm_priv->lck_invert = TDM_LCK_NON_INV;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		tdm_priv->bck_invert = TDM_BCK_NON_INV;
+		tdm_priv->lck_invert = TDM_LCK_INV;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		tdm_priv->bck_invert = TDM_BCK_INV;
+		tdm_priv->lck_invert = TDM_LCK_NON_INV;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+	default:
+		tdm_priv->bck_invert = TDM_BCK_INV;
+		tdm_priv->lck_invert = TDM_LCK_INV;
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops mtk_dai_tdm_ops = {
 	.hw_params = mtk_dai_tdm_hw_params,
 	.trigger = mtk_dai_tdm_trigger,
 	.set_sysclk = mtk_dai_tdm_set_sysclk,
+	.set_fmt = mtk_dai_tdm_set_fmt,
 };
 
 /* dai driver */
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index fe8a7461ace5..0fed0fa4704f 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -390,6 +390,9 @@ mt8183_mt6358_ts3a227_max98357_dai_links[] = {
 	{
 		.name = "TDM",
 		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			   SND_SOC_DAIFMT_IB_IF |
+			   SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
 		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
-- 
2.18.0
