From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: Add rt5650 codec support
Date: Wed, 21 Jan 2015 20:50:15 +0800
Message-ID: <1421844615-2503-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0117F2605D7
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 13:51:03 +0100 (CET)
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

This patch adds support for rt5650 codec.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 158 +++++++++++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/rt5645.h |  15 +++++
 2 files changed, 156 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 6e9cd8e..306db11 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -31,6 +31,7 @@
 #include "rt5645.h"
 
 #define RT5645_DEVICE_ID 0x6308
+#define RT5650_DEVICE_ID 0x6419
 
 #define RT5645_PR_RANGE_BASE (0xff + 1)
 #define RT5645_PR_SPACING 0x100
@@ -59,6 +60,10 @@ static const struct reg_default init_list[] = {
 };
 #define RT5645_INIT_REG_LEN ARRAY_SIZE(init_list)
 
+static const struct reg_default rt5650_init_list[] = {
+	{0xf6,	0x0100},
+};
+
 static const struct reg_default rt5645_reg[] = {
 	{ 0x00, 0x0000 },
 	{ 0x01, 0xc8c8 },
@@ -86,6 +91,7 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0x2a, 0x5656 },
 	{ 0x2b, 0x5454 },
 	{ 0x2c, 0xaaa0 },
+	{ 0x2d, 0x0000 },
 	{ 0x2f, 0x1002 },
 	{ 0x31, 0x5000 },
 	{ 0x32, 0x0000 },
@@ -192,6 +198,8 @@ static const struct reg_default rt5645_reg[] = {
 	{ 0xdb, 0x0003 },
 	{ 0xdc, 0x0049 },
 	{ 0xdd, 0x001b },
+	{ 0xdf, 0x0008 },
+	{ 0xe0, 0x4000 },
 	{ 0xe6, 0x8000 },
 	{ 0xe7, 0x0200 },
 	{ 0xec, 0xb300 },
@@ -241,6 +249,7 @@ static bool rt5645_volatile_register(struct device *dev, unsigned int reg)
 	case RT5645_IRQ_CTRL3:
 	case RT5645_INT_IRQ_ST:
 	case RT5645_IL_CMD:
+	case RT5650_4BTN_IL_CMD1:
 	case RT5645_VENDOR_ID:
 	case RT5645_VENDOR_ID1:
 	case RT5645_VENDOR_ID2:
@@ -286,6 +295,7 @@ static bool rt5645_readable_register(struct device *dev, unsigned int reg)
 	case RT5645_STO_DAC_MIXER:
 	case RT5645_MONO_DAC_MIXER:
 	case RT5645_DIG_MIXER:
+	case RT5650_A_DAC_SOUR:
 	case RT5645_DIG_INF1_DATA:
 	case RT5645_PDM_OUT_CTRL:
 	case RT5645_REC_L1_MIXER:
@@ -376,6 +386,8 @@ static bool rt5645_readable_register(struct device *dev, unsigned int reg)
 	case RT5645_IL_CMD:
 	case RT5645_IL_CMD2:
 	case RT5645_IL_CMD3:
+	case RT5650_4BTN_IL_CMD1:
+	case RT5650_4BTN_IL_CMD2:
 	case RT5645_DRC1_HL_CTRL1:
 	case RT5645_DRC2_HL_CTRL1:
 	case RT5645_ADC_MONO_HP_CTRL1:
@@ -1005,6 +1017,44 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new rt5645_if1_adc_in_mux =
 	SOC_DAPM_ENUM("IF1 ADC IN source", rt5645_if1_adc_in_enum);
 
+/* MX-2d [3] [2] */
+static const char * const rt5650_a_dac1_src[] = {
+	"DAC1", "Stereo DAC Mixer"
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5650_a_dac1_l_enum, RT5650_A_DAC_SOUR,
+	RT5650_A_DAC1_L_IN_SFT, rt5650_a_dac1_src);
+
+static const struct snd_kcontrol_new rt5650_a_dac1_l_mux =
+	SOC_DAPM_ENUM("A DAC1 L source", rt5650_a_dac1_l_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5650_a_dac1_r_enum, RT5650_A_DAC_SOUR,
+	RT5650_A_DAC1_R_IN_SFT, rt5650_a_dac1_src);
+
+static const struct snd_kcontrol_new rt5650_a_dac1_r_mux =
+	SOC_DAPM_ENUM("A DAC1 R source", rt5650_a_dac1_r_enum);
+
+/* MX-2d [1] [0] */
+static const char * const rt5650_a_dac2_src[] = {
+	"Stereo DAC Mixer", "Mono DAC Mixer"
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5650_a_dac2_l_enum, RT5650_A_DAC_SOUR,
+	RT5650_A_DAC2_L_IN_SFT, rt5650_a_dac2_src);
+
+static const struct snd_kcontrol_new rt5650_a_dac2_l_mux =
+	SOC_DAPM_ENUM("A DAC2 L source", rt5650_a_dac2_l_enum);
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5650_a_dac2_r_enum, RT5650_A_DAC_SOUR,
+	RT5650_A_DAC2_R_IN_SFT, rt5650_a_dac2_src);
+
+static const struct snd_kcontrol_new rt5650_a_dac2_r_mux =
+	SOC_DAPM_ENUM("A DAC2 R source", rt5650_a_dac2_r_enum);
+
 /* MX-2F [13:12] */
 static const char * const rt5645_if2_adc_in_src[] = {
 	"IF_ADC1", "IF_ADC2", "VAD_ADC"
@@ -1149,11 +1199,16 @@ static int rt5645_hp_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		hp_amp_power(codec, 1);
 		/* headphone unmute sequence */
-		snd_soc_update_bits(codec, RT5645_DEPOP_M3, RT5645_CP_FQ1_MASK |
-			RT5645_CP_FQ2_MASK | RT5645_CP_FQ3_MASK,
-			(RT5645_CP_FQ_192_KHZ << RT5645_CP_FQ1_SFT) |
-			(RT5645_CP_FQ_12_KHZ << RT5645_CP_FQ2_SFT) |
-			(RT5645_CP_FQ_192_KHZ << RT5645_CP_FQ3_SFT));
+		if (rt5645->codec_type == CODEC_TYPE_RT5650) {
+			snd_soc_write(codec, RT5645_DEPOP_M3, 0x0737);
+		} else {
+			snd_soc_update_bits(codec, RT5645_DEPOP_M3,
+				RT5645_CP_FQ1_MASK | RT5645_CP_FQ2_MASK |
+				RT5645_CP_FQ3_MASK,
+				(RT5645_CP_FQ_192_KHZ << RT5645_CP_FQ1_SFT) |
+				(RT5645_CP_FQ_12_KHZ << RT5645_CP_FQ2_SFT) |
+				(RT5645_CP_FQ_192_KHZ << RT5645_CP_FQ3_SFT));
+		}
 		regmap_write(rt5645->regmap,
 			RT5645_PR_BASE + RT5645_MAMP_INT_REG2, 0xfc00);
 		snd_soc_update_bits(codec, RT5645_DEPOP_M1,
@@ -1173,12 +1228,16 @@ static int rt5645_hp_event(struct snd_soc_dapm_widget *w,
 
 	case SND_SOC_DAPM_PRE_PMD:
 		/* headphone mute sequence */
-		snd_soc_update_bits(codec, RT5645_DEPOP_M3,
-			RT5645_CP_FQ1_MASK | RT5645_CP_FQ2_MASK |
-			RT5645_CP_FQ3_MASK,
-			(RT5645_CP_FQ_96_KHZ << RT5645_CP_FQ1_SFT) |
-			(RT5645_CP_FQ_12_KHZ << RT5645_CP_FQ2_SFT) |
-			(RT5645_CP_FQ_96_KHZ << RT5645_CP_FQ3_SFT));
+		if (rt5645->codec_type == CODEC_TYPE_RT5650) {
+			snd_soc_write(codec, RT5645_DEPOP_M3, 0x0737);
+		} else {
+			snd_soc_update_bits(codec, RT5645_DEPOP_M3,
+				RT5645_CP_FQ1_MASK | RT5645_CP_FQ2_MASK |
+				RT5645_CP_FQ3_MASK,
+				(RT5645_CP_FQ_96_KHZ << RT5645_CP_FQ1_SFT) |
+				(RT5645_CP_FQ_12_KHZ << RT5645_CP_FQ2_SFT) |
+				(RT5645_CP_FQ_96_KHZ << RT5645_CP_FQ3_SFT));
+		}
 		regmap_write(rt5645->regmap,
 			RT5645_PR_BASE + RT5645_MAMP_INT_REG2, 0xfc00);
 		snd_soc_update_bits(codec, RT5645_DEPOP_M1,
@@ -1572,6 +1631,17 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("SPOR"),
 };
 
+static const struct snd_soc_dapm_widget rt5650_specific_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("A DAC1 L Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_a_dac1_l_mux),
+	SND_SOC_DAPM_MUX("A DAC1 R Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_a_dac1_r_mux),
+	SND_SOC_DAPM_MUX("A DAC2 L Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_a_dac2_l_mux),
+	SND_SOC_DAPM_MUX("A DAC2 R Mux", SND_SOC_NOPM,
+		0, 0, &rt5650_a_dac2_r_mux),
+};
+
 static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 	{ "adc stereo1 filter", NULL, "ADC STO1 ASRC", is_using_asrc },
 	{ "adc stereo2 filter", NULL, "ADC STO2 ASRC", is_using_asrc },
@@ -1777,13 +1847,9 @@ static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 	{ "DAC MIXR", "DAC R2 Switch", "DAC R2 Volume" },
 	{ "DAC MIXR", "DAC L2 Switch", "DAC L2 Volume" },
 
-	{ "DAC L1", NULL, "Stereo DAC MIXL" },
 	{ "DAC L1", NULL, "PLL1", is_sys_clk_from_pll },
-	{ "DAC R1", NULL, "Stereo DAC MIXR" },
 	{ "DAC R1", NULL, "PLL1", is_sys_clk_from_pll },
-	{ "DAC L2", NULL, "Mono DAC MIXL" },
 	{ "DAC L2", NULL, "PLL1", is_sys_clk_from_pll },
-	{ "DAC R2", NULL, "Mono DAC MIXR" },
 	{ "DAC R2", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "SPK MIXL", "BST1 Switch", "BST1" },
@@ -1872,6 +1938,30 @@ static const struct snd_soc_dapm_route rt5645_dapm_routes[] = {
 	{ "SPOR", NULL, "SPK amp" },
 };
 
+static const struct snd_soc_dapm_route rt5650_specific_dapm_routes[] = {
+	{ "A DAC1 L Mux", "DAC1",  "DAC1 MIXL"},
+	{ "A DAC1 L Mux", "Stereo DAC Mixer", "Stereo DAC MIXL"},
+	{ "A DAC1 R Mux", "DAC1",  "DAC1 MIXR"},
+	{ "A DAC1 R Mux", "Stereo DAC Mixer", "Stereo DAC MIXR"},
+
+	{ "A DAC2 L Mux", "Stereo DAC Mixer", "Stereo DAC MIXL"},
+	{ "A DAC2 L Mux", "Mono DAC Mixer", "Mono DAC MIXL"},
+	{ "A DAC2 R Mux", "Stereo DAC Mixer", "Stereo DAC MIXR"},
+	{ "A DAC2 R Mux", "Mono DAC Mixer", "Mono DAC MIXR"},
+
+	{ "DAC L1", NULL, "A DAC1 L Mux" },
+	{ "DAC R1", NULL, "A DAC1 R Mux" },
+	{ "DAC L2", NULL, "A DAC2 L Mux" },
+	{ "DAC R2", NULL, "A DAC2 R Mux" },
+};
+
+static const struct snd_soc_dapm_route rt5645_specific_dapm_routes[] = {
+	{ "DAC L1", NULL, "Stereo DAC MIXL" },
+	{ "DAC R1", NULL, "Stereo DAC MIXR" },
+	{ "DAC L2", NULL, "Mono DAC MIXL" },
+	{ "DAC R2", NULL, "Mono DAC MIXR" },
+};
+
 static int rt5645_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -2287,6 +2377,22 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 
 	rt5645->codec = codec;
 
+	switch (rt5645->codec_type) {
+	case CODEC_TYPE_RT5645:
+		snd_soc_dapm_add_routes(&codec->dapm,
+			rt5645_specific_dapm_routes,
+			ARRAY_SIZE(rt5645_specific_dapm_routes));
+		break;
+	case CODEC_TYPE_RT5650:
+		snd_soc_dapm_new_controls(&codec->dapm,
+			rt5650_specific_dapm_widgets,
+			ARRAY_SIZE(rt5650_specific_dapm_widgets));
+		snd_soc_dapm_add_routes(&codec->dapm,
+			rt5650_specific_dapm_routes,
+			ARRAY_SIZE(rt5650_specific_dapm_routes));
+		break;
+	}
+
 	rt5645_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
@@ -2418,6 +2524,7 @@ static const struct regmap_config rt5645_regmap = {
 
 static const struct i2c_device_id rt5645_i2c_id[] = {
 	{ "rt5645", 0 },
+	{ "rt5650", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
@@ -2450,9 +2557,18 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	}
 
 	regmap_read(rt5645->regmap, RT5645_VENDOR_ID2, &val);
-	if (val != RT5645_DEVICE_ID) {
+
+	switch (val) {
+	case RT5645_DEVICE_ID:
+		rt5645->codec_type = CODEC_TYPE_RT5645;
+		break;
+	case RT5650_DEVICE_ID:
+		rt5645->codec_type = CODEC_TYPE_RT5650;
+		break;
+	default:
 		dev_err(&i2c->dev,
-			"Device with ID register %x is not rt5645\n", val);
+			"Device with ID register %x is not rt5645 or rt5650\n",
+			val);
 		return -ENODEV;
 	}
 
@@ -2463,6 +2579,14 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
+	if (rt5645->codec_type == CODEC_TYPE_RT5650) {
+		ret = regmap_register_patch(rt5645->regmap, rt5650_init_list,
+				    ARRAY_SIZE(rt5650_init_list));
+		if (ret != 0)
+			dev_warn(&i2c->dev, "Apply rt5650 patch failed: %d\n",
+					   ret);
+	}
+
 	if (rt5645->pdata.in2_diff)
 		regmap_update_bits(rt5645->regmap, RT5645_IN2_CTRL,
 					RT5645_IN_DF2, RT5645_IN_DF2);
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index a815e36..7454231 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -47,6 +47,7 @@
 #define RT5645_STO_DAC_MIXER			0x2a
 #define RT5645_MONO_DAC_MIXER			0x2b
 #define RT5645_DIG_MIXER			0x2c
+#define RT5650_A_DAC_SOUR			0x2d
 #define RT5645_DIG_INF1_DATA			0x2f
 /* Mixer - PDM */
 #define RT5645_PDM_OUT_CTRL			0x31
@@ -150,6 +151,8 @@
 #define RT5645_IL_CMD				0xdb
 #define RT5645_IL_CMD2				0xdc
 #define RT5645_IL_CMD3				0xdd
+#define RT5650_4BTN_IL_CMD1			0xdf
+#define RT5650_4BTN_IL_CMD2			0xe0
 #define RT5645_DRC1_HL_CTRL1			0xe7
 #define RT5645_DRC2_HL_CTRL1			0xe9
 #define RT5645_MUTI_DRC_CTRL1			0xea
@@ -472,6 +475,12 @@
 #define RT5645_DAC_L2_DAC_R_VOL_MASK		(0x1 << 4)
 #define RT5645_DAC_L2_DAC_R_VOL_SFT		4
 
+/* Analog DAC1/2 Input Source Control (0x2d) */
+#define RT5650_A_DAC1_L_IN_SFT			3
+#define RT5650_A_DAC1_R_IN_SFT			2
+#define RT5650_A_DAC2_L_IN_SFT			1
+#define RT5650_A_DAC2_R_IN_SFT			0
+
 /* Digital Interface Data Control (0x2f) */
 #define RT5645_IF1_ADC2_IN_SEL			(0x1 << 15)
 #define RT5645_IF1_ADC2_IN_SFT			15
@@ -2175,6 +2184,11 @@ enum {
 	RT5645_DMIC_DATA_GPIO11,
 };
 
+enum {
+	CODEC_TYPE_RT5645,
+	CODEC_TYPE_RT5650,
+};
+
 struct rt5645_priv {
 	struct snd_soc_codec *codec;
 	struct rt5645_platform_data pdata;
@@ -2184,6 +2198,7 @@ struct rt5645_priv {
 	struct snd_soc_jack *mic_jack;
 	struct delayed_work jack_detect_work;
 
+	int codec_type;
 	int sysclk;
 	int sysclk_src;
 	int lrck[RT5645_AIFS];
-- 
1.8.1.1.439.g50a6b54
