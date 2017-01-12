From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH v2 3/4] ASoC: Intel: Support rt5660 codec for Baytrail
Date: Thu, 12 Jan 2017 20:01:00 +0800
Message-ID: <20170112120101.16933-4-shrirang.bagul@canonical.com>
References: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112120101.16933-1-shrirang.bagul@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Shrirang Bagul <shrirang.bagul@canonical.com>, Ramesh Babu <ramesh.babu@intel.com>, John Keeping <john@metanate.com>, Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.king@canonical.com>, Wei Yongjun <weiyongjun1@huawei.com>, Irina Tirdea <irina.tirdea@intel.com>
List-Id: alsa-devel@alsa-project.org

rt5660 and rt5640 are similar codecs so reuse the bytcr_rt5640 driver.
RT5660 codec is used on Dell Edge IoT Gateways with ACPI ID 10EC3277.
These devices sport only Line-In and Line-Out jacks.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 sound/soc/intel/Kconfig               |  11 +--
 sound/soc/intel/atom/sst/sst_acpi.c   |   2 +
 sound/soc/intel/boards/bytcr_rt5640.c | 156 ++++++++++++++++++++++++++++++----
 3 files changed, 147 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index fd5d1e0..0b43b6a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -147,17 +147,18 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
-        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640 codec"
+	tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5640/5660 codec"
 	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
+	select SND_SOC_RT5660
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
 	select SND_SOC_INTEL_SST_MATCH if ACPI
 	help
-          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
-          platforms with RT5640 audio codec.
-          Say Y if you have such a device.
-          If unsure select "N".
+	  This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
+	  platforms with RT5640, RT5460 audio codec.
+	  Say Y if you have such a device.
+	  If unsure select "N".
 
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index f4d92bb..d401457f 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -441,6 +441,8 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 						&byt_rvp_platform_data },
 	{"10EC5642", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
 						&byt_rvp_platform_data },
+	{"10EC3277", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
+						&byt_rvp_platform_data },
 	{"INTCCFFD", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
 						&byt_rvp_platform_data },
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index f6fd397..e8c9a01 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -32,11 +32,17 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 #include "../../codecs/rt5640.h"
+#include "../../codecs/rt5660.h"
 #include "../atom/sst-atom-controls.h"
 #include "../common/sst-acpi.h"
 #include "../common/sst-dsp.h"
 
 enum {
+	CODEC_TYPE_RT5640,
+	CODEC_TYPE_RT5660,
+};
+
+enum {
 	BYT_RT5640_DMIC1_MAP,
 	BYT_RT5640_DMIC2_MAP,
 	BYT_RT5640_IN1_MAP,
@@ -60,8 +66,16 @@ enum {
 	PLL1_MCLK,
 };
 
+struct byt_acpi_card {
+	char *codec_id;
+	int codec_type;
+	struct snd_soc_card *soc_card;
+};
+
 struct byt_rt5640_private {
+	struct byt_acpi_card *acpi_card;
 	struct clk *mclk;
+	char codec_name[16];
 	int *clks;
 };
 
@@ -72,6 +86,13 @@ static int byt_rt5640_clks[] = {
 	RT5640_PLL1_S_MCLK
 };
 
+static int byt_rt5660_clks[] = {
+	RT5660_SCLK_S_PLL1,
+	RT5660_SCLK_S_RCCLK,
+	RT5660_PLL1_S_BCLK,
+	RT5660_PLL1_S_MCLK
+};
+
 static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
 
 static void log_quirks(struct device *dev)
@@ -105,6 +126,7 @@ static void log_quirks(struct device *dev)
 
 #define BYT_CODEC_DAI1	"rt5640-aif1"
 #define BYT_CODEC_DAI2	"rt5640-aif2"
+#define BYT_CODEC_DAI3	"rt5660-aif1"
 
 static inline struct snd_soc_dai *byt_get_codec_dai(struct snd_soc_card *card)
 {
@@ -117,6 +139,9 @@ static inline struct snd_soc_dai *byt_get_codec_dai(struct snd_soc_card *card)
 		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI2,
 				strlen(BYT_CODEC_DAI2)))
 			return rtd->codec_dai;
+		if (!strncmp(rtd->codec_dai->name, BYT_CODEC_DAI3,
+				strlen(BYT_CODEC_DAI3)))
+			return rtd->codec_dai;
 
 	}
 	return NULL;
@@ -269,6 +294,29 @@ static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
+static const struct snd_soc_dapm_widget byt_rt5660_widgets[] = {
+	SND_SOC_DAPM_MIC("Line In", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route byt_rt5660_audio_map[] = {
+	{"IN1P", NULL, "Line In"},
+	{"IN2P", NULL, "Line In"},
+	{"Line Out", NULL, "LOUTR"},
+	{"Line Out", NULL, "LOUTL"},
+
+	{"Line In", NULL, "Platform Clock"},
+	{"Line Out", NULL, "Platform Clock"},
+};
+
+static const struct snd_kcontrol_new byt_rt5660_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Line In"),
+	SOC_DAPM_PIN_SWITCH("Line Out"),
+};
+
 static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
@@ -422,11 +470,8 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_card *card = runtime->card;
 	const struct snd_soc_dapm_route *custom_map;
-	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
 	int num_routes;
 
-	card->dapm.idle_bias_off = true;
-
 	rt5640_sel_asrc_clk_src(codec,
 				RT5640_DA_STEREO_FILTER |
 				RT5640_DA_MONO_L_FILTER	|
@@ -511,6 +556,39 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
 
+	return ret;
+}
+
+static int byt_rt5660_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_card *card = runtime->card;
+
+	ret = snd_soc_dapm_add_routes(&card->dapm,
+			byt_rt5640_ssp2_aif1_map,
+			ARRAY_SIZE(byt_rt5640_ssp2_aif1_map));
+	if (ret)
+		return ret;
+
+	snd_soc_dapm_enable_pin(&card->dapm, "Line In");
+	snd_soc_dapm_enable_pin(&card->dapm, "Line Out");
+
+	return ret;
+}
+
+static int byt_rt56x0_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_card *card = runtime->card;
+	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
+
+	card->dapm.idle_bias_off = true;
+
+	if (priv->acpi_card->codec_type == CODEC_TYPE_RT5640)
+		ret = byt_rt5640_init(runtime);
+	else
+		ret = byt_rt5660_init(runtime);
+
 	if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk) {
 		/*
 		 * The firmware might enable the clock at
@@ -679,7 +757,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.ignore_suspend = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-		.init = byt_rt5640_init,
+		.init = byt_rt56x0_init,
 		.ops = &byt_rt5640_be_ssp2_ops,
 	},
 };
@@ -697,6 +775,25 @@ static struct snd_soc_card byt_rt5640_card = {
 	.fully_routed = true,
 };
 
+static struct snd_soc_card byt_rt5660_card = {
+	.name = "bytcr-rt5660",
+	.owner = THIS_MODULE,
+	.dai_link = byt_rt5640_dais,
+	.num_links = ARRAY_SIZE(byt_rt5640_dais),
+	.controls = byt_rt5660_controls,
+	.num_controls = ARRAY_SIZE(byt_rt5660_controls),
+	.dapm_widgets = byt_rt5660_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_rt5660_widgets),
+	.dapm_routes = byt_rt5660_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_rt5660_audio_map),
+	.fully_routed = true,
+};
+
+static struct byt_acpi_card snd_soc_cards[] = {
+	{"10EC5640", CODEC_TYPE_RT5640, &byt_rt5640_card},
+	{"10EC3277", CODEC_TYPE_RT5660, &byt_rt5660_card},
+};
+
 static char byt_rt5640_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
 static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
 static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
@@ -721,41 +818,51 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
-	struct sst_acpi_mach *mach;
-	const char *i2c_name = NULL;
 	int i;
-	int dai_index;
 	struct byt_rt5640_private *priv;
+	struct snd_soc_card *card = snd_soc_cards[0].soc_card;
+	struct sst_acpi_mach *mach;
+	const char *i2c_name = NULL;
+	int dai_index = 0;
 	bool is_bytcr = false;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv)
 		return -ENOMEM;
 
+	for (i = 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
+		if (acpi_dev_found(snd_soc_cards[i].codec_id)) {
+			dev_dbg(&pdev->dev,
+				"found codec %s\n", snd_soc_cards[i].codec_id);
+			card = snd_soc_cards[i].soc_card;
+			priv->acpi_card = &snd_soc_cards[i];
+			break;
+		}
+	}
+
 	/* register the soc card */
 	priv->clks = byt_rt5640_clks;
-	byt_rt5640_card.dev = &pdev->dev;
-	mach = byt_rt5640_card.dev->platform_data;
-	snd_soc_card_set_drvdata(&byt_rt5640_card, priv);
+	card->dev = &pdev->dev;
+	mach = card->dev->platform_data;
+	sprintf(priv->codec_name, "i2c-%s:00", priv->acpi_card->codec_id);
 
 	/* fix index of codec dai */
-	dai_index = MERR_DPCM_COMPR + 1;
-	for (i = 0; i < ARRAY_SIZE(byt_rt5640_dais); i++) {
+	for (i = 0; i < ARRAY_SIZE(byt_rt5640_dais); i++)
 		if (!strcmp(byt_rt5640_dais[i].codec_name, "i2c-10EC5640:00")) {
+			card->dai_link[i].codec_name = priv->codec_name;
 			dai_index = i;
-			break;
 		}
-	}
 
 	/* fixup codec name based on HID */
 	i2c_name = sst_acpi_find_name_from_hid(mach->id);
 	if (i2c_name != NULL) {
 		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
 			"%s%s", "i2c-", i2c_name);
-
 		byt_rt5640_dais[dai_index].codec_name = byt_rt5640_codec_name;
 	}
 
+	snd_soc_card_set_drvdata(card, priv);
+
 	/*
 	 * swap SSP0 if bytcr is detected
 	 * (will be overridden if DMI quirk is detected)
@@ -821,6 +928,21 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 				BYT_RT5640_DMIC_EN);
 	}
 
+	if (priv->acpi_card->codec_type == CODEC_TYPE_RT5660) {
+		priv->clks = byt_rt5660_clks;
+
+		/* fixup codec aif name for rt5660 */
+		snprintf(byt_rt5640_codec_aif_name,
+			sizeof(byt_rt5640_codec_aif_name),
+			"%s", "rt5660-aif1");
+
+		byt_rt5640_dais[dai_index].codec_dai_name =
+			byt_rt5640_codec_aif_name;
+
+		/* setup codec quirks for rt5660 */
+		byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
+	}
+
 	/* check quirks before creating card */
 	dmi_check_system(byt_rt5640_quirk_table);
 	log_quirks(&pdev->dev);
@@ -869,14 +991,14 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5640_card);
+	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 
 	if (ret_val) {
 		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
 			ret_val);
 		return ret_val;
 	}
-	platform_set_drvdata(pdev, &byt_rt5640_card);
+	platform_set_drvdata(pdev, card);
 	return ret_val;
 }
 
-- 
2.9.3
