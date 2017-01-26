From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/17] ASoC: Intel: cht_bsw_rt5645: add
	Baytrail MCLK support
Date: Thu, 26 Jan 2017 14:09:38 -0600
Message-ID: <1485461385-14544-11-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id C82F226779E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:26 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The existing code assumes a 19.2 MHz MCLK as the default
hardware configuration. This is valid for CherryTrail but
not for Baytrail.

Add explicit MCLK configuration to set the 19.2 clock on/off
depending on DAPM events.

This is a prerequisite step to enable devices with Baytrail
and RT5645 such as Asus X205TA

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 84 ++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 73efb38..3684bdb 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -24,6 +24,9 @@
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <asm/cpu_device_id.h>
+#include <asm/platform_sst_audio.h>
+#include <linux/clk.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -45,6 +48,7 @@ struct cht_mc_private {
 	struct snd_soc_jack jack;
 	struct cht_acpi_card *acpi_card;
 	char codec_name[16];
+	struct clk *mclk;
 };
 
 static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
@@ -65,6 +69,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dai *codec_dai;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	codec_dai = cht_get_codec_dai(card);
@@ -73,19 +78,30 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		return -EIO;
 	}
 
-	if (!SND_SOC_DAPM_EVENT_OFF(event))
-		return 0;
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		if (ctx->mclk) {
+			ret = clk_prepare_enable(ctx->mclk);
+			if (ret < 0) {
+				dev_err(card->dev,
+					"could not configure MCLK state");
+				return ret;
+			}
+		}
+	} else {
+		/* Set codec sysclk source to its internal clock because codec PLL will
+		 * be off when idle and MCLK will also be off when codec is
+		 * runtime suspended. Codec needs clock for jack detection and button
+		 * press. MCLK is turned off with clock framework or ACPI.
+		 */
+		ret = snd_soc_dai_set_sysclk(codec_dai, RT5645_SCLK_S_RCCLK,
+					48000 * 512, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "can't set codec sysclk: %d\n", ret);
+			return ret;
+		}
 
-	/* Set codec sysclk source to its internal clock because codec PLL will
-	 * be off when idle and MCLK will also be off by ACPI when codec is
-	 * runtime suspended. Codec needs clock for jack detection and button
-	 * press.
-	 */
-	ret = snd_soc_dai_set_sysclk(codec_dai, RT5645_SCLK_S_RCCLK,
-			0, SND_SOC_CLOCK_IN);
-	if (ret < 0) {
-		dev_err(card->dev, "can't set codec sysclk: %d\n", ret);
-		return ret;
+		if (ctx->mclk)
+			clk_disable_unprepare(ctx->mclk);
 	}
 
 	return 0;
@@ -97,7 +113,7 @@ static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Int Mic", NULL),
 	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
-			platform_clock_control, SND_SOC_DAPM_POST_PMD),
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route cht_rt5645_audio_map[] = {
@@ -225,6 +241,26 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 
 	rt5645_set_jack_detect(codec, &ctx->jack, &ctx->jack, &ctx->jack);
 
+	if (ctx->mclk) {
+		/*
+		 * The firmware might enable the clock at
+		 * boot (this information may or may not
+		 * be reflected in the enable clock register).
+		 * To change the rate we must disable the clock
+		 * first to cover these cases. Due to common
+		 * clock framework restrictions that do not allow
+		 * to disable a clock that has not been enabled,
+		 * we need to enable the clock first.
+		 */
+		ret = clk_prepare_enable(ctx->mclk);
+		if (!ret)
+			clk_disable_unprepare(ctx->mclk);
+
+		ret = clk_set_rate(ctx->mclk, CHT_PLAT_CLK_3_HZ);
+
+		if (ret)
+			dev_err(runtime->dev, "unable to set MCLK rate\n");
+	}
 	return ret;
 }
 
@@ -350,6 +386,18 @@ static struct cht_acpi_card snd_soc_cards[] = {
 
 static char cht_rt5640_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
 
+static bool is_valleyview(void)
+{
+	static const struct x86_cpu_id cpu_ids[] = {
+		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
+		{}
+	};
+
+	if (!x86_match_cpu(cpu_ids))
+		return false;
+	return true;
+}
+
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
@@ -392,6 +440,16 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		cht_dailink[dai_index].codec_name = cht_rt5640_codec_name;
 	}
 
+	if (is_valleyview()) {
+		drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+		if (IS_ERR(drv->mclk)) {
+			dev_err(&pdev->dev,
+				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
+				PTR_ERR(drv->mclk));
+			return PTR_ERR(drv->mclk);
+		}
+	}
+
 	snd_soc_card_set_drvdata(card, drv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret_val) {
-- 
2.7.4
