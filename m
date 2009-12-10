From: Tobias Hansen <Tobias.Hansen@physik.uni-hamburg.de>
Subject: Re: [PATCH] snd-usb-us122l: add product IDs of
	US-122MKII and US-144MKII
Date: Thu, 10 Dec 2009 12:58:17 +0100
Message-ID: <4B20E259.7070806@physik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010809070803010600020404"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.physnet.uni-hamburg.de (MAIL.PHYSnet.uni-hamburg.de
	[134.100.106.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E3CA724413
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 12:58:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, delaossa@mail.desy.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010809070803010600020404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alberto Martinez de la Ossa wrote:
> Thanks, but..
> Applied where? I have checked the new sources at 
> http://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/
> And they remain the same with respect to the changes that Tobias made.
> Could you please post the fixed patch, please? I also got errors when 
> trying to apply it.
> 
> Regards,
> Alberto

Sorry, it somehow broke when I copied it into the mail. I'll better attach it now. Several people already reported that, for both US-122MKII and US-144MKII, adding the Product IDs doesn't make them work. But you can give it a try nevertheless and report back whether you had more luck.

Regards, Tobias Hansen


--------------010809070803010600020404
Content-Type: text/x-patch;
 name="snd-usb-us122l-MKII-ids.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd-usb-us122l-MKII-ids.patch"

diff -upr alsa-driver.orig/alsa-kernel/usb/usx2y/us122l.c alsa-driver/alsa-kernel/usb/usx2y/us122l.c
--- alsa-driver.orig/alsa-kernel/usb/usx2y/us122l.c	2009-12-07 00:05:40.000000000 +0100
+++ alsa-driver/alsa-kernel/usb/usx2y/us122l.c	2009-12-07 18:50:27.801975964 +0100
@@ -194,7 +194,8 @@ static int usb_stream_hwdep_open(struct 
 	if (!us122l->first)
 		us122l->first = file;
 
-	if (us122l->dev->descriptor.idProduct == USB_ID_US144) {
+	if (us122l->dev->descriptor.idProduct == USB_ID_US144 ||
+		us122l->dev->descriptor.idProduct == USB_ID_US144MKII) {
 		iface = usb_ifnum_to_if(us122l->dev, 0);
 		usb_autopm_get_interface(iface);
 	}
@@ -209,7 +210,8 @@ static int usb_stream_hwdep_release(stru
 	struct usb_interface *iface;
 	snd_printdd(KERN_DEBUG "%p %p\n", hw, file);
 
-	if (us122l->dev->descriptor.idProduct == USB_ID_US144) {
+	if (us122l->dev->descriptor.idProduct == USB_ID_US144 ||
+		us122l->dev->descriptor.idProduct == USB_ID_US144MKII) {
 		iface = usb_ifnum_to_if(us122l->dev, 0);
 		usb_autopm_put_interface(iface);
 	}
@@ -476,7 +478,8 @@ static bool us122l_create_card(struct sn
 	int err;
 	struct us122l *us122l = US122L(card);
 
-	if (us122l->dev->descriptor.idProduct == USB_ID_US144) {
+	if (us122l->dev->descriptor.idProduct == USB_ID_US144 ||
+		us122l->dev->descriptor.idProduct == USB_ID_US144MKII) {
 		err = usb_set_interface(us122l->dev, 0, 1);
 		if (err) {
 			snd_printk(KERN_ERR "usb_set_interface error \n");
@@ -495,7 +498,8 @@ static bool us122l_create_card(struct sn
 	if (!us122l_start(us122l, 44100, 256))
 		return false;
 
-	if (us122l->dev->descriptor.idProduct == USB_ID_US144)
+	if (us122l->dev->descriptor.idProduct == USB_ID_US144 ||
+		us122l->dev->descriptor.idProduct == USB_ID_US144MKII)
 		err = us144_create_usbmidi(card);
 	else
 		err = us122l_create_usbmidi(card);
@@ -597,7 +601,8 @@ static int snd_us122l_probe(struct usb_i
 	struct snd_card *card;
 	int err;
 
-	if (device->descriptor.idProduct == USB_ID_US144
+	if ((device->descriptor.idProduct == USB_ID_US144 ||
+		us122l->dev->descriptor.idProduct == USB_ID_US144MKII)
 		&& device->speed == USB_SPEED_HIGH) {
 		snd_printk(KERN_ERR "disable ehci-hcd to run US-144 \n");
 		return -ENODEV;
@@ -692,7 +697,8 @@ static int snd_us122l_resume(struct usb_
 
 	mutex_lock(&us122l->mutex);
 	/* needed, doesn't restart without: */
-	if (us122l->dev->descriptor.idProduct == USB_ID_US144) {
+	if (us122l->dev->descriptor.idProduct == USB_ID_US144 ||
+		us122l->dev->descriptor.idProduct == USB_ID_US144MKII) {
 		err = usb_set_interface(us122l->dev, 0, 1);
 		if (err) {
 			snd_printk(KERN_ERR "usb_set_interface error \n");
@@ -737,6 +743,16 @@ static struct usb_device_id snd_us122l_u
 		.idVendor =	0x0644,
 		.idProduct =	USB_ID_US144
 	},
+	{
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	0x0644,
+		.idProduct =	USB_ID_US122MKII
+	},
+	{
+		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =	0x0644,
+		.idProduct =	USB_ID_US144MKII
+	},
 	{ /* terminator */ }
 };
 
diff -upr alsa-driver.orig/alsa-kernel/usb/usx2y/us122l.h alsa-driver/alsa-kernel/usb/usx2y/us122l.h
--- alsa-driver.orig/alsa-kernel/usb/usx2y/us122l.h	2009-12-07 00:05:40.000000000 +0100
+++ alsa-driver/alsa-kernel/usb/usx2y/us122l.h	2009-12-07 18:44:03.990236199 +0100
@@ -25,5 +25,7 @@ struct us122l {
 
 #define USB_ID_US122L 0x800E
 #define USB_ID_US144 0x800F
+#define USB_ID_US122MKII 0x8021
+#define USB_ID_US144MKII 0x8020
 
 #endif

--------------010809070803010600020404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010809070803010600020404--
