From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: hda/realtek - Use the mic-mute LED
	helper for HP and others
Date: Thu, 21 Jun 2018 14:24:57 +0200
Message-ID: <20180621122501.22290-2-tiwai@suse.de>
References: <20180621122501.22290-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A590D2676C3
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 14:25:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0FE71ADA7
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 12:25:05 +0000 (UTC)
In-Reply-To: <20180621122501.22290-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Similar as the previous commit, convert to use the common helper for
controlling the mic mute LED for HP and other machines in the Realtek
codec driver, too.  This will give the mic mute LED enum as gratis.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 49 +++++++++++++----------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 487ceb9fd038..32a7a72033ae 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3718,16 +3718,12 @@ static void alc_fixup_gpio_mute_hook(void *private_data, int enabled)
 }
 
 /* turn on/off mic-mute LED via GPIO per capture hook */
-static void alc_fixup_gpio_mic_mute_hook(struct hda_codec *codec,
-					 struct snd_kcontrol *kcontrol,
-					 struct snd_ctl_elem_value *ucontrol)
+static void alc_gpio_micmute_update(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (ucontrol)
-		alc_update_gpio_led(codec, spec->gpio_mic_led_mask,
-				    ucontrol->value.integer.value[0] ||
-				    ucontrol->value.integer.value[1]);
+	alc_update_gpio_led(codec, spec->gpio_mic_led_mask,
+			    spec->gen.micmute_led.led_value);
 }
 
 static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
@@ -3742,12 +3738,12 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = alc_fixup_gpio_mute_hook;
-		spec->gen.cap_sync_hook = alc_fixup_gpio_mic_mute_hook;
 		spec->gpio_led = 0;
 		spec->mute_led_polarity = 0;
 		spec->gpio_mute_led_mask = 0x08;
 		spec->gpio_mic_led_mask = 0x10;
 		snd_hda_add_verbs(codec, gpio_init);
+		snd_hda_gen_add_micmute_led(codec, alc_gpio_micmute_update);
 	}
 }
 
@@ -3763,39 +3759,30 @@ static void alc286_fixup_hp_gpio_led(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = alc_fixup_gpio_mute_hook;
-		spec->gen.cap_sync_hook = alc_fixup_gpio_mic_mute_hook;
 		spec->gpio_led = 0;
 		spec->mute_led_polarity = 0;
 		spec->gpio_mute_led_mask = 0x02;
 		spec->gpio_mic_led_mask = 0x20;
 		snd_hda_add_verbs(codec, gpio_init);
+		snd_hda_gen_add_micmute_led(codec, alc_gpio_micmute_update);
 	}
 }
 
 /* turn on/off mic-mute LED per capture hook */
-static void alc269_fixup_hp_cap_mic_mute_hook(struct hda_codec *codec,
-					       struct snd_kcontrol *kcontrol,
-					       struct snd_ctl_elem_value *ucontrol)
+static void alc_cap_micmute_update(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int pinval, enable, disable;
+	unsigned int pinval;
 
+	if (!spec->cap_mute_led_nid)
+		return;
 	pinval = snd_hda_codec_get_pin_target(codec, spec->cap_mute_led_nid);
 	pinval &= ~AC_PINCTL_VREFEN;
-	enable  = pinval | AC_PINCTL_VREF_80;
-	disable = pinval | AC_PINCTL_VREF_HIZ;
-
-	if (!ucontrol)
-		return;
-
-	if (ucontrol->value.integer.value[0] ||
-	    ucontrol->value.integer.value[1])
-		pinval = disable;
+	if (spec->gen.micmute_led.led_value)
+		pinval |= AC_PINCTL_VREF_80;
 	else
-		pinval = enable;
-
-	if (spec->cap_mute_led_nid)
-		snd_hda_set_pin_ctl_cache(codec, spec->cap_mute_led_nid, pinval);
+		pinval |= AC_PINCTL_VREF_HIZ;
+	snd_hda_set_pin_ctl_cache(codec, spec->cap_mute_led_nid, pinval);
 }
 
 static void alc269_fixup_hp_gpio_mic1_led(struct hda_codec *codec,
@@ -3810,12 +3797,12 @@ static void alc269_fixup_hp_gpio_mic1_led(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = alc_fixup_gpio_mute_hook;
-		spec->gen.cap_sync_hook = alc269_fixup_hp_cap_mic_mute_hook;
 		spec->gpio_led = 0;
 		spec->mute_led_polarity = 0;
 		spec->gpio_mute_led_mask = 0x08;
 		spec->cap_mute_led_nid = 0x18;
 		snd_hda_add_verbs(codec, gpio_init);
+		snd_hda_gen_add_micmute_led(codec, alc_cap_micmute_update);
 		codec->power_filter = led_power_filter;
 	}
 }
@@ -3833,12 +3820,12 @@ static void alc280_fixup_hp_gpio4(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = alc_fixup_gpio_mute_hook;
-		spec->gen.cap_sync_hook = alc269_fixup_hp_cap_mic_mute_hook;
 		spec->gpio_led = 0;
 		spec->mute_led_polarity = 0;
 		spec->gpio_mute_led_mask = 0x08;
 		spec->cap_mute_led_nid = 0x18;
 		snd_hda_add_verbs(codec, gpio_init);
+		snd_hda_gen_add_micmute_led(codec, alc_cap_micmute_update);
 		codec->power_filter = led_power_filter;
 	}
 }
@@ -3915,11 +3902,11 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 						    gpio2_mic_hotkey_event);
 
 		spec->gen.vmaster_mute.hook = alc_fixup_gpio_mute_hook;
-		spec->gen.cap_sync_hook = alc_fixup_gpio_mic_mute_hook;
 		spec->gpio_led = 0;
 		spec->mute_led_polarity = 0;
 		spec->gpio_mute_led_mask = 0x08;
 		spec->gpio_mic_led_mask = 0x10;
+		snd_hda_gen_add_micmute_led(codec, alc_gpio_micmute_update);
 		return;
 	}
 
@@ -3957,10 +3944,10 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 		snd_hda_jack_detect_enable_callback(codec, 0x1b,
 						    gpio2_mic_hotkey_event);
 
-		spec->gen.cap_sync_hook = alc_fixup_gpio_mic_mute_hook;
 		spec->gpio_led = 0;
 		spec->mute_led_polarity = 0;
 		spec->gpio_mic_led_mask = 0x04;
+		snd_hda_gen_add_micmute_led(codec, alc_gpio_micmute_update);
 		return;
 	}
 
@@ -3988,10 +3975,10 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
-		spec->gen.cap_sync_hook = alc269_fixup_hp_cap_mic_mute_hook;
 		spec->mute_led_polarity = 0;
 		spec->mute_led_nid = 0x1a;
 		spec->cap_mute_led_nid = 0x18;
+		snd_hda_gen_add_micmute_led(codec, alc_cap_micmute_update);
 		spec->gen.vmaster_mute_enum = 1;
 		codec->power_filter = led_power_filter;
 	}
-- 
2.17.1
