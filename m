From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] Switch palm27x-asoc to jack detection api
Date: Thu, 23 Jul 2009 22:16:56 +0200
Message-ID: <200907232216.56320.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4UMaKeyAW+4r6QY"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f226.google.com (mail-bw0-f226.google.com
	[209.85.218.226])
	by alsa0.perex.cz (Postfix) with ESMTP id CD02E103A23
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 22:17:21 +0200 (CEST)
Received: by bwz26 with SMTP id 26so1113156bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2009 13:17:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_4UMaKeyAW+4r6QY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch removes the old method of jack detection from palm27x-asoc
driver and adds jack detection api. It also removes some other (now)
useless stuff from the driver and corrects pin configuration for the
codec.

Please consider applying.

--Boundary-00=_4UMaKeyAW+4r6QY
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Switch-palm27x-asoc-to-jack-detection-api.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Switch-palm27x-asoc-to-jack-detection-api.patch"

=46rom dd9a44da68cb6ace756153270df7d88a62a74459 Mon Sep 17 00:00:00 2001
=46rom: Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 23 Jul 2009 21:26:30 +0200
Subject: [PATCH] Switch palm27x-asoc to jack detection api

This patch removes the old method of jack detection from palm27x-asoc
driver and adds jack detection api. It also removes some other (now)
useless stuff from the driver and corrects pin configuration for the
codec.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
=2D--
 sound/soc/pxa/palm27x.c |  204 +++++++++++++++++--------------------------=
=2D---
 1 files changed, 73 insertions(+), 131 deletions(-)

diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index e6102fd..1f96e32 100644
=2D-- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -17,13 +17,12 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/gpio.h>
=2D#include <linux/interrupt.h>
=2D#include <linux/irq.h>
=20
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/jack.h>
=20
 #include <asm/mach-types.h>
 #include <mach/audio.h>
@@ -33,90 +32,31 @@
 #include "pxa2xx-pcm.h"
 #include "pxa2xx-ac97.h"
=20
=2Dstatic int palm27x_jack_func =3D 1;
=2Dstatic int palm27x_spk_func =3D 1;
=2Dstatic int palm27x_ep_gpio =3D -1;
+static struct snd_soc_jack hs_jack;
=20
=2Dstatic void palm27x_ext_control(struct snd_soc_codec *codec)
=2D{
=2D	if (!palm27x_spk_func)
=2D		snd_soc_dapm_enable_pin(codec, "Speaker");
=2D	else
=2D		snd_soc_dapm_disable_pin(codec, "Speaker");
=2D
=2D	if (!palm27x_jack_func)
=2D		snd_soc_dapm_enable_pin(codec, "Headphone Jack");
=2D	else
=2D		snd_soc_dapm_disable_pin(codec, "Headphone Jack");
=2D
=2D	snd_soc_dapm_sync(codec);
=2D}
=2D
=2Dstatic int palm27x_startup(struct snd_pcm_substream *substream)
=2D{
=2D	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
=2D	struct snd_soc_codec *codec =3D rtd->socdev->card->codec;
=2D
=2D	/* check the jack status at stream startup */
=2D	palm27x_ext_control(codec);
=2D	return 0;
=2D}
=2D
=2Dstatic struct snd_soc_ops palm27x_ops =3D {
=2D	.startup =3D palm27x_startup,
+/* Headphones jack detection DAPM pins */
+static struct snd_soc_jack_pin hs_jack_pins[] =3D {
+	{
+		.pin    =3D "Headphone Jack",
+		.mask   =3D SND_JACK_HEADPHONE,
+	},
 };
=20
=2Dstatic irqreturn_t palm27x_interrupt(int irq, void *v)
=2D{
=2D	palm27x_spk_func =3D gpio_get_value(palm27x_ep_gpio);
=2D	palm27x_jack_func =3D !palm27x_spk_func;
=2D	return IRQ_HANDLED;
=2D}
=2D
=2Dstatic int palm27x_get_jack(struct snd_kcontrol *kcontrol,
=2D	struct snd_ctl_elem_value *ucontrol)
=2D{
=2D	ucontrol->value.integer.value[0] =3D palm27x_jack_func;
=2D	return 0;
=2D}
=2D
=2Dstatic int palm27x_set_jack(struct snd_kcontrol *kcontrol,
=2D	struct snd_ctl_elem_value *ucontrol)
=2D{
=2D	struct snd_soc_codec *codec =3D  snd_kcontrol_chip(kcontrol);
=2D
=2D	if (palm27x_jack_func =3D=3D ucontrol->value.integer.value[0])
=2D		return 0;
=2D
=2D	palm27x_jack_func =3D ucontrol->value.integer.value[0];
=2D	palm27x_ext_control(codec);
=2D	return 1;
=2D}
=2D
=2Dstatic int palm27x_get_spk(struct snd_kcontrol *kcontrol,
=2D	struct snd_ctl_elem_value *ucontrol)
=2D{
=2D	ucontrol->value.integer.value[0] =3D palm27x_spk_func;
=2D	return 0;
=2D}
=2D
=2Dstatic int palm27x_set_spk(struct snd_kcontrol *kcontrol,
=2D	struct snd_ctl_elem_value *ucontrol)
=2D{
=2D	struct snd_soc_codec *codec =3D  snd_kcontrol_chip(kcontrol);
=2D
=2D	if (palm27x_spk_func =3D=3D ucontrol->value.integer.value[0])
=2D		return 0;
=2D
=2D	palm27x_spk_func =3D ucontrol->value.integer.value[0];
=2D	palm27x_ext_control(codec);
=2D	return 1;
=2D}
+/* Headphones jack detection gpios */
+static struct snd_soc_jack_gpio hs_jack_gpios[] =3D {
+	[0] =3D {
+		/* gpio is set on per-platform basis */
+		.name           =3D "hp-gpio",
+		.report         =3D SND_JACK_HEADPHONE,
+		.debounce_time	=3D 200,
+	},
+};
=20
=2D/* PalmTX machine dapm widgets */
+/* Palm27x machine dapm widgets */
 static const struct snd_soc_dapm_widget palm27x_dapm_widgets[] =3D {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
=2D	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_SPK("Ext. Speaker", NULL),
+	SND_SOC_DAPM_MIC("Ext. Microphone", NULL),
 };
=20
 /* PalmTX audio map */
@@ -126,46 +66,66 @@ static const struct snd_soc_dapm_route audio_map[] =3D=
 {
 	{"Headphone Jack", NULL, "HPOUTR"},
=20
 	/* ext speaker connected to ROUT2, LOUT2 */
=2D	{"Speaker", NULL, "LOUT2"},
=2D	{"Speaker", NULL, "ROUT2"},
=2D};
+	{"Ext. Speaker", NULL, "LOUT2"},
+	{"Ext. Speaker", NULL, "ROUT2"},
=20
=2Dstatic const char *jack_function[] =3D {"Headphone", "Off"};
=2Dstatic const char *spk_function[] =3D {"On", "Off"};
=2Dstatic const struct soc_enum palm27x_enum[] =3D {
=2D	SOC_ENUM_SINGLE_EXT(2, jack_function),
=2D	SOC_ENUM_SINGLE_EXT(2, spk_function),
+	/* mic connected to MIC1 */
+	{"Ext. Microphone", NULL, "MIC1"},
 };
=20
=2Dstatic const struct snd_kcontrol_new palm27x_controls[] =3D {
=2D	SOC_ENUM_EXT("Jack Function", palm27x_enum[0], palm27x_get_jack,
=2D		palm27x_set_jack),
=2D	SOC_ENUM_EXT("Speaker Function", palm27x_enum[1], palm27x_get_spk,
=2D		palm27x_set_spk),
=2D};
+static struct snd_soc_card palm27x_asoc;
=20
 static int palm27x_ac97_init(struct snd_soc_codec *codec)
 {
 	int err;
=20
+	/* add palm27x specific widgets */
+	err =3D snd_soc_dapm_new_controls(codec, palm27x_dapm_widgets,
+				ARRAY_SIZE(palm27x_dapm_widgets));
+	if (err)
+		return err;
+
+	/* set up palm27x specific audio path audio_map */
+	err =3D snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	if (err)
+		return err;
+
+	/* connected pins */
+	if (machine_is_palmld())
+		snd_soc_dapm_enable_pin(codec, "MIC1");
+	snd_soc_dapm_enable_pin(codec, "HPOUTL");
+	snd_soc_dapm_enable_pin(codec, "HPOUTR");
+	snd_soc_dapm_enable_pin(codec, "LOUT2");
+	snd_soc_dapm_enable_pin(codec, "ROUT2");
+
+	/* not connected pins */
 	snd_soc_dapm_nc_pin(codec, "OUT3");
 	snd_soc_dapm_nc_pin(codec, "MONOOUT");
+	snd_soc_dapm_nc_pin(codec, "LINEINL");
+	snd_soc_dapm_nc_pin(codec, "LINEINR");
+	snd_soc_dapm_nc_pin(codec, "PCBEEP");
+	snd_soc_dapm_nc_pin(codec, "PHONE");
+	snd_soc_dapm_nc_pin(codec, "MIC2");
+
+	err =3D snd_soc_dapm_sync(codec);
+	if (err)
+		return err;
=20
=2D	/* add palm27x specific controls */
=2D	err =3D snd_soc_add_controls(codec, palm27x_controls,
=2D				ARRAY_SIZE(palm27x_controls));
=2D	if (err < 0)
+	/* Jack detection API stuff */
+	err =3D snd_soc_jack_new(&palm27x_asoc, "Headphone Jack",
+				SND_JACK_HEADPHONE, &hs_jack);
+	if (err)
 		return err;
=20
=2D	/* add palm27x specific widgets */
=2D	snd_soc_dapm_new_controls(codec, palm27x_dapm_widgets,
=2D				ARRAY_SIZE(palm27x_dapm_widgets));
+	err =3D snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins),
+				hs_jack_pins);
+	if (err)
+		return err;
=20
=2D	/* set up palm27x specific audio path audio_map */
=2D	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
+	err =3D snd_soc_jack_add_gpios(&hs_jack, ARRAY_SIZE(hs_jack_gpios),
+				hs_jack_gpios);
=20
=2D	snd_soc_dapm_sync(codec);
=2D	return 0;
+	return err;
 }
=20
 static struct snd_soc_dai_link palm27x_dai[] =3D {
@@ -175,14 +135,12 @@ static struct snd_soc_dai_link palm27x_dai[] =3D {
 	.cpu_dai =3D &pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI],
 	.codec_dai =3D &wm9712_dai[WM9712_DAI_AC97_HIFI],
 	.init =3D palm27x_ac97_init,
=2D	.ops =3D &palm27x_ops,
 },
 {
 	.name =3D "AC97 Aux",
 	.stream_name =3D "AC97 Aux",
 	.cpu_dai =3D &pxa_ac97_dai[PXA2XX_DAI_AC97_AUX],
 	.codec_dai =3D &wm9712_dai[WM9712_DAI_AC97_AUX],
=2D	.ops =3D &palm27x_ops,
 },
 };
=20
@@ -208,27 +166,17 @@ static int palm27x_asoc_probe(struct platform_device =
*pdev)
 		machine_is_palmld() || machine_is_palmte2()))
 		return -ENODEV;
=20
=2D	if (pdev->dev.platform_data)
=2D		palm27x_ep_gpio =3D ((struct palm27x_asoc_info *)
=2D			(pdev->dev.platform_data))->jack_gpio;
=2D
=2D	ret =3D gpio_request(palm27x_ep_gpio, "Headphone Jack");
=2D	if (ret)
=2D		return ret;
=2D	ret =3D gpio_direction_input(palm27x_ep_gpio);
=2D	if (ret)
=2D		goto err_alloc;
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "please supply platform_data\n");
+		return -ENODEV;
+	}
=20
=2D	if (request_irq(gpio_to_irq(palm27x_ep_gpio), palm27x_interrupt,
=2D			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
=2D			"Headphone jack", NULL))
=2D		goto err_alloc;
+	hs_jack_gpios[0].gpio =3D ((struct palm27x_asoc_info *)
+			(pdev->dev.platform_data))->jack_gpio;
=20
 	palm27x_snd_device =3D platform_device_alloc("soc-audio", -1);
=2D	if (!palm27x_snd_device) {
=2D		ret =3D -ENOMEM;
=2D		goto err_dev;
=2D	}
+	if (!palm27x_snd_device)
+		return -ENOMEM;
=20
 	platform_set_drvdata(palm27x_snd_device, &palm27x_snd_devdata);
 	palm27x_snd_devdata.dev =3D &palm27x_snd_device->dev;
@@ -241,18 +189,12 @@ static int palm27x_asoc_probe(struct platform_device =
*pdev)
=20
 put_device:
 	platform_device_put(palm27x_snd_device);
=2Derr_dev:
=2D	free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
=2Derr_alloc:
=2D	gpio_free(palm27x_ep_gpio);
=20
 	return ret;
 }
=20
 static int __devexit palm27x_asoc_remove(struct platform_device *pdev)
 {
=2D	free_irq(gpio_to_irq(palm27x_ep_gpio), NULL);
=2D	gpio_free(palm27x_ep_gpio);
 	platform_device_unregister(palm27x_snd_device);
 	return 0;
 }
=2D-=20
1.6.3.3


--Boundary-00=_4UMaKeyAW+4r6QY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_4UMaKeyAW+4r6QY--
