From: damien.zammit@gmail.com
Subject: [PATCH 1/2 v2] ALSA: usb-audio: Add mixer control for
	Digidesign mbox 1 clock source
Date: Sun,  9 Nov 2014 11:37:07 +1100
Message-ID: <1415493428-31653-2-git-send-email-damien.zammit@gmail.com>
References: <1415493428-31653-1-git-send-email-damien.zammit@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 7347D2604C5
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 01:37:55 +0100 (CET)
Received: by mail-pd0-f176.google.com with SMTP id ft15so5510021pdb.7
 for <alsa-devel@alsa-project.org>; Sat, 08 Nov 2014 16:37:54 -0800 (PST)
In-Reply-To: <1415493428-31653-1-git-send-email-damien.zammit@gmail.com>
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
Cc: Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

From: Damien Zammit <damien@zamaudio.com>

This patch provides the infrastructure for the Digidesign Mbox 1
to have a mixer control for selecting the clock source.
Valid options are Internal and S/PDIF external sync.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/mixer_maps.c   |   9 ++++
 sound/usb/mixer_quirks.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index d1d72ff..1994d41 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -179,6 +179,11 @@ static struct usbmix_name_map audigy2nx_map[] = {
 	{ 0 } /* terminator */
 };
 
+static struct usbmix_name_map mbox1_map[] = {
+	{ 1, "Clock" },
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
index 3980bf5..d6e5ee1 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -565,6 +565,132 @@ static int snd_xonar_u1_controls_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/* Digidesign Mbox 1 clock source switch (internal/spdif) */
+
+static int snd_mbox1_switch_get(struct snd_kcontrol *kctl,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	if (kctl->private_value) {
+		ucontrol->value.enumerated.item[0] = true;
+		return 0;
+	}
+
+	ucontrol->value.enumerated.item[0] = false;
+	return 0;
+}
+
+static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_usb_audio *chip;
+	struct usb_mixer_interface *mixer;
+	int err;
+	bool changed, cur_val, new_val;
+	bool value;
+	unsigned char buff[3];
+
+	changed = false;
+	value = false;
+
+	cur_val = kctl->private_value;
+	new_val = ucontrol->value.enumerated.item[0];
+
+	mixer = snd_kcontrol_chip(kctl);
+	if (snd_BUG_ON(!mixer))
+		return -EINVAL;
+
+	chip = mixer->chip;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+
+	/* update value if needed */
+	if (cur_val != new_val) {
+		value = new_val;
+		down_read(&chip->shutdown_rwsem);
+		if (chip->shutdown) {
+			err = -ENODEV;
+		} else {
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), 0x81,
+				USB_DIR_IN |
+				USB_TYPE_CLASS |
+				USB_RECIP_INTERFACE, 0x00, 0x500, buff, 1);
+			if (err < 0)
+				return err;
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), 0x81,
+				USB_DIR_IN |
+				USB_TYPE_CLASS |
+				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
+			if (err < 0)
+				return err;
+			if (new_val == 0) {
+				buff[0] = 0x80;
+				buff[1] = 0xbb;
+				buff[2] = 0x00;
+			} else {
+				buff[0] = buff[1] = buff[2] = 0x00;
+			}
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_sndctrlpipe(chip->dev, 0), 0x1,
+				USB_TYPE_CLASS |
+				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
+			if (err < 0)
+				return err;
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), 0x81,
+				USB_DIR_IN |
+				USB_TYPE_CLASS |
+				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
+			if (err < 0)
+				return err;
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), 0x81,
+				USB_DIR_IN |
+				USB_TYPE_CLASS |
+				USB_RECIP_ENDPOINT, 0x100, 0x2, buff, 3);
+			if (err < 0)
+				return err;
+		}
+		up_read(&chip->shutdown_rwsem);
+		if (err < 0)
+			return err;
+
+		kctl->private_value = new_val;
+		changed = true;
+	}
+
+	return changed;
+}
+
+static int snd_mbox1_switch_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const texts[2] = {
+		"Internal",
+		"S/PDIF"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(texts), texts);
+}
+
+static struct snd_kcontrol_new snd_mbox1_switch = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Clock Source",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = snd_mbox1_switch_info,
+	.get = snd_mbox1_switch_get,
+	.put = snd_mbox1_switch_put,
+	.private_value = 0
+};
+
+static int snd_mbox1_create_sync_switch(struct usb_mixer_interface *mixer)
+{
+	return snd_ctl_add(mixer->chip->card,
+			snd_ctl_new1(&snd_mbox1_switch, mixer));
+}
+
 /* Native Instruments device quirks */
 
 #define _MAKE_NI_CONTROL(bRequest,wIndex) ((bRequest) << 16 | (wIndex))
@@ -1605,6 +1731,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
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
