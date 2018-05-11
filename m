From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 03/10] ASoC: Intel: bytcr_rt5640: Enable
	jack detection
Date: Fri, 11 May 2018 15:29:21 +0200
Message-ID: <20180511132928.7669-4-hdegoede@redhat.com>
References: <20180511132928.7669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E27B2677CF
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 15:29:36 +0200 (CEST)
In-Reply-To: <20180511132928.7669-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Add code to support setting jack-detect parameters through quirks and
extend the existing DMI quirk table entries for the Asus T100TA and the
Dell Venue 8 Pro 5830 to enable jack detection.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 164 +++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b5972b7512d5..c69f48ff80c1 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/input.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
 #include <asm/platform_sst_audio.h>
@@ -46,19 +47,46 @@ enum {
 	BYT_RT5640_IN3_MAP,
 };
 
-#define BYT_RT5640_MAP(quirk)	((quirk) &  GENMASK(7, 0))
-#define BYT_RT5640_MONO_SPEAKER BIT(17)
-#define BYT_RT5640_DIFF_MIC     BIT(18) /* defaut is single-ended */
-#define BYT_RT5640_SSP2_AIF2    BIT(19) /* default is using AIF1  */
-#define BYT_RT5640_SSP0_AIF1    BIT(20)
-#define BYT_RT5640_SSP0_AIF2    BIT(21)
-#define BYT_RT5640_MCLK_EN	BIT(22)
-#define BYT_RT5640_MCLK_25MHZ	BIT(23)
+enum {
+	BYT_RT5640_JD_SRC_GPIO1		= (RT5640_JD_SRC_GPIO1 << 4),
+	BYT_RT5640_JD_SRC_JD1_IN4P	= (RT5640_JD_SRC_JD1_IN4P << 4),
+	BYT_RT5640_JD_SRC_JD2_IN4N	= (RT5640_JD_SRC_JD2_IN4N << 4),
+	BYT_RT5640_JD_SRC_GPIO2		= (RT5640_JD_SRC_GPIO2 << 4),
+	BYT_RT5640_JD_SRC_GPIO3		= (RT5640_JD_SRC_GPIO3 << 4),
+	BYT_RT5640_JD_SRC_GPIO4		= (RT5640_JD_SRC_GPIO4 << 4),
+};
+
+enum {
+	BYT_RT5640_OVCD_TH_600UA	= (6 << 8),
+	BYT_RT5640_OVCD_TH_1500UA	= (15 << 8),
+	BYT_RT5640_OVCD_TH_2000UA	= (20 << 8),
+};
+
+enum {
+	BYT_RT5640_OVCD_SF_0P5		= (RT5640_OVCD_SF_0P5 << 13),
+	BYT_RT5640_OVCD_SF_0P75		= (RT5640_OVCD_SF_0P75 << 13),
+	BYT_RT5640_OVCD_SF_1P0		= (RT5640_OVCD_SF_1P0 << 13),
+	BYT_RT5640_OVCD_SF_1P5		= (RT5640_OVCD_SF_1P5 << 13),
+};
 
-/* in-diff or dmic-pin + terminating empty entry */
-#define MAX_NO_PROPS 2
+#define BYT_RT5640_MAP(quirk)		((quirk) &  GENMASK(3, 0))
+#define BYT_RT5640_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
+#define BYT_RT5640_OVCD_TH(quirk)	(((quirk) & GENMASK(12, 8)) >> 8)
+#define BYT_RT5640_OVCD_SF(quirk)	(((quirk) & GENMASK(14, 13)) >> 13)
+#define BYT_RT5640_JD_NOT_INV		BIT(16)
+#define BYT_RT5640_MONO_SPEAKER		BIT(17)
+#define BYT_RT5640_DIFF_MIC		BIT(18) /* default is single-ended */
+#define BYT_RT5640_SSP2_AIF2		BIT(19) /* default is using AIF1  */
+#define BYT_RT5640_SSP0_AIF1		BIT(20)
+#define BYT_RT5640_SSP0_AIF2		BIT(21)
+#define BYT_RT5640_MCLK_EN		BIT(22)
+#define BYT_RT5640_MCLK_25MHZ		BIT(23)
+
+/* in-diff or dmic-pin + jdsrc + ovcd-th + -sf + jd-inv + terminating entry */
+#define MAX_NO_PROPS 6
 
 struct byt_rt5640_private {
+	struct snd_soc_jack jack;
 	struct clk *mclk;
 };
 static bool is_bytcr;
@@ -95,6 +123,16 @@ static void log_quirks(struct device *dev)
 		dev_err(dev, "quirk map 0x%x is not supported, microphone input will not work\n", map);
 		break;
 	}
+	if (BYT_RT5640_JDSRC(byt_rt5640_quirk)) {
+		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
+			 BYT_RT5640_JDSRC(byt_rt5640_quirk));
+		dev_info(dev, "quirk realtek,over-current-threshold-microamp %ld\n",
+			 BYT_RT5640_OVCD_TH(byt_rt5640_quirk) * 100);
+		dev_info(dev, "quirk realtek,over-current-scale-factor %ld\n",
+			 BYT_RT5640_OVCD_SF(byt_rt5640_quirk));
+	}
+	if (byt_rt5640_quirk & BYT_RT5640_JD_NOT_INV)
+		dev_info(dev, "quirk JD_NOT_INV enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER)
 		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
@@ -330,6 +368,17 @@ static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
+static struct snd_soc_jack_pin rt5640_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
 static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
@@ -353,6 +402,9 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
@@ -374,6 +426,9 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
 		},
 		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
 					BYT_RT5640_MONO_SPEAKER |
 					BYT_RT5640_MCLK_EN),
 	},
@@ -463,6 +518,23 @@ static int byt_rt5640_add_codec_device_props(const char *i2c_dev_name)
 		break;
 	}
 
+	if (BYT_RT5640_JDSRC(byt_rt5640_quirk)) {
+		props[cnt++] = PROPERTY_ENTRY_U32(
+				    "realtek,jack-detect-source",
+				    BYT_RT5640_JDSRC(byt_rt5640_quirk));
+
+		props[cnt++] = PROPERTY_ENTRY_U32(
+				    "realtek,over-current-threshold-microamp",
+				    BYT_RT5640_OVCD_TH(byt_rt5640_quirk) * 100);
+
+		props[cnt++] = PROPERTY_ENTRY_U32(
+				    "realtek,over-current-scale-factor",
+				    BYT_RT5640_OVCD_SF(byt_rt5640_quirk));
+	}
+
+	if (byt_rt5640_quirk & BYT_RT5640_JD_NOT_INV)
+		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,jack-detect-not-inverted");
+
 	ret = device_add_properties(i2c_dev, props);
 	put_device(i2c_dev);
 
@@ -480,6 +552,11 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 
 	card->dapm.idle_bias_off = true;
 
+	/* Start with RC clk for jack-detect (we disable MCLK below) */
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN)
+		snd_soc_component_update_bits(component, RT5640_GLB_CLK,
+			RT5640_SCLK_SRC_MASK, RT5640_SCLK_SRC_RCCLK);
+
 	rt5640_sel_asrc_clk_src(component,
 				RT5640_DA_STEREO_FILTER |
 				RT5640_DA_MONO_L_FILTER	|
@@ -570,11 +647,27 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		else
 			ret = clk_set_rate(priv->mclk, 19200000);
 
-		if (ret)
+		if (ret) {
 			dev_err(card->dev, "unable to set MCLK rate\n");
+			return ret;
+		}
 	}
 
-	return ret;
+	if (BYT_RT5640_JDSRC(byt_rt5640_quirk)) {
+		ret = snd_soc_card_jack_new(card, "Headset",
+					    SND_JACK_HEADSET | SND_JACK_BTN_0,
+					    &priv->jack, rt5640_pins,
+					    ARRAY_SIZE(rt5640_pins));
+		if (ret) {
+			dev_err(card->dev, "Jack creation failed %d\n", ret);
+			return ret;
+		}
+		snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0,
+				 KEY_PLAYPAUSE);
+		snd_soc_component_set_jack(component, &priv->jack, NULL);
+	}
+
+	return 0;
 }
 
 static const struct snd_soc_pcm_stream byt_rt5640_dai_params = {
@@ -715,6 +808,47 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 };
 
 /* SoC card */
+static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
+static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
+static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
+
+static int byt_rt5640_suspend(struct snd_soc_card *card)
+{
+	struct snd_soc_component *component;
+
+	if (!BYT_RT5640_JDSRC(byt_rt5640_quirk))
+		return 0;
+
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		if (!strcmp(component->name, byt_rt5640_codec_name)) {
+			dev_dbg(component->dev, "disabling jack detect before suspend\n");
+			snd_soc_component_set_jack(component, NULL, NULL);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int byt_rt5640_resume(struct snd_soc_card *card)
+{
+	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
+	struct snd_soc_component *component;
+
+	if (!BYT_RT5640_JDSRC(byt_rt5640_quirk))
+		return 0;
+
+	list_for_each_entry(component, &card->component_dev_list, card_list) {
+		if (!strcmp(component->name, byt_rt5640_codec_name)) {
+			dev_dbg(component->dev, "re-enabling jack detect after resume\n");
+			snd_soc_component_set_jack(component, &priv->jack, NULL);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static struct snd_soc_card byt_rt5640_card = {
 	.name = "bytcr-rt5640",
 	.owner = THIS_MODULE,
@@ -725,12 +859,10 @@ static struct snd_soc_card byt_rt5640_card = {
 	.dapm_routes = byt_rt5640_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(byt_rt5640_audio_map),
 	.fully_routed = true,
+	.suspend_pre = byt_rt5640_suspend,
+	.resume_post = byt_rt5640_resume,
 };
 
-static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
-static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
-static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
-
 static bool is_valleyview(void)
 {
 	static const struct x86_cpu_id cpu_ids[] = {
-- 
2.17.0
