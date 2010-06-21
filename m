From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] ASoC: RX-51: Add Jack Function kcontrol
Date: Mon, 21 Jun 2010 14:14:59 +0300
Message-ID: <1277118900-30100-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6338010383D
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 13:14:31 +0200 (CEST)
Received: by wyb40 with SMTP id 40so2192189wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 04:14:31 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Nokia RX-51/N900 has multifunction 4-pole audio-video jack that can be used
as headphone, headset or audio-video connector. This patch implements the
control 'Jack Function' which is used to select the desired function.
At the moment only TV-out without audio is supported.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/rx51.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 47d831e..1a2de34 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -37,14 +37,21 @@
 #include "omap-pcm.h"
 #include "../codecs/tlv320aic3x.h"
 
+#define RX51_TVOUT_SEL_GPIO		40
 /*
  * REVISIT: TWL4030 GPIO base in RX-51. Now statically defined to 192. This
  * gpio is reserved in arch/arm/mach-omap2/board-rx51-peripherals.c
  */
 #define RX51_SPEAKER_AMP_TWL_GPIO	(192 + 7)
 
+enum {
+	RX51_JACK_DISABLED,
+	RX51_JACK_TVOUT,		/* tv-out */
+};
+
 static int rx51_spk_func;
 static int rx51_dmic_func;
+static int rx51_jack_func;
 
 static void rx51_ext_control(struct snd_soc_codec *codec)
 {
@@ -57,6 +64,9 @@ static void rx51_ext_control(struct snd_soc_codec *codec)
 	else
 		snd_soc_dapm_disable_pin(codec, "DMic");
 
+	gpio_set_value(RX51_TVOUT_SEL_GPIO,
+		       rx51_jack_func == RX51_JACK_TVOUT);
+
 	snd_soc_dapm_sync(codec);
 }
 
@@ -162,6 +172,28 @@ static int rx51_set_input(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static int rx51_get_jack(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = rx51_jack_func;
+
+	return 0;
+}
+
+static int rx51_set_jack(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	if (rx51_jack_func == ucontrol->value.integer.value[0])
+		return 0;
+
+	rx51_jack_func = ucontrol->value.integer.value[0];
+	rx51_ext_control(codec);
+
+	return 1;
+}
+
 static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", rx51_spk_event),
 	SND_SOC_DAPM_MIC("DMic", NULL),
@@ -177,10 +209,12 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static const char *spk_function[] = {"Off", "On"};
 static const char *input_function[] = {"ADC", "Digital Mic"};
+static const char *jack_function[] = {"Off", "TV-OUT"};
 
 static const struct soc_enum rx51_enum[] = {
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(input_function), input_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(jack_function), jack_function),
 };
 
 static const struct snd_kcontrol_new aic34_rx51_controls[] = {
@@ -188,6 +222,8 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 		     rx51_get_spk, rx51_set_spk),
 	SOC_ENUM_EXT("Input Select",  rx51_enum[1],
 		     rx51_get_input, rx51_set_input),
+	SOC_ENUM_EXT("Jack Function", rx51_enum[2],
+		     rx51_get_jack, rx51_set_jack),
 };
 
 static int rx51_aic34_init(struct snd_soc_codec *codec)
@@ -259,6 +295,11 @@ static int __init rx51_soc_init(void)
 	if (!machine_is_nokia_rx51())
 		return -ENODEV;
 
+	err = gpio_request(RX51_TVOUT_SEL_GPIO, "tvout_sel");
+	if (err)
+		goto err_gpio_tvout_sel;
+	gpio_direction_output(RX51_TVOUT_SEL_GPIO, 0);
+
 	rx51_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!rx51_snd_device) {
 		err = -ENOMEM;
@@ -277,6 +318,8 @@ static int __init rx51_soc_init(void)
 err2:
 	platform_device_put(rx51_snd_device);
 err1:
+	gpio_free(RX51_TVOUT_SEL_GPIO);
+err_gpio_tvout_sel:
 
 	return err;
 }
@@ -284,6 +327,7 @@ err1:
 static void __exit rx51_soc_exit(void)
 {
 	platform_device_unregister(rx51_snd_device);
+	gpio_free(RX51_TVOUT_SEL_GPIO);
 }
 
 module_init(rx51_soc_init);
-- 
1.7.1
