From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] Edirol UA-20 PCM support
Date: Mon, 24 Feb 2003 11:24:19 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302241114310.11386-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Frank Barknecht <fbar@footils.org>
List-Id: alsa-devel@alsa-project.org


This adds support for the UA-20's PCM interfaces in "Advanced Driver"
mode. The device has all standard descriptors, so the normal descriptor
parsing code can be used, but the interface class is set to "vendor
specific".

The entry in usbquirks.h is there so that the driver is loaded for the
device, but .driver_info isn't set so that the standard code is used.

usbaudio.c has been modified to accept both CLASS_AUDIO and
CLASS_VENDOR_SPEC as valid interface classes.



Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.44
diff -u -r1.44 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	17 Feb 2003 10:37:40 -0000	1.44
+++ alsa-kernel/usb/usbaudio.c	24 Feb 2003 10:11:40 -0000
@@ -1971,7 +1971,8 @@
 		alts = &iface->altsetting[i];
 		altsd = get_iface_desc(alts);
 		/* skip invalid one */
-		if (altsd->bInterfaceClass != USB_CLASS_AUDIO ||
+		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
+		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
 		    altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING ||
 		    altsd->bNumEndpoints < 1)
 			continue;
@@ -2158,7 +2159,8 @@
 		}
 		alts = &iface->altsetting[0];
 		altsd = get_iface_desc(alts);
-		if (altsd->bInterfaceClass == USB_CLASS_AUDIO &&
+		if ((altsd->bInterfaceClass == USB_CLASS_AUDIO ||
+		     altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
 		    altsd->bInterfaceSubClass == USB_SUBCLASS_MIDI_STREAMING) {
 			if (snd_usb_create_midi_interface(chip, iface, NULL) < 0) {
 				snd_printk(KERN_ERR "%d:%u:%d: cannot create sequencer device\n", dev->devnum, ctrlif, j);
@@ -2167,7 +2169,8 @@
 			usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
 			continue;
 		}
-		if (altsd->bInterfaceClass != USB_CLASS_AUDIO ||
+		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
+		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
 		    altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING) {
 			snd_printdd(KERN_ERR "%d:%u:%d: skipping non-supported interface %d\n", dev->devnum, ctrlif, j, altsd->bInterfaceClass);
 			/* skip non-supported classes */
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.16
diff -u -r1.16 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	13 Feb 2003 17:18:10 -0000	1.16
+++ alsa-kernel/usb/usbquirks.h	24 Feb 2003 10:11:40 -0000
@@ -226,16 +226,10 @@
 },

 /*
- * Once upon a time people thought, "Wouldn't it be nice if there was a
- * standard for USB MIDI devices, so that device drivers would not be forced
- * to know about the quirks of specific devices?"  So Roland went ahead and
- * wrote the USB Device Class Definition for MIDI Devices, and the USB-IF
- * endorsed it, and now everybody designing USB MIDI devices does so in
- * agreement with this standard (or at least tries to).
+ * Roland/RolandED/Edirol devices
  *
- * And if you prefer a happy end, you can imagine that Roland devices set a
- * good example. Instead of being completely fucked up due to the lack of
- * class-specific descriptors.
+ * The USB MIDI Specification has been written by Roland,
+ * but a 100% conforming Roland device has yet to be found.
  */
 {
 	USB_DEVICE(0x0582, 0x0000),
@@ -507,17 +501,11 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0025),
-	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
-		.vendor_name = "EDIROL",
-		.product_name = "UA-20",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0001
-		}
-	}
+	/*
+	 * Edirol UA-20 in "Advanced Driver" mode.
+	 * Standard descriptors, but vendor-specific interfaces.
+	 */
+	USB_DEVICE(0x0582, 0x0025)
 },
 {
 	USB_DEVICE(0x0582, 0x0027),




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
