From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH] usb-audio: Add mixer control for Digidesign
 Mbox 1 clock source
Date: Fri, 31 Oct 2014 12:57:20 +1100
Message-ID: <5452EC80.8060005@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000904000108010008060307"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id B872C26065F
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 02:57:26 +0100 (CET)
Received: by mail-pd0-f175.google.com with SMTP id y13so6301748pdi.34
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 18:57:25 -0700 (PDT)
Received: from [192.168.140.2] (14-201-185-176.static.tpgi.com.au.
 [14.201.185.176])
 by mx.google.com with ESMTPSA id pc8sm8325755pdb.54.2014.10.30.18.57.22
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 30 Oct 2014 18:57:24 -0700 (PDT)
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

This is a multi-part message in MIME format.
--------------000904000108010008060307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch provides a mixer control for selecting the clock source of
the Digidesign Mbox 1 to either internal clock or S/PDIF external.
Trial and error and bus snooping were the only way to get this
information, but it works on the hardware.


--------------000904000108010008060307
Content-Type: text/x-patch;
 name="0001-mbox1-spdif.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-mbox1-spdif.patch"

>From d19804aa8b1d3355b647a3209dce4cb5c181ee2b Mon Sep 17 00:00:00 2001
From: Damien Zammit <damien@zamaudio.com>
Date: Fri, 31 Oct 2014 12:44:25 +1100
Subject: [PATCH] snd-usb-audio: Add mixer control for Digidesign Mbox 1 clock
 source

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/mixer.h        |   1 +
 sound/usb/mixer_maps.c   |   9 +++
 sound/usb/mixer_quirks.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)

diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 73b1f64..5ab6935 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -23,6 +23,7 @@ struct usb_mixer_interface {
 
 	u8 audigy2nx_leds[3];
 	u8 xonar_u1_status;
+	u8 mbox1_status;
 };
 
 #define MAX_CHANNELS	16	/* max logical channels */
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index d1d72ff..9ee3fc2 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -179,6 +179,11 @@ static struct usbmix_name_map audigy2nx_map[] = {
 	{ 0 } /* terminator */
 };
 
+static struct usbmix_name_map mbox1_map[] = {
+	{ 1, "Control" },
+	{ 0 } /* terminator */
+};
+
 static struct usbmix_selector_map c400_selectors[] = {
 	{
 		.id = 0x80,
@@ -416,6 +421,10 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = aureon_51_2_map,
 	},
 	{
+		.id = USB_ID(0x0dba, 0x1000),
+		.map = mbox1_map,
+	},
+	{
 		.id = USB_ID(0x13e5, 0x0001),
 		.map = scratch_live_map,
 		.ignore_ctl_error = 1,
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 3980bf5..b69e8f4 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -565,6 +565,185 @@ static int snd_xonar_u1_controls_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/* Digidesign Mbox 1 clock source switch (internal/spdif) */
+
+struct snd_mbox1_switch_priv_val {
+	struct usb_mixer_interface *mixer;
+	int cached_value;
+	int is_cached;
+};
+
+static int snd_mbox1_switch_get(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_mbox1_switch_priv_val *pval;
+	unsigned char value;
+
+	value = 0x00;
+
+	pval = (struct snd_mbox1_switch_priv_val *)
+		kctl->private_value;
+
+	if (pval->is_cached) {
+		ucontrol->value.enumerated.item[0] = pval->cached_value;
+		return 0;
+	}
+
+	ucontrol->value.enumerated.item[0] = value;
+	pval->cached_value = value;
+	pval->is_cached = 1;
+
+	return 0;
+}
+
+static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_audio *chip;
+	struct snd_mbox1_switch_priv_val *pval;
+
+	struct usb_mixer_interface *mixer;
+	int changed, cur_val, err, new_val;
+	unsigned char value[2];
+	unsigned char buff[3];
+
+	changed = 0;
+	value[0] = 0x00;
+	value[1] = 0x00;
+
+	pval = (struct snd_mbox1_switch_priv_val *)
+		kctl->private_value;
+	cur_val = pval->cached_value;
+	new_val = ucontrol->value.enumerated.item[0];
+
+	mixer = (struct usb_mixer_interface *) pval->mixer;
+	if (snd_BUG_ON(!mixer))
+		return -EINVAL;
+
+	chip = (struct snd_usb_audio *) mixer->chip;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+
+	if (!pval->is_cached) {
+		cur_val = value[0];
+		pval->cached_value = cur_val;
+		pval->is_cached = 1;
+	}
+	/* update value if needed */
+	if (cur_val != new_val) {
+		value[0] = new_val;
+		value[1] = 0;
+		down_read(&mixer->chip->shutdown_rwsem);
+		if (mixer->chip->shutdown) {
+			err = -ENODEV;
+		} else {
+			err = snd_usb_ctl_msg(mixer->chip->dev,
+				      usb_rcvctrlpipe(mixer->chip->dev, 0), 0x81,
+				      USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+				      0x00, 0x500, buff, 1);
+			if (err < 0)
+				return err;
+			err = snd_usb_ctl_msg(mixer->chip->dev,
+				      usb_rcvctrlpipe(mixer->chip->dev, 0), 0x81,
+				      USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_ENDPOINT,
+				      0x100, 0x81, buff, 3);
+			if (err < 0)
+				return err;
+			if (new_val == 0) {
+				buff[0] = 0x80;
+				buff[1] = 0xbb;
+				buff[2] = 0x00;
+			} else {
+				buff[0] = buff[1] = buff[2] = 0;
+			}
+			err = snd_usb_ctl_msg(mixer->chip->dev,
+				      usb_sndctrlpipe(mixer->chip->dev, 0), 0x1,
+				      USB_TYPE_CLASS | USB_RECIP_ENDPOINT,
+				      0x100, 0x81, buff, 3);
+			if (err < 0)
+				return err;
+			err = snd_usb_ctl_msg(mixer->chip->dev,
+				      usb_rcvctrlpipe(mixer->chip->dev, 0), 0x81,
+				      USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_ENDPOINT,
+				      0x100, 0x81, buff, 3);
+			if (err < 0)
+				return err;
+			err = snd_usb_ctl_msg(mixer->chip->dev,
+				      usb_rcvctrlpipe(mixer->chip->dev, 0), 0x81,
+				      USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_ENDPOINT,
+				      0x100, 0x2, buff, 3);
+			if (err < 0)
+				return err;
+		}
+		up_read(&mixer->chip->shutdown_rwsem);
+		if (err < 0)
+			return err;
+
+		pval->cached_value = new_val;
+		pval->is_cached = 1;
+		changed = 1;
+	}
+
+	return changed;
+}
+
+static int snd_mbox1_switch_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	static const char *texts[2] = {"Internal",
+				       "S/PDIF"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item > 1)
+		uinfo->value.enumerated.item = 1;
+	strcpy(uinfo->value.enumerated.name,
+		texts[uinfo->value.enumerated.item]);
+
+	return 0;
+}
+
+static int snd_mbox1_create_sync_switch(struct usb_mixer_interface *mixer)
+	/*int validx, int bUnitID)*/
+{
+	static struct snd_kcontrol_new template = {
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Clock Source",
+		.index = 0,
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_mbox1_switch_info,
+		.get = snd_mbox1_switch_get,
+		.put = snd_mbox1_switch_put
+	};
+
+	int err;
+	struct snd_kcontrol *kctl;
+	struct snd_mbox1_switch_priv_val *pval;
+
+	pval = kzalloc(sizeof(*pval), GFP_KERNEL);
+	if (!pval)
+		return -ENOMEM;
+
+	pval->cached_value = 0;
+	pval->is_cached = 0;
+	pval->mixer = mixer;
+
+	template.private_value = (unsigned long) pval;
+	kctl = snd_ctl_new1(&template, mixer->chip);
+	if (!kctl) {
+		kfree(pval);
+		return -ENOMEM;
+	}
+
+	err = snd_ctl_add(mixer->chip->card, kctl);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 /* Native Instruments device quirks */
 
 #define _MAKE_NI_CONTROL(bRequest,wIndex) ((bRequest) << 16 | (wIndex))
@@ -1605,6 +1784,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 					      snd_audigy2nx_proc_read);
 		break;
 
+	/* Digidesign Mbox 1 */
+	case USB_ID(0x0dba, 0x1000):
+		err = snd_mbox1_create_sync_switch(mixer);
+		if (err < 0)
+			break;
+		break;
+
 	/* EMU0204 */
 	case USB_ID(0x041e, 0x3f19):
 		err = snd_emu0204_controls_create(mixer);
-- 
1.9.1


--------------000904000108010008060307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000904000108010008060307--
