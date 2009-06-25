From: Jorge Eduardo Candelaria <x0107209@ti.com>
Subject: [PATCH] ASoC: TWL4030: Add EXT_MUTE gpio to reduce
	pop-noise effect
Date: Wed, 24 Jun 2009 21:25:33 -0500
Message-ID: <1245896733-3973-1-git-send-email-x0107209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id D9C24249FB
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 04:27:26 +0200 (CEST)
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
Cc: Jorge Eduardo Candelaria <x0107209@ti.com>, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

According to TRM, an external FET controlled by a 1.8V output signal
can be used to reduce the pop-noise heard when the audio amplifier is
switched on.

The signal is controlled by a gpio pin and should be defined in the
machine driver. However, the codec driver takes care of enabling and
disabling this output during the headset pop attenuation sequence.

If the board does not have an EXT_MUTE, then the machine driver should
set the value of ext_mute_gpio to -EINVAL through ramp delay setup data,
to bypass execution of the code that manages the gpio line.

Also add a delay to let VMID settle in ramp up sequence.

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 sound/soc/codecs/twl4030.c |   23 +++++++++++++++++++++++
 sound/soc/codecs/twl4030.h |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index df42fa2..e850b30 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -27,6 +27,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -620,6 +621,9 @@ static int handsfreerpga_event(struct snd_soc_dapm_widget *w,
 
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
+	struct snd_soc_device *socdev = codec->socdev;
+	struct twl4030_setup_data *setup = socdev->codec_data;
+
 	unsigned char hs_gain, hs_pop;
 	struct twl4030_priv *twl4030 = codec->private_data;
 	/* Base values for ramp delay calculation: 2^19 - 2^26 */
@@ -629,6 +633,11 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 	hs_gain = twl4030_read_reg_cache(codec, TWL4030_REG_HS_GAIN_SET);
 	hs_pop = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
 
+	/* Enable external mute, this dramatically reduces
+	 * the pop-noise */
+	if (setup && gpio_is_valid(setup->ext_mute_gpio))
+		gpio_set_value(setup->ext_mute_gpio, 1);
+
 	if (ramp) {
 		/* Headset ramp-up according to the TRM */
 		hs_pop |= TWL4030_VMID_EN;
@@ -636,6 +645,9 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 		twl4030_write(codec, TWL4030_REG_HS_GAIN_SET, hs_gain);
 		hs_pop |= TWL4030_RAMP_EN;
 		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		/* Wait ramp delay time + 1, so the VMID can settle */
+		mdelay((ramp_base[(hs_pop & TWL4030_RAMP_DELAY) >> 2] /
+			twl4030->sysclk) + 1);
 	} else {
 		/* Headset ramp-down _not_ according to
 		 * the TRM, but in a way that it is working */
@@ -652,6 +664,10 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 		hs_pop &= ~TWL4030_VMID_EN;
 		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 	}
+
+	/* Disable external mute */
+	if (setup && gpio_is_valid(setup->ext_mute_gpio))
+		gpio_set_value(setup->ext_mute_gpio, 0);
 }
 
 static int headsetlpga_event(struct snd_soc_dapm_widget *w,
@@ -2101,6 +2117,7 @@ static int twl4030_init(struct snd_soc_device *socdev)
 	/* Configuration for headset ramp delay from setup data */
 	if (setup) {
 		unsigned char hs_pop;
+		unsigned int ext_mute;
 
 		if (setup->sysclk)
 			twl4030->sysclk = setup->sysclk;
@@ -2111,6 +2128,12 @@ static int twl4030_init(struct snd_soc_device *socdev)
 		hs_pop &= ~TWL4030_RAMP_DELAY;
 		hs_pop |= (setup->ramp_delay_value << 2);
 		twl4030_write_reg_cache(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+
+		if (gpio_is_valid(setup->ext_mute_gpio)) {
+			ext_mute = setup->ext_mute_gpio;
+			BUG_ON(gpio_request(ext_mute, "ext_mute") < 0);
+			gpio_direction_output(ext_mute, 0);
+		}
 	} else {
 		twl4030->sysclk = 26000;
 	}
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index fe5f395..23a75e2 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -274,6 +274,7 @@ extern struct snd_soc_codec_device soc_codec_dev_twl4030;
 struct twl4030_setup_data {
 	unsigned int ramp_delay_value;
 	unsigned int sysclk;
+	unsigned int ext_mute_gpio;
 };
 
 #endif	/* End of __TWL4030_AUDIO_H__ */
-- 
1.6.0.4
