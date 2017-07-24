From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Add the I2S ASRC support
Date: Mon, 24 Jul 2017 15:34:23 +0800
Message-ID: <1500881663-28990-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E575266949
 for <alsa-devel@alsa-project.org>; Mon, 24 Jul 2017 09:34:33 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, harshapriya.n@intel.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the I2S ASRC support.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 19 +++++++++++++++++++
 sound/soc/codecs/rt5514.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index a105c84..882fdc4 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -63,6 +63,7 @@ static const struct reg_sequence rt5514_patch[] = {
 	{RT5514_SRC_CTRL,		0x44000eee},
 	{RT5514_ANA_CTRL_LDO10,		0x00028604},
 	{RT5514_ANA_CTRL_ADCFED,	0x00000800},
+	{RT5514_ASRC_IN_CTRL1,		0x00000003},
 };
 
 static const struct reg_default rt5514_reg[] = {
@@ -471,6 +472,15 @@ static int rt5514_is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 		return 0;
 }
 
+static int rt5514_i2s_use_asrc(struct snd_soc_dapm_widget *source,
+	struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
+
+	return (rt5514->sysclk > rt5514->lrck * 384);
+}
+
 static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC1L"),
@@ -541,6 +551,10 @@ static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
 		RT5514_POW_PLL1_LDO_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("PLL1", RT5514_PWR_ANA2, RT5514_POW_PLL1_BIT, 0,
 		NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ASRC AD1", 1, RT5514_CLK_CTRL2,
+		RT5514_CLK_AD0_ASRC_EN_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ASRC AD2", 1, RT5514_CLK_CTRL2,
+		RT5514_CLK_AD1_ASRC_EN_BIT, 0, NULL, 0),
 
 	/* ADC Mux */
 	SND_SOC_DAPM_MUX("Stereo1 DMIC Mux", SND_SOC_NOPM, 0, 0,
@@ -638,6 +652,7 @@ static const struct snd_soc_dapm_route rt5514_dapm_routes[] = {
 	{ "Stereo1 ADC MIX", NULL, "Stereo1 ADC MIXR" },
 	{ "Stereo1 ADC MIX", NULL, "adc stereo1 filter" },
 	{ "adc stereo1 filter", NULL, "PLL1", rt5514_is_sys_clk_from_pll },
+	{ "adc stereo1 filter", NULL, "ASRC AD1", rt5514_i2s_use_asrc },
 
 	{ "Stereo2 DMIC Mux", "DMIC1", "DMIC1" },
 	{ "Stereo2 DMIC Mux", "DMIC2", "DMIC2" },
@@ -654,6 +669,7 @@ static const struct snd_soc_dapm_route rt5514_dapm_routes[] = {
 	{ "Stereo2 ADC MIX", NULL, "Stereo2 ADC MIXR" },
 	{ "Stereo2 ADC MIX", NULL, "adc stereo2 filter" },
 	{ "adc stereo2 filter", NULL, "PLL1", rt5514_is_sys_clk_from_pll },
+	{ "adc stereo2 filter", NULL, "ASRC AD2", rt5514_i2s_use_asrc },
 
 	{ "AIF1TX", NULL, "Stereo1 ADC MIX"},
 	{ "AIF1TX", NULL, "Stereo2 ADC MIX"},
@@ -706,6 +722,9 @@ static int rt5514_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(rt5514->regmap, RT5514_I2S_CTRL1, RT5514_I2S_DL_MASK,
 		val_len);
+	regmap_update_bits(rt5514->regmap, RT5514_CLK_CTRL1,
+		RT5514_CLK_AD_ANA1_SEL_MASK,
+		(pre_div + 1) << RT5514_CLK_AD_ANA1_SEL_SFT);
 	regmap_update_bits(rt5514->regmap, RT5514_CLK_CTRL2,
 		RT5514_CLK_SYS_DIV_OUT_MASK | RT5514_SEL_ADC_OSR_MASK,
 		pre_div << RT5514_CLK_SYS_DIV_OUT_SFT |
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 75024a4..2dc40e6 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -37,6 +37,7 @@
 #define RT5514_PLL3_CALIB_CTRL5			0x2124
 #define RT5514_DELAY_BUF_CTRL1			0x2140
 #define RT5514_DELAY_BUF_CTRL3			0x2148
+#define RT5514_ASRC_IN_CTRL1			0x2180
 #define RT5514_DOWNFILTER0_CTRL1		0x2190
 #define RT5514_DOWNFILTER0_CTRL2		0x2194
 #define RT5514_DOWNFILTER0_CTRL3		0x2198
@@ -197,8 +198,14 @@
 #define RT5514_CLK_AD0_EN_BIT			23
 #define RT5514_CLK_DMIC_OUT_SEL_MASK		(0x7 << 8)
 #define RT5514_CLK_DMIC_OUT_SEL_SFT		8
+#define RT5514_CLK_AD_ANA1_SEL_MASK		(0xf << 0)
+#define RT5514_CLK_AD_ANA1_SEL_SFT		0
 
 /* RT5514_CLK_CTRL2 (0x2108) */
+#define RT5514_CLK_AD1_ASRC_EN			(0x1 << 17)
+#define RT5514_CLK_AD1_ASRC_EN_BIT		17
+#define RT5514_CLK_AD0_ASRC_EN			(0x1 << 16)
+#define RT5514_CLK_AD0_ASRC_EN_BIT		16
 #define RT5514_CLK_SYS_DIV_OUT_MASK		(0x7 << 8)
 #define RT5514_CLK_SYS_DIV_OUT_SFT		8
 #define RT5514_SEL_ADC_OSR_MASK			(0x7 << 4)
-- 
2.7.4
