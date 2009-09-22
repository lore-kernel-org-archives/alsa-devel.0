From: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
Subject: [PATCH] snd-usb-us122l: added support for US-144
Date: Tue, 22 Sep 2009 03:49:11 +0200
Message-ID: <4AB82D17.8090100@physik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080207000702020205020603"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.physnet.uni-hamburg.de (MAIL.PHYSnet.uni-hamburg.de
	[134.100.106.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B893624696
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 03:49:20 +0200 (CEST)
Received: from i577aae3d.versanet.de ([87.122.174.61] helo=[192.168.0.2])
	by mail.physnet.uni-hamburg.de with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.40) id 1MpuVH-004vEI-GD
	for alsa-devel@alsa-project.org; Tue, 22 Sep 2009 03:49:19 +0200
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080207000702020205020603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

here is a patch that adds support for the Tascam US-144 to 
snd-usb-us122l when uhci-hcd is used (ehci-hcd has to be disabled). With 
ehci-hcd the US-144 behaves completely differently.

The difference between US-122L and US-144 on uhci-hcd is, that US-144 
uses endpoints on two interfaces, while on US-122L all endpoints are on 
one interface. US-122L should still work, but I don't have a US-122L to 
test that.

Audio in and out and Midi in were tested with US-144 and work.

This is my first contribution to the linux kernel, so please have a 
critical look on it. ;)

Taken against snd-usb-us122l 0.5 / alsa 1.0.20.

Regards,
Tobias Hansen

--------------080207000702020205020603
Content-Type: text/x-patch;
 name="snd-usb-us122l_us144-support_v0.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd-usb-us122l_us144-support_v0.1.patch"

diff -uNr a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
--- a/sound/usb/usx2y/us122l.c	2009-09-10 00:13:59.000000000 +0200
+++ b/sound/usb/usx2y/us122l.c	2009-09-22 03:01:24.162254000 +0200
@@ -66,6 +66,28 @@
 					     iface, &quirk);
 }
 
+static int us144_create_usbmidi(struct snd_card *card)
+{
+	static struct snd_usb_midi_endpoint_info quirk_data = {
+		.out_ep = 4,
+		.in_ep = 3,
+		.out_cables =	0x001,
+		.in_cables =	0x001
+	};
+	static struct snd_usb_audio_quirk quirk = {
+		.vendor_name =	"US144",
+		.product_name =	NAME_ALLCAPS,
+		.ifnum = 	0,
+		.type = QUIRK_MIDI_US122L,
+		.data = &quirk_data
+	};
+	struct usb_device *dev = US122L(card)->chip.dev;
+	struct usb_interface *iface = usb_ifnum_to_if(dev, 0);
+
+	return snd_usb_create_midi_interface(&US122L(card)->chip,
+					     iface, &quirk);
+}
+
 /*
  * Wrapper for usb_control_msg().
  * Allocates a temp buffer to prevent dmaing from/to the stack.
@@ -171,6 +193,11 @@
 
 	if (!us122l->first)
 		us122l->first = file;
+
+	if (us122l->chip.dev->descriptor.idProduct == USB_ID_US144) {
+		iface = usb_ifnum_to_if(us122l->chip.dev, 0);
+		usb_autopm_get_interface(iface);
+	}
 	iface = usb_ifnum_to_if(us122l->chip.dev, 1);
 	usb_autopm_get_interface(iface);
 	return 0;
@@ -179,8 +206,14 @@
 static int usb_stream_hwdep_release(struct snd_hwdep *hw, struct file *file)
 {
 	struct us122l	*us122l = hw->private_data;
-	struct usb_interface *iface = usb_ifnum_to_if(us122l->chip.dev, 1);
+	struct usb_interface *iface;
 	snd_printdd(KERN_DEBUG "%p %p\n", hw, file);
+
+	if (us122l->chip.dev->descriptor.idProduct == USB_ID_US144) {
+		iface = usb_ifnum_to_if(us122l->chip.dev, 0);
+		usb_autopm_put_interface(iface);
+	}
+	iface = usb_ifnum_to_if(us122l->chip.dev, 1);
 	usb_autopm_put_interface(iface);
 	if (us122l->first == file)
 		us122l->first = NULL;
@@ -443,6 +476,13 @@
 	int err;
 	struct us122l *us122l = US122L(card);
 
+	if (us122l->chip.dev->descriptor.idProduct == USB_ID_US144) {
+		err = usb_set_interface(us122l->chip.dev, 0, 1);
+		if (err) {
+			snd_printk(KERN_ERR "usb_set_interface error \n");
+			return false;
+		}
+	}
 	err = usb_set_interface(us122l->chip.dev, 1, 1);
 	if (err) {
 		snd_printk(KERN_ERR "usb_set_interface error \n");
@@ -455,7 +495,10 @@
 	if (!us122l_start(us122l, 44100, 256))
 		return false;
 
-	err = us122l_create_usbmidi(card);
+	if (us122l->chip.dev->descriptor.idProduct == USB_ID_US144)
+		err = us144_create_usbmidi(card);
+	else
+		err = us122l_create_usbmidi(card);
 	if (err < 0) {
 		snd_printk(KERN_ERR "us122l_create_usbmidi error %i \n", err);
 		us122l_stop(us122l);
@@ -530,7 +573,7 @@
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(card, &intf->dev);
+	snd_card_set_dev(card, &device->dev);
 	if (!us122l_create_card(card)) {
 		snd_card_free(card);
 		return -EINVAL;
@@ -642,6 +685,13 @@
 
 	mutex_lock(&us122l->mutex);
 	/* needed, doesn't restart without: */
+	if (us122l->chip.dev->descriptor.idProduct == USB_ID_US144) {
+		err = usb_set_interface(us122l->chip.dev, 0, 1);
+		if (err) {
+			snd_printk(KERN_ERR "usb_set_interface error \n");
+			goto unlock;
+		}
+	}
 	err = usb_set_interface(us122l->chip.dev, 1, 1);
 	if (err) {
 		snd_printk(KERN_ERR "usb_set_interface error \n");
@@ -675,11 +725,11 @@
 		.idVendor =	0x0644,
 		.idProduct =	USB_ID_US122L
 	},
-/*  	{ */		/* US-144 maybe works when @USB1.1. Untested. */
-/* 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE, */
-/* 		.idVendor =	0x0644, */
-/* 		.idProduct =	USB_ID_US144 */
-/* 	}, */
+	{		/* US-144 only works at USB1.1! Disable module ehci-hcd. */
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	0x0644,
+		.idProduct =	USB_ID_US144
+	},
 	{ /* terminator */ }
 };
 

--------------080207000702020205020603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080207000702020205020603--
