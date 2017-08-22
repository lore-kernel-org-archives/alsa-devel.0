From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Implement mic-mute LED mode enum
Date: Tue, 22 Aug 2017 16:57:31 +0200
Message-ID: <20170822145731.12924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B638266812
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 16:57:35 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id CB9E3AE97
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 14:57:34 +0000 (UTC)
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

Dell laptops have another LED for mic-mute in addition to the master
mute.  The former is tied with the capture switch (in a reverse way)
while the latter is tied with the master playback switch.  We already
have an enum control to change the behavior for the master mute LED in
different ways, e.g. keeping always off or turning off at mute.  But,
the mic-mute LED has no such management but its behavior is
hard-coded.

This patch implements an enum control to change the mic-mute LED
behavior like what we have for the master mute LED.  The ctl provides
four modes: keep-on, keep-off, follow-capture and follow-mute.  The
default mode is the last one, follow-mute, which follows the capture
mute, i.e. LED turning on when the capture is off, and turning off
when the capture is active.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/dell_wmi_helper.c | 87 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/dell_wmi_helper.c b/sound/pci/hda/dell_wmi_helper.c
index 7efa7bd7acb2..44b1e15682b9 100644
--- a/sound/pci/hda/dell_wmi_helper.c
+++ b/sound/pci/hda/dell_wmi_helper.c
@@ -5,12 +5,47 @@
 #if IS_ENABLED(CONFIG_DELL_LAPTOP)
 #include <linux/dell-led.h>
 
+enum {
+	MICMUTE_LED_ON,
+	MICMUTE_LED_OFF,
+	MICMUTE_LED_FOLLOW_CAPTURE,
+	MICMUTE_LED_FOLLOW_MUTE,
+};
+
+static int dell_led_mode = MICMUTE_LED_FOLLOW_MUTE;
+static int dell_capture;
 static int dell_led_value;
 static int (*dell_micmute_led_set_func)(int);
 static void (*dell_old_cap_hook)(struct hda_codec *,
 			         struct snd_kcontrol *,
 				 struct snd_ctl_elem_value *);
 
+static void call_micmute_led_update(void)
+{
+	int val;
+
+	switch (dell_led_mode) {
+	case MICMUTE_LED_ON:
+		val = 1;
+		break;
+	case MICMUTE_LED_OFF:
+		val = 0;
+		break;
+	case MICMUTE_LED_FOLLOW_CAPTURE:
+		val = dell_capture;
+		break;
+	case MICMUTE_LED_FOLLOW_MUTE:
+	default:
+		val = !dell_capture;
+		break;
+	}
+
+	if (val == dell_led_value)
+		return;
+	dell_led_value = val;
+	dell_micmute_led_set_func(dell_led_value);
+}
+
 static void update_dell_wmi_micmute_led(struct hda_codec *codec,
 				        struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
@@ -22,15 +57,54 @@ static void update_dell_wmi_micmute_led(struct hda_codec *codec,
 		return;
 	if (strcmp("Capture Switch", ucontrol->id.name) == 0 && ucontrol->id.index == 0) {
 		/* TODO: How do I verify if it's a mono or stereo here? */
-		int val = (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) ? 0 : 1;
-		if (val == dell_led_value)
-			return;
-		dell_led_value = val;
-		if (dell_micmute_led_set_func)
-			dell_micmute_led_set_func(dell_led_value);
+		dell_capture = (ucontrol->value.integer.value[0] ||
+				ucontrol->value.integer.value[1]);
+		call_micmute_led_update();
 	}
 }
 
+static int dell_mic_mute_led_mode_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts[] = {
+		"On", "Off", "Follow Capture", "Follow Mute",
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
+}
+
+static int dell_mic_mute_led_mode_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] = dell_led_mode;
+	return 0;
+}
+
+static int dell_mic_mute_led_mode_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	unsigned int mode;
+
+	mode = ucontrol->value.enumerated.item[0];
+	if (mode > MICMUTE_LED_FOLLOW_MUTE)
+		mode = MICMUTE_LED_FOLLOW_MUTE;
+	if (mode == dell_led_mode)
+		return 0;
+	dell_led_mode = mode;
+	call_micmute_led_update();
+	return 1;
+}
+
+static const struct snd_kcontrol_new dell_mic_mute_mode_ctls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Mic Mute-LED Mode",
+		.info = dell_mic_mute_led_mode_info,
+		.get = dell_mic_mute_led_mode_get,
+		.put = dell_mic_mute_led_mode_put,
+	},
+	{}
+};
 
 static void alc_fixup_dell_wmi(struct hda_codec *codec,
 			       const struct hda_fixup *fix, int action)
@@ -55,6 +129,7 @@ static void alc_fixup_dell_wmi(struct hda_codec *codec,
 				dell_old_cap_hook = spec->gen.cap_sync_hook;
 				spec->gen.cap_sync_hook = update_dell_wmi_micmute_led;
 				removefunc = false;
+				add_mixer(spec, dell_mic_mute_mode_ctls);
 			}
 		}
 
-- 
2.14.0
