From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: [PATCH] ASoC: TWL4030: Add EXTMUTE to reduce pop-noise
	effect
Date: Wed, 1 Jul 2009 19:17:43 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B52037758@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id AAB5B244B3
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 02:17:54 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

According to TRM, an external FET controlled by a 1.8V output signal
can be used to reduce the pop-noise heard when the audio amplifier is
switched on. It is suggested that GPIO6 of TWL4030 be used, but any
other gpio can be used instead. This is indicated in machine driver
with the following twl4030_setup_data members:

-hs_extmute. Set to 1 if board has support for EXTMUTE.

-set_hs_extmute. Set to a callback funcion to control an external gpio
line. Set to NULL if MUTE[GPIO6] pin is used.

Codec driver takes care of enabling and disabling this output during
the headset pop attenuation sequence.

Also add a delay to let VMID settle in ramp up sequence.

Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
---
 sound/soc/codecs/twl4030.c |   27 +++++++++++++++++++++++++++
 sound/soc/codecs/twl4030.h |    2 ++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 06a95f2..4e9e0e1 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -620,6 +620,9 @@ static int handsfreerpga_event(struct snd_soc_dapm_widget *w,
 
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
+	struct snd_soc_device *socdev = codec->socdev;
+	struct twl4030_setup_data *setup = socdev->codec_data;
+
 	unsigned char hs_gain, hs_pop;
 	struct twl4030_priv *twl4030 = codec->private_data;
 	/* Base values for ramp delay calculation: 2^19 - 2^26 */
@@ -629,6 +632,17 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 	hs_gain = twl4030_read_reg_cache(codec, TWL4030_REG_HS_GAIN_SET);
 	hs_pop = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
 
+	/* Enable external mute control, this dramatically reduces
+	 * the pop-noise */
+	if (setup && setup->hs_extmute) {
+		if (setup->set_hs_extmute) {
+			setup->set_hs_extmute(1);
+		} else {
+			hs_pop |= TWL4030_EXTMUTE;
+			twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		}
+	}
+
 	if (ramp) {
 		/* Headset ramp-up according to the TRM */
 		hs_pop |= TWL4030_VMID_EN;
@@ -636,6 +650,9 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 		twl4030_write(codec, TWL4030_REG_HS_GAIN_SET, hs_gain);
 		hs_pop |= TWL4030_RAMP_EN;
 		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		/* Wait ramp delay time + 1, so the VMID can settle */
+		mdelay((ramp_base[(hs_pop & TWL4030_RAMP_DELAY) >> 2] /
+			twl4030->sysclk) + 1);
 	} else {
 		/* Headset ramp-down _not_ according to
 		 * the TRM, but in a way that it is working */
@@ -652,6 +669,16 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 		hs_pop &= ~TWL4030_VMID_EN;
 		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 	}
+
+	/* Disable external mute */
+	if (setup && setup->hs_extmute) {
+		if (setup->set_hs_extmute) {
+			setup->set_hs_extmute(0);
+		} else {
+			hs_pop &= ~TWL4030_EXTMUTE;
+			twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+		}
+	}
 }
 
 static int headsetlpga_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index fe5f395..2b4bfa2 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -274,6 +274,8 @@ extern struct snd_soc_codec_device soc_codec_dev_twl4030;
 struct twl4030_setup_data {
 	unsigned int ramp_delay_value;
 	unsigned int sysclk;
+	unsigned int hs_extmute:1;
+	void (*set_hs_extmute)(int mute);
 };
 
 #endif	/* End of __TWL4030_AUDIO_H__ */
-- 
1.6.0.4
