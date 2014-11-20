From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 08/10] ALSA: usb-audio: Add resume support
	for FTU controls
Date: Thu, 20 Nov 2014 18:33:33 +0100
Message-ID: <1416504815-28685-9-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A002A260621
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E4083AD89
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

A few FTU mixer controls have the own value handling, so they have to
be rewritten to follow the support for resume callbacks.  This ended
up in a fair amount of refactoring.  Its own struct is now removed,
instead the values are embedded in kctl private_value totally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 194 +++++++++++++----------------------------------
 1 file changed, 54 insertions(+), 140 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 29324f4b3a7b..29afad6aac04 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -892,14 +892,6 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 
 /* M-Audio FastTrack Ultra quirks */
 /* FTU Effect switch (also used by C400/C600) */
-struct snd_ftu_eff_switch_priv_val {
-	struct usb_mixer_interface *mixer;
-	int cached_value;
-	int is_cached;
-	int bUnitID;
-	int validx;
-};
-
 static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
 {
@@ -911,138 +903,77 @@ static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
 	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
 }
 
-static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
+static int snd_ftu_eff_switch_init(struct usb_mixer_interface *mixer,
+				   struct snd_kcontrol *kctl)
 {
-	struct snd_usb_audio *chip;
-	struct usb_mixer_interface *mixer;
-	struct snd_ftu_eff_switch_priv_val *pval;
+	struct usb_device *dev = mixer->chip->dev;
+	unsigned int pval = kctl->private_value;
 	int err;
 	unsigned char value[2];
-	int id, validx;
-
-	const int val_len = 2;
 
 	value[0] = 0x00;
 	value[1] = 0x00;
 
-	pval = (struct snd_ftu_eff_switch_priv_val *)
-		kctl->private_value;
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC_GET_CUR,
+			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
+			      pval & 0xff00,
+			      snd_usb_ctrl_intf(mixer->chip) | ((pval & 0xff) << 8),
+			      value, 2);
+	if (err < 0)
+		return err;
 
-	if (pval->is_cached) {
-		ucontrol->value.enumerated.item[0] = pval->cached_value;
-		return 0;
-	}
+	kctl->private_value |= value[0] << 24;
+	return 0;
+}
 
-	mixer = (struct usb_mixer_interface *) pval->mixer;
-	if (snd_BUG_ON(!mixer))
-		return -EINVAL;
+static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] = kctl->private_value >> 24;
+	return 0;
+}
 
-	chip = (struct snd_usb_audio *) mixer->chip;
-	if (snd_BUG_ON(!chip))
-		return -EINVAL;
+static int snd_ftu_eff_switch_update(struct usb_mixer_elem_list *list)
+{
+	struct snd_usb_audio *chip = list->mixer->chip;
+	unsigned int pval = list->kctl->private_value;
+	unsigned char value[2];
+	int err;
 
-	id = pval->bUnitID;
-	validx = pval->validx;
+	value[0] = pval >> 24;
+	value[1] = 0;
 
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
+	down_read(&chip->shutdown_rwsem);
+	if (chip->shutdown)
 		err = -ENODEV;
 	else
 		err = snd_usb_ctl_msg(chip->dev,
-			usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
-			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-			validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
-			value, val_len);
-	up_read(&mixer->chip->shutdown_rwsem);
-	if (err < 0)
-		return err;
-
-	ucontrol->value.enumerated.item[0] = value[0];
-	pval->cached_value = value[0];
-	pval->is_cached = 1;
-
-	return 0;
+				      usb_sndctrlpipe(chip->dev, 0),
+				      UAC_SET_CUR,
+				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+				      pval & 0xff00,
+				      snd_usb_ctrl_intf(chip) | ((pval & 0xff) << 8),
+				      value, 2);
+	up_read(&chip->shutdown_rwsem);
+	return err;
 }
 
 static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 					struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_usb_audio *chip;
-	struct snd_ftu_eff_switch_priv_val *pval;
-
-	struct usb_mixer_interface *mixer;
-	int changed, cur_val, err, new_val;
-	unsigned char value[2];
-	int id, validx;
-
-	const int val_len = 2;
-
-	changed = 0;
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kctl);
+	unsigned int pval = list->kctl->private_value;
+	int cur_val, err, new_val;
 
-	pval = (struct snd_ftu_eff_switch_priv_val *)
-		kctl->private_value;
-	cur_val = pval->cached_value;
+	cur_val = pval >> 24;
 	new_val = ucontrol->value.enumerated.item[0];
+	if (cur_val == new_val)
+		return 0;
 
-	mixer = (struct usb_mixer_interface *) pval->mixer;
-	if (snd_BUG_ON(!mixer))
-		return -EINVAL;
-
-	chip = (struct snd_usb_audio *) mixer->chip;
-	if (snd_BUG_ON(!chip))
-		return -EINVAL;
-
-	id = pval->bUnitID;
-	validx = pval->validx;
-
-	if (!pval->is_cached) {
-		/* Read current value */
-		down_read(&mixer->chip->shutdown_rwsem);
-		if (mixer->chip->shutdown)
-			err = -ENODEV;
-		else
-			err = snd_usb_ctl_msg(chip->dev,
-				usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
-				USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-				validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
-				value, val_len);
-		up_read(&mixer->chip->shutdown_rwsem);
-		if (err < 0)
-			return err;
-
-		cur_val = value[0];
-		pval->cached_value = cur_val;
-		pval->is_cached = 1;
-	}
-	/* update value if needed */
-	if (cur_val != new_val) {
-		value[0] = new_val;
-		value[1] = 0;
-		down_read(&mixer->chip->shutdown_rwsem);
-		if (mixer->chip->shutdown)
-			err = -ENODEV;
-		else
-			err = snd_usb_ctl_msg(chip->dev,
-				usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
-				USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
-				validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
-				value, val_len);
-		up_read(&mixer->chip->shutdown_rwsem);
-		if (err < 0)
-			return err;
-
-		pval->cached_value = new_val;
-		pval->is_cached = 1;
-		changed = 1;
-	}
-
-	return changed;
-}
-
-static void kctl_private_value_free(struct snd_kcontrol *kctl)
-{
-	kfree((void *)kctl->private_value);
+	kctl->private_value &= ~(0xff << 24);
+	kctl->private_value |= new_val << 24;
+	err = snd_ftu_eff_switch_update(list);
+	return err < 0 ? err : 1;
 }
 
 static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer,
@@ -1057,33 +988,16 @@ static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer,
 		.get = snd_ftu_eff_switch_get,
 		.put = snd_ftu_eff_switch_put
 	};
-
+	struct usb_mixer_elem_list *list;
 	int err;
-	struct snd_kcontrol *kctl;
-	struct snd_ftu_eff_switch_priv_val *pval;
-
-	pval = kzalloc(sizeof(*pval), GFP_KERNEL);
-	if (!pval)
-		return -ENOMEM;
-
-	pval->cached_value = 0;
-	pval->is_cached = 0;
-	pval->mixer = mixer;
-	pval->bUnitID = bUnitID;
-	pval->validx = validx;
 
-	template.private_value = (unsigned long) pval;
-	kctl = snd_ctl_new1(&template, mixer->chip);
-	if (!kctl) {
-		kfree(pval);
-		return -ENOMEM;
-	}
-
-	kctl->private_free = kctl_private_value_free;
-	err = snd_ctl_add(mixer->chip->card, kctl);
+	err = add_single_ctl_with_resume(mixer, bUnitID,
+					 snd_ftu_eff_switch_update,
+					 &template, &list);
 	if (err < 0)
 		return err;
-
+	list->kctl->private_value = (validx << 8) | bUnitID;
+	snd_ftu_eff_switch_init(mixer, list->kctl);
 	return 0;
 }
 
-- 
2.1.3
