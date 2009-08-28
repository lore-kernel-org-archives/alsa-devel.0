From: LCID Fire <lcid-fire@gmx.net>
Subject: [Fwd: Scratch Live amplifier switch]
Date: Fri, 28 Aug 2009 09:52:45 +0200
Message-ID: <4A978CCD.3000408@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000803040709060802010100"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 31A8C24589
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 09:52:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000803040709060802010100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi.
Following the patch to add the amplifier switch (changing input levels
phono/line) for the Serato Scratch Live device.

Please apply or complain ;)


--------------000803040709060802010100
Content-Type: text/x-patch;
 name="0001-Add-scratch-live-preamp-switch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Add-scratch-live-preamp-switch.patch"

>From 29ffdae95f1dec05ec0e00d483d46c6a20bf17f2 Mon Sep 17 00:00:00 2001
From: Andreas Bergmeier <lcid-fire@gmx.net>
Date: Sun, 23 Aug 2009 13:36:51 +0200
Subject: [PATCH] Add scratch live preamp switch

Signed-off-by: Andreas Bergmeier <andreas.bergmeier@gmx.net>
---
 sound/usb/usbmixer.c |  235 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 235 insertions(+), 0 deletions(-)

diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 00397c8..f8946fc 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -2013,6 +2013,236 @@ static void snd_audigy2nx_proc_read(struct snd_info_entry *entry,
 	}
 }
 
+static void snd_usb_cleanup_interrupt_urb(struct urb* pUrb)
+{
+	if(pUrb->transfer_buffer_length > 0)
+		kfree(pUrb->transfer_buffer);
+	
+	kfree(pUrb->context);
+
+	usb_free_urb(pUrb);
+}
+
+/* Wrapper for setting and submitting the interrupt urb().*/
+static int snd_usb_interrupt_trans(struct usb_device *dev, unsigned int pipe, void *data,
+			 __u16 size, usb_complete_t callback)
+{
+	int err;
+	void *buf = NULL;
+	struct urb* pUrb = NULL;
+
+	if (size > 0) {
+		buf = kmemdup(data, size, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+	}
+
+	pUrb = usb_alloc_urb(1/*int iso packets*/, GFP_KERNEL);
+
+	if (!pUrb)
+		return -ENOMEM;
+
+	/*TODO: Remove hardcoded 4*/
+	usb_fill_int_urb(pUrb, dev, pipe, buf, size, callback, NULL, 4);
+
+	err = usb_submit_urb(pUrb, GFP_KERNEL);
+	
+	return err;
+}
+
+#define snd_sl_phono_info		snd_ctl_boolean_mono_info
+
+#define snd_sl_phono_receive snd_usb_cleanup_interrupt_urb
+
+#define snd_sl_phono_changed snd_sl_phono_receive
+
+static int snd_sl_phono_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = kcontrol->private_value;
+
+/* getting value of the device - commented out
+
+	snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_rcvbulkpipe(mixer->chip->dev, 0x83),
+				buffer, bufferSize, snd_sl_phono_receive);
+
+	unsigned char statusMessage[] = {7};
+
+	snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_sndintpipe(mixer->chip->dev, 0x03),
+				statusMessage, 1, snd_sl_phono_receive);
+*/
+
+	return 0;
+}
+
+/* Log of usb messages on startup
+STARTUP:
+
+IN  03 Length: 0x40 ...
+OUT 83 Length: 0x01 "00"
+IN  03 Length: 0x40 "00 00 03 00 FF FF 02 00 01 00 03 00 01 00 FB FF 01 00 FF FF 06 00 02 00 FF FF 03 00 05 00 00 00 06 00 FC FF FD FF 03 00 FD FF 04 00 FB FF F8 FF FC FF FD FF 06 00 01 00 01 00 FF FF 04 00 02 00"
+
+IN  03 Length: 0x40 ...
+OUT 83 Length: 0x02 "07 01"
+IN  03 Length: 0x40 "07 FF 03 00 FF FF 02 00 01 00 03 00 01 00 FB FF 01 00 FF FF 06 00 02 00 FF FF 03 00 05 00 00 00 06 00 FC FF FD FF 03 00 FD FF 04 00 FB FF F8 FF FC FF FD FF 06 00 01 00 01 00 FF FF 04 00 02 00"
+
+IN  03 Length: 0x40 ...
+OUT 83 Length: 0x01 "06"
+OUT 83 Length: 0x01 "00"
+IN  03 Length: 0x40 "00 FF FE FF FD FF 01 00 03 00 07 00 FE FF 08 00 03 00 00 00 FC FF 03 00 FF FF 00 00 01 00 03 00 FB FF F9 FF 01 00 FF FF FD FF 00 00 FE FF FA FF FF FF FD FF 01 00 04 00 00 00 03 00 FB FF 01 00"
+
+IN  03 Length: 0x40 ...
+OUT 83 Length: 0x01 "01"
+IN  03 Length: 0x40 "01 42 FC 54 03 FF 01 00 03 00 07 00 FE FF 08 00 03 00 00 00 FC FF 03 00 FF FF 00 00 01 00 03 00 FB FF F9 FF 01 00 FF FF FD FF 00 00 FE FF FA FF FF FF FD FF 01 00 04 00 00
+*/
+
+/* Following the messages that are sent prior and after setting the device
+ * no clue what they are good for - but they don't seem necessary
+static int snd_sl_phono_start(struct snd_kcontrol *kcontrol)
+{
+	unsigned char buffer[] = {0};
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	return snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_sndintpipe(mixer->chip->dev, 0x03),
+				buffer, 1, snd_sl_phono_receive);
+}
+
+static int snd_sl_phono_end(struct snd_kcontrol *kcontrol)
+{
+	unsigned char buffer[] = {6};
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	return snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_sndintpipe(mixer->chip->dev, 0x03),
+				buffer, 1, snd_sl_phono_receive);
+}
+*/
+
+static int snd_sl_phono_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	int err, changed;
+	const unsigned int bufferSize = 64;
+	unsigned char buffer[bufferSize];	
+	unsigned char instructions[] = {7, 0};
+	
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+	int value = ucontrol->value.integer.value[0];	
+
+/* USB traffic by serato driver
+line to phono:
+
+OUT 03 Length: 0x01 "00"
+
+IN  83 Length: 0x40 ...
+OUT 03 Length: 0x02 "07 00"
+IN  83 Length: 0x40 "07 00 01 00 04 00 02 00 02 00 05 00 04 00 02 00 05 00 06 00 02 00 01 00 03 00 0E 00 05 00 0E 00 09 00 FF FF 02 00 02 00 05 00 03 00 FA FF 04 00 05 00 07 00 08 00 01 00 02 00 01 00 02 00 01 00"
+
+IN  83 Length: 0x40 ...
+OUT 03 Length: 0x01 "06"
+IN  83 Length: 0x40 No answer!?
+
+phono to line:
+OUT 03 Length: 0x01 "00"
+
+IN  83 Length: 0x40 ...
+OUT 03 Length: 0x02 "07 01"
+IN  83 Length: 0x40 "07 FF F9 FF FB FF 01 00 FF FF FE FF F6 FF EF FF F8 FF FD FF FB FF FC FF FA FF 00 00 FA FF F7 FF F5 FF FB FF 01 00 F7 FF F7 FF FC FF F9 FF F9 FF F7 FF F7 FF 00 00 F4 FF FB FF F6 FF F9 FF FA FF"
+
+IN  83 Length: 0x40 ...
+OUT 03 Length: 0x01 "06"
+IN  83 Length: 0x40 No answer!?
+*/
+
+	if (value > 1)
+		return -EINVAL;
+
+	changed = (value != ucontrol->value.integer.value[0]);
+
+/* outcommented for now since it works without and don't have a clue what it's good for
+	err = snd_sl_phono_start(kcontrol);
+*/
+
+	err = snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_rcvbulkpipe(mixer->chip->dev, 0x83),
+				buffer, bufferSize, snd_sl_phono_receive);
+	
+	/* 07 00 = phone
+	   07 01 = line */
+	instructions[1] = !value;
+
+	err =  snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_sndintpipe(mixer->chip->dev, 0x03),
+				instructions, 2, snd_sl_phono_receive);
+
+	if(err < 0)
+		return err;
+	
+	err = snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_rcvbulkpipe(mixer->chip->dev, 0x83),
+				buffer, bufferSize, snd_sl_phono_changed);
+
+/* outcommented for now since it works without and don't have a clue what it's good for
+	err = snd_sl_phono_end(kcontrol);
+*/
+
+	if (err < 0)
+		return err;
+
+	kcontrol->private_value = value;
+	return changed;
+}
+
+static struct snd_kcontrol_new snd_sl_controls[] =
+{
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "External Amplifier",
+		.info = snd_sl_phono_info,
+		.get = snd_sl_phono_get,
+		.put = snd_sl_phono_put,
+		.private_value = 1, /*switch is activated*/
+	}
+};
+
+/* gets called multiple times! */
+static int snd_sl_controls_create(struct usb_mixer_interface *mixer)
+{
+	int i, err;
+
+	for (i = 0; i < ARRAY_SIZE(snd_sl_controls); ++i) {
+		struct snd_ctl_elem_value ucontrol;
+		struct snd_kcontrol *kcontrol = snd_ctl_new1(&snd_sl_controls[i], mixer);
+
+		/* Since we only need one control and the routine
+		 * is called multiple times we have to ignore all
+		 * attempts to attach controls multiple times*/
+		if(snd_ctl_find_id(mixer->chip->card, &kcontrol->id))
+		{
+			/* we found the control - it is already present
+			 * so just continue*/
+			snd_ctl_free_one(kcontrol);
+			continue;
+		}
+
+		/* add frees the control if on err < 0! */
+		err = snd_ctl_add(mixer->chip->card,
+				  kcontrol);
+		if (err < 0)
+			return err;
+		
+		/* Phono input is on by default */
+		ucontrol.value.integer.value[0] = 1;
+
+		err = snd_sl_phono_put(kcontrol, &ucontrol);
+
+		if(err < 0)
+			return err; /* the device screwed up */
+	}
+
+	return 0;
+}
+
+
 int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 			 int ignore_error)
 {
@@ -2043,6 +2273,11 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	if ((err = snd_usb_soundblaster_remote_init(mixer)) < 0)
 		goto _error;
 
+	if (mixer->chip->usb_id == USB_ID(0x13e5, 0x001)) {
+		if ((err = snd_sl_controls_create(mixer)) < 0)
+			goto _error;
+	}
+
 	if (mixer->chip->usb_id == USB_ID(0x041e, 0x3020) ||
 	    mixer->chip->usb_id == USB_ID(0x041e, 0x3040)) {
 		struct snd_info_entry *entry;
-- 
1.6.3.3



--------------000803040709060802010100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000803040709060802010100--
