From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: omap: rx51: Add stereo output support to
	audio jack
Date: Wed,  5 Jan 2011 17:46:00 +0200
Message-ID: <1294242360-1903-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 04688244AF
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 16:49:53 +0100 (CET)
Received: by eyg24 with SMTP id 24so6398646eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 07:49:51 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Audio jack in Nokia RX-51/N900 is driven by TPA6130 headphone amplifier.
This patch adds support for it and stereo output can be active when
"Jack Function" == "TV-OUT" || "Headphone".

As the TPA6130 can output very high volume levels the output is limited
with snd_soc_limit_volume. Limiting value is found from Maemo kernel sources.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
This support could have been implemented earlier but I was targeting to have
ASoC cross-device support first. But as there's no DAPM widgets anymore in
TPA6130, I don't see any other way to implement this than by registering TPA6130
controls to aic34a with tpa6130a2_add_controls and by using
tpa6130a2_stereo_enable.

This is from top of "ASoC: Remove needless inclusion of tlv320aic3x.h from
machine drivers" but applies also into lrg's tree.
---
 sound/soc/omap/Kconfig |    1 +
 sound/soc/omap/rx51.c  |   43 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index a088db6..b592298 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -24,6 +24,7 @@ config SND_OMAP_SOC_RX51
 	select OMAP_MCBSP
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
+	select SND_SOC_TPA6130A2
 	help
 	  Say Y if you want to add support for SoC audio on Nokia RX-51
 	  hardware. This is also known as Nokia N900 product.
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 09fb0df..251afbe 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -31,6 +31,7 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <plat/mcbsp.h>
+#include "../codecs/tpa6130a2.h"
 
 #include <asm/mach-types.h>
 
@@ -47,7 +48,8 @@
 
 enum {
 	RX51_JACK_DISABLED,
-	RX51_JACK_TVOUT,		/* tv-out */
+	RX51_JACK_TVOUT,		/* tv-out with stereo output */
+	RX51_JACK_HP,			/* headphone: stereo output, no mic */
 };
 
 static int rx51_spk_func;
@@ -57,6 +59,15 @@ static int rx51_jack_func;
 static void rx51_ext_control(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int hp = 0, tvout = 0;
+
+	switch (rx51_jack_func) {
+	case RX51_JACK_TVOUT:
+		tvout = 1;
+	case RX51_JACK_HP:
+		hp = 1;
+		break;
+	}
 
 	if (rx51_spk_func)
 		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
@@ -66,9 +77,12 @@ static void rx51_ext_control(struct snd_soc_codec *codec)
 		snd_soc_dapm_enable_pin(dapm, "DMic");
 	else
 		snd_soc_dapm_disable_pin(dapm, "DMic");
+	if (hp)
+		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	else
+		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 
-	gpio_set_value(RX51_TVOUT_SEL_GPIO,
-		       rx51_jack_func == RX51_JACK_TVOUT);
+	gpio_set_value(RX51_TVOUT_SEL_GPIO, tvout);
 
 	snd_soc_dapm_sync(dapm);
 }
@@ -153,6 +167,19 @@ static int rx51_spk_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rx51_hp_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_codec *codec = w->dapm->codec;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		tpa6130a2_stereo_enable(codec, 1);
+	else
+		tpa6130a2_stereo_enable(codec, 0);
+
+	return 0;
+}
+
 static int rx51_get_input(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
@@ -212,11 +239,14 @@ static struct snd_soc_jack_gpio rx51_av_jack_gpios[] = {
 static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", rx51_spk_event),
 	SND_SOC_DAPM_MIC("DMic", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", rx51_hp_event),
 };
 
 static const struct snd_soc_dapm_route audio_map[] = {
 	{"Ext Spk", NULL, "HPLOUT"},
 	{"Ext Spk", NULL, "HPROUT"},
+	{"Headphone Jack", NULL, "LLOUT"},
+	{"Headphone Jack", NULL, "RLOUT"},
 
 	{"DMic Rate 64", NULL, "Mic Bias 2V"},
 	{"Mic Bias 2V", NULL, "DMic"},
@@ -224,7 +254,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static const char *spk_function[] = {"Off", "On"};
 static const char *input_function[] = {"ADC", "Digital Mic"};
-static const char *jack_function[] = {"Off", "TV-OUT"};
+static const char *jack_function[] = {"Off", "TV-OUT", "Headphone"};
 
 static const struct soc_enum rx51_enum[] = {
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
@@ -265,6 +295,11 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 	/* Set up RX-51 specific audio path audio_map */
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 
+	err = tpa6130a2_add_controls(codec);
+	if (err < 0)
+		return err;
+	snd_soc_limit_volume(codec, "TPA6130A2 Headphone Playback Volume", 42);
+
 	snd_soc_dapm_sync(dapm);
 
 	/* AV jack detection */
-- 
1.7.2.3
