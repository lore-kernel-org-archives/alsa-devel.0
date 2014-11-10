From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 1/2 v5] ALSA: usb-audio: Add mixer control for
	Digidesign mbox 1 clock source
Date: Mon, 10 Nov 2014 21:17:54 +1100
Message-ID: <1415614675-6792-2-git-send-email-damien@zamaudio.com>
References: <1415614675-6792-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 13D11260650
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:18:12 +0100 (CET)
Received: by mail-pd0-f175.google.com with SMTP id y13so7588046pdi.34
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 02:18:11 -0800 (PST)
In-Reply-To: <1415614675-6792-1-git-send-email-damien@zamaudio.com>
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
Cc: tiwai@suse.de, Damien Zammit <damien@zamaudio.com>, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This patch provides the infrastructure for the Digidesign Mbox 1
to have a mixer control for selecting the clock source.
Valid options are Internal and S/PDIF external sync.
A non-documented command is sent to the device to enable this feature
found by reverse engineering and bus snooping.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/mixer_maps.c   |   9 +++
 sound/usb/mixer_quirks.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

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
index 3980bf5..21b539b 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -565,6 +565,142 @@ static int snd_xonar_u1_controls_create(struct usb_mixer_interface *mixer)
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
+			goto err;
+		} else {
+			/* Prepare for magic command to toggle clock source */
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), 0x81,
+				USB_DIR_IN |
+				USB_TYPE_CLASS |
+				USB_RECIP_INTERFACE, 0x00, 0x500, buff, 1);
+			if (err < 0)
+				goto err;
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), 0x81,
+				USB_DIR_IN |
+				USB_TYPE_CLASS |
+				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
+			if (err < 0)
+				goto err;
+			/* 2 possibilities:	Internal    -> send sample rate
+			 *			S/PDIF sync -> send zeroes
+			 * NB: Sample rate locked to 48kHz on purpose to
+			 *     prevent user from resetting the sample rate
+			 *     while S/PDIF sync is enabled and confusing
+			 *     this configuration.
+			 */
+			if (new_val == 0) {
+				buff[0] = 0x80;
+				buff[1] = 0xbb;
+				buff[2] = 0x00;
+			} else {
+				buff[0] = buff[1] = buff[2] = 0x00;
+			}
+			/* Send the magic command to toggle the clock source */
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_sndctrlpipe(chip->dev, 0), 0x1,
+				USB_TYPE_CLASS |
+				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
+			if (err < 0)
+				goto err;
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), 0x81,
+				USB_DIR_IN |
+				USB_TYPE_CLASS |
+				USB_RECIP_ENDPOINT, 0x100, 0x81, buff, 3);
+			if (err < 0)
+				goto err;
+			err = snd_usb_ctl_msg(chip->dev,
+				usb_rcvctrlpipe(chip->dev, 0), 0x81,
+				USB_DIR_IN |
+				USB_TYPE_CLASS |
+				USB_RECIP_ENDPOINT, 0x100, 0x2, buff, 3);
+			if (err < 0)
+				goto err;
+		}
+		up_read(&chip->shutdown_rwsem);
+		kctl->private_value = new_val;
+		changed = true;
+	}
+
+	return changed;
+err:
+	up_read(&chip->shutdown_rwsem);
+	return err;
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
@@ -1632,6 +1768,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_microii_controls_create(mixer);
 		break;
 
+	case USB_ID(0x0dba, 0x1000): /* Digidesign Mbox 1 */
+		err = snd_mbox1_create_sync_switch(mixer);
+		break;
+
 	case USB_ID(0x17cc, 0x1011): /* Traktor Audio 6 */
 		err = snd_nativeinstruments_create_mixer(mixer,
 				snd_nativeinstruments_ta6_mixers,
-- 
1.9.1
