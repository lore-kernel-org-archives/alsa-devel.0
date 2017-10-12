From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 2/9] ASoC: Intel: bytcr_rt5640: cosmetic
	fixes
Date: Thu, 12 Oct 2017 18:37:58 -0500
Message-ID: <20171012233805.30055-3-pierre-louis.bossart@linux.intel.com>
References: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C0958266F1E
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:38:17 +0200 (CEST)
In-Reply-To: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Reorder variable names, change MCLK test, change quirks
No functional change

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 73 +++++++++++++++++------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7cee09d08ad7..ffb3ca971df4 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -22,12 +22,12 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
 #include <asm/platform_sst_audio.h>
-#include <linux/clk.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -44,13 +44,13 @@ enum {
 	BYT_RT5640_IN3_MAP,
 };
 
-#define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
+#define BYT_RT5640_MAP(quirk)	((quirk) &  GENMASK(7, 0))
 #define BYT_RT5640_DMIC_EN	BIT(16)
 #define BYT_RT5640_MONO_SPEAKER BIT(17)
 #define BYT_RT5640_DIFF_MIC     BIT(18) /* defaut is single-ended */
-#define BYT_RT5640_SSP2_AIF2     BIT(19) /* default is using AIF1  */
-#define BYT_RT5640_SSP0_AIF1     BIT(20)
-#define BYT_RT5640_SSP0_AIF2     BIT(21)
+#define BYT_RT5640_SSP2_AIF2    BIT(19) /* default is using AIF1  */
+#define BYT_RT5640_SSP0_AIF1    BIT(20)
+#define BYT_RT5640_SSP0_AIF2    BIT(21)
 #define BYT_RT5640_MCLK_EN	BIT(22)
 #define BYT_RT5640_MCLK_25MHZ	BIT(23)
 
@@ -178,7 +178,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	}
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		if (priv->mclk) {
+		if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
 			ret = clk_prepare_enable(priv->mclk);
 			if (ret < 0) {
 				dev_err(card->dev,
@@ -199,7 +199,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 		if (!ret) {
-			if (priv->mclk)
+			if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN)
 				clk_disable_unprepare(priv->mclk);
 		}
 	}
@@ -376,8 +376,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
 		},
-		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
-						 BYT_RT5640_MCLK_EN),
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_MCLK_EN),
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
@@ -385,12 +385,11 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
 		},
-		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
-						 BYT_RT5640_MONO_SPEAKER |
-						 BYT_RT5640_DIFF_MIC |
-						 BYT_RT5640_SSP0_AIF2 |
-						 BYT_RT5640_MCLK_EN
-						 ),
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
+					BYT_RT5640_MCLK_EN),
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
@@ -398,9 +397,9 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "DellInc."),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
 		},
-		.driver_data = (unsigned long *)(BYT_RT5640_DMIC2_MAP |
-						 BYT_RT5640_DMIC_EN |
-						 BYT_RT5640_MCLK_EN),
+		.driver_data = (void *)(BYT_RT5640_DMIC2_MAP |
+					BYT_RT5640_DMIC_EN |
+					BYT_RT5640_MCLK_EN),
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
@@ -408,8 +407,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP ElitePad 1000 G2"),
 		},
-		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
-						 BYT_RT5640_MCLK_EN),
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_MCLK_EN),
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
@@ -417,8 +416,8 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
 		},
-		.driver_data = (unsigned long *)(BYT_RT5640_DMIC1_MAP |
-						 BYT_RT5640_DMIC_EN),
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_DMIC_EN),
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
@@ -426,9 +425,9 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "TECLAST"),
 			DMI_MATCH(DMI_BOARD_NAME, "tPAD"),
 		},
-		.driver_data = (unsigned long *)(BYT_RT5640_IN3_MAP |
-						BYT_RT5640_MCLK_EN |
-						BYT_RT5640_SSP0_AIF1),
+		.driver_data = (void *)(BYT_RT5640_IN3_MAP |
+					BYT_RT5640_MCLK_EN |
+					BYT_RT5640_SSP0_AIF1),
 	},
 	{
 		.callback = byt_rt5640_quirk_cb,
@@ -436,7 +435,7 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
 		},
-		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 						 BYT_RT5640_MCLK_EN |
 						 BYT_RT5640_SSP0_AIF1),
 
@@ -446,9 +445,9 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 		},
-		.driver_data = (unsigned long *)(BYT_RT5640_IN3_MAP |
-						 BYT_RT5640_MCLK_EN |
-						 BYT_RT5640_SSP0_AIF1),
+		.driver_data = (void *)(BYT_RT5640_IN3_MAP |
+					BYT_RT5640_MCLK_EN |
+					BYT_RT5640_SSP0_AIF1),
 
 	},
 	{}
@@ -456,12 +455,12 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 {
-	int ret;
-	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_card *card = runtime->card;
-	const struct snd_soc_dapm_route *custom_map;
 	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
+	struct snd_soc_codec *codec = runtime->codec;
+	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
+	int ret;
 
 	card->dapm.idle_bias_off = true;
 
@@ -549,7 +548,7 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
 
-	if (priv->mclk) {
+	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
 		/*
 		 * The firmware might enable the clock at
 		 * boot (this information may or may not
@@ -758,12 +757,12 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
-	int ret_val = 0;
+	struct byt_rt5640_private *priv;
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
-	int i;
+	int ret_val = 0;
 	int dai_index;
-	struct byt_rt5640_private *priv;
+	int i;
 
 	is_bytcr = false;
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
@@ -786,7 +785,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	i2c_name = sst_acpi_find_name_from_hid(mach->id);
-	if (i2c_name != NULL) {
+	if (i2c_name) {
 		snprintf(byt_rt5640_codec_name, sizeof(byt_rt5640_codec_name),
 			"%s%s", "i2c-", i2c_name);
 
-- 
2.11.0
