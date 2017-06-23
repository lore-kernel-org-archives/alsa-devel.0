From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: cht_bsw_rt5672: 19.2MHz clock
	for Baytrail platforms
Date: Fri, 23 Jun 2017 12:21:00 -0500
Message-ID: <20170623172101.29079-2-pierre-louis.bossart@linux.intel.com>
References: <20170623172101.29079-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DD1A8266AE9
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 19:21:21 +0200 (CEST)
In-Reply-To: <20170623172101.29079-1-pierre-louis.bossart@linux.intel.com>
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

Lenovo platforms use RT5670 with Baytrail, add the required
MCLK control and configuration to 19.2MHz

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96691
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 89 +++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index e4d46d4..bc2a52d 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -19,6 +19,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/clk.h>
+#include <asm/cpu_device_id.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -31,8 +33,11 @@
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"rt5670-aif1"
 
-static struct snd_soc_jack cht_bsw_headset;
-static char cht_bsw_codec_name[16];
+struct cht_mc_private {
+	struct snd_soc_jack headset;
+	char codec_name[16];
+	struct clk *mclk;
+};
 
 /* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin cht_bsw_headset_pins[] = {
@@ -64,6 +69,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_card *card = dapm->card;
 	struct snd_soc_dai *codec_dai;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 	int ret;
 
 	codec_dai = cht_get_codec_dai(card);
@@ -73,6 +79,15 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 	}
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		if (ctx->mclk) {
+			ret = clk_prepare_enable(ctx->mclk);
+			if (ret < 0) {
+				dev_err(card->dev,
+					"could not configure MCLK state");
+				return ret;
+			}
+		}
+
 		/* set codec PLL source to the 19.2MHz platform clock (MCLK) */
 		ret = snd_soc_dai_set_pll(codec_dai, 0, RT5670_PLL1_S_MCLK,
 				CHT_PLAT_CLK_3_HZ, 48000 * 512);
@@ -96,6 +111,9 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		 */
 		snd_soc_dai_set_sysclk(codec_dai, RT5670_SCLK_S_RCCLK,
 				       48000 * 512, SND_SOC_CLOCK_IN);
+
+		if (ctx->mclk)
+			clk_disable_unprepare(ctx->mclk);
 	}
 	return 0;
 }
@@ -171,6 +189,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	int ret;
 	struct snd_soc_dai *codec_dai = runtime->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 
 	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
 	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
@@ -194,13 +213,37 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 				RT5670_CLK_SEL_I2S1_ASRC);
 
         ret = snd_soc_card_jack_new(runtime->card, "Headset",
-                SND_JACK_HEADSET | SND_JACK_BTN_0 |
-                SND_JACK_BTN_1 | SND_JACK_BTN_2, &cht_bsw_headset,
-                cht_bsw_headset_pins, ARRAY_SIZE(cht_bsw_headset_pins));
+				    SND_JACK_HEADSET | SND_JACK_BTN_0 |
+				    SND_JACK_BTN_1 | SND_JACK_BTN_2,
+				    &ctx->headset,
+				    cht_bsw_headset_pins,
+				    ARRAY_SIZE(cht_bsw_headset_pins));
         if (ret)
                 return ret;
 
-	rt5670_set_jack_detect(codec, &cht_bsw_headset);
+	rt5670_set_jack_detect(codec, &ctx->headset);
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
+		if (ret) {
+			dev_err(runtime->dev, "unable to set MCLK rate\n");
+			return ret;
+		}
+	}
 	return 0;
 }
 
@@ -341,34 +384,62 @@ static struct snd_soc_card snd_soc_card_cht = {
 	.resume_post = cht_resume_post,
 };
 
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
 #define RT5672_I2C_DEFAULT	"i2c-10EC5670:00"
 
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
+	struct cht_mc_private *drv;
 	struct sst_acpi_mach *mach = pdev->dev.platform_data;
 	const char *i2c_name;
 	int i;
 
-	strcpy(cht_bsw_codec_name, RT5672_I2C_DEFAULT);
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
+	if (!drv)
+		return -ENOMEM;
+
+	strcpy(drv->codec_name, RT5672_I2C_DEFAULT);
 
 	/* fixup codec name based on HID */
 	if (mach) {
 		i2c_name = sst_acpi_find_name_from_hid(mach->id);
 		if (i2c_name) {
-			snprintf(cht_bsw_codec_name, sizeof(cht_bsw_codec_name),
+			snprintf(drv->codec_name, sizeof(drv->codec_name),
 				 "i2c-%s", i2c_name);
 			for (i = 0; i < ARRAY_SIZE(cht_dailink); i++) {
 				if (!strcmp(cht_dailink[i].codec_name,
 					    RT5672_I2C_DEFAULT)) {
 					cht_dailink[i].codec_name =
-						cht_bsw_codec_name;
+						drv->codec_name;
 					break;
 				}
 			}
 		}
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
+	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
+
 	/* register the soc card */
 	snd_soc_card_cht.dev = &pdev->dev;
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
-- 
2.9.3
