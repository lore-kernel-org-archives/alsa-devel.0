From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: start merging byt-rt5640
	drivers" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:33 +0000
Message-ID: <E1aAG2v-0004g4-Od@debutante>
References: <1450406156-22246-5-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BF3D260600
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:39 +0100 (CET)
In-Reply-To: <1450406156-22246-5-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: start merging byt-rt5640 drivers

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a2d5563bc6655f25e23f3c2c700d601ef077499e Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 17 Dec 2015 20:35:41 -0600
Subject: [PATCH] ASoC: Intel: boards: start merging byt-rt5640 drivers

first renaming and reducing delta with byt-rt5640 code before
dmi-based quirks are enabled

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c   |   2 +-
 sound/soc/intel/boards/bytcr_rt5640.c | 128 ++++++++++++++++++++++++----------
 2 files changed, 93 insertions(+), 37 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index f3d109eb3800..f424460b917e 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -314,7 +314,7 @@ static int sst_acpi_remove(struct platform_device *pdev)
 }
 
 static struct sst_acpi_mach sst_acpi_bytcr[] = {
-	{"10EC5640", "bytt100_rt5640", "intel/fw_sst_0f28.bin", "T100", NULL,
+	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
 						&byt_rvp_platform_data },
 	{},
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 694061c4c649..8dfb57d96985 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -20,23 +20,25 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/slab.h>
-#include <linux/input.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
 #include "../../codecs/rt5640.h"
 #include "../atom/sst-atom-controls.h"
 
-static const struct snd_soc_dapm_widget byt_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIC("Internal Mic", NULL),
 	SND_SOC_DAPM_SPK("Speaker", NULL),
 };
 
-static const struct snd_soc_dapm_route byt_audio_map[] = {
+static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
 	{"Headset Mic", NULL, "MICBIAS1"},
 	{"IN2P", NULL, "Headset Mic"},
 	{"Headphone", NULL, "HPOL"},
@@ -56,14 +58,39 @@ static const struct snd_soc_dapm_route byt_audio_map[] = {
 	{"ssp2 Rx", NULL, "AIF1 Capture"},
 };
 
-static const struct snd_kcontrol_new byt_mc_controls[] = {
+static const struct snd_soc_dapm_route byt_rt5640_intmic_dmic1_map[] = {
+	{"DMIC1", NULL, "Internal Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5640_intmic_dmic2_map[] = {
+	{"DMIC2", NULL, "Internal Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5640_intmic_in1_map[] = {
+	{"Internal Mic", NULL, "MICBIAS1"},
+	{"IN1P", NULL, "Internal Mic"},
+};
+
+enum {
+	BYT_RT5640_DMIC1_MAP,
+	BYT_RT5640_DMIC2_MAP,
+	BYT_RT5640_IN1_MAP,
+};
+
+#define BYT_RT5640_MAP(quirk)	((quirk) & 0xff)
+#define BYT_RT5640_DMIC_EN	BIT(16)
+
+static unsigned long byt_rt5640_quirk = BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_DMIC_EN;
+
+static const struct snd_kcontrol_new byt_rt5640_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Internal Mic"),
 	SOC_DAPM_PIN_SWITCH("Speaker"),
 };
 
-static int byt_aif1_hw_params(struct snd_pcm_substream *substream,
+static int byt_rt5640_aif1_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -91,7 +118,34 @@ static int byt_aif1_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_pcm_stream byt_dai_params = {
+static int byt_rt5640_quirk_cb(const struct dmi_system_id *id)
+{
+	byt_rt5640_quirk = (unsigned long)id->driver_data;
+	return 1;
+}
+
+static const struct dmi_system_id byt_rt5640_quirk_table[] = {
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+		},
+		.driver_data = (unsigned long *)BYT_RT5640_IN1_MAP,
+	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DellInc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5640_DMIC2_MAP |
+						 BYT_RT5640_DMIC_EN),
+	},
+	{}
+};
+
+static const struct snd_soc_pcm_stream byt_rt5640_dai_params = {
 	.formats = SNDRV_PCM_FMTBIT_S24_LE,
 	.rate_min = 48000,
 	.rate_max = 48000,
@@ -99,7 +153,7 @@ static const struct snd_soc_pcm_stream byt_dai_params = {
 	.channels_max = 2,
 };
 
-static int byt_codec_fixup(struct snd_soc_pcm_runtime *rtd,
+static int byt_rt5640_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 			    struct snd_pcm_hw_params *params)
 {
 	struct snd_interval *rate = hw_param_interval(params,
@@ -139,21 +193,21 @@ static int byt_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int byt_aif1_startup(struct snd_pcm_substream *substream)
+static int byt_rt5640_aif1_startup(struct snd_pcm_substream *substream)
 {
 	return snd_pcm_hw_constraint_single(substream->runtime,
 			SNDRV_PCM_HW_PARAM_RATE, 48000);
 }
 
-static struct snd_soc_ops byt_aif1_ops = {
-	.startup = byt_aif1_startup,
+static struct snd_soc_ops byt_rt5640_aif1_ops = {
+	.startup = byt_rt5640_aif1_startup,
 };
 
-static struct snd_soc_ops byt_be_ssp2_ops = {
-	.hw_params = byt_aif1_hw_params,
+static struct snd_soc_ops byt_rt5640_be_ssp2_ops = {
+	.hw_params = byt_rt5640_aif1_hw_params,
 };
 
-static struct snd_soc_dai_link byt_dailink[] = {
+static struct snd_soc_dai_link byt_rt5640_dais[] = {
 	[MERR_DPCM_AUDIO] = {
 		.name = "Baytrail Audio Port",
 		.stream_name = "Baytrail Audio",
@@ -165,7 +219,7 @@ static struct snd_soc_dai_link byt_dailink[] = {
 		.dynamic = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-		.ops = &byt_aif1_ops,
+		.ops = &byt_rt5640_aif1_ops,
 	},
 	[MERR_DPCM_COMPR] = {
 		.name = "Baytrail Compressed Port",
@@ -186,55 +240,57 @@ static struct snd_soc_dai_link byt_dailink[] = {
 		.codec_name = "i2c-10EC5640:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 						| SND_SOC_DAIFMT_CBS_CFS,
-		.be_hw_params_fixup = byt_codec_fixup,
+		.be_hw_params_fixup = byt_rt5640_codec_fixup,
 		.ignore_suspend = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-		.ops = &byt_be_ssp2_ops,
+		.ops = &byt_rt5640_be_ssp2_ops,
 	},
 };
 
 /* SoC card */
-static struct snd_soc_card snd_soc_card_byt = {
-	.name = "baytrailcraudio",
+static struct snd_soc_card snd_soc_card_byt_rt5640 = {
+	.name = "bytcr-rt5640",
 	.owner = THIS_MODULE,
-	.dai_link = byt_dailink,
-	.num_links = ARRAY_SIZE(byt_dailink),
-	.dapm_widgets = byt_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(byt_dapm_widgets),
-	.dapm_routes = byt_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(byt_audio_map),
-	.controls = byt_mc_controls,
-	.num_controls = ARRAY_SIZE(byt_mc_controls),
+	.dai_link = byt_rt5640_dais,
+	.num_links = ARRAY_SIZE(byt_rt5640_dais),
+	.dapm_widgets = byt_rt5640_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_rt5640_widgets),
+	.dapm_routes = byt_rt5640_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_rt5640_audio_map),
+	.controls = byt_rt5640_controls,
+	.num_controls = ARRAY_SIZE(byt_rt5640_controls),
 };
 
-static int snd_byt_mc_probe(struct platform_device *pdev)
+static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
 
 	/* register the soc card */
-	snd_soc_card_byt.dev = &pdev->dev;
+	snd_soc_card_byt_rt5640.dev = &pdev->dev;
 
-	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_byt);
+	ret_val = devm_snd_soc_register_card(&pdev->dev,
+					&snd_soc_card_byt_rt5640);
 	if (ret_val) {
-		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n", ret_val);
+		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
+			ret_val);
 		return ret_val;
 	}
-	platform_set_drvdata(pdev, &snd_soc_card_byt);
+	platform_set_drvdata(pdev, &snd_soc_card_byt_rt5640);
 	return ret_val;
 }
 
-static struct platform_driver snd_byt_mc_driver = {
+static struct platform_driver snd_byt_rt5640_mc_driver = {
 	.driver = {
-		.name = "bytt100_rt5640",
+		.name = "bytcr_rt5640",
 		.pm = &snd_soc_pm_ops,
 	},
-	.probe = snd_byt_mc_probe,
+	.probe = snd_byt_rt5640_mc_probe,
 };
 
-module_platform_driver(snd_byt_mc_driver);
+module_platform_driver(snd_byt_rt5640_mc_driver);
 
 MODULE_DESCRIPTION("ASoC Intel(R) Baytrail CR Machine driver");
 MODULE_AUTHOR("Subhransu S. Prusty <subhransu.s.prusty@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:bytt100_rt5640");
+MODULE_ALIAS("platform:bytcr_rt5640");
-- 
2.6.2
