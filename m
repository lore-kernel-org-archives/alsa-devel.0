From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Add Palm/PXA27x unified ASoC audio
	driver
Date: Wed,  5 Nov 2008 18:53:29 +0000
Message-ID: <1225911211-22474-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081105185220.GA10816@rakim.wolfsonmicro.main>
	<1225911211-22474-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 54B632436C
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 19:53:33 +0100 (CET)
In-Reply-To: <1225911211-22474-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Marek Vasut <marek.vasut@gmail.com>

this patch adds asoc audio driver for pxa27x based Palm PDAs. I tested it for
palmtx, t5 and ld, it should work with palmz72 as well (slapin, please test).
I sent it here some time ago, but now I got to fixing bugs in it. It should
be somehow mostly ok and ready for applying.

[Converted to use snd_soc_dapm_nc_pin() -- broonie]

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-pxa/include/mach/palmasoc.h |   13 ++
 sound/soc/pxa/Kconfig                     |    9 +
 sound/soc/pxa/Makefile                    |    2 +
 sound/soc/pxa/palm27x.c                   |  269 +++++++++++++++++++++++++++++
 4 files changed, 293 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/palmasoc.h
 create mode 100644 sound/soc/pxa/palm27x.c

diff --git a/arch/arm/mach-pxa/include/mach/palmasoc.h b/arch/arm/mach-pxa/include/mach/palmasoc.h
new file mode 100644
index 0000000..6c4b1f7
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/palmasoc.h
@@ -0,0 +1,13 @@
+#ifndef _INCLUDE_PALMASOC_H_
+#define _INCLUDE_PALMASOC_H_
+struct palm27x_asoc_info {
+	int	jack_gpio;
+};
+
+#ifdef CONFIG_SND_PXA2XX_SOC_PALM27X
+void __init palm27x_asoc_set_pdata(struct palm27x_asoc_info *data);
+#else
+static inline void palm27x_asoc_set_pdata(struct palm27x_asoc_info *data) {}
+#endif
+
+#endif
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 4235524..1187603 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -79,6 +79,15 @@ config SND_PXA2XX_SOC_EM_X270
 	  Say Y if you want to add support for SoC audio on
 	  CompuLab EM-x270.
 
+config SND_PXA2XX_SOC_PALM27X
+	tristate "SoC Audio support for Palm T|X, T5 and LifeDrive"
+	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || MACH_PALMT5)
+	select SND_PXA2XX_SOC_AC97
+	select SND_SOC_WM9712
+	help
+	  Say Y if you want to add support for SoC audio on
+	  Palm T|X, T5 or LifeDrive handheld computer.
+
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 00258ab..1a3a36e 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -16,6 +16,7 @@ snd-soc-tosa-objs := tosa.o
 snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
 snd-soc-em-x270-objs := em-x270.o
+snd-soc-palm27x-objs := palm27x.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
@@ -23,3 +24,4 @@ obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
 obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
 obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
+obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
new file mode 100644
index 0000000..e364abc
--- /dev/null
+++ b/sound/soc/pxa/palm27x.c
@@ -0,0 +1,269 @@
+/*
+ * linux/sound/soc/pxa/palm27x.c
+ *
+ * SoC Audio driver for Palm T|X, T5 and LifeDrive
+ *
+ * based on tosa.c
+ *
+ * Copyright (C) 2008 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <mach/audio.h>
+#include <mach/palmasoc.h>
+
+#include "../codecs/wm9712.h"
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
+
+static int palm27x_jack_func = 1;
+static int palm27x_spk_func = 1;
+static int palm27x_ep_gpio = -1;
+
+static void palm27x_ext_control(struct snd_soc_codec *codec)
+{
+	if (!palm27x_spk_func)
+		snd_soc_dapm_enable_pin(codec, "Speaker");
+	else
+		snd_soc_dapm_disable_pin(codec, "Speaker");
+
+	if (!palm27x_jack_func)
+		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
+	else
+		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
+
+	snd_soc_dapm_sync(codec);
+}
+
+static int palm27x_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->socdev->codec;
+
+	/* check the jack status at stream startup */
+	palm27x_ext_control(codec);
+	return 0;
+}
+
+static struct snd_soc_ops palm27x_ops = {
+	.startup = palm27x_startup,
+};
+
+static irqreturn_t palm27x_interrupt(int irq, void *v)
+{
+	palm27x_spk_func = gpio_get_value(palm27x_ep_gpio);
+	palm27x_jack_func = !palm27x_spk_func;
+	return IRQ_HANDLED;
+}
+
+static int palm27x_get_jack(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = palm27x_jack_func;
+	return 0;
+}
+
+static int palm27x_set_jack(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (palm27x_jack_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	palm27x_jack_func = ucontrol->value.integer.value[0];
+	palm27x_ext_control(codec);
+	return 1;
+}
+
+static int palm27x_get_spk(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = palm27x_spk_func;
+	return 0;
+}
+
+static int palm27x_set_spk(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (palm27x_spk_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	palm27x_spk_func = ucontrol->value.integer.value[0];
+	palm27x_ext_control(codec);
+	return 1;
+}
+
+/* PalmTX machine dapm widgets */
+static const struct snd_soc_dapm_widget palm27x_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+/* PalmTX audio map */
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* headphone connected to HPOUTL, HPOUTR */
+	{"Headphone Jack", NULL, "HPOUTL"},
+	{"Headphone Jack", NULL, "HPOUTR"},
+
+	/* ext speaker connected to ROUT2, LOUT2 */
+	{"Speaker", NULL, "LOUT2"},
+	{"Speaker", NULL, "ROUT2"},
+};
+
+static const char *jack_function[] = {"Headphone", "Off"};
+static const char *spk_function[] = {"On", "Off"};
+static const struct soc_enum palm27x_enum[] = {
+	SOC_ENUM_SINGLE_EXT(2, jack_function),
+	SOC_ENUM_SINGLE_EXT(2, spk_function),
+};
+
+static const struct snd_kcontrol_new palm27x_controls[] = {
+	SOC_ENUM_EXT("Jack Function", palm27x_enum[0], palm27x_get_jack,
+		palm27x_set_jack),
+	SOC_ENUM_EXT("Speaker Function", palm27x_enum[1], palm27x_get_spk,
+		palm27x_set_spk),
+};
+
+static int palm27x_ac97_init(struct snd_soc_codec *codec)
+{
+	int i, err;
+
+	snd_soc_dapm_nc_pin(codec, "OUT3");
+	snd_soc_dapm_nc_pin(codec, "MONOOUT");
+
+	/* add palm27x specific controls */
+	for (i = 0; i < ARRAY_SIZE(palm27x_controls); i++) {
+		err = snd_ctl_add(codec->card,
+				snd_soc_cnew(&palm27x_controls[i],
+						codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	/* add palm27x specific widgets */
+	snd_soc_dapm_new_controls(codec, palm27x_dapm_widgets,
+				ARRAY_SIZE(palm27x_dapm_widgets));
+
+	/* set up palm27x specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link palm27x_dai[] = {
+{
+	.name = "AC97 HiFi",
+	.stream_name = "AC97 HiFi",
+	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
+	.init = palm27x_ac97_init,
+	.ops = &palm27x_ops,
+},
+{
+	.name = "AC97 Aux",
+	.stream_name = "AC97 Aux",
+	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
+	.ops = &palm27x_ops,
+},
+};
+
+static struct snd_soc_machine palm27x_asoc = {
+	.name = "Palm/PXA27x",
+	.dai_link = palm27x_dai,
+	.num_links = ARRAY_SIZE(palm27x_dai),
+};
+
+static struct snd_soc_device palm27x_snd_devdata = {
+	.machine = &palm27x_asoc,
+	.platform = &pxa2xx_soc_platform,
+	.codec_dev = &soc_codec_dev_wm9712,
+};
+
+static struct platform_device *palm27x_snd_device;
+
+static int __init palm27x_asoc_init(void)
+{
+	int ret;
+
+	if (!(machine_is_palmtx() || machine_is_palmt5() ||
+		machine_is_palmld()))
+		return -ENODEV;
+
+	ret = gpio_request(palm27x_ep_gpio, "Headphone Jack");
+	if (ret)
+		return ret;
+	ret = gpio_direction_input(palm27x_ep_gpio);
+	if (ret)
+		goto err_alloc;
+
+	if (request_irq(gpio_to_irq(palm27x_ep_gpio), palm27x_interrupt,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			"Headphone jack", NULL))
+		goto err_alloc;
+
+	palm27x_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!palm27x_snd_device) {
+		ret = -ENOMEM;
+		goto err_dev;
+	}
+
+	platform_set_drvdata(palm27x_snd_device, &palm27x_snd_devdata);
+	palm27x_snd_devdata.dev = &palm27x_snd_device->dev;
+	ret = platform_device_add(palm27x_snd_device);
+
+	if (ret != 0)
+		goto put_device;
+
+	return 0;
+
+put_device:
+	platform_device_put(palm27x_snd_device);
+err_dev:
+	free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
+err_alloc:
+	gpio_free(palm27x_ep_gpio);
+
+	return ret;
+}
+
+static void __exit palm27x_asoc_exit(void)
+{
+	free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
+	gpio_free(palm27x_ep_gpio);
+	platform_device_unregister(palm27x_snd_device);
+}
+
+void __init palm27x_asoc_set_pdata(struct palm27x_asoc_info *data)
+{
+	palm27x_ep_gpio = data->jack_gpio;
+}
+
+module_init(palm27x_asoc_init);
+module_exit(palm27x_asoc_exit);
+
+/* Module information */
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("ALSA SoC Palm T|X, T5 and LifeDrive");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
