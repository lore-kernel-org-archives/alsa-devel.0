From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 09/10] ALSA: usb-audio: Add resume support
	for MicroII SPDIF ctls
Date: Thu, 20 Nov 2014 18:33:34 +0100
Message-ID: <1416504815-28685-10-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D870826063C
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E448FAD91
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

Like the previous fixes, the mixer accessors are converted to use
usb_mixer_elem_list objects.  In addition, the proper shutdown check
are put in get and put callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 135 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 42 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 29afad6aac04..1fae956d6692 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1509,7 +1509,8 @@ static int snd_microii_spdif_info(struct snd_kcontrol *kcontrol,
 static int snd_microii_spdif_default_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
 	int err;
 	struct usb_interface *iface;
 	struct usb_host_interface *alts;
@@ -1517,17 +1518,23 @@ static int snd_microii_spdif_default_get(struct snd_kcontrol *kcontrol,
 	unsigned char data[3];
 	int rate;
 
+	down_read(&chip->shutdown_rwsem);
+	if (chip->shutdown) {
+		err = -ENODEV;
+		goto end;
+	}
+
 	ucontrol->value.iec958.status[0] = kcontrol->private_value & 0xff;
 	ucontrol->value.iec958.status[1] = (kcontrol->private_value >> 8) & 0xff;
 	ucontrol->value.iec958.status[2] = 0x00;
 
 	/* use known values for that card: interface#1 altsetting#1 */
-	iface = usb_ifnum_to_if(mixer->chip->dev, 1);
+	iface = usb_ifnum_to_if(chip->dev, 1);
 	alts = &iface->altsetting[1];
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
 
-	err = snd_usb_ctl_msg(mixer->chip->dev,
-			usb_rcvctrlpipe(mixer->chip->dev, 0),
+	err = snd_usb_ctl_msg(chip->dev,
+			usb_rcvctrlpipe(chip->dev, 0),
 			UAC_GET_CUR,
 			USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
 			UAC_EP_CS_ATTR_SAMPLE_RATE << 8,
@@ -1542,22 +1549,27 @@ static int snd_microii_spdif_default_get(struct snd_kcontrol *kcontrol,
 			IEC958_AES3_CON_FS_48000 : IEC958_AES3_CON_FS_44100;
 
 	err = 0;
-end:
+ end:
+	up_read(&chip->shutdown_rwsem);
 	return err;
 }
 
-static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+static int snd_microii_spdif_default_update(struct usb_mixer_elem_list *list)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
-	int err;
+	struct snd_usb_audio *chip = list->mixer->chip;
+	unsigned int pval = list->kctl->private_value;
 	u8 reg;
-	unsigned long priv_backup = kcontrol->private_value;
+	int err;
+
+	down_read(&chip->shutdown_rwsem);
+	if (chip->shutdown) {
+		err = -ENODEV;
+		goto end;
+	}
 
-	reg = ((ucontrol->value.iec958.status[1] & 0x0f) << 4) |
-			(ucontrol->value.iec958.status[0] & 0x0f);
-	err = snd_usb_ctl_msg(mixer->chip->dev,
-			usb_sndctrlpipe(mixer->chip->dev, 0),
+	reg = ((pval >> 4) & 0xf0) | (pval & 0x0f);
+	err = snd_usb_ctl_msg(chip->dev,
+			usb_sndctrlpipe(chip->dev, 0),
 			UAC_SET_CUR,
 			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			reg,
@@ -1567,15 +1579,10 @@ static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
 	if (err < 0)
 		goto end;
 
-	kcontrol->private_value &= 0xfffff0f0;
-	kcontrol->private_value |= (ucontrol->value.iec958.status[1] & 0x0f) << 8;
-	kcontrol->private_value |= (ucontrol->value.iec958.status[0] & 0x0f);
-
-	reg = (ucontrol->value.iec958.status[0] & IEC958_AES0_NONAUDIO) ?
-			0xa0 : 0x20;
-	reg |= (ucontrol->value.iec958.status[1] >> 4) & 0x0f;
-	err = snd_usb_ctl_msg(mixer->chip->dev,
-			usb_sndctrlpipe(mixer->chip->dev, 0),
+	reg = (pval & IEC958_AES0_NONAUDIO) ? 0xa0 : 0x20;
+	reg |= (pval >> 12) & 0x0f;
+	err = snd_usb_ctl_msg(chip->dev,
+			usb_sndctrlpipe(chip->dev, 0),
 			UAC_SET_CUR,
 			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			reg,
@@ -1585,16 +1592,36 @@ static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
 	if (err < 0)
 		goto end;
 
-	kcontrol->private_value &= 0xffff0fff;
-	kcontrol->private_value |= (ucontrol->value.iec958.status[1] & 0xf0) << 8;
+ end:
+	up_read(&chip->shutdown_rwsem);
+	return err;
+}
+
+static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	unsigned int pval, pval_old;
+	int err;
+
+	pval = pval_old = kcontrol->private_value;
+	pval &= 0xfffff0f0;
+	pval |= (ucontrol->value.iec958.status[1] & 0x0f) << 8;
+	pval |= (ucontrol->value.iec958.status[0] & 0x0f);
+
+	pval &= 0xffff0fff;
+	pval |= (ucontrol->value.iec958.status[1] & 0xf0) << 8;
 
 	/* The frequency bits in AES3 cannot be set via register access. */
 
 	/* Silently ignore any bits from the request that cannot be set. */
 
-	err = (priv_backup != kcontrol->private_value);
-end:
-	return err;
+	if (pval == pval_old)
+		return 0;
+
+	kcontrol->private_value = pval;
+	err = snd_microii_spdif_default_update(list);
+	return err < 0 ? err : 1;
 }
 
 static int snd_microii_spdif_mask_get(struct snd_kcontrol *kcontrol,
@@ -1616,15 +1643,20 @@ static int snd_microii_spdif_switch_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int snd_microii_spdif_switch_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+static int snd_microii_spdif_switch_update(struct usb_mixer_elem_list *list)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	u8 reg = list->kctl->private_value;
 	int err;
-	u8 reg = ucontrol->value.integer.value[0] ? 0x28 : 0x2a;
 
-	err = snd_usb_ctl_msg(mixer->chip->dev,
-			usb_sndctrlpipe(mixer->chip->dev, 0),
+	down_read(&chip->shutdown_rwsem);
+	if (chip->shutdown) {
+		err = -ENODEV;
+		goto end;
+	}
+
+	err = snd_usb_ctl_msg(chip->dev,
+			usb_sndctrlpipe(chip->dev, 0),
 			UAC_SET_CUR,
 			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			reg,
@@ -1632,15 +1664,27 @@ static int snd_microii_spdif_switch_put(struct snd_kcontrol *kcontrol,
 			NULL,
 			0);
 
-	if (!err) {
-		err = (reg != (kcontrol->private_value & 0x0ff));
-		if (err)
-			kcontrol->private_value = reg;
-	}
-
+ end:
+	up_read(&chip->shutdown_rwsem);
 	return err;
 }
 
+static int snd_microii_spdif_switch_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	u8 reg;
+	int err;
+
+	reg = ucontrol->value.integer.value[0] ? 0x28 : 0x2a;
+	if (reg != list->kctl->private_value)
+		return 0;
+
+	kcontrol->private_value = reg;
+	err = snd_microii_spdif_switch_update(list);
+	return err < 0 ? err : 1;
+}
+
 static struct snd_kcontrol_new snd_microii_mixer_spdif[] = {
 	{
 		.iface =    SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1670,10 +1714,17 @@ static struct snd_kcontrol_new snd_microii_mixer_spdif[] = {
 static int snd_microii_controls_create(struct usb_mixer_interface *mixer)
 {
 	int err, i;
+	static usb_mixer_elem_resume_func resume_funcs[] = {
+		snd_microii_spdif_default_update,
+		NULL,
+		snd_microii_spdif_switch_update
+	};
 
 	for (i = 0; i < ARRAY_SIZE(snd_microii_mixer_spdif); ++i) {
-		err = snd_ctl_add(mixer->chip->card,
-			snd_ctl_new1(&snd_microii_mixer_spdif[i], mixer));
+		err = add_single_ctl_with_resume(mixer, 0,
+						 resume_funcs[i],
+						 &snd_microii_mixer_spdif[i],
+						 NULL);
 		if (err < 0)
 			return err;
 	}
-- 
2.1.3
