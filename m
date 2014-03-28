From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5640: Use the platform data for DMIC
	settings
Date: Fri, 28 Mar 2014 10:46:18 +0800
Message-ID: <1395974778-4217-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AE5B82619E9
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 03:46:40 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch uses the platform data for DMIC settings.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 include/sound/rt5640.h    |  4 +++
 sound/soc/codecs/rt5640.c | 77 ++++++++++++++---------------------------------
 2 files changed, 27 insertions(+), 54 deletions(-)

diff --git a/include/sound/rt5640.h b/include/sound/rt5640.h
index 27cc75e..59d26dd 100644
--- a/include/sound/rt5640.h
+++ b/include/sound/rt5640.h
@@ -16,6 +16,10 @@ struct rt5640_platform_data {
 	bool in1_diff;
 	bool in2_diff;
 
+	bool dmic_en;
+	bool dmic1_data_pin; /* 0 = IN1P; 1 = GPIO3 */
+	bool dmic2_data_pin; /* 0 = IN1N; 1 = GPIO4 */
+
 	int ldo1_en; /* GPIO for LDO1_EN */
 };
 
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index bcd6513..cf041e3 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -872,54 +872,6 @@ static SOC_ENUM_SINGLE_DECL(rt5640_sdi_sel_enum, RT5640_I2S2_SDP,
 static const struct snd_kcontrol_new rt5640_sdi_mux =
 	SOC_DAPM_ENUM("SDI select", rt5640_sdi_sel_enum);
 
-static int rt5640_set_dmic1_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec, RT5640_GPIO_CTRL1,
-			RT5640_GP2_PIN_MASK | RT5640_GP3_PIN_MASK,
-			RT5640_GP2_PIN_DMIC1_SCL | RT5640_GP3_PIN_DMIC1_SDA);
-		snd_soc_update_bits(codec, RT5640_DMIC,
-			RT5640_DMIC_1L_LH_MASK | RT5640_DMIC_1R_LH_MASK |
-			RT5640_DMIC_1_DP_MASK,
-			RT5640_DMIC_1L_LH_FALLING | RT5640_DMIC_1R_LH_RISING |
-			RT5640_DMIC_1_DP_IN1P);
-		break;
-
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
-static int rt5640_set_dmic2_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec, RT5640_GPIO_CTRL1,
-			RT5640_GP2_PIN_MASK | RT5640_GP4_PIN_MASK,
-			RT5640_GP2_PIN_DMIC1_SCL | RT5640_GP4_PIN_DMIC2_SDA);
-		snd_soc_update_bits(codec, RT5640_DMIC,
-			RT5640_DMIC_2L_LH_MASK | RT5640_DMIC_2R_LH_MASK |
-			RT5640_DMIC_2_DP_MASK,
-			RT5640_DMIC_2L_LH_FALLING | RT5640_DMIC_2R_LH_RISING |
-			RT5640_DMIC_2_DP_IN1N);
-		break;
-
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
 static void hp_amp_power_on(struct snd_soc_codec *codec)
 {
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
@@ -1054,12 +1006,10 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 
 	SND_SOC_DAPM_SUPPLY("DMIC CLK", SND_SOC_NOPM, 0, 0,
 		set_dmic_clk, SND_SOC_DAPM_PRE_PMU),
-	SND_SOC_DAPM_SUPPLY("DMIC1 Power", RT5640_DMIC,
-		RT5640_DMIC_1_EN_SFT, 0, rt5640_set_dmic1_event,
-		SND_SOC_DAPM_PRE_PMU),
-	SND_SOC_DAPM_SUPPLY("DMIC2 Power", RT5640_DMIC,
-		RT5640_DMIC_2_EN_SFT, 0, rt5640_set_dmic2_event,
-		SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY("DMIC1 Power", RT5640_DMIC, RT5640_DMIC_1_EN_SFT, 0,
+		NULL, 0),
+	SND_SOC_DAPM_SUPPLY("DMIC2 Power", RT5640_DMIC, RT5640_DMIC_2_EN_SFT, 0,
+		NULL, 0),
 	/* Boost */
 	SND_SOC_DAPM_PGA("BST1", RT5640_PWR_ANLG2,
 		RT5640_PWR_BST1_BIT, 0, NULL, 0),
@@ -2179,6 +2129,25 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5640->regmap, RT5640_IN3_IN4,
 					RT5640_IN_DF2, RT5640_IN_DF2);
 
+	if (rt5640->pdata.dmic_en) {
+		regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
+			RT5640_GP2_PIN_MASK, RT5640_GP2_PIN_DMIC1_SCL);
+
+		if (rt5640->pdata.dmic1_data_pin) {
+			regmap_update_bits(rt5640->regmap, RT5640_DMIC,
+				RT5640_DMIC_1_DP_MASK, RT5640_DMIC_1_DP_GPIO3);
+			regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
+				RT5640_GP3_PIN_MASK, RT5640_GP3_PIN_DMIC1_SDA);
+		}
+
+		if (rt5640->pdata.dmic2_data_pin) {
+			regmap_update_bits(rt5640->regmap, RT5640_DMIC,
+				RT5640_DMIC_2_DP_MASK, RT5640_DMIC_2_DP_GPIO4);
+			regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
+				RT5640_GP4_PIN_MASK, RT5640_GP4_PIN_DMIC2_SDA);
+		}
+	}
+
 	rt5640->hp_mute = 1;
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
-- 
1.8.1.1.439.g50a6b54
