From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] PalmTX aSoC sound support
Date: Sat, 5 Jul 2008 07:17:41 +0200
Message-ID: <200807050717.41965.marek.vasut@gmail.com>
References: <200807042126.29154.marek.vasut@gmail.com>
	<20080704202615.GB20719@sirena.org.uk>
	<200807050019.08444.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1PwbIHwYQ7YhjYu"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ABF2243A0
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jul 2008 07:16:04 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so561203fgg.44
	for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2008 22:16:03 -0700 (PDT)
In-Reply-To: <200807050019.08444.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_1PwbIHwYQ7YhjYu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dne Saturday 05 of July 2008 00:19:08 Marek Vasut napsal(a):
> Dne Friday 04 of July 2008 22:26:15 Mark Brown napsal(a):
> > On Fri, Jul 04, 2008 at 09:49:57PM +0200, Marek Vasut wrote:
> >
> > Like Liam said, audio patches should be CCed to alsa-devel as well - a
> >
> > couple of comments from a quick scan through:
> > > +	/* add palmtx specific widgets */
> > > +	for (i = 0; i < ARRAY_SIZE(palmtx_dapm_widgets); i++)
> > > +		snd_soc_dapm_new_control(codec, &palmtx_dapm_widgets[i]);
> >
> > Ideally this should use the new snd_soc_dapm_new_controls() function...
> >
> > > +	/* set up palmtx specific audio path audio_map */
> > > +	for (i = 0; audio_map[i][0] != NULL; i++)
> > > +		snd_soc_dapm_connect_input(codec, audio_map[i][0],
> > > +			audio_map[i][1], audio_map[i][2]);
> >
> > and this should use snd_soc_dapm_add_routes (which would also mean you
> > could drop the null terminator from audio_map()).  Both are queued for
> > merge in the window - see ALSA git, it'll also appear in linux-next.
> >
> > > +	ret = platform_device_add(palmtx_snd_device);
> > > +
> > > +	if (!ret)
> > > +		return 0;
> > > +
> > > +	platform_device_put(palmtx_snd_device);
> >
> > It took me a double take to follow this - it'd be more idiomatic to say:
> >
> > 	if (ret != 0)
> > 		goto put_device;
> >
> > 	return 0;
> >  put_device:
>
> ok, I applied some alsa patches to my branch of "devel"
even better version of the previous one


--Boundary-00=_1PwbIHwYQ7YhjYu
Content-Type: text/x-diff;
  charset="utf-8";
  name="palmtx-asoc-ml-v5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="palmtx-asoc-ml-v5.patch"

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 329b33f..570b88a 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -63,3 +63,12 @@ config SND_PXA2XX_SOC_E800
 	help
 	  Say Y if you want to add support for SoC audio on the
 	  Toshiba e800 PDA
+
+config SND_PXA2XX_SOC_PALMTX
+	tristate "SoC AC97 Audio support for Palm T|X"
+	depends on SND_PXA2XX_SOC && MACH_XSCALE_PALMTX
+	select SND_PXA2XX_SOC_AC97
+	select SND_SOC_WM9712
+	help
+	  Say Y if you want to add support for SoC audio on
+	  Palm T|X.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 04e5646..9ab59f9 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -13,10 +13,12 @@ snd-soc-poodle-objs := poodle.o
 snd-soc-tosa-objs := tosa.o
 snd-soc-e800-objs := e800_wm9712.o
 snd-soc-spitz-objs := spitz.o
+snd-soc-palmtx-objs := palmtx.o
 
 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
 obj-$(CONFIG_SND_PXA2XX_SOC_TOSA) += snd-soc-tosa.o
 obj-$(CONFIG_SND_PXA2XX_SOC_E800) += snd-soc-e800.o
 obj-$(CONFIG_SND_PXA2XX_SOC_SPITZ) += snd-soc-spitz.o
+obj-$(CONFIG_SND_PXA2XX_SOC_PALMTX) += snd-soc-palmtx.o
 
diff --git a/sound/soc/pxa/palmtx.c b/sound/soc/pxa/palmtx.c
new file mode 100644
index 0000000..72d8319
--- /dev/null
+++ b/sound/soc/pxa/palmtx.c
@@ -0,0 +1,246 @@
+/*
+ * linux/sound/soc/pxa/palmtx.c
+ *
+ * SoC Audio driver for Palm T|X handheld
+ *
+ * based on tosa.c
+ *
+ * Copyright (C) 2008 Marek Vasut <marek.vasut@gmail.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include <asm/mach-types.h>
+#include <asm/arch/audio.h>
+#include <asm/arch/palmtx-gpio.h>
+
+#include "../codecs/wm9712.h"
+#include "pxa2xx-pcm.h"
+#include "pxa2xx-ac97.h"
+
+static int palmtx_jack_func;
+static int palmtx_spk_func;
+
+static void palmtx_ext_control(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_set_endpoint(codec, "Speaker", !palmtx_spk_func);
+	snd_soc_dapm_set_endpoint(codec, "Headphone Jack", !palmtx_jack_func);
+	snd_soc_dapm_sync_endpoints(codec);
+}
+
+static int palmtx_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->socdev->codec;
+
+	/* check the jack status at stream startup */
+	palmtx_ext_control(codec);
+	return 0;
+}
+
+static struct snd_soc_ops palmtx_ops = {
+	.startup = palmtx_startup,
+};
+
+static int palmtx_get_jack(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = palmtx_jack_func;
+	return 0;
+}
+
+static int palmtx_set_jack(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (palmtx_jack_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	palmtx_jack_func = ucontrol->value.integer.value[0];
+	palmtx_ext_control(codec);
+	return 1;
+}
+
+static int palmtx_get_spk(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = palmtx_spk_func;
+	return 0;
+}
+
+static int palmtx_set_spk(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+
+	if (palmtx_spk_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	palmtx_spk_func = ucontrol->value.integer.value[0];
+	palmtx_ext_control(codec);
+	return 1;
+}
+
+/* PalmTX dapm event handlers */
+static int palmtx_hp_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int event)
+{
+	gpio_set_value(GPIO_NR_PALMTX_EARPHONE_DETECT,
+			SND_SOC_DAPM_EVENT_ON(event));
+	return 0;
+}
+
+/* PalmTX machine dapm widgets */
+static const struct snd_soc_dapm_widget palmtx_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", palmtx_hp_event),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+/* PalmTX audio map */
+static const struct snd_soc_dapm_route audio_map[] = {
+
+	/* headphone connected to HPOUTL, HPOUTR */
+	{"Headphone Jack", NULL, "HPOUTL"},
+	{"Headphone Jack", NULL, "HPOUTR"},
+
+	/* ext speaker connected to LOUT2, ROUT2 */
+	{"Speaker", NULL, "LOUT2"},
+	{"Speaker", NULL, "ROUT2"},
+};
+
+static const char *jack_function[] = {"Headphone", "Off"};
+static const char *spk_function[] = {"On", "Off"};
+static const struct soc_enum palmtx_enum[] = {
+	SOC_ENUM_SINGLE_EXT(2, jack_function),
+	SOC_ENUM_SINGLE_EXT(2, spk_function),
+};
+
+static const struct snd_kcontrol_new palmtx_controls[] = {
+	SOC_ENUM_EXT("Jack Function", palmtx_enum[0], palmtx_get_jack,
+		palmtx_set_jack),
+	SOC_ENUM_EXT("Speaker Function", palmtx_enum[1], palmtx_get_spk,
+		palmtx_set_spk),
+};
+
+static int palmtx_ac97_init(struct snd_soc_codec *codec)
+{
+	int i, err;
+
+	snd_soc_dapm_set_endpoint(codec, "OUT3", 0);
+	snd_soc_dapm_set_endpoint(codec, "MONOOUT", 0);
+
+	/* add palmtx specific controls */
+	for (i = 0; i < ARRAY_SIZE(palmtx_controls); i++) {
+		err = snd_ctl_add(codec->card,
+				snd_soc_cnew(&palmtx_controls[i], codec, NULL));
+		if (err < 0)
+			return err;
+	}
+
+	/* add palmtx specific widgets */
+	snd_soc_dapm_new_controls(codec, palmtx_dapm_widgets,
+				ARRAY_SIZE(palmtx_dapm_widgets));
+
+	/* set up palmtx specific audio path audio_map */
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_sync_endpoints(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link palmtx_dai[] = {
+{
+	.name = "AC97",
+	.stream_name = "AC97 HiFi",
+	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
+	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_HIFI],
+	.init = palmtx_ac97_init,
+	.ops = &palmtx_ops,
+},
+{
+	.name = "AC97 Aux",
+	.stream_name = "AC97 Aux",
+	.cpu_dai = &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
+	.codec_dai = &wm9712_dai[WM9712_DAI_AC97_AUX],
+	.ops = &palmtx_ops,
+},
+};
+
+static struct snd_soc_machine palmtx_asoc = {
+	.name = "Palm T|X",
+	.dai_link = palmtx_dai,
+	.num_links = ARRAY_SIZE(palmtx_dai),
+};
+
+static struct snd_soc_device palmtx_snd_devdata = {
+	.machine = &palmtx_asoc,
+	.platform = &pxa2xx_soc_platform,
+	.codec_dev = &soc_codec_dev_wm9712,
+};
+
+static struct platform_device *palmtx_snd_device;
+
+static int __init palmtx_asoc_init(void)
+{
+	int ret;
+
+	if (!machine_is_xscale_palmtx())
+		return -ENODEV;
+
+	ret = gpio_request(GPIO_NR_PALMTX_EARPHONE_DETECT, "Headphone Jack");
+	if (ret)
+		return ret;
+	gpio_direction_output(GPIO_NR_PALMTX_EARPHONE_DETECT, 0);
+
+	palmtx_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!palmtx_snd_device) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	platform_set_drvdata(palmtx_snd_device, &palmtx_snd_devdata);
+	palmtx_snd_devdata.dev = &palmtx_snd_device->dev;
+	ret = platform_device_add(palmtx_snd_device);
+
+	if (ret != 0)
+		goto put_device;
+
+	return 0;
+
+put_device:
+	platform_device_put(palmtx_snd_device);
+
+err_alloc:
+	gpio_free(GPIO_NR_PALMTX_EARPHONE_DETECT);
+
+	return ret;
+}
+
+static void __exit palmtx_asoc_exit(void)
+{
+	platform_device_unregister(palmtx_snd_device);
+	gpio_free(GPIO_NR_PALMTX_EARPHONE_DETECT);
+}
+
+module_init(palmtx_asoc_init);
+module_exit(palmtx_asoc_exit);
+
+/* Module information */
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("ALSA SoC Palm T|X");
+MODULE_LICENSE("GPL");

--Boundary-00=_1PwbIHwYQ7YhjYu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_1PwbIHwYQ7YhjYu--
