From: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
Subject: Re: [PATCH] snd-usb-us122l: added support for US-144
Date: Tue, 22 Sep 2009 16:52:08 +0200
Message-ID: <4AB8E498.1070108@physik.uni-hamburg.de>
References: <4AB82D17.8090100@physik.uni-hamburg.de>	<s5hws3runoi.wl%tiwai@suse.de>	<4AB8D773.9090401@physik.uni-hamburg.de>
	<s5hws3r9iul.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.physnet.uni-hamburg.de (MAIL.PHYSnet.uni-hamburg.de
	[134.100.106.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 16C9F243C7
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 16:52:17 +0200 (CEST)
In-Reply-To: <s5hws3r9iul.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>
> Yes.  Udev requires that the card instance to be the child of usb
> interface.
>   
Ok, done.
>
> Read the document above again :)
> The right patch format consists of a summary line, the change log
> texts, your sign-off, then the patch body.
>   
Ok, here is the next try. ;) I didn't find very precise instructions on 
the patch format, so if it is still not good, please tell me what to change.



snd-usb-us122l: add support for US-144

Adds support for US-144 when attached on USB1.1.
Unlike the US-122L it uses both USB interfaces 0 and 1.

Signed-off-by: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
---

--- linux-2.6/sound/usb/usx2y/us122l.c.orig	2009-09-10 00:13:59.000000000 +0200
+++ linux-2.6/sound/usb/usx2y/us122l.c	2009-09-22 16:15:53.166294000 +0200
@@ -66,6 +66,28 @@ static int us122l_create_usbmidi(struct 
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
@@ -171,6 +193,11 @@ static int usb_stream_hwdep_open(struct 
 
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
@@ -179,8 +206,14 @@ static int usb_stream_hwdep_open(struct 
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
@@ -443,6 +476,13 @@ static bool us122l_create_card(struct sn
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
@@ -455,7 +495,10 @@ static bool us122l_create_card(struct sn
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
@@ -542,6 +585,7 @@ static int us122l_usb_probe(struct usb_i
 		return err;
 	}
 
+	usb_get_intf(usb_ifnum_to_if(device, 0));
 	usb_get_dev(device);
 	*cardp = card;
 	return 0;
@@ -550,8 +594,15 @@ static int us122l_usb_probe(struct usb_i
 static int snd_us122l_probe(struct usb_interface *intf,
 			    const struct usb_device_id *id)
 {
+	struct usb_device *device = interface_to_usbdev(intf);
 	struct snd_card *card;
 	int err;
+	
+	if (device->descriptor.idProduct == USB_ID_US144 
+		&& device->speed == USB_SPEED_HIGH) {
+		snd_printk(KERN_ERR "disable ehci-hcd to run US-144 \n");
+		return -ENOENT;
+	}
 
 	snd_printdd(KERN_DEBUG"%p:%i\n",
 		    intf, intf->cur_altsetting->desc.bInterfaceNumber);
@@ -591,7 +642,8 @@ static void snd_us122l_disconnect(struct
 		snd_usbmidi_disconnect(p);
 	}
 
-	usb_put_intf(intf);
+	usb_put_intf(usb_ifnum_to_if(us122l->chip.dev, 0));
+	usb_put_intf(usb_ifnum_to_if(us122l->chip.dev, 1));
 	usb_put_dev(us122l->chip.dev);
 
 	while (atomic_read(&us122l->mmap_count))
@@ -642,6 +694,13 @@ static int snd_us122l_resume(struct usb_
 
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
@@ -675,11 +734,11 @@ static struct usb_device_id snd_us122l_u
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
