From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/3] ASoC: omap: rx51: Add headset support
Date: Mon, 14 Feb 2011 17:20:21 +0200
Message-ID: <1297696822-32174-2-git-send-email-jhnikula@gmail.com>
References: <1297696822-32174-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id BBD5E243CD
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 16:20:37 +0100 (CET)
Received: by mail-bw0-f51.google.com with SMTP id 10so5716229bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 07:20:37 -0800 (PST)
In-Reply-To: <1297696822-32174-1-git-send-email-jhnikula@gmail.com>
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

This patch adds support for headset microphone in Nokia RX-51/N900. The mic
signal from audio jack is routed to codec A LINE1L via two switches and the
mic bias is coming from codec B part.

First switch is the tv-out switch that is already supported and the second
switch selects between voltage detection circuit and codecs. As there is
no use for voltage detection at the moment the second switch is connected
statically to codecs in rx51_soc_init.

Headset can be active when control "Jack Function" is set to "Headset".

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/rx51.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 9411969..9860018 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -40,6 +40,7 @@
 
 #define RX51_TVOUT_SEL_GPIO		40
 #define RX51_JACK_DETECT_GPIO		177
+#define RX51_ECI_SW_GPIO		182
 /*
  * REVISIT: TWL4030 GPIO base in RX-51. Now statically defined to 192. This
  * gpio is reserved in arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -50,6 +51,7 @@ enum {
 	RX51_JACK_DISABLED,
 	RX51_JACK_TVOUT,		/* tv-out with stereo output */
 	RX51_JACK_HP,			/* headphone: stereo output, no mic */
+	RX51_JACK_HS,			/* headset: stereo output with mic */
 };
 
 static int rx51_spk_func;
@@ -59,11 +61,15 @@ static int rx51_jack_func;
 static void rx51_ext_control(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
-	int hp = 0, tvout = 0;
+	int hp = 0, hs = 0, tvout = 0;
 
 	switch (rx51_jack_func) {
 	case RX51_JACK_TVOUT:
 		tvout = 1;
+		hp = 1;
+		break;
+	case RX51_JACK_HS:
+		hs = 1;
 	case RX51_JACK_HP:
 		hp = 1;
 		break;
@@ -81,6 +87,10 @@ static void rx51_ext_control(struct snd_soc_codec *codec)
 		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	else
 		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+	if (hs)
+		snd_soc_dapm_enable_pin(dapm, "HS Mic");
+	else
+		snd_soc_dapm_disable_pin(dapm, "HS Mic");
 
 	gpio_set_value(RX51_TVOUT_SEL_GPIO, tvout);
 
@@ -240,6 +250,7 @@ static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", rx51_spk_event),
 	SND_SOC_DAPM_MIC("DMic", NULL),
 	SND_SOC_DAPM_HP("Headphone Jack", rx51_hp_event),
+	SND_SOC_DAPM_MIC("HS Mic", NULL),
 };
 
 static const struct snd_soc_dapm_widget aic34_dapm_widgetsb[] = {
@@ -259,11 +270,14 @@ static const struct snd_soc_dapm_route audio_map[] = {
 static const struct snd_soc_dapm_route audio_mapb[] = {
 	{"b LINE2R", NULL, "MONO_LOUT"},
 	{"Earphone", NULL, "b HPLOUT"},
+
+	{"LINE1L", NULL, "b Mic Bias 2.5V"},
+	{"b Mic Bias 2.5V", NULL, "HS Mic"}
 };
 
 static const char *spk_function[] = {"Off", "On"};
 static const char *input_function[] = {"ADC", "Digital Mic"};
-static const char *jack_function[] = {"Off", "TV-OUT", "Headphone"};
+static const char *jack_function[] = {"Off", "TV-OUT", "Headphone", "Headset"};
 
 static const struct soc_enum rx51_enum[] = {
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
@@ -398,6 +412,10 @@ static int __init rx51_soc_init(void)
 			       GPIOF_DIR_OUT | GPIOF_INIT_LOW, "tvout_sel");
 	if (err)
 		goto err_gpio_tvout_sel;
+	err = gpio_request_one(RX51_ECI_SW_GPIO,
+			       GPIOF_DIR_OUT | GPIOF_INIT_HIGH, "eci_sw");
+	if (err)
+		goto err_gpio_eci_sw;
 
 	rx51_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!rx51_snd_device) {
@@ -415,6 +433,8 @@ static int __init rx51_soc_init(void)
 err2:
 	platform_device_put(rx51_snd_device);
 err1:
+	gpio_free(RX51_ECI_SW_GPIO);
+err_gpio_eci_sw:
 	gpio_free(RX51_TVOUT_SEL_GPIO);
 err_gpio_tvout_sel:
 
@@ -427,6 +447,7 @@ static void __exit rx51_soc_exit(void)
 				rx51_av_jack_gpios);
 
 	platform_device_unregister(rx51_snd_device);
+	gpio_free(RX51_ECI_SW_GPIO);
 	gpio_free(RX51_TVOUT_SEL_GPIO);
 }
 
-- 
1.7.0.4
