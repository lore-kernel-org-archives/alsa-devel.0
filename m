From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Add TDM channel mapping function
Date: Sat, 18 Oct 2014 17:52:06 +0800
Message-ID: <1413625926-18294-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 786082604CB
 for <alsa-devel@alsa-project.org>; Sat, 18 Oct 2014 11:52:34 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

It is for channel to slot mapping, and it is not only for 8 channels mapping,
but also in 2, 4 and 6 channels mapping. If we want to use the 2 channels in
the stereo2 adc path, we need to set the item "2/1/3/4" or "2/3/1/4".

It also adds for stereo channel swap. It can map the sterero channels "L/R"
to "R/L", "L/L" or R/R.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 241 +++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/rt5677.h |  38 +++++++-
 2 files changed, 264 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f6df276..8be899d 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -1834,6 +1834,87 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5677_if4_adc_mux =
 	SOC_DAPM_ENUM("IF4 ADC Source", rt5677_if4_adc_enum);
 
+/* TDM IF1/2 ADC Data Selection */ /* MX-3B MX-40 [7:6][5:4][3:2][1:0] */
+static const char * const rt5677_if12_adc_swap_src[] = {
+	"L/R", "R/L", "L/L", "R/R"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_adc1_swap_enum, RT5677_TDM1_CTRL1,
+	RT5677_IF1_ADC1_SWAP_SFT, rt5677_if12_adc_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if1_adc1_swap_mux =
+	SOC_DAPM_ENUM("IF1 ADC1 Swap Source", rt5677_if1_adc1_swap_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_adc2_swap_enum, RT5677_TDM1_CTRL1,
+	RT5677_IF1_ADC2_SWAP_SFT, rt5677_if12_adc_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if1_adc2_swap_mux =
+	SOC_DAPM_ENUM("IF1 ADC2 Swap Source", rt5677_if1_adc2_swap_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_adc3_swap_enum, RT5677_TDM1_CTRL1,
+	RT5677_IF1_ADC3_SWAP_SFT, rt5677_if12_adc_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if1_adc3_swap_mux =
+	SOC_DAPM_ENUM("IF1 ADC3 Swap Source", rt5677_if1_adc3_swap_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_adc4_swap_enum, RT5677_TDM1_CTRL1,
+	RT5677_IF1_ADC4_SWAP_SFT, rt5677_if12_adc_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if1_adc4_swap_mux =
+	SOC_DAPM_ENUM("IF1 ADC4 Swap Source", rt5677_if1_adc4_swap_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_adc1_swap_enum, RT5677_TDM2_CTRL1,
+	RT5677_IF1_ADC2_SWAP_SFT, rt5677_if12_adc_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if2_adc1_swap_mux =
+	SOC_DAPM_ENUM("IF1 ADC2 Swap Source", rt5677_if2_adc1_swap_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_adc2_swap_enum, RT5677_TDM2_CTRL1,
+	RT5677_IF2_ADC2_SWAP_SFT, rt5677_if12_adc_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if2_adc2_swap_mux =
+	SOC_DAPM_ENUM("IF2 ADC2 Swap Source", rt5677_if2_adc2_swap_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_adc3_swap_enum, RT5677_TDM2_CTRL1,
+	RT5677_IF2_ADC3_SWAP_SFT, rt5677_if12_adc_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if2_adc3_swap_mux =
+	SOC_DAPM_ENUM("IF2 ADC3 Swap Source", rt5677_if2_adc3_swap_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_adc4_swap_enum, RT5677_TDM2_CTRL1,
+	RT5677_IF2_ADC4_SWAP_SFT, rt5677_if12_adc_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if2_adc4_swap_mux =
+	SOC_DAPM_ENUM("IF2 ADC4 Swap Source", rt5677_if2_adc4_swap_enum);
+
+/* TDM IF1/2 ADC Data Selection */ /* MX-3C MX-41 [2:0] */
+static const char * const rt5677_if12_adc_tdm_swap_src[] = {
+	"1/2/3/4", "2/1/3/4", "2/3/1/4", "4/1/2/3", "1/3/2/4", "1/4/2/3",
+	"3/1/2/4", "3/4/1/2"
+};
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if1_adc_tdm_swap_enum, RT5677_TDM1_CTRL2,
+	RT5677_IF1_ADC_CTRL_SFT, rt5677_if12_adc_tdm_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if1_adc_tdm_swap_mux =
+	SOC_DAPM_ENUM("IF1 ADC TDM Swap Source", rt5677_if1_adc_tdm_swap_enum);
+
+static const SOC_ENUM_SINGLE_DECL(
+	rt5677_if2_adc_tdm_swap_enum, RT5677_TDM2_CTRL2,
+	RT5677_IF2_ADC_CTRL_SFT, rt5677_if12_adc_tdm_swap_src);
+
+static const struct snd_kcontrol_new rt5677_if2_adc_tdm_swap_mux =
+	SOC_DAPM_ENUM("IF2 ADC TDM Swap Source", rt5677_if2_adc_tdm_swap_enum);
+
 static int rt5677_bst1_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -1945,6 +2026,60 @@ static int rt5677_set_micbias1_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5677_if1_adc_tdm_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	unsigned int value;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_read(rt5677->regmap, RT5677_TDM1_CTRL2, &value);
+		if (value & RT5677_IF1_ADC_CTRL_MASK)
+			regmap_update_bits(rt5677->regmap, RT5677_TDM1_CTRL1,
+				RT5677_IF1_ADC_MODE_MASK,
+				RT5677_IF1_ADC_MODE_TDM);
+		else
+			regmap_update_bits(rt5677->regmap, RT5677_TDM1_CTRL1,
+				RT5677_IF1_ADC_MODE_MASK,
+				RT5677_IF1_ADC_MODE_I2S);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5677_if2_adc_tdm_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+	unsigned int value;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		regmap_read(rt5677->regmap, RT5677_TDM2_CTRL2, &value);
+		if (value & RT5677_IF2_ADC_CTRL_MASK)
+			regmap_update_bits(rt5677->regmap, RT5677_TDM2_CTRL1,
+				RT5677_IF2_ADC_MODE_MASK,
+				RT5677_IF2_ADC_MODE_TDM);
+		else
+			regmap_update_bits(rt5677->regmap, RT5677_TDM2_CTRL1,
+				RT5677_IF2_ADC_MODE_MASK,
+				RT5677_IF2_ADC_MODE_I2S);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PLL1", RT5677_PWR_ANLG2, RT5677_PWR_PLL1_BIT,
 		0, rt5677_set_pll1_event, SND_SOC_DAPM_POST_PMU),
@@ -2104,10 +2239,8 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("Stereo4 ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Sto2 ADC LR MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("Mono ADC MIX", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1_ADC1", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1_ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1_ADC3", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1_ADC4", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF1 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("IF2 ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* DSP */
 	SND_SOC_DAPM_MUX("IB9 Mux", SND_SOC_NOPM, 0, 0,
@@ -2230,6 +2363,17 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 			&rt5677_if1_adc3_mux),
 	SND_SOC_DAPM_MUX("IF1 ADC4 Mux", SND_SOC_NOPM, 0, 0,
 			&rt5677_if1_adc4_mux),
+	SND_SOC_DAPM_MUX("IF1 ADC1 Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_adc1_swap_mux),
+	SND_SOC_DAPM_MUX("IF1 ADC2 Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_adc2_swap_mux),
+	SND_SOC_DAPM_MUX("IF1 ADC3 Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_adc3_swap_mux),
+	SND_SOC_DAPM_MUX("IF1 ADC4 Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_adc4_swap_mux),
+	SND_SOC_DAPM_MUX_E("IF1 ADC TDM Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if1_adc_tdm_swap_mux, rt5677_if1_adc_tdm_event,
+			SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_MUX("IF2 ADC1 Mux", SND_SOC_NOPM, 0, 0,
 			&rt5677_if2_adc1_mux),
 	SND_SOC_DAPM_MUX("IF2 ADC2 Mux", SND_SOC_NOPM, 0, 0,
@@ -2238,6 +2382,17 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 			&rt5677_if2_adc3_mux),
 	SND_SOC_DAPM_MUX("IF2 ADC4 Mux", SND_SOC_NOPM, 0, 0,
 			&rt5677_if2_adc4_mux),
+	SND_SOC_DAPM_MUX("IF2 ADC1 Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_adc1_swap_mux),
+	SND_SOC_DAPM_MUX("IF2 ADC2 Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_adc2_swap_mux),
+	SND_SOC_DAPM_MUX("IF2 ADC3 Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_adc3_swap_mux),
+	SND_SOC_DAPM_MUX("IF2 ADC4 Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_adc4_swap_mux),
+	SND_SOC_DAPM_MUX_E("IF2 ADC TDM Swap Mux", SND_SOC_NOPM, 0, 0,
+			&rt5677_if2_adc_tdm_swap_mux, rt5677_if2_adc_tdm_event,
+			SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_MUX("IF3 ADC Mux", SND_SOC_NOPM, 0, 0,
 			&rt5677_if3_adc_mux),
 	SND_SOC_DAPM_MUX("IF4 ADC Mux", SND_SOC_NOPM, 0, 0,
@@ -2621,11 +2776,42 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "IF1 ADC4 Mux", "OB67", "OB67" },
 	{ "IF1 ADC4 Mux", "OB01", "OB01 Bypass Mux" },
 
+	{ "IF1 ADC1 Swap Mux", "L/R", "IF1 ADC1 Mux" },
+	{ "IF1 ADC1 Swap Mux", "R/L", "IF1 ADC1 Mux" },
+	{ "IF1 ADC1 Swap Mux", "L/L", "IF1 ADC1 Mux" },
+	{ "IF1 ADC1 Swap Mux", "R/R", "IF1 ADC1 Mux" },
+
+	{ "IF1 ADC2 Swap Mux", "L/R", "IF1 ADC2 Mux" },
+	{ "IF1 ADC2 Swap Mux", "R/L", "IF1 ADC2 Mux" },
+	{ "IF1 ADC2 Swap Mux", "L/L", "IF1 ADC2 Mux" },
+	{ "IF1 ADC2 Swap Mux", "R/R", "IF1 ADC2 Mux" },
+
+	{ "IF1 ADC3 Swap Mux", "L/R", "IF1 ADC3 Mux" },
+	{ "IF1 ADC3 Swap Mux", "R/L", "IF1 ADC3 Mux" },
+	{ "IF1 ADC3 Swap Mux", "L/L", "IF1 ADC3 Mux" },
+	{ "IF1 ADC3 Swap Mux", "R/R", "IF1 ADC3 Mux" },
+
+	{ "IF1 ADC4 Swap Mux", "L/R", "IF1 ADC4 Mux" },
+	{ "IF1 ADC4 Swap Mux", "R/L", "IF1 ADC4 Mux" },
+	{ "IF1 ADC4 Swap Mux", "L/L", "IF1 ADC4 Mux" },
+	{ "IF1 ADC4 Swap Mux", "R/R", "IF1 ADC4 Mux" },
+
+	{ "IF1 ADC", NULL, "IF1 ADC1 Swap Mux" },
+	{ "IF1 ADC", NULL, "IF1 ADC2 Swap Mux" },
+	{ "IF1 ADC", NULL, "IF1 ADC3 Swap Mux" },
+	{ "IF1 ADC", NULL, "IF1 ADC4 Swap Mux" },
+
+	{ "IF1 ADC TDM Swap Mux", "1/2/3/4", "IF1 ADC" },
+	{ "IF1 ADC TDM Swap Mux", "2/1/3/4", "IF1 ADC" },
+	{ "IF1 ADC TDM Swap Mux", "2/3/1/4", "IF1 ADC" },
+	{ "IF1 ADC TDM Swap Mux", "4/1/2/3", "IF1 ADC" },
+	{ "IF1 ADC TDM Swap Mux", "1/3/2/4", "IF1 ADC" },
+	{ "IF1 ADC TDM Swap Mux", "1/4/2/3", "IF1 ADC" },
+	{ "IF1 ADC TDM Swap Mux", "3/1/2/4", "IF1 ADC" },
+	{ "IF1 ADC TDM Swap Mux", "3/4/1/2", "IF1 ADC" },
+
 	{ "AIF1TX", NULL, "I2S1" },
-	{ "AIF1TX", NULL, "IF1 ADC1 Mux" },
-	{ "AIF1TX", NULL, "IF1 ADC2 Mux" },
-	{ "AIF1TX", NULL, "IF1 ADC3 Mux" },
-	{ "AIF1TX", NULL, "IF1 ADC4 Mux" },
+	{ "AIF1TX", NULL, "IF1 ADC TDM Swap Mux" },
 
 	{ "IF2 ADC1 Mux", "STO1 ADC MIX", "Stereo1 ADC MIX" },
 	{ "IF2 ADC1 Mux", "OB01", "OB01 Bypass Mux" },
@@ -2642,11 +2828,42 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "IF2 ADC4 Mux", "OB67", "OB67" },
 	{ "IF2 ADC4 Mux", "OB01", "OB01 Bypass Mux" },
 
+	{ "IF2 ADC1 Swap Mux", "L/R", "IF2 ADC1 Mux" },
+	{ "IF2 ADC1 Swap Mux", "R/L", "IF2 ADC1 Mux" },
+	{ "IF2 ADC1 Swap Mux", "L/L", "IF2 ADC1 Mux" },
+	{ "IF2 ADC1 Swap Mux", "R/R", "IF2 ADC1 Mux" },
+
+	{ "IF2 ADC2 Swap Mux", "L/R", "IF2 ADC2 Mux" },
+	{ "IF2 ADC2 Swap Mux", "R/L", "IF2 ADC2 Mux" },
+	{ "IF2 ADC2 Swap Mux", "L/L", "IF2 ADC2 Mux" },
+	{ "IF2 ADC2 Swap Mux", "R/R", "IF2 ADC2 Mux" },
+
+	{ "IF2 ADC3 Swap Mux", "L/R", "IF2 ADC3 Mux" },
+	{ "IF2 ADC3 Swap Mux", "R/L", "IF2 ADC3 Mux" },
+	{ "IF2 ADC3 Swap Mux", "L/L", "IF2 ADC3 Mux" },
+	{ "IF2 ADC3 Swap Mux", "R/R", "IF2 ADC3 Mux" },
+
+	{ "IF2 ADC4 Swap Mux", "L/R", "IF2 ADC4 Mux" },
+	{ "IF2 ADC4 Swap Mux", "R/L", "IF2 ADC4 Mux" },
+	{ "IF2 ADC4 Swap Mux", "L/L", "IF2 ADC4 Mux" },
+	{ "IF2 ADC4 Swap Mux", "R/R", "IF2 ADC4 Mux" },
+
+	{ "IF2 ADC", NULL, "IF2 ADC1 Swap Mux" },
+	{ "IF2 ADC", NULL, "IF2 ADC2 Swap Mux" },
+	{ "IF2 ADC", NULL, "IF2 ADC3 Swap Mux" },
+	{ "IF2 ADC", NULL, "IF2 ADC4 Swap Mux" },
+
+	{ "IF2 ADC TDM Swap Mux", "1/2/3/4", "IF2 ADC" },
+	{ "IF2 ADC TDM Swap Mux", "2/1/3/4", "IF2 ADC" },
+	{ "IF2 ADC TDM Swap Mux", "2/3/1/4", "IF2 ADC" },
+	{ "IF2 ADC TDM Swap Mux", "4/1/2/3", "IF2 ADC" },
+	{ "IF2 ADC TDM Swap Mux", "1/3/2/4", "IF2 ADC" },
+	{ "IF2 ADC TDM Swap Mux", "1/4/2/3", "IF2 ADC" },
+	{ "IF2 ADC TDM Swap Mux", "3/1/2/4", "IF2 ADC" },
+	{ "IF2 ADC TDM Swap Mux", "3/4/1/2", "IF2 ADC" },
+
 	{ "AIF2TX", NULL, "I2S2" },
-	{ "AIF2TX", NULL, "IF2 ADC1 Mux" },
-	{ "AIF2TX", NULL, "IF2 ADC2 Mux" },
-	{ "AIF2TX", NULL, "IF2 ADC3 Mux" },
-	{ "AIF2TX", NULL, "IF2 ADC4 Mux" },
+	{ "AIF2TX", NULL, "IF2 ADC TDM Swap Mux" },
 
 	{ "IF3 ADC Mux", "STO1 ADC MIX", "Stereo1 ADC MIX" },
 	{ "IF3 ADC Mux", "STO2 ADC MIX", "Stereo2 ADC MIX" },
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 20efa4a..a0ae32f 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -799,7 +799,21 @@
 #define RT5677_PDM2_I2C_EXE			(0x1 << 1)
 #define RT5677_PDM2_I2C_BUSY			(0x1 << 0)
 
-/* MX3C TDM1 control 1 (0x3c) */
+/* MX3B TDM1 control 1 (0x3b) */
+#define RT5677_IF1_ADC_MODE_MASK		(0x1 << 12)
+#define RT5677_IF1_ADC_MODE_SFT			12
+#define RT5677_IF1_ADC_MODE_I2S			(0x0 << 12)
+#define RT5677_IF1_ADC_MODE_TDM			(0x1 << 12)
+#define RT5677_IF1_ADC1_SWAP_MASK		(0x3 << 6)
+#define RT5677_IF1_ADC1_SWAP_SFT		6
+#define RT5677_IF1_ADC2_SWAP_MASK		(0x3 << 4)
+#define RT5677_IF1_ADC2_SWAP_SFT		4
+#define RT5677_IF1_ADC3_SWAP_MASK		(0x3 << 2)
+#define RT5677_IF1_ADC3_SWAP_SFT		2
+#define RT5677_IF1_ADC4_SWAP_MASK		(0x3 << 0)
+#define RT5677_IF1_ADC4_SWAP_SFT		0
+
+/* MX3C TDM1 control 2 (0x3c) */
 #define RT5677_IF1_ADC4_MASK			(0x3 << 10)
 #define RT5677_IF1_ADC4_SFT			10
 #define RT5677_IF1_ADC3_MASK			(0x3 << 8)
@@ -808,8 +822,24 @@
 #define RT5677_IF1_ADC2_SFT			6
 #define RT5677_IF1_ADC1_MASK			(0x3 << 4)
 #define RT5677_IF1_ADC1_SFT			4
-
-/* MX41 TDM2 control 1 (0x41) */
+#define RT5677_IF1_ADC_CTRL_MASK		(0x7 << 0)
+#define RT5677_IF1_ADC_CTRL_SFT			0
+
+/* MX40 TDM2 control 1 (0x40) */
+#define RT5677_IF2_ADC_MODE_MASK		(0x1 << 12)
+#define RT5677_IF2_ADC_MODE_SFT			12
+#define RT5677_IF2_ADC_MODE_I2S			(0x0 << 12)
+#define RT5677_IF2_ADC_MODE_TDM			(0x1 << 12)
+#define RT5677_IF2_ADC1_SWAP_MASK		(0x3 << 6)
+#define RT5677_IF2_ADC1_SWAP_SFT		6
+#define RT5677_IF2_ADC2_SWAP_MASK		(0x3 << 4)
+#define RT5677_IF2_ADC2_SWAP_SFT		4
+#define RT5677_IF2_ADC3_SWAP_MASK		(0x3 << 2)
+#define RT5677_IF2_ADC3_SWAP_SFT		2
+#define RT5677_IF2_ADC4_SWAP_MASK		(0x3 << 0)
+#define RT5677_IF2_ADC4_SWAP_SFT		0
+
+/* MX41 TDM2 control 2 (0x41) */
 #define RT5677_IF2_ADC4_MASK			(0x3 << 10)
 #define RT5677_IF2_ADC4_SFT			10
 #define RT5677_IF2_ADC3_MASK			(0x3 << 8)
@@ -818,6 +848,8 @@
 #define RT5677_IF2_ADC2_SFT			6
 #define RT5677_IF2_ADC1_MASK			(0x3 << 4)
 #define RT5677_IF2_ADC1_SFT			4
+#define RT5677_IF2_ADC_CTRL_MASK		(0x7 << 0)
+#define RT5677_IF2_ADC_CTRL_SFT			0
 
 /* Digital Microphone Control 1 (0x50) */
 #define RT5677_DMIC_1_EN_MASK			(0x1 << 15)
-- 
1.8.1.1.439.g50a6b54
