From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: reduce power consumption
Date: Fri, 31 Oct 2014 14:52:16 +0800
Message-ID: <1414738336-17371-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AB9926068C
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 07:52:44 +0100 (CET)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch will optimize the power consumption of rt286.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 211 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 155 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 4aa555c..97daa80 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -36,11 +36,13 @@
 
 struct rt286_priv {
 	struct regmap *regmap;
+	struct snd_soc_codec *codec;
 	struct rt286_platform_data pdata;
 	struct i2c_client *i2c;
 	struct snd_soc_jack *jack;
 	struct delayed_work jack_detect_work;
 	int sys_clk;
+	int clk_id;
 	struct reg_default *index_cache;
 };
 
@@ -298,7 +300,6 @@ static int rt286_support_power_controls[] = {
 static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 {
 	unsigned int val, buf;
-	int i;
 
 	*hp = false;
 	*mic = false;
@@ -309,67 +310,44 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 		if (*hp) {
 			/* power on HV,VERF */
 			regmap_update_bits(rt286->regmap,
-				RT286_POWER_CTRL1, 0x1001, 0x0);
+				RT286_DC_GAIN, 0x200, 0x200);
+
+			snd_soc_dapm_force_enable_pin(&rt286->codec->dapm,
+							"HV");
+			snd_soc_dapm_force_enable_pin(&rt286->codec->dapm,
+							"VREF");
 			/* power LDO1 */
-			regmap_update_bits(rt286->regmap,
-				RT286_POWER_CTRL2, 0x4, 0x4);
-			regmap_write(rt286->regmap, RT286_SET_MIC1, 0x24);
-			regmap_read(rt286->regmap, RT286_CBJ_CTRL2, &val);
+			snd_soc_dapm_force_enable_pin(&rt286->codec->dapm,
+							"LDO1");
+			snd_soc_dapm_sync(&rt286->codec->dapm);
 
-			msleep(200);
-			i = 40;
-			while (((val & 0x0800) == 0) && (i > 0)) {
-				regmap_read(rt286->regmap,
-					RT286_CBJ_CTRL2, &val);
-				i--;
-				msleep(20);
-			}
+			regmap_write(rt286->regmap, RT286_SET_MIC1, 0x24);
+			msleep(50);
 
-			if (0x0400 == (val & 0x0700)) {
-				*mic = false;
+			regmap_update_bits(rt286->regmap,
+				RT286_CBJ_CTRL1, 0xfcc0, 0xd400);
+			msleep(300);
+			regmap_read(rt286->regmap, RT286_CBJ_CTRL2, &val);
 
-				regmap_write(rt286->regmap,
-					RT286_SET_MIC1, 0x20);
-				/* power off HV,VERF */
-				regmap_update_bits(rt286->regmap,
-					RT286_POWER_CTRL1, 0x1001, 0x1001);
-				regmap_update_bits(rt286->regmap,
-					RT286_A_BIAS_CTRL3, 0xc000, 0x0000);
-				regmap_update_bits(rt286->regmap,
-					RT286_CBJ_CTRL1, 0x0030, 0x0000);
-				regmap_update_bits(rt286->regmap,
-					RT286_A_BIAS_CTRL2, 0xc000, 0x0000);
-			} else if ((0x0200 == (val & 0x0700)) ||
-				(0x0100 == (val & 0x0700))) {
+			if (0x0070 == (val & 0x0070)) {
 				*mic = true;
-				regmap_update_bits(rt286->regmap,
-					RT286_A_BIAS_CTRL3, 0xc000, 0x8000);
-				regmap_update_bits(rt286->regmap,
-					RT286_CBJ_CTRL1, 0x0030, 0x0020);
-				regmap_update_bits(rt286->regmap,
-					RT286_A_BIAS_CTRL2, 0xc000, 0x8000);
 			} else {
-				*mic = false;
+				regmap_update_bits(rt286->regmap,
+					RT286_CBJ_CTRL1, 0xfcc0, 0xe400);
+				msleep(300);
+				regmap_read(rt286->regmap,
+					RT286_CBJ_CTRL2, &val);
+				if (0x0070 == (val & 0x0070))
+					*mic = true;
+				else
+					*mic = false;
 			}
-
-			regmap_update_bits(rt286->regmap,
-						RT286_MISC_CTRL1,
-						0x0060, 0x0000);
-		} else {
-			regmap_update_bits(rt286->regmap,
-						RT286_MISC_CTRL1,
-						0x0060, 0x0020);
-			regmap_update_bits(rt286->regmap,
-						RT286_A_BIAS_CTRL3,
-						0xc000, 0x8000);
 			regmap_update_bits(rt286->regmap,
-						RT286_CBJ_CTRL1,
-						0x0030, 0x0020);
-			regmap_update_bits(rt286->regmap,
-						RT286_A_BIAS_CTRL2,
-						0xc000, 0x8000);
+				RT286_DC_GAIN, 0x200, 0x0);
 
+		} else {
 			*mic = false;
+			regmap_write(rt286->regmap, RT286_SET_MIC1, 0x20);
 		}
 	} else {
 		regmap_read(rt286->regmap, RT286_GET_HP_SENSE, &buf);
@@ -378,6 +356,12 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 		*mic = buf & 0x80000000;
 	}
 
+	snd_soc_dapm_disable_pin(&rt286->codec->dapm, "HV");
+	snd_soc_dapm_disable_pin(&rt286->codec->dapm, "VREF");
+	if (!*hp)
+		snd_soc_dapm_disable_pin(&rt286->codec->dapm, "LDO1");
+	snd_soc_dapm_sync(&rt286->codec->dapm);
+
 	return 0;
 }
 
@@ -415,6 +399,17 @@ int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 }
 EXPORT_SYMBOL_GPL(rt286_mic_detect);
 
+static int is_mclk_mode(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(source->codec);
+
+	if (rt286->clk_id == RT286_SCLK_S_MCLK)
+		return 1;
+	else
+		return 0;
+}
+
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -6350, 50, 0);
 static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
 
@@ -568,7 +563,84 @@ static int rt286_adc_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt286_vref_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec,
+			RT286_CBJ_CTRL1, 0x0400, 0x0000);
+		mdelay(50);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt286_ldo2_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		snd_soc_update_bits(codec, RT286_POWER_CTRL2, 0x38, 0x08);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_update_bits(codec, RT286_POWER_CTRL2, 0x38, 0x30);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt286_mic1_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = w->codec;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec,
+			RT286_A_BIAS_CTRL3, 0xc000, 0x8000);
+		snd_soc_update_bits(codec,
+			RT286_A_BIAS_CTRL2, 0xc000, 0x8000);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec,
+			RT286_A_BIAS_CTRL3, 0xc000, 0x0000);
+		snd_soc_update_bits(codec,
+			RT286_A_BIAS_CTRL2, 0xc000, 0x0000);
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt286_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY_S("HV", 1, RT286_POWER_CTRL1,
+		12, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("VREF", RT286_POWER_CTRL1,
+		0, 1, rt286_vref_event, SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY_S("LDO1", 1, RT286_POWER_CTRL2,
+		2, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("LDO2", 2, RT286_POWER_CTRL1,
+		13, 1, rt286_ldo2_event, SND_SOC_DAPM_PRE_PMD |
+		SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_SUPPLY("MCLK MODE", RT286_PLL_CTRL1,
+		5, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MIC1 Input Buffer", SND_SOC_NOPM,
+		0, 0, rt286_mic1_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
+
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC1 Pin"),
 	SND_SOC_DAPM_INPUT("DMIC2 Pin"),
@@ -642,6 +714,25 @@ static const struct snd_soc_dapm_widget rt286_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route rt286_dapm_routes[] = {
+	{"ADC 0", NULL, "MCLK MODE", is_mclk_mode},
+	{"ADC 1", NULL, "MCLK MODE", is_mclk_mode},
+	{"Front", NULL, "MCLK MODE", is_mclk_mode},
+	{"Surround", NULL, "MCLK MODE", is_mclk_mode},
+
+	{"HP Power", NULL, "LDO1"},
+	{"HP Power", NULL, "LDO2"},
+
+	{"MIC1", NULL, "LDO1"},
+	{"MIC1", NULL, "LDO2"},
+	{"MIC1", NULL, "HV"},
+	{"MIC1", NULL, "VREF"},
+	{"MIC1", NULL, "MIC1 Input Buffer"},
+
+	{"SPO", NULL, "LDO1"},
+	{"SPO", NULL, "LDO2"},
+	{"SPO", NULL, "HV"},
+	{"SPO", NULL, "VREF"},
+
 	{"DMIC1", NULL, "DMIC1 Pin"},
 	{"DMIC2", NULL, "DMIC2 Pin"},
 	{"DMIC1", NULL, "DMIC Receiver"},
@@ -880,6 +971,7 @@ static int rt286_set_dai_sysclk(struct snd_soc_dai *dai,
 	}
 
 	rt286->sys_clk = freq;
+	rt286->clk_id = clk_id;
 
 	return 0;
 }
@@ -915,13 +1007,18 @@ static int rt286_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_ON:
 		mdelay(10);
+		snd_soc_update_bits(codec,
+			RT286_CBJ_CTRL1, 0x0400, 0x0400);
+		snd_soc_update_bits(codec,
+			RT286_DC_GAIN, 0x200, 0x0);
+
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		snd_soc_write(codec,
 			RT286_SET_AUDIO_POWER, AC_PWRST_D3);
 		snd_soc_update_bits(codec,
-			RT286_DC_GAIN, 0x200, 0x0);
+			RT286_CBJ_CTRL1, 0x0400, 0x0000);
 		break;
 
 	default:
@@ -962,6 +1059,7 @@ static int rt286_probe(struct snd_soc_codec *codec)
 {
 	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
 
+	rt286->codec = codec;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 
 	if (rt286->i2c->irq) {
@@ -1152,7 +1250,6 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	if (!rt286->pdata.cbj_en) {
 		regmap_write(rt286->regmap, RT286_CBJ_CTRL2, 0x0000);
 		regmap_write(rt286->regmap, RT286_MIC1_DET_CTRL, 0x0816);
-		regmap_write(rt286->regmap, RT286_MISC_CTRL1, 0x0000);
 		regmap_update_bits(rt286->regmap,
 					RT286_CBJ_CTRL1, 0xf000, 0xb000);
 	} else {
@@ -1169,8 +1266,10 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 
 	mdelay(10);
 
-	/*Power down LDO2*/
-	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL2, 0x8, 0x0);
+	regmap_write(rt286->regmap, RT286_MISC_CTRL1, 0x0000);
+	/*Power down LDO, VREF*/
+	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL2, 0xc, 0x0);
+	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL1, 0x1001, 0x1001);
 
 	/*Set depop parameter*/
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL2, 0x403a, 0x401a);
-- 
1.8.1.1.439.g50a6b54
