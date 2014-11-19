From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5677: Set the slow charge of the
	vref in the end of the power sequences
Date: Wed, 19 Nov 2014 13:52:20 +0800
Message-ID: <1416376340-4789-3-git-send-email-oder_chiou@realtek.com>
References: <1416376340-4789-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EE5C265456
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 06:53:05 +0100 (CET)
In-Reply-To: <1416376340-4789-1-git-send-email-oder_chiou@realtek.com>
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

Set the slow charge of the vref in the end of the power sequences

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 56 ++++++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/rt5677.h |  1 +
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index dd080cd..f2211f1 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -2184,6 +2184,31 @@ static int rt5677_if2_adc_tdm_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5677_vref_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (codec->dapm.bias_level != SND_SOC_BIAS_ON &&
+			!rt5677->is_vref_slow) {
+			mdelay(20);
+			regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
+				RT5677_PWR_FV1 | RT5677_PWR_FV2,
+				RT5677_PWR_FV1 | RT5677_PWR_FV2);
+			rt5677->is_vref_slow = true;
+		}
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
@@ -2669,13 +2694,20 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("PDM2 R Mux", RT5677_PDM_OUT_CTRL, RT5677_M_PDM2_R_SFT,
 		1, &rt5677_pdm2_r_mux),
 
-	SND_SOC_DAPM_PGA_S("LOUT1 amp", 1, RT5677_PWR_ANLG1, RT5677_PWR_LO1_BIT,
+	SND_SOC_DAPM_PGA_S("LOUT1 amp", 0, RT5677_PWR_ANLG1, RT5677_PWR_LO1_BIT,
 		0, NULL, 0),
-	SND_SOC_DAPM_PGA_S("LOUT2 amp", 1, RT5677_PWR_ANLG1, RT5677_PWR_LO2_BIT,
+	SND_SOC_DAPM_PGA_S("LOUT2 amp", 0, RT5677_PWR_ANLG1, RT5677_PWR_LO2_BIT,
 		0, NULL, 0),
-	SND_SOC_DAPM_PGA_S("LOUT3 amp", 1, RT5677_PWR_ANLG1, RT5677_PWR_LO3_BIT,
+	SND_SOC_DAPM_PGA_S("LOUT3 amp", 0, RT5677_PWR_ANLG1, RT5677_PWR_LO3_BIT,
 		0, NULL, 0),
 
+	SND_SOC_DAPM_PGA_S("LOUT1 vref", 1, SND_SOC_NOPM, 0, 0,
+		rt5677_vref_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("LOUT2 vref", 1, SND_SOC_NOPM, 0, 0,
+		rt5677_vref_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_PGA_S("LOUT3 vref", 1, SND_SOC_NOPM, 0, 0,
+		rt5677_vref_event, SND_SOC_DAPM_POST_PMU),
+
 	/* Output Lines */
 	SND_SOC_DAPM_OUTPUT("LOUT1"),
 	SND_SOC_DAPM_OUTPUT("LOUT2"),
@@ -2684,6 +2716,8 @@ static const struct snd_soc_dapm_widget rt5677_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("PDM1R"),
 	SND_SOC_DAPM_OUTPUT("PDM2L"),
 	SND_SOC_DAPM_OUTPUT("PDM2R"),
+
+	SND_SOC_DAPM_POST("vref", rt5677_vref_event),
 };
 
 static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
@@ -3572,9 +3606,13 @@ static const struct snd_soc_dapm_route rt5677_dapm_routes[] = {
 	{ "LOUT2 amp", NULL, "DAC 2" },
 	{ "LOUT3 amp", NULL, "DAC 3" },
 
-	{ "LOUT1", NULL, "LOUT1 amp" },
-	{ "LOUT2", NULL, "LOUT2 amp" },
-	{ "LOUT3", NULL, "LOUT3 amp" },
+	{ "LOUT1 vref", NULL, "LOUT1 amp" },
+	{ "LOUT2 vref", NULL, "LOUT2 amp" },
+	{ "LOUT3 vref", NULL, "LOUT3 amp" },
+
+	{ "LOUT1", NULL, "LOUT1 vref" },
+	{ "LOUT2", NULL, "LOUT2 vref" },
+	{ "LOUT3", NULL, "LOUT3 vref" },
 
 	{ "PDM1L", NULL, "PDM1 L Mux" },
 	{ "PDM1R", NULL, "PDM1 R Mux" },
@@ -3957,14 +3995,12 @@ static int rt5677_set_bias_level(struct snd_soc_codec *codec,
 				RT5677_PR_BASE + RT5677_BIAS_CUR4,
 				0x0f00, 0x0f00);
 			regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
+				RT5677_PWR_FV1 | RT5677_PWR_FV2 |
 				RT5677_PWR_VREF1 | RT5677_PWR_MB |
 				RT5677_PWR_BG | RT5677_PWR_VREF2,
 				RT5677_PWR_VREF1 | RT5677_PWR_MB |
 				RT5677_PWR_BG | RT5677_PWR_VREF2);
-			mdelay(20);
-			regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG1,
-				RT5677_PWR_FV1 | RT5677_PWR_FV2,
-				RT5677_PWR_FV1 | RT5677_PWR_FV2);
+			rt5677->is_vref_slow = false;
 			regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
 				RT5677_PWR_CORE, RT5677_PWR_CORE);
 			regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC,
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 2979d5a..a02f64c 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1687,6 +1687,7 @@ struct rt5677_priv {
 	bool dsp_vad_en;
 	struct regmap_irq_chip_data *irq_data;
 	bool is_dsp_mode;
+	bool is_vref_slow;
 };
 
 #endif /* __RT5677_H__ */
-- 
1.8.1.1.439.g50a6b54
