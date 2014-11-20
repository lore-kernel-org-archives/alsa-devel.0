From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 06/10] ALSA: usb-audio: Add Digidesign Mbox
	1 resume support
Date: Thu, 20 Nov 2014 18:33:31 +0100
Message-ID: <1416504815-28685-7-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DA79E26589A
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 013EDAD97
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 17:33:47 +0000 (UTC)
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

Again another quirk fix, just convert to usb_mixer_elem_list with the
resume callback for Mbox 1 stuff.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 52 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index e7519770632d..5491c68efbc0 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -616,29 +616,12 @@ static int snd_mbox1_switch_get(struct snd_kcontrol *kctl,
 	return 0;
 }
 
-static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
-				struct snd_ctl_elem_value *ucontrol)
+static int snd_mbox1_switch_update(struct usb_mixer_interface *mixer, int val)
 {
-	struct snd_usb_audio *chip;
-	struct usb_mixer_interface *mixer;
+	struct snd_usb_audio *chip = mixer->chip;
 	int err;
-	bool cur_val, new_val;
 	unsigned char buff[3];
 
-	cur_val = kctl->private_value;
-	new_val = ucontrol->value.enumerated.item[0];
-
-	mixer = snd_kcontrol_chip(kctl);
-	if (snd_BUG_ON(!mixer))
-		return -EINVAL;
-
-	chip = mixer->chip;
-	if (snd_BUG_ON(!chip))
-		return -EINVAL;
-
-	if (cur_val == new_val)
-		return 0;
-
 	down_read(&chip->shutdown_rwsem);
 	if (chip->shutdown) {
 		err = -ENODEV;
@@ -668,7 +651,7 @@ static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
 	 *     while S/PDIF sync is enabled and confusing
 	 *     this configuration.
 	 */
-	if (new_val == 0) {
+	if (val == 0) {
 		buff[0] = 0x80;
 		buff[1] = 0xbb;
 		buff[2] = 0x00;
@@ -697,10 +680,27 @@ static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
 				USB_RECIP_ENDPOINT, 0x100, 0x2, buff, 3);
 	if (err < 0)
 		goto err;
-	kctl->private_value = new_val;
 
 err:
 	up_read(&chip->shutdown_rwsem);
+	return err;
+}
+
+static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kctl);
+	struct usb_mixer_interface *mixer = list->mixer;
+	int err;
+	bool cur_val, new_val;
+
+	cur_val = kctl->private_value;
+	new_val = ucontrol->value.enumerated.item[0];
+	if (cur_val == new_val)
+		return 0;
+
+	kctl->private_value = new_val;
+	err = snd_mbox1_switch_update(mixer, new_val);
 	return err < 0 ? err : 1;
 }
 
@@ -715,6 +715,11 @@ static int snd_mbox1_switch_info(struct snd_kcontrol *kcontrol,
 	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
 }
 
+static int snd_mbox1_switch_resume(struct usb_mixer_elem_list *list)
+{
+	return snd_mbox1_switch_update(list->mixer, list->kctl->private_value);
+}
+
 static struct snd_kcontrol_new snd_mbox1_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Clock Source",
@@ -728,8 +733,9 @@ static struct snd_kcontrol_new snd_mbox1_switch = {
 
 static int snd_mbox1_create_sync_switch(struct usb_mixer_interface *mixer)
 {
-	return snd_ctl_add(mixer->chip->card,
-			snd_ctl_new1(&snd_mbox1_switch, mixer));
+	return add_single_ctl_with_resume(mixer, 0,
+					  snd_mbox1_switch_resume,
+					  &snd_mbox1_switch, NULL);
 }
 
 /* Native Instruments device quirks */
-- 
2.1.3
