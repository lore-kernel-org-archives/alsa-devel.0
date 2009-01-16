From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: machine driver for Toshiba e800
Date: Fri, 16 Jan 2009 17:15:15 +0000
Message-ID: <1232126115-1966-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090116171347.GA1912@rakim.wolfsonmicro.main>
	<1232126115-1966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232126115-1966-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232126115-1966-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98FB52439E
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 18:15:16 +0100 (CET)
In-Reply-To: <1232126115-1966-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Ian Molton <ian@mnementh.co.uk>

This patch adds support for the wm9712 ac97 codec as used in the Toshiba e800
PDA. It includes support for powering up / down the external headphone and
speaker amplifiers on this machine.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-pxa/include/mach/eseries-gpio.h |    5 +
 sound/soc/pxa/e800_wm9712.c                   |  116 ++++++++++++++++++++++---
 2 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/eseries-gpio.h b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
index 02b28e0..6d6e4d8 100644
--- a/arch/arm/mach-pxa/include/mach/eseries-gpio.h
+++ b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
@@ -50,6 +50,11 @@
 #define GPIO_E750_SPK_AMP_OFF     7
 #define GPIO_E750_HP_DETECT      37
 
+/* e800 audio control GPIOs */
+#define GPIO_E800_HP_DETECT      81
+#define GPIO_E800_HP_AMP_OFF     82
+#define GPIO_E800_SPK_AMP_ON     83
+
 /* ASIC related GPIOs */
 #define GPIO_ESERIES_TMIO_IRQ        5
 #define GPIO_ESERIES_TMIO_PCLR      19
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 2e3386d..78a1770 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -1,8 +1,6 @@
 /*
  * e800-wm9712.c  --  SoC audio for e800
  *
- * Based on tosa.c
- *
  * Copyright 2007 (c) Ian Molton <spyro@f2s.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -13,31 +11,96 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/device.h>
+#include <linux/gpio.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-#include <asm/mach-types.h>
 #include <mach/pxa-regs.h>
 #include <mach/hardware.h>
 #include <mach/audio.h>
+#include <mach/eseries-gpio.h>
+
+#include <asm/mach-types.h>
 
 #include "../codecs/wm9712.h"
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"
 
-static struct snd_soc_card e800;
+static int e800_spk_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		gpio_set_value(GPIO_E800_SPK_AMP_ON, 1);
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		gpio_set_value(GPIO_E800_SPK_AMP_ON, 0);
 
-static struct snd_soc_dai_link e800_dai[] = {
+	return 0;
+}
+
+static int e800_hp_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
 {
-	.name = "AC97 Aux",
-	.stream_name = "AC97 Aux",
-	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
-	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
-},
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		gpio_set_value(GPIO_E800_HP_AMP_OFF, 0);
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		gpio_set_value(GPIO_E800_HP_AMP_OFF, 1);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget e800_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Mic (Internal1)", NULL),
+	SND_SOC_DAPM_MIC("Mic (Internal2)", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_PGA_E("Headphone Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e800_hp_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("Speaker Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e800_spk_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Jack", NULL, "HPOUTL"},
+	{"Headphone Jack", NULL, "HPOUTR"},
+	{"Headphone Jack", NULL, "Headphone Amp"},
+
+	{"Speaker Amp", NULL, "MONOOUT"},
+	{"Speaker", NULL, "Speaker Amp"},
+
+	{"MIC1", NULL, "Mic (Internal1)"},
+	{"MIC2", NULL, "Mic (Internal2)"},
+};
+
+static int e800_ac97_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_new_controls(codec, e800_dapm_widgets,
+					ARRAY_SIZE(e800_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link e800_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+		.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
+		.init = e800_ac97_init,
+	},
+	{
+		.name = "AC97 Aux",
+		.stream_name = "AC97 Aux",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+		.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
+	},
 };
 
 static struct snd_soc_card e800 = {
@@ -61,6 +124,22 @@ static int __init e800_init(void)
 	if (!machine_is_e800())
 		return -ENODEV;
 
+	ret = gpio_request(GPIO_E800_HP_AMP_OFF,  "Headphone amp");
+	if (ret)
+		return ret;
+
+	ret = gpio_request(GPIO_E800_SPK_AMP_ON, "Speaker amp");
+	if (ret)
+		goto free_hp_amp_gpio;
+
+	ret = gpio_direction_output(GPIO_E800_HP_AMP_OFF, 1);
+	if (ret)
+		goto free_spk_amp_gpio;
+
+	ret = gpio_direction_output(GPIO_E800_SPK_AMP_ON, 1);
+	if (ret)
+		goto free_spk_amp_gpio;
+
 	e800_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!e800_snd_device)
 		return -ENOMEM;
@@ -69,8 +148,15 @@ static int __init e800_init(void)
 	e800_snd_devdata.dev = &e800_snd_device->dev;
 	ret = platform_device_add(e800_snd_device);
 
-	if (ret)
-		platform_device_put(e800_snd_device);
+	if (!ret)
+		return 0;
+
+/* Fail gracefully */
+	platform_device_put(e800_snd_device);
+free_spk_amp_gpio:
+	gpio_free(GPIO_E800_SPK_AMP_ON);
+free_hp_amp_gpio:
+	gpio_free(GPIO_E800_HP_AMP_OFF);
 
 	return ret;
 }
@@ -78,6 +164,8 @@ static int __init e800_init(void)
 static void __exit e800_exit(void)
 {
 	platform_device_unregister(e800_snd_device);
+	gpio_free(GPIO_E800_SPK_AMP_ON);
+	gpio_free(GPIO_E800_HP_AMP_OFF);
 }
 
 module_init(e800_init);
@@ -86,4 +174,4 @@ module_exit(e800_exit);
 /* Module information */
 MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
 MODULE_DESCRIPTION("ALSA SoC driver for e800");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
1.5.6.5
