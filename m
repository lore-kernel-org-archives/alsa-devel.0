From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: hda - Allow multiple ADCs for mic
	mute LED controls
Date: Thu, 21 Jun 2018 14:24:59 +0200
Message-ID: <20180621122501.22290-4-tiwai@suse.de>
References: <20180621122501.22290-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A6CDC2676C4
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 14:25:05 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 16E3DAFE9
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

Instead of refusing, allow the configuration with the multiple ADCs
(thus multiple capture switches) for enabling the mic mute LED.
This has been done for Sigmatel/IDT codecs, and we treat the OR-ed
values from all capture switches as the boolean condition.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index cdce9ce6b901..942f96e184b6 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3922,7 +3922,7 @@ static void call_micmute_led_update(struct hda_codec *codec)
 		val = 0;
 		break;
 	case MICMUTE_LED_FOLLOW_CAPTURE:
-		val = spec->micmute_led.capture;
+		val = !!spec->micmute_led.capture;
 		break;
 	case MICMUTE_LED_FOLLOW_MUTE:
 	default:
@@ -3942,17 +3942,21 @@ static void update_micmute_led(struct hda_codec *codec,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_gen_spec *spec = codec->spec;
+	unsigned int mask;
 
 	if (spec->micmute_led.old_hook)
 		spec->micmute_led.old_hook(codec, kcontrol, ucontrol);
 
 	if (!ucontrol)
 		return;
-	if (!strcmp("Capture Switch", ucontrol->id.name) &&
-	    !ucontrol->id.index) {
+	mask = 1U << snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	if (!strcmp("Capture Switch", ucontrol->id.name)) {
 		/* TODO: How do I verify if it's a mono or stereo here? */
-		spec->micmute_led.capture = (ucontrol->value.integer.value[0] ||
-					     ucontrol->value.integer.value[1]);
+		if (ucontrol->value.integer.value[0] ||
+		    ucontrol->value.integer.value[1])
+			spec->micmute_led.capture |= mask;
+		else
+			spec->micmute_led.capture &= ~mask;
 		call_micmute_led_update(codec);
 	}
 }
@@ -4008,25 +4012,17 @@ static const struct snd_kcontrol_new micmute_led_mode_ctl = {
  * @hook: the callback for updating LED
  *
  * Called from the codec drivers for offering the mic mute LED controls.
- * Only valid for a single ADC (or a single input).  When established, it
- * sets up cap_sync_hook and triggers the callback at each time when the
- * capture mixer switch changes.  The callback is supposed to update the LED
- * accordingly.
+ * When established, it sets up cap_sync_hook and triggers the callback at
+ * each time when the capture mixer switch changes.  The callback is supposed
+ * to update the LED accordingly.
  *
- * Returns 1 if the hook is established, 0 if skipped (no valid config), or
- * a negative error code.
+ * Returns 0 if the hook is established or a negative error code.
  */
 int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
 				void (*hook)(struct hda_codec *))
 {
 	struct hda_gen_spec *spec = codec->spec;
 
-	if (spec->num_adc_nids > 1 && !spec->dyn_adc_switch) {
-		codec_dbg(codec,
-			  "Skipping micmute LED control due to several ADCs");
-		return 0;
-	}
-
 	spec->micmute_led.led_mode = MICMUTE_LED_FOLLOW_MUTE;
 	spec->micmute_led.capture = 0;
 	spec->micmute_led.led_value = 0;
@@ -4035,7 +4031,7 @@ int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
 	spec->cap_sync_hook = update_micmute_led;
 	if (!snd_hda_gen_add_kctl(spec, NULL, &micmute_led_mode_ctl))
 		return -ENOMEM;
-	return 1;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_add_micmute_led);
 
-- 
2.17.1
