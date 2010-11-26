From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Implement support for enhanced AIF3
	on WM8958
Date: Fri, 26 Nov 2010 15:21:07 +0000
Message-ID: <1290784869-22204-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290784869-22204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9160A24504
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 16:23:29 +0100 (CET)
In-Reply-To: <1290784869-22204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Additional audio routing options are available on the WM8958 audio
interface 3. Add support for these.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/registers.h |   67 ++++++++++++++
 sound/soc/codecs/wm8994.c            |  166 ++++++++++++++++++++++++++++++++--
 2 files changed, 224 insertions(+), 9 deletions(-)

diff --git a/include/linux/mfd/wm8994/registers.h b/include/linux/mfd/wm8994/registers.h
index 967f62f..3eb70a4 100644
--- a/include/linux/mfd/wm8994/registers.h
+++ b/include/linux/mfd/wm8994/registers.h
@@ -109,6 +109,10 @@
 #define WM8994_AIF2DAC_LRCLK                    0x315
 #define WM8994_AIF2DAC_DATA                     0x316
 #define WM8994_AIF2ADC_DATA                     0x317
+#define WM8958_AIF3_CONTROL_1                   0x320
+#define WM8958_AIF3_CONTROL_2                   0x321
+#define WM8958_AIF3DAC_DATA                     0x322
+#define WM8958_AIF3ADC_DATA                     0x323
 #define WM8994_AIF1_ADC1_LEFT_VOLUME            0x400
 #define WM8994_AIF1_ADC1_RIGHT_VOLUME           0x401
 #define WM8994_AIF1_DAC1_LEFT_VOLUME            0x402
@@ -992,6 +996,12 @@
 /*
  * R6 (0x06) - Power Management (6)
  */
+#define WM8958_AIF3ADC_SRC_MASK                 0x0600  /* AIF3ADC_SRC - [10:9] */
+#define WM8958_AIF3ADC_SRC_SHIFT                     9  /* AIF3ADC_SRC - [10:9] */
+#define WM8958_AIF3ADC_SRC_WIDTH                     2  /* AIF3ADC_SRC - [10:9] */
+#define WM8958_AIF2DAC_SRC_MASK                 0x0180  /* AIF2DAC_SRC - [8:7] */
+#define WM8958_AIF2DAC_SRC_SHIFT                     7  /* AIF2DAC_SRC - [8:7] */
+#define WM8958_AIF2DAC_SRC_WIDTH                     2  /* AIF2DAC_SRC - [8:7] */
 #define WM8994_AIF3_TRI                         0x0020  /* AIF3_TRI */
 #define WM8994_AIF3_TRI_MASK                    0x0020  /* AIF3_TRI */
 #define WM8994_AIF3_TRI_SHIFT                        5  /* AIF3_TRI */
@@ -2553,6 +2563,63 @@
 #define WM8994_AIF2ADCR_DAT_INV_WIDTH                1  /* AIF2ADCR_DAT_INV */
 
 /*
+ * R800 (0x320) - AIF3 Control (1)
+ */
+#define WM8958_AIF3_LRCLK_INV                   0x0080  /* AIF3_LRCLK_INV */
+#define WM8958_AIF3_LRCLK_INV_MASK              0x0080  /* AIF3_LRCLK_INV */
+#define WM8958_AIF3_LRCLK_INV_SHIFT                  7  /* AIF3_LRCLK_INV */
+#define WM8958_AIF3_LRCLK_INV_WIDTH                  1  /* AIF3_LRCLK_INV */
+#define WM8958_AIF3_WL_MASK                     0x0060  /* AIF3_WL - [6:5] */
+#define WM8958_AIF3_WL_SHIFT                         5  /* AIF3_WL - [6:5] */
+#define WM8958_AIF3_WL_WIDTH                         2  /* AIF3_WL - [6:5] */
+#define WM8958_AIF3_FMT_MASK                    0x0018  /* AIF3_FMT - [4:3] */
+#define WM8958_AIF3_FMT_SHIFT                        3  /* AIF3_FMT - [4:3] */
+#define WM8958_AIF3_FMT_WIDTH                        2  /* AIF3_FMT - [4:3] */
+
+/*
+ * R801 (0x321) - AIF3 Control (2)
+ */
+#define WM8958_AIF3DAC_BOOST_MASK               0x0C00  /* AIF3DAC_BOOST - [11:10] */
+#define WM8958_AIF3DAC_BOOST_SHIFT                  10  /* AIF3DAC_BOOST - [11:10] */
+#define WM8958_AIF3DAC_BOOST_WIDTH                   2  /* AIF3DAC_BOOST - [11:10] */
+#define WM8958_AIF3DAC_COMP                     0x0010  /* AIF3DAC_COMP */
+#define WM8958_AIF3DAC_COMP_MASK                0x0010  /* AIF3DAC_COMP */
+#define WM8958_AIF3DAC_COMP_SHIFT                    4  /* AIF3DAC_COMP */
+#define WM8958_AIF3DAC_COMP_WIDTH                    1  /* AIF3DAC_COMP */
+#define WM8958_AIF3DAC_COMPMODE                 0x0008  /* AIF3DAC_COMPMODE */
+#define WM8958_AIF3DAC_COMPMODE_MASK            0x0008  /* AIF3DAC_COMPMODE */
+#define WM8958_AIF3DAC_COMPMODE_SHIFT                3  /* AIF3DAC_COMPMODE */
+#define WM8958_AIF3DAC_COMPMODE_WIDTH                1  /* AIF3DAC_COMPMODE */
+#define WM8958_AIF3ADC_COMP                     0x0004  /* AIF3ADC_COMP */
+#define WM8958_AIF3ADC_COMP_MASK                0x0004  /* AIF3ADC_COMP */
+#define WM8958_AIF3ADC_COMP_SHIFT                    2  /* AIF3ADC_COMP */
+#define WM8958_AIF3ADC_COMP_WIDTH                    1  /* AIF3ADC_COMP */
+#define WM8958_AIF3ADC_COMPMODE                 0x0002  /* AIF3ADC_COMPMODE */
+#define WM8958_AIF3ADC_COMPMODE_MASK            0x0002  /* AIF3ADC_COMPMODE */
+#define WM8958_AIF3ADC_COMPMODE_SHIFT                1  /* AIF3ADC_COMPMODE */
+#define WM8958_AIF3ADC_COMPMODE_WIDTH                1  /* AIF3ADC_COMPMODE */
+#define WM8958_AIF3_LOOPBACK                    0x0001  /* AIF3_LOOPBACK */
+#define WM8958_AIF3_LOOPBACK_MASK               0x0001  /* AIF3_LOOPBACK */
+#define WM8958_AIF3_LOOPBACK_SHIFT                   0  /* AIF3_LOOPBACK */
+#define WM8958_AIF3_LOOPBACK_WIDTH                   1  /* AIF3_LOOPBACK */
+
+/*
+ * R802 (0x322) - AIF3DAC Data
+ */
+#define WM8958_AIF3DAC_DAT_INV                  0x0001  /* AIF3DAC_DAT_INV */
+#define WM8958_AIF3DAC_DAT_INV_MASK             0x0001  /* AIF3DAC_DAT_INV */
+#define WM8958_AIF3DAC_DAT_INV_SHIFT                 0  /* AIF3DAC_DAT_INV */
+#define WM8958_AIF3DAC_DAT_INV_WIDTH                 1  /* AIF3DAC_DAT_INV */
+
+/*
+ * R803 (0x323) - AIF3ADC Data
+ */
+#define WM8958_AIF3ADC_DAT_INV                  0x0001  /* AIF3ADC_DAT_INV */
+#define WM8958_AIF3ADC_DAT_INV_MASK             0x0001  /* AIF3ADC_DAT_INV */
+#define WM8958_AIF3ADC_DAT_INV_SHIFT                 0  /* AIF3ADC_DAT_INV */
+#define WM8958_AIF3ADC_DAT_INV_WIDTH                 1  /* AIF3ADC_DAT_INV */
+
+/*
  * R1024 (0x400) - AIF1 ADC1 Left Volume
  */
 #define WM8994_AIF1ADC1_VU                      0x0100  /* AIF1ADC1_VU */
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 8232d5e..fb06093 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -647,6 +647,10 @@ SOC_SINGLE_TLV("AIF2 EQ5 Volume", WM8994_AIF2_EQ_GAINS_2, 6, 31, 0,
 	       eq_tlv),
 };
 
+static const struct snd_kcontrol_new wm8958_snd_controls[] = {
+SOC_SINGLE_TLV("AIF3 Boost Volume", WM8958_AIF3_CONTROL_2, 10, 3, 0, aif_tlv),
+};
+
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
@@ -953,14 +957,47 @@ static const struct snd_kcontrol_new aif2adc_mux =
 	SOC_DAPM_ENUM("AIF2ADC Mux", aif2adc_enum);
 
 static const char *aif3adc_text[] = {
-	"AIF1ADCDAT", "AIF2ADCDAT", "AIF2DACDAT",
+	"AIF1ADCDAT", "AIF2ADCDAT", "AIF2DACDAT", "Mono PCM",
 };
 
-static const struct soc_enum aif3adc_enum =
+static const struct soc_enum wm8994_aif3adc_enum =
 	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 3, 3, aif3adc_text);
 
-static const struct snd_kcontrol_new aif3adc_mux =
-	SOC_DAPM_ENUM("AIF3ADC Mux", aif3adc_enum);
+static const struct snd_kcontrol_new wm8994_aif3adc_mux =
+	SOC_DAPM_ENUM("AIF3ADC Mux", wm8994_aif3adc_enum);
+
+static const struct soc_enum wm8958_aif3adc_enum =
+	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 3, 4, aif3adc_text);
+
+static const struct snd_kcontrol_new wm8958_aif3adc_mux =
+	SOC_DAPM_ENUM("AIF3ADC Mux", wm8958_aif3adc_enum);
+
+static const char *mono_pcm_out_text[] = {
+	"None", "AIF2ADCL", "AIF2ADCR", 
+};
+
+static const struct soc_enum mono_pcm_out_enum =
+	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 9, 3, mono_pcm_out_text);
+
+static const struct snd_kcontrol_new mono_pcm_out_mux =
+	SOC_DAPM_ENUM("Mono PCM Out Mux", mono_pcm_out_enum);
+
+static const char *aif2dac_src_text[] = {
+	"AIF2", "AIF3",
+};
+
+/* Note that these two control shouldn't be simultaneously switched to AIF3 */
+static const struct soc_enum aif2dacl_src_enum =
+	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 7, 2, aif2dac_src_text);
+
+static const struct snd_kcontrol_new aif2dacl_src_mux =
+	SOC_DAPM_ENUM("AIF2DACL Mux", aif2dacl_src_enum);
+
+static const struct soc_enum aif2dacr_src_enum =
+	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 8, 2, aif2dac_src_text);
+
+static const struct snd_kcontrol_new aif2dacr_src_mux =
+	SOC_DAPM_ENUM("AIF2DACR Mux", aif2dacr_src_enum);
 
 static const struct snd_soc_dapm_widget wm8994_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("DMIC1DAT"),
@@ -1034,7 +1071,6 @@ SND_SOC_DAPM_AIF_OUT("AIF2ADCDAT", "AIF2 Capture", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_MUX("AIF1DAC Mux", SND_SOC_NOPM, 0, 0, &aif1dac_mux),
 SND_SOC_DAPM_MUX("AIF2DAC Mux", SND_SOC_NOPM, 0, 0, &aif2dac_mux),
 SND_SOC_DAPM_MUX("AIF2ADC Mux", SND_SOC_NOPM, 0, 0, &aif2adc_mux),
-SND_SOC_DAPM_MUX("AIF3ADC Mux", SND_SOC_NOPM, 0, 0, &aif3adc_mux),
 
 SND_SOC_DAPM_AIF_IN("AIF3DACDAT", "AIF3 Playback", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_IN("AIF3ADCDAT", "AIF3 Capture", 0, SND_SOC_NOPM, 0, 0),
@@ -1072,8 +1108,18 @@ SND_SOC_DAPM_MIXER("SPKR", WM8994_POWER_MANAGEMENT_3, 9, 0,
 SND_SOC_DAPM_POST("Debug log", post_ev),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_widget wm8994_specific_dapm_widgets[] = {
+SND_SOC_DAPM_MUX("AIF3ADC Mux", SND_SOC_NOPM, 0, 0, &wm8994_aif3adc_mux),
+};
 
+static const struct snd_soc_dapm_widget wm8958_dapm_widgets[] = {
+SND_SOC_DAPM_MUX("Mono PCM Out Mux", SND_SOC_NOPM, 0, 0, &mono_pcm_out_mux),
+SND_SOC_DAPM_MUX("AIF2DACL Mux", SND_SOC_NOPM, 0, 0, &aif2dacl_src_mux),
+SND_SOC_DAPM_MUX("AIF2DACR Mux", SND_SOC_NOPM, 0, 0, &aif2dacr_src_mux),
+SND_SOC_DAPM_MUX("AIF3ADC Mux", SND_SOC_NOPM, 0, 0, &wm8958_aif3adc_mux),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
 	{ "CLK_SYS", NULL, "AIF1CLK", check_clk_sys },
 	{ "CLK_SYS", NULL, "AIF2CLK", check_clk_sys },
 
@@ -1181,9 +1227,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "AIF1DAC2L", NULL, "AIF1DAC Mux" },
 	{ "AIF1DAC2R", NULL, "AIF1DAC Mux" },
 
-	{ "AIF2DACL", NULL, "AIF2DAC Mux" },
-	{ "AIF2DACR", NULL, "AIF2DAC Mux" },
-
 	{ "AIF1DAC Mux", "AIF1DACDAT", "AIF1DACDAT" },
 	{ "AIF1DAC Mux", "AIF3DACDAT", "AIF3DACDAT" },
 	{ "AIF2DAC Mux", "AIF2DACDAT", "AIF2DACDAT" },
@@ -1256,6 +1299,26 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{ "Right Headphone Mux", "DAC", "DAC1R" },
 };
 
+static const struct snd_soc_dapm_route wm8994_intercon[] = {
+	{ "AIF2DACL", NULL, "AIF2DAC Mux" },
+	{ "AIF2DACR", NULL, "AIF2DAC Mux" },
+};
+
+static const struct snd_soc_dapm_route wm8958_intercon[] = {
+	{ "AIF2DACL", NULL, "AIF2DACL Mux" },
+	{ "AIF2DACR", NULL, "AIF2DACR Mux" },
+
+	{ "AIF2DACL Mux", "AIF2", "AIF2DAC Mux" },
+	{ "AIF2DACL Mux", "AIF3", "AIF3DACDAT" },
+	{ "AIF2DACR Mux", "AIF2", "AIF2DAC Mux" },
+	{ "AIF2DACR Mux", "AIF3", "AIF3DACDAT" },
+
+	{ "Mono PCM Out Mux", "AIF2ADCL", "AIF2ADCL" },
+	{ "Mono PCM Out Mux", "AIF2ADCR", "AIF2ADCR" },
+
+	{ "AIF3ADC Mux", "Mono PCM", "Mono PCM Out Mux" },
+};
+
 /* The size in bits of the FLL divide multiplied by 10
  * to allow rounding later */
 #define FIXED_FLL_SIZE ((1 << 16) * 10)
@@ -1635,6 +1698,7 @@ static int wm8994_set_bias_level(struct snd_soc_codec *codec,
 static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct wm8994 *control = codec->control_data;
 	int ms_reg;
 	int aif1_reg;
 	int ms = 0;
@@ -1719,6 +1783,13 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	/* The AIF2 format configuration needs to be mirrored to AIF3
+	 * on WM8958 if it's in use so just do it all the time. */
+	if (control->type == WM8958 && dai->id == 2)
+		snd_soc_update_bits(codec, WM8958_AIF3_CONTROL_1,
+				    WM8994_AIF1_LRCLK_INV |
+				    WM8958_AIF3_FMT_MASK, aif1);
+
 	snd_soc_update_bits(codec, aif1_reg,
 			    WM8994_AIF1_BCLK_INV | WM8994_AIF1_LRCLK_INV |
 			    WM8994_AIF1_FMT_MASK,
@@ -1759,6 +1830,7 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct wm8994 *control = codec->control_data;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int aif1_reg;
 	int bclk_reg;
@@ -1797,6 +1869,14 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 			dev_dbg(codec->dev, "AIF2 using split LRCLK\n");
 		}
 		break;
+	case 3:
+		switch (control->type) {
+		case WM8958:
+			aif1_reg = WM8958_AIF3_CONTROL_1;
+			break;
+		default:
+			return 0;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1900,6 +1980,47 @@ static int wm8994_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int wm8994_aif3_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8994 *control = codec->control_data;
+	int aif1_reg;
+	int aif1 = 0;
+
+	switch (dai->id) {
+	case 3:
+		switch (control->type) {
+		case WM8958:
+			aif1_reg = WM8958_AIF3_CONTROL_1;
+			break;
+		default:
+			return 0;
+		}
+	default:
+		return 0;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		aif1 |= 0x20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		aif1 |= 0x40;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		aif1 |= 0x60;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snd_soc_update_bits(codec, aif1_reg, WM8994_AIF1_WL_MASK, aif1);
+}
+
 static int wm8994_aif_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -1981,6 +2102,7 @@ static struct snd_soc_dai_ops wm8994_aif2_dai_ops = {
 };
 
 static struct snd_soc_dai_ops wm8994_aif3_dai_ops = {
+	.hw_params	= wm8994_aif3_hw_params,
 	.set_tristate	= wm8994_set_tristate,
 };
 
@@ -2511,9 +2633,35 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 			     ARRAY_SIZE(wm8994_snd_controls));
 	snd_soc_dapm_new_controls(dapm, wm8994_dapm_widgets,
 				  ARRAY_SIZE(wm8994_dapm_widgets));
+
+	switch (control->type) {
+	case WM8994:
+		snd_soc_dapm_new_controls(dapm, wm8994_specific_dapm_widgets,
+					  ARRAY_SIZE(wm8994_specific_dapm_widgets));
+		break;
+	case WM8958:
+		snd_soc_add_controls(codec, wm8958_snd_controls,
+				     ARRAY_SIZE(wm8958_snd_controls));
+		snd_soc_dapm_new_controls(dapm, wm8958_dapm_widgets,
+					  ARRAY_SIZE(wm8958_dapm_widgets));
+		break;
+	}
+		
+
 	wm_hubs_add_analogue_routes(codec, 0, 0);
 	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
 
+	switch (control->type) {
+	case WM8994:
+		snd_soc_dapm_add_routes(dapm, wm8994_intercon,
+					ARRAY_SIZE(wm8994_intercon));
+		break;
+	case WM8958:
+		snd_soc_dapm_add_routes(dapm, wm8958_intercon,
+					ARRAY_SIZE(wm8958_intercon));
+		break;
+	}
+
 	return 0;
 
 err_irq:
-- 
1.7.1
