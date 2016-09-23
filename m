From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] ALSA: usb-audio: Extend DragonFly dB scale
	quirk to cover other variants
Date: Fri, 23 Sep 2016 06:43:47 +0300
Message-ID: <1474602227-7122-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 60589266A28
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2016 05:44:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The DragonFly quirk added in 42e3121d90f4 ("ALSA: usb-audio: Add a more
accurate volume quirk for AudioQuest DragonFly") applies a custom dB map
on the volume control when its range is reported as 0..50 (0 .. 0.2dB).

However, there exists at least one other variant (hw v1.0c, as opposed
to the tested v1.2) which reports a different non-sensical volume range
(0..53) and the custom map is therefore not applied for that device.

This results in all of the volume change appearing close to 100% on
mixer UIs that utilize the dB TLV information.

Add a fallback case where no dB TLV is reported at all if the control
range is not 0..50 but still 0..N where N <= 1000 (3.9 dB). Also
restrict the quirk to only apply to the volume control as there is also
a mute control which would match the check otherwise.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Reported-by: David W <regulars@d-dub.org.uk>
Tested-by: David W <regulars@d-dub.org.uk>
Cc: <stable@vger.kernel.org>
---
 sound/usb/mixer_quirks.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index f6c3bf79af9a..f0de14a293ce 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1831,6 +1831,7 @@ void snd_usb_mixer_rc_memory_change(struct usb_mixer_interface *mixer,
 }
 
 static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
+					 struct usb_mixer_elem_info *cval,
 					 struct snd_kcontrol *kctl)
 {
 	/* Approximation using 10 ranges based on output measurement on hw v1.2.
@@ -1848,10 +1849,18 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
 		41, 50, TLV_DB_MINMAX_ITEM(-441, 0),
 	);
 
-	usb_audio_info(mixer->chip, "applying DragonFly dB scale quirk\n");
-	kctl->tlv.p = scale;
-	kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
-	kctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+	if (cval->min == 0 && cval->max == 50) {
+		usb_audio_info(mixer->chip, "applying DragonFly dB scale quirk (0-50 variant)\n");
+		kctl->tlv.p = scale;
+		kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+		kctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+
+	} else if (cval->min == 0 && cval->max <= 1000) {
+		/* Some other clearly broken DragonFly variant.
+		 * At least a 0..53 variant (hw v1.0) exists. */
+		usb_audio_info(mixer->chip, "ignoring too narrow dB range on a DragonFly device");
+		kctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+	}
 }
 
 void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
@@ -1860,8 +1869,8 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 {
 	switch (mixer->chip->usb_id) {
 	case USB_ID(0x21b4, 0x0081): /* AudioQuest DragonFly */
-		if (unitid == 7 && cval->min == 0 && cval->max == 50)
-			snd_dragonfly_quirk_db_scale(mixer, kctl);
+		if (unitid == 7 && cval->control == UAC_FU_VOLUME)
+			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
 	}
 }
-- 
2.7.4
