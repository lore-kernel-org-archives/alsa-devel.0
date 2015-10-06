From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 13/18] ALSA: hda: move patch_realtek to use
	hdac helpers
Date: Tue,  6 Oct 2015 16:07:50 +0100
Message-ID: <1444144075-28963-14-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3019726589B
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:09:50 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move patch_realtek to use newly moved snd_hdac_read/write_codec()
APIs

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_realtek.c | 136 +++++++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 63 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index afec6dc9f91f..30f3978df056 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -133,8 +133,10 @@ static int alc_read_coefex_idx(struct hda_codec *codec, hda_nid_t nid,
 {
 	unsigned int val;
 
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, coef_idx);
-	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PROC_COEF, 0);
+	snd_hdac_codec_write(&codec->core, nid, 0, AC_VERB_SET_COEF_INDEX,
+			     coef_idx);
+	val = snd_hdac_codec_read(&codec->core, nid, 0, AC_VERB_GET_PROC_COEF,
+				  0);
 	return val;
 }
 
@@ -144,8 +146,10 @@ static int alc_read_coefex_idx(struct hda_codec *codec, hda_nid_t nid,
 static void alc_write_coefex_idx(struct hda_codec *codec, hda_nid_t nid,
 				 unsigned int coef_idx, unsigned int coef_val)
 {
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX, coef_idx);
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PROC_COEF, coef_val);
+	snd_hdac_codec_write(&codec->core, nid, 0, AC_VERB_SET_COEF_INDEX,
+			     coef_idx);
+	snd_hdac_codec_write(&codec->core, nid, 0, AC_VERB_SET_PROC_COEF,
+			     coef_val);
 }
 
 #define alc_write_coef_idx(codec, coef_idx, coef_val) \
@@ -276,8 +280,8 @@ static void alc_update_knob_master(struct hda_codec *codec,
 	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
 	if (!uctl)
 		return;
-	val = snd_hda_codec_read(codec, jack->tbl->nid, 0,
-				 AC_VERB_GET_VOLUME_KNOB_CONTROL, 0);
+	val = snd_hdac_codec_read(&codec->core, jack->tbl->nid, 0,
+				  AC_VERB_GET_VOLUME_KNOB_CONTROL, 0);
 	val &= HDA_AMP_VOLMASK;
 	uctl->value.integer.value[0] = val;
 	uctl->value.integer.value[1] = val;
@@ -387,8 +391,8 @@ static void set_eapd(struct hda_codec *codec, hda_nid_t nid, int on)
 	if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
 		return;
 	if (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD)
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_EAPD_BTLENABLE,
-				    on ? 2 : 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     AC_VERB_SET_EAPD_BTLENABLE, on ? 2 : 0);
 }
 
 /* turn on/off EAPD controls of the codec */
@@ -1502,8 +1506,8 @@ enum {
 static void alc260_gpio1_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
-			    spec->gen.hp_jack_present);
+	snd_hdac_codec_write(&codec->core, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+			     spec->gen.hp_jack_present);
 }
 
 static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
@@ -1784,32 +1788,32 @@ static void alc882_gpio_mute(struct hda_codec *codec, int pin, int muted)
 {
 	unsigned int gpiostate, gpiomask, gpiodir;
 
-	gpiostate = snd_hda_codec_read(codec, codec->core.afg, 0,
-				       AC_VERB_GET_GPIO_DATA, 0);
+	gpiostate = snd_hdac_codec_read(&codec->core, codec->core.afg, 0,
+					AC_VERB_GET_GPIO_DATA, 0);
 
 	if (!muted)
 		gpiostate |= (1 << pin);
 	else
 		gpiostate &= ~(1 << pin);
 
-	gpiomask = snd_hda_codec_read(codec, codec->core.afg, 0,
-				      AC_VERB_GET_GPIO_MASK, 0);
+	gpiomask = snd_hdac_codec_read(&codec->core, codec->core.afg, 0,
+				       AC_VERB_GET_GPIO_MASK, 0);
 	gpiomask |= (1 << pin);
 
-	gpiodir = snd_hda_codec_read(codec, codec->core.afg, 0,
-				     AC_VERB_GET_GPIO_DIRECTION, 0);
+	gpiodir = snd_hdac_codec_read(&codec->core, codec->core.afg, 0,
+				      AC_VERB_GET_GPIO_DIRECTION, 0);
 	gpiodir |= (1 << pin);
 
 
-	snd_hda_codec_write(codec, codec->core.afg, 0,
-			    AC_VERB_SET_GPIO_MASK, gpiomask);
-	snd_hda_codec_write(codec, codec->core.afg, 0,
-			    AC_VERB_SET_GPIO_DIRECTION, gpiodir);
+	snd_hdac_codec_write(&codec->core, codec->core.afg, 0,
+			     AC_VERB_SET_GPIO_MASK, gpiomask);
+	snd_hdac_codec_write(&codec->core, codec->core.afg, 0,
+			     AC_VERB_SET_GPIO_DIRECTION, gpiodir);
 
 	msleep(1);
 
-	snd_hda_codec_write(codec, codec->core.afg, 0,
-			    AC_VERB_SET_GPIO_DATA, gpiostate);
+	snd_hdac_codec_write(&codec->core, codec->core.afg, 0,
+			     AC_VERB_SET_GPIO_DATA, gpiostate);
 }
 
 /* set up GPIO at initialization */
@@ -2675,8 +2679,8 @@ static void alc286_shutup(struct hda_codec *codec)
 		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
 		/* use read here for syncing after issuing each verb */
 		if (pin->nid != mic_pin)
-			snd_hda_codec_read(codec, pin->nid, 0,
-					AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
+			snd_hdac_codec_read(&codec->core, pin->nid, 0,
+					    AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
 	}
 	codec->pins_shutup = 1;
 }
@@ -2758,14 +2762,14 @@ static void alc282_init(struct hda_codec *codec)
 	if (hp_pin_sense)
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
 	if (hp_pin_sense)
 		msleep(85);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
 	if (hp_pin_sense)
 		msleep(100);
@@ -2793,14 +2797,14 @@ static void alc282_shutup(struct hda_codec *codec)
 	if (hp_pin_sense)
 		msleep(2);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
 	if (hp_pin_sense)
 		msleep(85);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
 	if (hp_pin_sense)
 		msleep(100);
@@ -2875,14 +2879,14 @@ static void alc283_init(struct hda_codec *codec)
 	/* Headphone capless set to high power mode */
 	alc_write_coef_idx(codec, 0x43, 0x9004);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
 	if (hp_pin_sense)
 		msleep(85);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
 	if (hp_pin_sense)
 		msleep(85);
@@ -2916,14 +2920,14 @@ static void alc283_shutup(struct hda_codec *codec)
 	/*depop hp during suspend*/
 	alc_write_coef_idx(codec, 0x06, 0x2100);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
 	if (hp_pin_sense)
 		msleep(100);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
 	alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
@@ -2937,19 +2941,23 @@ static void alc283_shutup(struct hda_codec *codec)
 static void alc5505_coef_set(struct hda_codec *codec, unsigned int index_reg,
 			     unsigned int val)
 {
-	snd_hda_codec_write(codec, 0x51, 0, AC_VERB_SET_COEF_INDEX, index_reg >> 1);
-	snd_hda_codec_write(codec, 0x51, 0, AC_VERB_SET_PROC_COEF, val & 0xffff); /* LSB */
-	snd_hda_codec_write(codec, 0x51, 0, AC_VERB_SET_PROC_COEF, val >> 16); /* MSB */
+	snd_hdac_codec_write(&codec->core, 0x51, 0, AC_VERB_SET_COEF_INDEX,
+			     index_reg >> 1);
+	snd_hdac_codec_write(&codec->core, 0x51, 0, AC_VERB_SET_PROC_COEF,
+			     val & 0xffff); /* LSB */
+	snd_hdac_codec_write(&codec->core, 0x51, 0, AC_VERB_SET_PROC_COEF,
+			     val >> 16); /* MSB */
 }
 
 static int alc5505_coef_get(struct hda_codec *codec, unsigned int index_reg)
 {
 	unsigned int val;
 
-	snd_hda_codec_write(codec, 0x51, 0, AC_VERB_SET_COEF_INDEX, index_reg >> 1);
-	val = snd_hda_codec_read(codec, 0x51, 0, AC_VERB_GET_PROC_COEF, 0)
+	snd_hdac_codec_write(&codec->core, 0x51, 0, AC_VERB_SET_COEF_INDEX,
+			     index_reg >> 1);
+	val = snd_hdac_codec_read(&codec->core, 0x51, 0, AC_VERB_GET_PROC_COEF, 0)
 		& 0xffff;
-	val |= snd_hda_codec_read(codec, 0x51, 0, AC_VERB_GET_PROC_COEF, 0)
+	val |= snd_hdac_codec_read(&codec->core, 0x51, 0, AC_VERB_GET_PROC_COEF, 0)
 		<< 16;
 	return val;
 }
@@ -2991,7 +2999,8 @@ static void alc5505_dsp_init(struct hda_codec *codec)
 	alc5505_coef_set(codec, 0x61b4, 0x04132b02);
 	alc5505_coef_set(codec, 0x61b8, 0x041f3300); /* PLL3 control*/
 	alc5505_coef_set(codec, 0x61b8, 0x041f3302);
-	snd_hda_codec_write(codec, 0x51, 0, AC_VERB_SET_CODEC_RESET, 0); /* Function reset */
+	snd_hdac_codec_write(&codec->core, 0x51, 0, AC_VERB_SET_CODEC_RESET,
+			     0); /* Function reset */
 	alc5505_coef_set(codec, 0x61b8, 0x041b3302);
 	alc5505_coef_set(codec, 0x61b8, 0x04173302);
 	alc5505_coef_set(codec, 0x61b8, 0x04163302);
@@ -3064,8 +3073,8 @@ static int alc269_resume(struct hda_codec *codec)
 	 * in the driver.
 	 */
 	if (spec->gpio_led)
-		snd_hda_codec_write(codec, codec->core.afg, 0, AC_VERB_SET_GPIO_DATA,
-			    spec->gpio_led);
+		snd_hdac_codec_write(&codec->core, codec->core.afg, 0,
+				     AC_VERB_SET_GPIO_DATA, spec->gpio_led);
 
 	if (spec->has_alc5505_dsp)
 		alc5505_dsp_resume(codec);
@@ -3171,11 +3180,11 @@ static void alc269_x101_hp_automute_hook(struct hda_codec *codec,
 
 	vref = spec->gen.hp_jack_present ? PIN_VREF80 : 0;
 	msleep(100);
-	snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    vref);
+	snd_hdac_codec_write(&codec->core, 0x18, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, vref);
 	msleep(500);
-	snd_hda_codec_write(codec, 0x18, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    vref);
+	snd_hdac_codec_write(&codec->core, 0x18, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, vref);
 }
 
 static void alc269_fixup_x101_headset_mic(struct hda_codec *codec,
@@ -3291,8 +3300,8 @@ static void alc_update_gpio_led(struct hda_codec *codec, unsigned int mask,
 	else
 		spec->gpio_led |= mask;
 	if (spec->gpio_led != oldval)
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
-				    spec->gpio_led);
+		snd_hdac_codec_write(&codec->core, 0x01, 0,
+				     AC_VERB_SET_GPIO_DATA, spec->gpio_led);
 }
 
 /* turn on/off mute LED via GPIO per vmaster hook */
@@ -4142,8 +4151,8 @@ static void alc288_update_headset_jack_cb(struct hda_codec *codec,
 	alc_update_headset_jack_cb(codec, jack);
 	/* Headset Mic enable or disable, only for Dell Dino */
 	present = spec->gen.hp_jack_present ? 0x40 : 0;
-	snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
-				present);
+	snd_hdac_codec_write(&codec->core, 0x01, 0, AC_VERB_SET_GPIO_DATA,
+			     present);
 }
 
 static void alc_fixup_headset_mode_dell_alc288(struct hda_codec *codec,
@@ -4212,8 +4221,8 @@ static void alc_shutup_dell_xps13(struct hda_codec *codec)
 	int hp_pin = spec->gen.autocfg.hp_pins[0];
 
 	/* Prevent pop noises when headphones are plugged in */
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	snd_hdac_codec_write(&codec->core, hp_pin, 0,
+			     AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 	msleep(20);
 }
 
@@ -4256,7 +4265,8 @@ static void alc_fixup_headset_mode_alc662(struct hda_codec *codec,
 
 		/* Disable boost for mic-in permanently. (This code is only called
 		   from quirks that guarantee that the headphone is at NID 0x1b.) */
-		snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_AMP_GAIN_MUTE, 0x7000);
+		snd_hdac_codec_write(&codec->core, 0x1b, 0,
+				     AC_VERB_SET_AMP_GAIN_MUTE, 0x7000);
 		snd_hda_override_wcaps(codec, 0x1b, get_wcaps(codec, 0x1b) & ~AC_WCAP_IN_AMP);
 	} else
 		alc_fixup_headset_mode(codec, fix, action);
@@ -4355,8 +4365,8 @@ static void alc283_hp_automute_hook(struct hda_codec *codec,
 	vref = spec->gen.hp_jack_present ? PIN_VREF80 : 0;
 
 	msleep(600);
-	snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
-			    vref);
+	snd_hdac_codec_write(&codec->core, 0x19, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, vref);
 }
 
 static void alc283_fixup_chromebook(struct hda_codec *codec,
@@ -5742,7 +5752,7 @@ static int patch_alc269(struct hda_codec *codec)
 		break;
 	}
 
-	if (snd_hda_codec_read(codec, 0x51, 0, AC_VERB_PARAMETERS, 0) == 0x10ec5505) {
+	if (snd_hdac_codec_read(&codec->core, 0x51, 0, AC_VERB_PARAMETERS, 0) == 0x10ec5505) {
 		spec->has_alc5505_dsp = 1;
 		spec->init_hook = alc5505_dsp_init;
 	}
-- 
2.4.3
