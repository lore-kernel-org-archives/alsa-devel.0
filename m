From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 07/10] ALSA: usb-audio: Add resume support
	for Native Instruments controls
Date: Thu, 20 Nov 2014 18:33:32 +0100
Message-ID: <1416504815-28685-8-git-send-email-tiwai@suse.de>
References: <1416504815-28685-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE2EC2659D7
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 18:33:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E3FAAAD88
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

The changes at this time are a bit more wider than previous ones.
Firstly, the NI controls didn't cache the values, so I had to
implement the caching.  It's stored in bit 24 of private_value.
In addition to that, the initial values have to be read from
registers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 99 +++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 5491c68efbc0..29324f4b3a7b 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -742,64 +742,68 @@ static int snd_mbox1_create_sync_switch(struct usb_mixer_interface *mixer)
 
 #define _MAKE_NI_CONTROL(bRequest,wIndex) ((bRequest) << 16 | (wIndex))
 
-static int snd_nativeinstruments_control_get(struct snd_kcontrol *kcontrol,
-					     struct snd_ctl_elem_value *ucontrol)
+static int snd_ni_control_init_val(struct usb_mixer_interface *mixer,
+				   struct snd_kcontrol *kctl)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
 	struct usb_device *dev = mixer->chip->dev;
-	u8 bRequest = (kcontrol->private_value >> 16) & 0xff;
-	u16 wIndex = kcontrol->private_value & 0xffff;
-	u8 tmp;
-	int ret;
-
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		ret = -ENODEV;
-	else
-		ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), bRequest,
-				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-				  0, wIndex,
-				  &tmp, sizeof(tmp), 1000);
-	up_read(&mixer->chip->shutdown_rwsem);
+	unsigned int pval = kctl->private_value;
+	u8 value;
+	int err;
 
-	if (ret < 0) {
+	err = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      (pval >> 16) & 0xff,
+			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+			      0, pval & 0xffff, &value, 1, 1000);
+	if (err < 0) {
 		dev_err(&dev->dev,
-			"unable to issue vendor read request (ret = %d)", ret);
-		return ret;
+			"unable to issue vendor read request (ret = %d)", err);
+		return err;
 	}
 
-	ucontrol->value.integer.value[0] = tmp;
-
+	kctl->private_value |= (value << 24);
 	return 0;
 }
 
-static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
+static int snd_nativeinstruments_control_get(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_value *ucontrol)
 {
-	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
-	struct usb_device *dev = mixer->chip->dev;
-	u8 bRequest = (kcontrol->private_value >> 16) & 0xff;
-	u16 wIndex = kcontrol->private_value & 0xffff;
-	u16 wValue = ucontrol->value.integer.value[0];
-	int ret;
+	ucontrol->value.integer.value[0] = kcontrol->private_value >> 24;
+	return 0;
+}
 
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		ret = -ENODEV;
+static int snd_ni_update_cur_val(struct usb_mixer_elem_list *list)
+{
+	struct snd_usb_audio *chip = list->mixer->chip;
+	unsigned int pval = list->kctl->private_value;
+	int err;
+
+	down_read(&chip->shutdown_rwsem);
+	if (chip->shutdown)
+		err = -ENODEV;
 	else
-		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), bRequest,
-				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-				  wValue, wIndex,
-				  NULL, 0, 1000);
-	up_read(&mixer->chip->shutdown_rwsem);
+		err = usb_control_msg(chip->dev, usb_sndctrlpipe(chip->dev, 0),
+				      (pval >> 16) & 0xff,
+				      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
+				      pval >> 24, pval & 0xffff, NULL, 0, 1000);
+	up_read(&chip->shutdown_rwsem);
+	return err;
+}
 
-	if (ret < 0) {
-		dev_err(&dev->dev,
-			"unable to issue vendor write request (ret = %d)", ret);
-		return ret;
-	}
+static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_value *ucontrol)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	u8 oldval = (kcontrol->private_value >> 24) & 0xff;
+	u8 newval = ucontrol->value.integer.value[0];
+	int err;
 
-	return 0;
+	if (oldval == newval)
+		return 0;
+
+	kcontrol->private_value &= ~(0xff << 24);
+	kcontrol->private_value |= newval;
+	err = snd_ni_update_cur_val(list);
+	return err < 0 ? err : 1;
 }
 
 static struct snd_kcontrol_new snd_nativeinstruments_ta6_mixers[] = {
@@ -870,16 +874,17 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 	};
 
 	for (i = 0; i < count; i++) {
-		struct snd_kcontrol *c;
+		struct usb_mixer_elem_list *list;
 
 		template.name = kc[i].name;
 		template.private_value = kc[i].private_value;
 
-		c = snd_ctl_new1(&template, mixer);
-		err = snd_ctl_add(mixer->chip->card, c);
-
+		err = add_single_ctl_with_resume(mixer, 0,
+						 snd_ni_update_cur_val,
+						 &template, &list);
 		if (err < 0)
 			break;
+		snd_ni_control_init_val(mixer, list->kctl);
 	}
 
 	return err;
-- 
2.1.3
