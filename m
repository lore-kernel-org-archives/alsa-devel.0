From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] snd-usb-audio: quirk for Edirol UA-5 in Advanced
 Mode
Date: Tue, 17 Jun 2003 11:28:25 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306171107040.18972-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0306121358040.9849-101000@kani-keli.alnet.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0306121358040.9849-101000@kani-keli.alnet.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephane Alnet <alsa-dev@shimaore.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(Jaroslav/Takashi: please apply the patch below)

Stephane Alnet wrote:
> On Thu, 12 Jun 2003, Clemens Ladisch wrote:
> > There already is a quirk type for this, QUIRK_STANDARD_INTERFACE. See
> > the quirk entry for the UA-20, which behaves in the same way (the
> > UA-20's interface #3 is for the MIDI ports).
>
> That's what I hoped too (didn't want to have to change usbaudio.c if at
> all possible) but it didn't seem to work. (My understanding is that
> STANDARD_INTERFACE needs at least the bInterfaceSubClass info to be valid.
> This isn't the case on the UA-5.)

Yes, the UA-20 does has valid subclass info, so the driver uses it.

> Here's the interesting part of the quirk I proposed (mostly a rewrite of
> STANDARD_INTERFACE that goes blindly trusting what usbquirks.h says):
> ...
>     altsd->bInterfaceClass = USB_CLASS_AUDIO;
>     altsd->bInterfaceSubClass = USB_SUBCLASS_AUDIO_STREAMING;

The _STANDARD_INTERFACE quirk type did almost the same as your
_AUDIOSTREAM_INTERFACE, but was just a special case for the UA-20, so
I've split it into two types to to allow specifying the interface type
(audio or MIDI) without reading the subclass from the descriptors. So
now we have a more generic solution for both the UA-5 and the UA-20.


Regards,
Clemens
-- 


- split QUIRK_STANDARD_INTERFACE into QUIRK_AUDIO_STANDARD_INTERFACE
  and QUIRK_MIDI_STANDARD_INTERFACE
- add quirk for Edirol UA-20


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.56
diff -u -r1.56 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	4 Jun 2003 12:43:55 -0000	1.56
+++ alsa-kernel/usb/usbaudio.c	17 Jun 2003 06:56:16 -0000
@@ -2381,7 +2381,8 @@
  * create a stream for an interface with proper descriptors
  */
 static int create_standard_interface_quirk(snd_usb_audio_t *chip,
-					   struct usb_interface *iface)
+					   struct usb_interface *iface,
+					   const snd_usb_audio_quirk_t *quirk)
 {
 	struct usb_host_interface *alts;
 	struct usb_interface_descriptor *altsd;
@@ -2389,19 +2390,18 @@

 	alts = &iface->altsetting[0];
 	altsd = get_iface_desc(alts);
-	switch (altsd->bInterfaceSubClass) {
-	case USB_SUBCLASS_AUDIO_STREAMING:
+	switch (quirk->type) {
+	case QUIRK_AUDIO_STANDARD_INTERFACE:
 		err = parse_audio_endpoints(chip, altsd->bInterfaceNumber);
 		if (!err)
 			usb_set_interface(chip->dev, altsd->bInterfaceNumber, 0); /* reset the current interface */
 		break;
-	case USB_SUBCLASS_MIDI_STREAMING:
+	case QUIRK_MIDI_STANDARD_INTERFACE:
 		err = snd_usb_create_midi_interface(chip, iface, NULL);
 		break;
 	default:
-		snd_printk(KERN_ERR "if %d: non-supported subclass %d\n",
-			   altsd->bInterfaceNumber, altsd->bInterfaceSubClass);
-		return -ENODEV;
+		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
+		return -ENXIO;
 	}
 	if (err < 0) {
 		snd_printk(KERN_ERR "cannot setup if %d: error %d\n",
@@ -2495,8 +2495,9 @@
 		return create_composite_quirk(chip, iface, quirk);
 	case QUIRK_AUDIO_FIXED_ENDPOINT:
 		return create_fixed_stream_quirk(chip, iface, quirk);
-	case QUIRK_STANDARD_INTERFACE:
-		return create_standard_interface_quirk(chip, iface);
+	case QUIRK_AUDIO_STANDARD_INTERFACE:
+	case QUIRK_MIDI_STANDARD_INTERFACE:
+		return create_standard_interface_quirk(chip, iface, quirk);
 	default:
 		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 		return -ENXIO;
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.17
diff -u -r1.17 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	13 May 2003 10:44:09 -0000	1.17
+++ alsa-kernel/usb/usbaudio.h	17 Jun 2003 06:56:16 -0000
@@ -154,7 +154,8 @@
 #define QUIRK_MIDI_MIDIMAN		2
 #define QUIRK_COMPOSITE			3
 #define QUIRK_AUDIO_FIXED_ENDPOINT	4
-#define QUIRK_STANDARD_INTERFACE	5
+#define QUIRK_AUDIO_STANDARD_INTERFACE	5
+#define QUIRK_MIDI_STANDARD_INTERFACE	6

 typedef struct snd_usb_audio_quirk snd_usb_audio_quirk_t;
 typedef struct snd_usb_midi_endpoint_info snd_usb_midi_endpoint_info_t;
@@ -184,7 +185,7 @@

 /* for QUIRK_AUDIO_FIXED_ENDPOINT, data points to an audioformat structure */

-/* for QUIRK_STANDARD_INTERFACE, data is NULL */
+/* for QUIRK_AUDIO/MIDI_STANDARD_INTERFACE, data is NULL */

 /*
  */
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.20
diff -u -r1.20 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	13 May 2003 10:44:09 -0000	1.20
+++ alsa-kernel/usb/usbquirks.h	17 Jun 2003 06:56:16 -0000
@@ -453,6 +453,36 @@
 		}
 	}
 },
+{	/*
+	 * This quirk is for the "Advanced Driver" mode of the Edirol UA-5.
+	 * If the advanced mode switch at the back of the unit is off, the
+	 * UA-5 has ID 0x0582/0x0011 and is standard compliant (no quirks),
+	 * but offers only 16-bit PCM.
+	 * In advanced mode, the UA-5 will output S24_3LE samples (two
+	 * channels) at the rate indicated on the front switch, including
+	 * the 96kHz sample rate.
+	 */
+	USB_DEVICE(0x0582, 0x0010),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "EDIROL",
+		.product_name = "UA-5",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const snd_usb_audio_quirk_t[]) {
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 {
 	USB_DEVICE(0x0582, 0x0012),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
@@ -520,15 +550,15 @@
 		.data = & (const snd_usb_audio_quirk_t[]) {
 			{
 				.ifnum = 1,
-				.type = QUIRK_STANDARD_INTERFACE
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_STANDARD_INTERFACE
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
 			{
 				.ifnum = 3,
-				.type = QUIRK_STANDARD_INTERFACE
+				.type = QUIRK_MIDI_STANDARD_INTERFACE
 			},
 			{
 				.ifnum = -1




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
