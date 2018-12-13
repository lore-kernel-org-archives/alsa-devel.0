From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH v3 0/1] Add a new machine driver kbl_rt5660
Date: Thu, 13 Dec 2018 21:02:15 +0800
Message-ID: <20181213130216.4558-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 03A93267BB0
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 14:02:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, naveen.m@intel.com
List-Id: alsa-devel@alsa-project.org

In the V3, I addressed all comments in the V2 except one, the one is
about:
	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
I tried to change it to:
	runtime->hw.formats = SNDRV_PCM_FMTBIT_S24_LE;
	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
But there is only noise when playing sound or recording sound, so I
keep it as it is in the v2.

Here I paste the diff between V3 and V2, this is the change I did in the v3:
 sound/soc/intel/boards/kbl_rt5660.c           | 59 +++++++++++--------
 .../intel/common/soc-acpi-intel-kbl-match.c   |  5 ++
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index 0482e6a7fc2a..1dd9b32d612c 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright(c) 2018-19 Intel Corporation.
+// Copyright(c) 2018-19 Canonical Corporation.
 
 /*
  * Intel Kabylake I2S Machine Driver with RT5660 Codec
@@ -61,7 +61,7 @@ static const struct acpi_gpio_params mic_det_gpio = { GPIO_LINEIN_DET_INDEX, 0,
 
 
 static const struct acpi_gpio_mapping acpi_rt5660_gpios[] = {
-	{ "lineout-mute-gpios", &lineout_mute_gpio , 1 },
+	{ "lineout-mute-gpios", &lineout_mute_gpio, 1 },
 	{ "lineout-det-gpios", &lineout_det_gpio, 1 },
 	{ "mic-det-gpios", &mic_det_gpio, 1 },
 	{ NULL },
@@ -109,8 +109,6 @@ static const struct snd_kcontrol_new kabylake_rt5660_controls[] = {
 static const struct snd_soc_dapm_widget kabylake_rt5660_widgets[] = {
 	SND_SOC_DAPM_MIC("Line In", NULL),
 	SND_SOC_DAPM_LINE("Line Out", kabylake_5660_event_lineout),
-	SND_SOC_DAPM_SPK("DP", NULL),
-	SND_SOC_DAPM_SPK("HDMI", NULL),
 };
 
 static const struct snd_soc_dapm_route kabylake_rt5660_map[] = {
@@ -127,10 +125,12 @@ static const struct snd_soc_dapm_route kabylake_rt5660_map[] = {
 	{ "codec0_in", NULL, "ssp0 Rx" },
 	{ "ssp0 Rx", NULL, "AIF1 Capture" },
 
-	{ "hifi2", NULL, "iDisp2 Tx"},
-	{ "iDisp2 Tx", NULL, "iDisp2_out"},
 	{ "hifi1", NULL, "iDisp1 Tx"},
 	{ "iDisp1 Tx", NULL, "iDisp1_out"},
+	{ "hifi2", NULL, "iDisp2 Tx"},
+	{ "iDisp2 Tx", NULL, "iDisp2_out"},
+	{ "hifi3", NULL, "iDisp3 Tx"},
+	{ "iDisp3 Tx", NULL, "iDisp3_out"},
 };
 
 static int kabylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -164,35 +164,42 @@ static int kabylake_rt5660_codec_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret)
 		dev_warn(component->dev, "Failed to add driver gpios\n");
 
-	/* Request rt5660 GPIO for lineout mute control */
+	/* Request rt5660 GPIO for lineout mute control, return if fails */
 	ctx->gpio_lo_mute = devm_gpiod_get(component->dev, "lineout-mute",
-			GPIOD_OUT_HIGH);
+					   GPIOD_OUT_HIGH);
 	if (IS_ERR(ctx->gpio_lo_mute)) {
 		dev_err(component->dev, "Can't find GPIO_MUTE# gpio\n");
 		return PTR_ERR(ctx->gpio_lo_mute);
 	}
 
-	/* Create and initialize headphone jack */
-	if (!snd_soc_card_jack_new(rtd->card, "Lineout Jack",
-			SND_JACK_LINEOUT, &lineout_jack,
-			&lineout_jack_pin, 1)) {
+	/* Create and initialize headphone jack, this jack is not mandatory, don't return if fails */
+	ret = snd_soc_card_jack_new(rtd->card, "Lineout Jack",
+				    SND_JACK_LINEOUT, &lineout_jack,
+				    &lineout_jack_pin, 1);
+	if (ret)
+		dev_warn(component->dev, "Can't create Lineout jack\n");
+	else {
 		lineout_jack_gpio.gpiod_dev = component->dev;
-		if (snd_soc_jack_add_gpios(&lineout_jack, 1,
-				&lineout_jack_gpio))
-			dev_err(component->dev, "Can't add Lineout jack gpio\n");
-	} else
-		dev_err(component->dev, "Can't create Lineout jack\n");
-
-	/* Create and initialize mic jack */
-	if (!snd_soc_card_jack_new(rtd->card, "Mic Jack",
-			SND_JACK_MICROPHONE, &mic_jack,
-			&mic_jack_pin, 1)) {
+		ret = snd_soc_jack_add_gpios(&lineout_jack, 1,
+					     &lineout_jack_gpio);
+		if (ret)
+			dev_warn(component->dev, "Can't add Lineout jack gpio\n");
+	}
+
+	/* Create and initialize mic jack, this jack is not mandatory, don't return if fails */
+	ret = snd_soc_card_jack_new(rtd->card, "Mic Jack",
+				    SND_JACK_MICROPHONE, &mic_jack,
+				    &mic_jack_pin, 1);
+	if (ret)
+		dev_warn(component->dev, "Can't create mic jack\n");
+	else {
 		mic_jack_gpio.gpiod_dev = component->dev;
-		if (snd_soc_jack_add_gpios(&mic_jack, 1, &mic_jack_gpio))
-			dev_err(component->dev, "Can't add mic jack gpio\n");
-	} else
-		dev_err(component->dev, "Can't create mic jack\n");
+		ret = snd_soc_jack_add_gpios(&mic_jack, 1, &mic_jack_gpio);
+		if (ret)
+			dev_warn(component->dev, "Can't add mic jack gpio\n");
+	}
 
+	/* Here we enable some dapms in advance to reduce the pop noise for recording via line-in */
 	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
 	snd_soc_dapm_force_enable_pin(dapm, "BST1");
 	snd_soc_dapm_force_enable_pin(dapm, "BST2");
diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
index 1e41c7ded9e9..e6fa6f470526 100644
--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
@@ -96,6 +96,11 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
 		.quirk_data = &kbl_7219_98927_codecs,
 		.pdata = &skl_dmic_data
 	},
+	{
+		.id = "10EC5660",
+		.drv_name = "kbl_rt5660",
+		.fw_filename = "intel/dsp_fw_kbl.bin",
+	},
 	{
 		.id = "10EC3277",
 		.drv_name = "kbl_rt5660",

Hui Wang (1):
  ASoC: Intel: kbl_rt5660: Add a new machine driver for kbl with rt5660

 sound/soc/intel/boards/Kconfig                |  10 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/kbl_rt5660.c           | 543 ++++++++++++++++++
 .../intel/common/soc-acpi-intel-kbl-match.c   |  10 +
 4 files changed, 565 insertions(+)
 create mode 100644 sound/soc/intel/boards/kbl_rt5660.c

-- 
2.17.1
