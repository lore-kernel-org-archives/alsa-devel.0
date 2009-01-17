From: Ian Molton <ian@mnementh.co.uk>
Subject: [Pull request] ASoC: machine support for Toshiba e740
	PDA
Date: Sat, 17 Jan 2009 15:20:32 +0000
Message-ID: <4971F740.3050204@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id B89192415F
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 16:19:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@sirena.org.uk>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi folks,

This is complete support for the wm9705 codec on the e740. Everything works.

Please review. Patch attached below the pull request.

Mark, if you want the pull request minus the other patchset in my tree 
(caching stuff) then I can redo. Otherwise, feel free to cherrypick.

Thanks,

-Ian

The following changes since commit 7ff27c9c1f7a7b7c86d3138060b1b406ad5dd6af:
   Ian Molton (1):
         ASoC: fixes to caching implementations

are available in the git repository at:

   git://git.mnementh.co.uk/linux-2.6-im.git asoc-pu

Ian Molton (1):
       ASoC: machine support for Toshiba e740 PDA

  arch/arm/mach-pxa/e740.c                      |    5 +
  arch/arm/mach-pxa/include/mach/eseries-gpio.h |    5 +
  sound/soc/pxa/Kconfig                         |    9 +
  sound/soc/pxa/Makefile                        |    2 +
  sound/soc/pxa/e740_wm9705.c                   |  213 
+++++++++++++++++++++++++
  5 files changed, 234 insertions(+), 0 deletions(-)
  create mode 100644 sound/soc/pxa/e740_wm9705.c



 From 45bf08e654a94cfc8933e57b7c275cf565783fe3 Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Sat, 17 Jan 2009 15:11:06 +0000
Subject: [PATCH] ASoC: machine support for Toshiba e740 PDA

This patch provides suupport for the wm9705 AC97 codec on the Toshiba e740.

Note:
The e740 has a hard headphone switch that turns the speaker off and is not
software detectable or controlable. Also both headphone and speaker amps
share a common output enable.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
  arch/arm/mach-pxa/e740.c                      |    5 +
  arch/arm/mach-pxa/include/mach/eseries-gpio.h |    5 +
  sound/soc/pxa/Kconfig                         |    9 +
  sound/soc/pxa/Makefile                        |    2 +
  sound/soc/pxa/e740_wm9705.c                   |  213 
+++++++++++++++++++++++++
  5 files changed, 234 insertions(+), 0 deletions(-)
  create mode 100644 sound/soc/pxa/e740_wm9705.c

diff --git a/arch/arm/mach-pxa/e740.c b/arch/arm/mach-pxa/e740.c
index 6d48e00..a6fff78 100644
--- a/arch/arm/mach-pxa/e740.c
+++ b/arch/arm/mach-pxa/e740.c
@@ -135,6 +135,11 @@ static unsigned long e740_pin_config[] __initdata = {
  	/* IrDA */
  	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,

+	/* Audio power control */
+	GPIO16_GPIO,  /* AC97 codec AVDD2 supply (analogue power) */
+	GPIO40_GPIO,  /* Mic amp power */
+	GPIO41_GPIO,  /* Headphone amp power */
+
  	/* PC Card */
  	GPIO8_GPIO,   /* CD0 */
  	GPIO44_GPIO,  /* CD1 */
diff --git a/arch/arm/mach-pxa/include/mach/eseries-gpio.h 
b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
index 6d6e4d8..f3e5509 100644
--- a/arch/arm/mach-pxa/include/mach/eseries-gpio.h
+++ b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
@@ -45,6 +45,11 @@
  /* e7xx IrDA power control */
  #define GPIO_E7XX_IR_OFF         38

+/* e740 audio control GPIOs */
+#define GPIO_E740_WM9705_nAVDD2  16
+#define GPIO_E740_MIC_ON         40
+#define GPIO_E740_AMP_ON         41
+
  /* e750 audio control GPIOs */
  #define GPIO_E750_HP_AMP_OFF      4
  #define GPIO_E750_SPK_AMP_OFF     7
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index b9b1a3f..958ac3f 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -61,6 +61,15 @@ config SND_PXA2XX_SOC_TOSA
  	  Say Y if you want to add support for SoC audio on Sharp
  	  Zaurus SL-C6000x models (Tosa).

+config SND_PXA2XX_SOC_E740
+	tristate "SoC AC97 Audio support for e740"
+	depends on SND_PXA2XX_SOC && MACH_E740
+	select SND_SOC_WM9705
+	select SND_PXA2XX_SOC_AC97
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  toshiba e740 PDA
+
  config SND_PXA2XX_SOC_E750
  	tristate "SoC AC97 Audio support for e750"
  	depends on SND_PXA2XX_SOC && MACH_E750
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index c7d4cce..97a51a8 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
  snd-soc-corgi-objs := corgi.o
  snd-soc-poodle-objs := poodle.o
  snd-soc-tosa-objs := tosa.o
+snd-soc-e740-objs := e740_wm9705.o
  snd-soc-e750-objs := e750_wm9705.o
  snd-soc-e800-objs := e800_wm9712.o
  snd-soc-spitz-objs := spitz.o
@@ -23,6 +24,7 @@ snd-soc-zylonite-objs := zylonite.o
  obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
  obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
  obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
+obj-$(CONFIG_SND_PXA2XX_SOC_E740) += snd-soc-e740.o
  obj-$(CONFIG_SND_PXA2XX_SOC_E750) += snd-soc-e750.o
  obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
  obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
new file mode 100644
index 0000000..ac36176
--- /dev/null
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -0,0 +1,213 @@
+/*
+ * e740-wm9705.c  --  SoC audio for e740
+ *
+ * Copyright 2007 (c) Ian Molton <spyro@f2s.com>
+ *
+ *  This program is free software; you can redistribute  it and/or 
modify it
+ *  under  the terms of  the GNU General  Public License as published 
by the
+ *  Free Software Foundation; version 2 ONLY.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/gpio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <mach/pxa-regs.h>
+#include <mach/hardware.h>
+#include <mach/audio.h>
+#include <mach/eseries-gpio.h>
+
+#include <asm/mach-types.h>
+
+#include "../codecs/wm9705.h"
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
+
+
+#define E740_AUDIO_OUT 1
+#define E740_AUDIO_IN  2
+
+static int e740_audio_power;
+
+static void e740_sync_audio_power(int status)
+{
+	gpio_set_value(GPIO_E740_WM9705_nAVDD2, !status);
+	gpio_set_value(GPIO_E740_AMP_ON, (status & E740_AUDIO_OUT) ? 1 : 0);
+	gpio_set_value(GPIO_E740_MIC_ON, (status & E740_AUDIO_IN) ? 1 : 0);
+}
+
+static int e740_mic_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		e740_audio_power |= E740_AUDIO_IN;
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		e740_audio_power &= ~E740_AUDIO_IN;
+
+	e740_sync_audio_power(e740_audio_power);
+
+	return 0;
+}
+
+static int e740_output_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		e740_audio_power |= E740_AUDIO_OUT;
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		e740_audio_power &= ~E740_AUDIO_OUT;
+
+	e740_sync_audio_power(e740_audio_power);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget e740_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Mic (Internal)", NULL),
+	SND_SOC_DAPM_PGA_E("Output Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e740_output_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("Mic Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e740_mic_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Output Amp", NULL, "LOUT"},
+	{"Output Amp", NULL, "ROUT"},
+	{"Output Amp", NULL, "MONOOUT"},
+
+	{"Speaker", NULL, "Output Amp"},
+	{"Headphone Jack", NULL, "Output Amp"},
+
+	{"MIC1", NULL, "Mic Amp"},
+	{"Mic Amp", NULL, "Mic (Internal)"},
+};
+
+static int e740_ac97_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_nc_pin(codec, "HPOUTL");
+	snd_soc_dapm_nc_pin(codec, "HPOUTR");
+	snd_soc_dapm_nc_pin(codec, "PHONE");
+	snd_soc_dapm_nc_pin(codec, "LINEINL");
+	snd_soc_dapm_nc_pin(codec, "LINEINR");
+	snd_soc_dapm_nc_pin(codec, "CDINL");
+	snd_soc_dapm_nc_pin(codec, "CDINR");
+	snd_soc_dapm_nc_pin(codec, "PCBEEP");
+	snd_soc_dapm_nc_pin(codec, "MIC2");
+
+	snd_soc_dapm_new_controls(codec, e740_dapm_widgets,
+					ARRAY_SIZE(e740_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link e740_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+		.codec_dai = &wm9705_dai[WM9705_DAI_AC97_HIFI],
+		.init = e740_ac97_init,
+	},
+	{
+		.name = "AC97 Aux",
+		.stream_name = "AC97 Aux",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+		.codec_dai = &wm9705_dai[WM9705_DAI_AC97_AUX],
+	},
+};
+
+static struct snd_soc_card e740 = {
+	.name = "Toshiba e740",
+	.platform = &pxa2xx_soc_platform,
+	.dai_link = e740_dai,
+	.num_links = ARRAY_SIZE(e740_dai),
+};
+
+static struct snd_soc_device e740_snd_devdata = {
+	.card = &e740,
+	.codec_dev = &soc_codec_dev_wm9705,
+};
+
+static struct platform_device *e740_snd_device;
+
+static int __init e740_init(void)
+{
+	int ret;
+
+	if (!machine_is_e740())
+		return -ENODEV;
+
+	ret = gpio_request(GPIO_E740_MIC_ON,  "Mic amp");
+	if (ret)
+		return ret;
+
+	ret = gpio_request(GPIO_E740_AMP_ON, "Output amp");
+	if (ret)
+		goto free_mic_amp_gpio;
+
+	ret = gpio_request(GPIO_E740_WM9705_nAVDD2, "Audio power");
+	if (ret)
+		goto free_op_amp_gpio;
+
+	/* Disable audio */
+	ret = gpio_direction_output(GPIO_E740_MIC_ON, 0);
+	if (ret)
+		goto free_apwr_gpio;
+	ret = gpio_direction_output(GPIO_E740_AMP_ON, 0);
+	if (ret)
+		goto free_apwr_gpio;
+	ret = gpio_direction_output(GPIO_E740_WM9705_nAVDD2, 1);
+	if (ret)
+		goto free_apwr_gpio;
+
+	e740_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!e740_snd_device) {
+		ret = -ENOMEM;
+		goto free_apwr_gpio;
+	}
+
+	platform_set_drvdata(e740_snd_device, &e740_snd_devdata);
+	e740_snd_devdata.dev = &e740_snd_device->dev;
+	ret = platform_device_add(e740_snd_device);
+
+	if (!ret)
+		return 0;
+
+/* Fail gracefully */
+	platform_device_put(e740_snd_device);
+free_apwr_gpio:
+	gpio_free(GPIO_E740_WM9705_nAVDD2);
+free_op_amp_gpio:
+	gpio_free(GPIO_E740_AMP_ON);
+free_mic_amp_gpio:
+	gpio_free(GPIO_E740_MIC_ON);
+
+	return ret;
+}
+
+static void __exit e740_exit(void)
+{
+	platform_device_unregister(e740_snd_device);
+}
+
+module_init(e740_init);
+module_exit(e740_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
+MODULE_DESCRIPTION("ALSA SoC driver for e740");
+MODULE_LICENSE("GPL v2");
-- 
1.5.6.5
