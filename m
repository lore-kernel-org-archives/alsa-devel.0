From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 3/9] ASoC: Intel: cht_bsw_rt5645: cosmetic
	fixes
Date: Thu, 12 Oct 2017 18:37:59 -0500
Message-ID: <20171012233805.30055-4-pierre-louis.bossart@linux.intel.com>
References: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D969B266F30
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
 sound/soc/intel/boards/cht_bsw_rt5645.c | 73 ++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index d553e2b67c92..6ccb599c1082 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -21,13 +21,13 @@
  */
 
 #include <linux/module.h>
-#include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
 #include <asm/platform_sst_audio.h>
-#include <linux/clk.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -53,7 +53,7 @@ struct cht_mc_private {
 	struct clk *mclk;
 };
 
-#define CHT_RT5645_MAP(quirk)	((quirk) & 0xff)
+#define CHT_RT5645_MAP(quirk)	((quirk) & GENMASK(7, 0))
 #define CHT_RT5645_SSP2_AIF2     BIT(16) /* default is using AIF1  */
 #define CHT_RT5645_SSP0_AIF1     BIT(17)
 #define CHT_RT5645_SSP0_AIF2     BIT(18)
@@ -101,13 +101,11 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	}
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-		if (ctx->mclk) {
-			ret = clk_prepare_enable(ctx->mclk);
-			if (ret < 0) {
-				dev_err(card->dev,
-					"could not configure MCLK state");
-				return ret;
-			}
+		ret = clk_prepare_enable(ctx->mclk);
+		if (ret < 0) {
+			dev_err(card->dev,
+				"could not configure MCLK state");
+			return ret;
 		}
 	} else {
 		/* Set codec sysclk source to its internal clock because codec PLL will
@@ -122,8 +120,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 			return ret;
 		}
 
-		if (ctx->mclk)
-			clk_disable_unprepare(ctx->mclk);
+		clk_disable_unprepare(ctx->mclk);
 	}
 
 	return 0;
@@ -258,11 +255,11 @@ static const struct dmi_system_id cht_rt5645_quirk_table[] = {
 
 static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 {
-	int ret;
-	int jack_type;
-	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_card *card = runtime->card;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
+	struct snd_soc_codec *codec = runtime->codec;
+	int jack_type;
+	int ret;
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
 	    (cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
@@ -320,26 +317,26 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 
 	rt5645_set_jack_detect(codec, &ctx->jack, &ctx->jack, &ctx->jack);
 
-	if (ctx->mclk) {
-		/*
-		 * The firmware might enable the clock at
-		 * boot (this information may or may not
-		 * be reflected in the enable clock register).
-		 * To change the rate we must disable the clock
-		 * first to cover these cases. Due to common
-		 * clock framework restrictions that do not allow
-		 * to disable a clock that has not been enabled,
-		 * we need to enable the clock first.
-		 */
-		ret = clk_prepare_enable(ctx->mclk);
-		if (!ret)
-			clk_disable_unprepare(ctx->mclk);
 
-		ret = clk_set_rate(ctx->mclk, CHT_PLAT_CLK_3_HZ);
+	/*
+	 * The firmware might enable the clock at
+	 * boot (this information may or may not
+	 * be reflected in the enable clock register).
+	 * To change the rate we must disable the clock
+	 * first to cover these cases. Due to common
+	 * clock framework restrictions that do not allow
+	 * to disable a clock that has not been enabled,
+	 * we need to enable the clock first.
+	 */
+	ret = clk_prepare_enable(ctx->mclk);
+	if (!ret)
+		clk_disable_unprepare(ctx->mclk);
+
+	ret = clk_set_rate(ctx->mclk, CHT_PLAT_CLK_3_HZ);
+
+	if (ret)
+		dev_err(runtime->dev, "unable to set MCLK rate\n");
 
-		if (ret)
-			dev_err(runtime->dev, "unable to set MCLK rate\n");
-	}
 	return ret;
 }
 
@@ -545,15 +542,15 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
 
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
-	int ret_val = 0;
-	int i;
-	struct cht_mc_private *drv;
 	struct snd_soc_card *card = snd_soc_cards[0].soc_card;
 	struct sst_acpi_mach *mach;
+	struct cht_mc_private *drv;
 	const char *i2c_name = NULL;
-	int dai_index = 0;
 	bool found = false;
 	bool is_bytcr = false;
+	int dai_index = 0;
+	int ret_val = 0;
+	int i;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
@@ -590,7 +587,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 
 	/* fixup codec name based on HID */
 	i2c_name = sst_acpi_find_name_from_hid(mach->id);
-	if (i2c_name != NULL) {
+	if (i2c_name) {
 		snprintf(cht_rt5645_codec_name, sizeof(cht_rt5645_codec_name),
 			"%s%s", "i2c-", i2c_name);
 		cht_dailink[dai_index].codec_name = cht_rt5645_codec_name;
-- 
2.11.0
