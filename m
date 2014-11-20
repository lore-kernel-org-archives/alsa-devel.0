From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 05/10] ALSA: usb-audio: Add Xonar U1 resume
	support
Date: Thu, 20 Nov 2014 18:33:30 +0100
Message-ID: <1416504815-28685-6-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D5CF260619
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E438DAD8A
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 17:33:46 +0000 (UTC)
In-Reply-To: <1416504815-28685-1-git-send-email-tiwai@suse.de>
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

This time it's about Xonar U1: add the proper resume support for
"Digital Playback Switch" element.

Also, the status is moved into kcontrol private_value from
usb_mixer_interface struct field.  One more cut.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.h        |  2 --
 sound/usb/mixer_quirks.c | 66 ++++++++++++++++++++++++++++--------------------
 2 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index a9697fe93aef..c2a5b923f9bc 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -22,8 +22,6 @@ struct usb_mixer_interface {
 	struct urb *rc_urb;
 	struct usb_ctrlrequest *rc_setup_packet;
 	u8 rc_buffer[6];
-
-	u8 xonar_u1_status;
 };
 
 #define MAX_CHANNELS	16	/* max logical channels */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 870d8975ae2e..e7519770632d 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -543,38 +543,52 @@ static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
 static int snd_xonar_u1_switch_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
-
-	ucontrol->value.integer.value[0] = !!(mixer->xonar_u1_status & 0x02);
+	ucontrol->value.integer.value[0] = !!(kcontrol->private_value & 0x02);
 	return 0;
 }
 
+static int snd_xonar_u1_switch_update(struct usb_mixer_interface *mixer,
+				      unsigned char status)
+{
+	struct snd_usb_audio *chip = mixer->chip;
+	int err;
+
+	down_read(&chip->shutdown_rwsem);
+	if (chip->shutdown)
+		err = -ENODEV;
+	else
+		err = snd_usb_ctl_msg(chip->dev,
+			      usb_sndctrlpipe(chip->dev, 0), 0x08,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+			      50, 0, &status, 1);
+	up_read(&chip->shutdown_rwsem);
+	return err;
+}
+
 static int snd_xonar_u1_switch_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	u8 old_status, new_status;
-	int err, changed;
+	int err;
 
-	old_status = mixer->xonar_u1_status;
+	old_status = kcontrol->private_value;
 	if (ucontrol->value.integer.value[0])
 		new_status = old_status | 0x02;
 	else
 		new_status = old_status & ~0x02;
-	changed = new_status != old_status;
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		err = -ENODEV;
-	else
-		err = snd_usb_ctl_msg(mixer->chip->dev,
-			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x08,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			      50, 0, &new_status, 1);
-	up_read(&mixer->chip->shutdown_rwsem);
-	if (err < 0)
-		return err;
-	mixer->xonar_u1_status = new_status;
-	return changed;
+	if (new_status == old_status)
+		return 0;
+
+	kcontrol->private_value = new_status;
+	err = snd_xonar_u1_switch_update(list->mixer, new_status);
+	return err < 0 ? err : 1;
+}
+
+static int snd_xonar_u1_switch_resume(struct usb_mixer_elem_list *list)
+{
+	return snd_xonar_u1_switch_update(list->mixer,
+					  list->kctl->private_value);
 }
 
 static struct snd_kcontrol_new snd_xonar_u1_output_switch = {
@@ -583,18 +597,14 @@ static struct snd_kcontrol_new snd_xonar_u1_output_switch = {
 	.info = snd_ctl_boolean_mono_info,
 	.get = snd_xonar_u1_switch_get,
 	.put = snd_xonar_u1_switch_put,
+	.private_value = 0x05,
 };
 
 static int snd_xonar_u1_controls_create(struct usb_mixer_interface *mixer)
 {
-	int err;
-
-	err = snd_ctl_add(mixer->chip->card,
-			  snd_ctl_new1(&snd_xonar_u1_output_switch, mixer));
-	if (err < 0)
-		return err;
-	mixer->xonar_u1_status = 0x05;
-	return 0;
+	return add_single_ctl_with_resume(mixer, 0,
+					  snd_xonar_u1_switch_resume,
+					  &snd_xonar_u1_output_switch, NULL);
 }
 
 /* Digidesign Mbox 1 clock source switch (internal/spdif) */
-- 
2.1.3
