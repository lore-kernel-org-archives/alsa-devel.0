From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: machine driver for Toshiba e750
Date: Fri, 16 Jan 2009 17:15:14 +0000
Message-ID: <1232126115-1966-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090116171347.GA1912@rakim.wolfsonmicro.main>
	<1232126115-1966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232126115-1966-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A74B2243A1
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 18:15:16 +0100 (CET)
In-Reply-To: <1232126115-1966-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

This patch adds support for the wm9705 ac97 codec as used in the Toshiba e750
PDA. It includes support for powering up / down the external headphone and
speaker amplifiers on this machine.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-pxa/e750.c                      |    5 +
 arch/arm/mach-pxa/include/mach/eseries-gpio.h |    5 +
 sound/soc/pxa/Kconfig                         |    9 ++
 sound/soc/pxa/Makefile                        |    2 +
 sound/soc/pxa/e750_wm9705.c                   |  189 +++++++++++++++++++++++++
 5 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/e750_wm9705.c

diff --git a/arch/arm/mach-pxa/e750.c b/arch/arm/mach-pxa/e750.c
index be1ab8e..665066f 100644
--- a/arch/arm/mach-pxa/e750.c
+++ b/arch/arm/mach-pxa/e750.c
@@ -133,6 +133,11 @@ static unsigned long e750_pin_config[] __initdata = {
 	/* IrDA */
 	GPIO38_GPIO | MFP_LPM_DRIVE_HIGH,
 
+	/* Audio power control */
+	GPIO4_GPIO,  /* Headphone amp power */
+	GPIO7_GPIO,  /* Speaker amp power */
+	GPIO37_GPIO, /* Headphone detect */
+
 	/* PC Card */
 	GPIO8_GPIO,   /* CD0 */
 	GPIO44_GPIO,  /* CD1 */
diff --git a/arch/arm/mach-pxa/include/mach/eseries-gpio.h b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
index efbd2aa..02b28e0 100644
--- a/arch/arm/mach-pxa/include/mach/eseries-gpio.h
+++ b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
@@ -45,6 +45,11 @@
 /* e7xx IrDA power control */
 #define GPIO_E7XX_IR_OFF         38
 
+/* e750 audio control GPIOs */
+#define GPIO_E750_HP_AMP_OFF      4
+#define GPIO_E750_SPK_AMP_OFF     7
+#define GPIO_E750_HP_DETECT      37
+
 /* ASIC related GPIOs */
 #define GPIO_ESERIES_TMIO_IRQ        5
 #define GPIO_ESERIES_TMIO_PCLR      19
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index f82e106..b9b1a3f 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -61,6 +61,15 @@ config SND_PXA2XX_SOC_TOSA
 	  Say Y if you want to add support for SoC audio on Sharp
 	  Zaurus SL-C6000x models (Tosa).
 
+config SND_PXA2XX_SOC_E750
+	tristate "SoC AC97 Audio support for e750"
+	depends on SND_PXA2XX_SOC && MACH_E750
+	select SND_SOC_WM9705
+	select SND_PXA2XX_SOC_AC97
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  toshiba e750 PDA
+
 config SND_PXA2XX_SOC_E800
 	tristate "SoC AC97 Audio support for e800"
 	depends on SND_PXA2XX_SOC && MACH_E800
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 08a9f27..c7d4cce 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SND_PXA_SOC_SSP) += snd-soc-pxa-ssp.o
 snd-soc-corgi-objs := corgi.o
 snd-soc-poodle-objs := poodle.o
 snd-soc-tosa-objs := tosa.o
+snd-soc-e750-objs := e750_wm9705.o
 snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
 snd-soc-em-x270-objs := em-x270.o
@@ -22,6 +23,7 @@ snd-soc-zylonite-objs := zylonite.o
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
 obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
+obj-$(CONFIG_SND_PXA2XX_SOC_E750) += snd-soc-e750.o
 obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
 obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
new file mode 100644
index 0000000..20fbdcf
--- /dev/null
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -0,0 +1,189 @@
+/*
+ * e750-wm9705.c  --  SoC audio for e750
+ *
+ * Copyright 2007 (c) Ian Molton <spyro@f2s.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
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
+static int e750_spk_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		gpio_set_value(GPIO_E750_SPK_AMP_OFF, 0);
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		gpio_set_value(GPIO_E750_SPK_AMP_OFF, 1);
+
+	return 0;
+}
+
+static int e750_hp_amp_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	if (event & SND_SOC_DAPM_PRE_PMU)
+		gpio_set_value(GPIO_E750_HP_AMP_OFF, 0);
+	else if (event & SND_SOC_DAPM_POST_PMD)
+		gpio_set_value(GPIO_E750_HP_AMP_OFF, 1);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget e750_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Mic (Internal)", NULL),
+	SND_SOC_DAPM_PGA_E("Headphone Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e750_hp_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA_E("Speaker Amp", SND_SOC_NOPM, 0, 0, NULL, 0,
+			e750_spk_amp_event, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"Headphone Amp", NULL, "HPOUTL"},
+	{"Headphone Amp", NULL, "HPOUTR"},
+	{"Headphone Jack", NULL, "Headphone Amp"},
+
+	{"Speaker Amp", NULL, "MONOOUT"},
+	{"Speaker", NULL, "Speaker Amp"},
+
+	{"MIC1", NULL, "Mic (Internal)"},
+};
+
+static int e750_ac97_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_nc_pin(codec, "LOUT");
+	snd_soc_dapm_nc_pin(codec, "ROUT");
+	snd_soc_dapm_nc_pin(codec, "PHONE");
+	snd_soc_dapm_nc_pin(codec, "LINEINL");
+	snd_soc_dapm_nc_pin(codec, "LINEINR");
+	snd_soc_dapm_nc_pin(codec, "CDINL");
+	snd_soc_dapm_nc_pin(codec, "CDINR");
+	snd_soc_dapm_nc_pin(codec, "PCBEEP");
+	snd_soc_dapm_nc_pin(codec, "MIC2");
+
+	snd_soc_dapm_new_controls(codec, e750_dapm_widgets,
+					ARRAY_SIZE(e750_dapm_widgets));
+
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_sync(codec);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link e750_dai[] = {
+	{
+		.name = "AC97",
+		.stream_name = "AC97 HiFi",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+		.codec_dai = &wm9705_dai[WM9705_DAI_AC97_HIFI],
+		.init = e750_ac97_init,
+		/* use ops to check startup state */
+	},
+	{
+		.name = "AC97 Aux",
+		.stream_name = "AC97 Aux",
+		.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+		.codec_dai = &wm9705_dai[WM9705_DAI_AC97_AUX],
+	},
+};
+
+static struct snd_soc_card e750 = {
+	.name = "Toshiba e750",
+	.platform = &pxa2xx_soc_platform,
+	.dai_link = e750_dai,
+	.num_links = ARRAY_SIZE(e750_dai),
+};
+
+static struct snd_soc_device e750_snd_devdata = {
+	.card = &e750,
+	.codec_dev = &soc_codec_dev_wm9705,
+};
+
+static struct platform_device *e750_snd_device;
+
+static int __init e750_init(void)
+{
+	int ret;
+
+	if (!machine_is_e750())
+		return -ENODEV;
+
+	ret = gpio_request(GPIO_E750_HP_AMP_OFF,  "Headphone amp");
+	if (ret)
+		return ret;
+
+	ret = gpio_request(GPIO_E750_SPK_AMP_OFF, "Speaker amp");
+	if (ret)
+		goto free_hp_amp_gpio;
+
+	ret = gpio_direction_output(GPIO_E750_HP_AMP_OFF, 1);
+	if (ret)
+		goto free_spk_amp_gpio;
+
+	ret = gpio_direction_output(GPIO_E750_SPK_AMP_OFF, 1);
+	if (ret)
+		goto free_spk_amp_gpio;
+
+	e750_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!e750_snd_device) {
+		ret = -ENOMEM;
+		goto free_spk_amp_gpio;
+	}
+
+	platform_set_drvdata(e750_snd_device, &e750_snd_devdata);
+	e750_snd_devdata.dev = &e750_snd_device->dev;
+	ret = platform_device_add(e750_snd_device);
+
+	if (!ret)
+		return 0;
+
+/* Fail gracefully */
+	platform_device_put(e750_snd_device);
+free_spk_amp_gpio:
+	gpio_free(GPIO_E750_SPK_AMP_OFF);
+free_hp_amp_gpio:
+	gpio_free(GPIO_E750_HP_AMP_OFF);
+
+	return ret;
+}
+
+static void __exit e750_exit(void)
+{
+	platform_device_unregister(e750_snd_device);
+	gpio_free(GPIO_E750_SPK_AMP_OFF);
+	gpio_free(GPIO_E750_HP_AMP_OFF);
+}
+
+module_init(e750_init);
+module_exit(e750_exit);
+
+/* Module information */
+MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
+MODULE_DESCRIPTION("ALSA SoC driver for e750");
+MODULE_LICENSE("GPL v2");
-- 
1.5.6.5
