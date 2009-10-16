From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: [Fwd: Scratch Live amplifier switch]
Date: Fri, 16 Oct 2009 21:52:48 +0200
Message-ID: <4AD8CF10.9050707@gmx.net>
References: <4A978CCD.3000408@gmx.net> <s5hy6p4l5hc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030201090306030205010704"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 100DC1037EA
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 21:52:53 +0200 (CEST)
In-Reply-To: <s5hy6p4l5hc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030201090306030205010704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:
> I'd recommend not to use put callback.  snd_kcontrol_value is a big
> struct, so it should be avoided to be used on the stack as much as
> possible.  Better to take the accessor part from the put callback and
> call it from here.
> 
> 
> Could you fix and repost?
I reworked the patch and it should be better now (with regards to
multiple issues).
As always - apply or complain :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkrYzw0ACgkQWo5Cf7DM0R8/JQCdFVUojGczhdtqizcm809LSov+
ndMAoIkW0mL7Hq0bhj0N/FZxBunL2VO8
=2KbY
-----END PGP SIGNATURE-----

--------------030201090306030205010704
Content-Type: text/x-diff;
 name="slpreamp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slpreamp.patch"

Signed-off-by: Andreas Bergmeier <andreas.bergmeier@gmx.net>

diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 00397c8..532d02d 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -2013,6 +2013,281 @@ static void snd_audigy2nx_proc_read(struct snd_info_entry *entry,
 	}
 }
 
+static void snd_usb_cleanup_interrupt_urb(struct urb *pUrb)
+{
+	if (pUrb->transfer_buffer_length > 0)
+		kfree(pUrb->transfer_buffer);
+
+	kfree(pUrb->context);
+
+	usb_free_urb(pUrb);
+}
+
+/* Wrapper for setting and submitting the interrupt urb().*/
+static int snd_usb_interrupt_trans(struct usb_device *dev,
+	unsigned int pipe, void *data, __u16 size, usb_complete_t callback)
+{
+	int err = 0;
+	void *buf = NULL;
+	struct urb *pUrb = NULL;
+
+	buf = kmemdup(data, size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pUrb = usb_alloc_urb(1/*int iso packets*/, GFP_KERNEL);
+
+	if (!pUrb) {
+		/* cleanup */
+		kfree(buf);
+		return -ENOMEM;
+	}
+
+	/*TODO: Remove hardcoded 4*/
+	usb_fill_int_urb(pUrb, dev, pipe, buf, size, callback, NULL, 4);
+
+	err = usb_submit_urb(pUrb, GFP_KERNEL);
+
+	if (err < 0)
+		snd_usb_cleanup_interrupt_urb(pUrb);
+
+	return err;
+}
+
+#define snd_sl_phono_info snd_ctl_boolean_mono_info
+
+#define snd_sl_phono_receive snd_usb_cleanup_interrupt_urb
+
+#define snd_sl_phono_changed snd_sl_phono_receive
+
+static int snd_sl_phono_get(struct snd_kcontrol *kcontrol,
+	 struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = kcontrol->private_value;
+
+	/* the following code gets the value of the device
+	 * we just trust that the remembered state is correct
+	 * and don't use it :)
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
+/* One example USB message on startup
+ * Unknown command
+	IN  03 Length: 0x40 ...
+	OUT 83 Length: 0x01 "00"
+	IN  03 Length: 0x40 "00 00 03 00 FF FF 02 00 01 00 03 00 01 00 FB FF
+		01 00 FF FF 06 00 02 00 FF FF 03 00 05 00 00 00
+		06 00 FC FF FD FF 03 00 FD FF 04 00 FB FF F8 FF
+		FC FF FD FF 06 00 01 00 01 00 FF FF 04 00 02 00"
+
+ * Sets line mode
+	IN  03 Length: 0x40 ...
+	OUT 83 Length: 0x02 "07 01"
+	IN  03 Length: 0x40 "07 FF 03 00 FF FF 02 00 01 00 03 00 01 00 FB FF
+		01 00 FF FF 06 00 02 00 FF FF 03 00 05 00 00 00
+		06 00 FC FF FD FF 03 00 FD FF 04 00 FB FF F8 FF
+		FC FF FD FF 06 00 01 00 01 00 FF FF 04 00 02 00"
+
+ * Unknown "termination" message?
+	IN  03 Length: 0x40 ...
+	OUT 83 Length: 0x01 "06"
+	OUT 83 Length: 0x01 "00"
+	IN  03 Length: 0x40 "00 FF FE FF FD FF 01 00 03 00 07 00 FE FF 08 00
+		03 00 00 00 FC FF 03 00 FF FF 00 00 01 00 03 00
+		FB FF F9 FF 01 00 FF FF FD FF 00 00 FE FF FA FF
+		FF FF FD FF 01 00 04 00 00 00 03 00 FB FF 01 00"
+
+ * Unknown commmand
+	IN  03 Length: 0x40 ...
+	OUT 83 Length: 0x01 "01"
+	IN  03 Length: 0x40 "01 42 FC 54 03 FF 01 00 03 00 07 00 FE FF 08 00
+		03 00 00 00 FC FF 03 00 FF FF 00 00 01 00 03 00
+		FB FF F9 FF 01 00 FF FF FD FF 00 00 FE FF FA FF
+		FF FF FD FF 01 00 04 00 00
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
+static int snd_sl_phono_set(struct snd_kcontrol *kcontrol,
+	int value)
+{
+	int err;
+	const unsigned int bufferSize = 64;
+	unsigned char buffer[bufferSize];
+	unsigned char instructions[] = {7, 0};
+
+	struct usb_mixer_interface *mixer = snd_kcontrol_chip(kcontrol);
+
+/* One example of USB traffic by serato driver
+ * switching line to phono:
+
+	OUT 03 Length: 0x01 "00"
+
+	IN  83 Length: 0x40 ...
+	OUT 03 Length: 0x02 "07 00"
+	IN  83 Length: 0x40 "07 00 01 00 04 00 02 00 02 00 05 00 04 00 02 00
+		05 00 06 00 02 00 01 00 03 00 0E 00 05 00 0E 00
+		09 00 FF FF 02 00 02 00 05 00 03 00 FA FF 04 00
+		05 00 07 00 08 00 01 00 02 00 01 00 02 00 01 00"
+
+	IN  83 Length: 0x40 ...
+	OUT 03 Length: 0x01 "06"
+	IN  83 Length: 0x40 No answer!?
+
+ * switching phono to line:
+	OUT 03 Length: 0x01 "00"
+
+	IN  83 Length: 0x40 ...
+	OUT 03 Length: 0x02 "07 01"
+	IN  83 Length: 0x40 "07 FF F9 FF FB FF 01 00 FF FF FE FF F6 FF EF FF
+		F8 FF FD FF FB FF FC FF FA FF 00 00 FA FF F7 FF
+		F5 FF FB FF 01 00 F7 FF F7 FF FC FF F9 FF F9 FF
+		F7 FF F7 FF 00 00 F4 FF FB FF F6 FF F9 FF FA FF"
+
+	IN  83 Length: 0x40 ...
+	OUT 03 Length: 0x01 "06"
+	IN  83 Length: 0x40 No answer!?
+*/
+
+	if (value > 1)
+		return -EINVAL;
+
+	/* outcommented for now since it works without
+	 * and don't have a clue what it's good for
+	err = snd_sl_phono_start(kcontrol);
+	*/
+
+	err = snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_rcvbulkpipe(mixer->chip->dev, 0x83),
+				buffer, bufferSize, snd_sl_phono_receive);
+
+	if (err < 0)
+		return err;
+
+	/* 07 00 = phone
+	   07 01 = line */
+	instructions[1] = !value;
+
+	err =  snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_sndintpipe(mixer->chip->dev, 0x03),
+				instructions, 2, snd_sl_phono_receive);
+
+	if (err < 0)
+		return err;
+
+	err = snd_usb_interrupt_trans(mixer->chip->dev,
+				usb_rcvbulkpipe(mixer->chip->dev, 0x83),
+				buffer, bufferSize, snd_sl_phono_changed);
+
+	/* outcommented for now since it works without
+	 * and don't have a clue what it's good for
+	err = snd_sl_phono_end(kcontrol);
+	*/
+
+	if (err < 0)
+		return err;
+
+	kcontrol->private_value = value;
+	return 0;
+}
+
+static int snd_sl_phono_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	int err = 0;
+	int value = ucontrol->value.integer.value[0];
+
+	if (value == kcontrol->private_value)
+		return 0;
+
+	err = snd_sl_phono_set(kcontrol, value);
+
+	if (err < 0)
+		return err;
+
+	return 1;
+}
+
+static struct snd_kcontrol_new snd_sl_controls[] =
+{
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Phono Switch",
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
+		struct snd_kcontrol *kcontrol =
+			snd_ctl_new1(&snd_sl_controls[i], mixer);
+
+		/* Since we only need one control and the routine
+		 * is called multiple times we have to ignore all
+		 * attempts to attach controls multiple times*/
+		if (snd_ctl_find_id(mixer->chip->card, &kcontrol->id)) {
+			/* we found the control - it is already present
+			 * so just continue*/
+			snd_ctl_free_one(kcontrol);
+			continue;
+		}
+
+		/* add frees the control if on err < 0! */
+		err = snd_ctl_add(mixer->chip->card,
+			  kcontrol);
+		if (err < 0)
+			return err;
+
+		/* Make sure device is set to default */
+		err = snd_sl_phono_set(kcontrol, kcontrol->private_value);
+
+		if (err < 0) {
+			snd_ctl_free_one(kcontrol);
+			return err; /* the device screwed up */
+		}
+	}
+
+	return 0;
+}
+
 int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 			 int ignore_error)
 {
@@ -2043,6 +2318,12 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	if ((err = snd_usb_soundblaster_remote_init(mixer)) < 0)
 		goto _error;
 
+	if (mixer->chip->usb_id == USB_ID(0x13e5, 0x001)) {
+		err = snd_sl_controls_create(mixer);
+		if (err < 0)
+			goto _error;
+	}
+
 	if (mixer->chip->usb_id == USB_ID(0x041e, 0x3020) ||
 	    mixer->chip->usb_id == USB_ID(0x041e, 0x3040)) {
 		struct snd_info_entry *entry;

--------------030201090306030205010704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030201090306030205010704--
