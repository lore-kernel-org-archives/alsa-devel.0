From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Edirol UA-20 PCM support
Date: Fri, 28 Feb 2003 12:33:02 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302281144030.5750-100000@studcom.urz.uni-halle.de>
References: <s5hof50zmhx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5hof50zmhx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> could you resend the patch if finished?

The new parsing code works with my device (UA-1A), but I couldn't test the
changes for the mixer and the UA-20.


- removed buffer allocation for class-specific descriptors; get them from
  intf->extra and ep->extra.
- accept USB_CLASS_VENDOR_SPECIFIC when parsing audio interfaces
- added quirk type for interfaces having standard descriptors
- added quirk for UA-20


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.45
diff -u -r1.45 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	25 Feb 2003 12:35:45 -0000	1.45
+++ alsa-kernel/usb/usbaudio.c	28 Feb 2003 10:34:19 -0000
@@ -1556,15 +1556,11 @@

 /*
  * parse descriptor buffer and return the pointer starting the given
- * descriptor type and interface.
- * if altsetting is not -1, seek the buffer until the matching alternate
- * setting is found.
+ * descriptor type.
  */
-void *snd_usb_find_desc(void *descstart, int desclen, void *after,
-			u8 dtype, int iface, int altsetting)
+void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype)
 {
 	u8 *p, *end, *next;
-	int ifc = -1, as = -1;

 	p = descstart;
 	end = p + desclen;
@@ -1574,15 +1570,7 @@
 		next = p + p[0];
 		if (next > end)
 			return NULL;
-		if (p[1] == USB_DT_INTERFACE) {
-			/* minimum length of interface descriptor */
-			if (p[0] < 9)
-				return NULL;
-			ifc = p[2];
-			as = p[3];
-		}
-		if (p[1] == dtype && (!after || (void *)p > after) &&
-		    (iface == -1 || iface == ifc) && (altsetting == -1 || altsetting == as)) {
+		if (p[1] == dtype && (!after || (void *)p > after)) {
 			return p;
 		}
 		p = next;
@@ -1593,12 +1581,12 @@
 /*
  * find a class-specified interface descriptor with the given subtype.
  */
-void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype, int iface, int altsetting)
+void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype)
 {
 	unsigned char *p = after;

 	while ((p = snd_usb_find_desc(buffer, buflen, p,
-				      USB_DT_CS_INTERFACE, iface, altsetting)) != NULL) {
+				      USB_DT_CS_INTERFACE)) != NULL) {
 		if (p[0] >= 3 && p[2] == dsubtype)
 			return p;
 	}
@@ -1950,7 +1938,7 @@
 }


-static int parse_audio_endpoints(snd_usb_audio_t *chip, unsigned char *buffer, int buflen, int iface_no)
+static int parse_audio_endpoints(snd_usb_audio_t *chip, int iface_no)
 {
 	struct usb_device *dev;
 	struct usb_host_config *config;
@@ -1971,7 +1959,8 @@
 		alts = &iface->altsetting[i];
 		altsd = get_iface_desc(alts);
 		/* skip invalid one */
-		if (altsd->bInterfaceClass != USB_CLASS_AUDIO ||
+		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
+		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
 		    altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING ||
 		    altsd->bNumEndpoints < 1)
 			continue;
@@ -1985,7 +1974,7 @@
 		altno = altsd->bAlternateSetting;

 		/* get audio formats */
-		fmt = snd_usb_find_csint_desc(buffer, buflen, NULL, AS_GENERAL, iface_no, altno);
+		fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, AS_GENERAL);
 		if (!fmt) {
 			snd_printk(KERN_ERR "%d:%u:%d : AS_GENERAL descriptor not found\n",
 				   dev->devnum, iface_no, altno);
@@ -2001,7 +1990,7 @@
 		format = (fmt[6] << 8) | fmt[5]; /* remember the format value */

 		/* get format type */
-		fmt = snd_usb_find_csint_desc(buffer, buflen, NULL, FORMAT_TYPE, iface_no, altno);
+		fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, FORMAT_TYPE);
 		if (!fmt) {
 			snd_printk(KERN_ERR "%d:%u:%d : no FORMAT_TYPE desc\n",
 				   dev->devnum, iface_no, altno);
@@ -2031,7 +2020,7 @@
 			continue;
 		}

-		csep = snd_usb_find_desc(buffer, buflen, NULL, USB_DT_CS_ENDPOINT, iface_no, altno);
+		csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
 		if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
 			snd_printk(KERN_ERR "%d:%u:%d : no or invalid class specific endpoint descriptor\n",
 				   dev->devnum, iface_no, altno);
@@ -2119,17 +2108,19 @@
 /*
  * parse audio control descriptor and create pcm/midi streams
  */
-static int snd_usb_create_streams(snd_usb_audio_t *chip, int ctrlif,
-				  unsigned char *buffer, int buflen)
+static int snd_usb_create_streams(snd_usb_audio_t *chip, int ctrlif)
 {
 	struct usb_device *dev = chip->dev;
 	struct usb_host_config *config;
+	struct usb_host_interface *host_iface;
 	struct usb_interface *iface;
 	unsigned char *p1;
 	int i, j;

 	/* find audiocontrol interface */
-	if (!(p1 = snd_usb_find_csint_desc(buffer, buflen, NULL, HEADER, ctrlif, -1))) {
+	config = dev->actconfig;
+	host_iface = &config->interface[ctrlif].altsetting[0];
+	if (!(p1 = snd_usb_find_csint_desc(host_iface->extra, host_iface->extralen, NULL, HEADER))) {
 		snd_printk(KERN_ERR "cannot find HEADER\n");
 		return -EINVAL;
 	}
@@ -2141,7 +2132,6 @@
 	/*
 	 * parse all USB audio streaming interfaces
 	 */
-	config = dev->actconfig;
 	for (i = 0; i < p1[7]; i++) {
 		struct usb_host_interface *alts;
 		struct usb_interface_descriptor *altsd;
@@ -2158,7 +2148,8 @@
 		}
 		alts = &iface->altsetting[0];
 		altsd = get_iface_desc(alts);
-		if (altsd->bInterfaceClass == USB_CLASS_AUDIO &&
+		if ((altsd->bInterfaceClass == USB_CLASS_AUDIO ||
+		     altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
 		    altsd->bInterfaceSubClass == USB_SUBCLASS_MIDI_STREAMING) {
 			if (snd_usb_create_midi_interface(chip, iface, NULL) < 0) {
 				snd_printk(KERN_ERR "%d:%u:%d: cannot create sequencer device\n", dev->devnum, ctrlif, j);
@@ -2167,13 +2158,14 @@
 			usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
 			continue;
 		}
-		if (altsd->bInterfaceClass != USB_CLASS_AUDIO ||
+		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
+		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
 		    altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING) {
 			snd_printdd(KERN_ERR "%d:%u:%d: skipping non-supported interface %d\n", dev->devnum, ctrlif, j, altsd->bInterfaceClass);
 			/* skip non-supported classes */
 			continue;
 		}
-		if (! parse_audio_endpoints(chip, buffer, buflen, j)) {
+		if (! parse_audio_endpoints(chip, j)) {
 			usb_set_interface(dev, j, 0); /* reset the current interface */
 			usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
 		}
@@ -2213,6 +2205,40 @@
 	return 0;
 }

+/*
+ * create a stream for an interface with proper descriptors
+ */
+static int create_standard_interface_quirk(snd_usb_audio_t *chip,
+					   struct usb_interface *iface)
+{
+	struct usb_host_interface *alts;
+	struct usb_interface_descriptor *altsd;
+	int err;
+
+	alts = &iface->altsetting[0];
+	altsd = get_iface_desc(alts);
+	switch (altsd->bInterfaceSubClass) {
+	case USB_SUBCLASS_AUDIO_STREAMING:
+		err = parse_audio_endpoints(chip, altsd->bInterfaceNumber);
+		if (!err)
+			usb_set_interface(chip->dev, altsd->bInterfaceNumber, 0); /* reset the current interface */
+		break;
+	case USB_SUBCLASS_MIDI_STREAMING:
+		err = snd_usb_create_midi_interface(chip, iface, NULL);
+		break;
+	default:
+		snd_printk(KERN_ERR "if %d: non-supported subclass %d\n",
+			   altsd->bInterfaceNumber, altsd->bInterfaceSubClass);
+		return -ENODEV;
+	}
+	if (err < 0) {
+		snd_printk(KERN_ERR "cannot setup if %d: error %d\n",
+			   altsd->bInterfaceNumber, err);
+		return err;
+	}
+	return 0;
+}
+
 static int snd_usb_create_quirk(snd_usb_audio_t *chip,
 				struct usb_interface *iface,
 				const snd_usb_audio_quirk_t *quirk);
@@ -2296,6 +2322,8 @@
 		return create_composite_quirk(chip, iface, quirk);
 	case QUIRK_AUDIO_FIXED_ENDPOINT:
 		return create_fixed_stream_quirk(chip, iface, quirk);
+	case QUIRK_STANDARD_INTERFACE:
+		return create_standard_interface_quirk(chip, iface);
 	default:
 		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 		return -ENXIO;
@@ -2413,42 +2441,6 @@


 /*
- * allocate and get description buffer
- * must be freed later.
- */
-static int alloc_desc_buffer(struct usb_device *dev, int index, unsigned char **bufptr)
-{
-	int err, buflen;
-	unsigned char buf[8];
-	unsigned char *buffer;
-
-	*bufptr = 0;
-	err = usb_get_descriptor(dev, USB_DT_CONFIG, index, buf, 8);
-	if (err < 0) {
-		snd_printk(KERN_ERR "%d:%d: cannot get first 8 bytes\n", index, dev->devnum);
-		return err;
-	}
-	if (buf[1] != USB_DT_CONFIG || buf[0] < 9) {
-		snd_printk(KERN_ERR "%d:%d: invalid config desc\n", index, dev->devnum);
-		return -EINVAL;
-	}
-	buflen = combine_word(&buf[2]);
-	if (!(buffer = kmalloc(buflen, GFP_KERNEL))) {
-		snd_printk(KERN_ERR "cannot malloc descriptor (size = %d)\n", buflen);
-		return -ENOMEM;
-	}
-	err = usb_get_descriptor(dev, USB_DT_CONFIG, index, buffer, buflen);
-	if (err < 0) {
-		snd_printk(KERN_ERR "%d:%d: cannot get DT_CONFIG: error %d\n", index, dev->devnum, err);
-		kfree(buffer);
-		return err;
-	}
-	*bufptr = buffer;
-	return buflen;
-}
-
-
-/*
  * probe the active usb device
  *
  * note that this can be called multiple times per a device, when it
@@ -2540,20 +2532,10 @@

 	if (err > 0) {
 		/* create normal USB audio interfaces */
-		unsigned char *buffer;
-		unsigned int index;
-		int buflen;
-
-		index = dev->actconfig - config;
-		buflen = alloc_desc_buffer(dev, index, &buffer);
-		if (buflen <= 0)
-			goto __error;
-		if (snd_usb_create_streams(chip, ifnum, buffer, buflen) < 0 ||
-		    snd_usb_create_mixer(chip, ifnum, buffer, buflen) < 0) {
-			kfree(buffer);
+		if (snd_usb_create_streams(chip, ifnum) < 0 ||
+		    snd_usb_create_mixer(chip, ifnum) < 0) {
 			goto __error;
 		}
-		kfree(buffer);
 	}

 	/* we are allowed to call snd_card_register() many times */
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.15
diff -u -r1.15 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	10 Feb 2003 17:59:50 -0000	1.15
+++ alsa-kernel/usb/usbaudio.h	28 Feb 2003 10:34:19 -0000
@@ -146,6 +146,7 @@
 /*
  * Information about devices with broken descriptors
  */
+
 #define QUIRK_ANY_INTERFACE -1

 #define QUIRK_MIDI_FIXED_ENDPOINT	0
@@ -153,6 +154,7 @@
 #define QUIRK_MIDI_MIDIMAN		2
 #define QUIRK_COMPOSITE			3
 #define QUIRK_AUDIO_FIXED_ENDPOINT	4
+#define QUIRK_STANDARD_INTERFACE	5

 #define QUIRK_BOOT_MASK			0x80
 #define QUIRK_BOOT_EXTIGY		(QUIRK_BOOT_MASK | 0)
@@ -185,6 +187,8 @@

 /* for QUIRK_AUDIO_FIXED_ENDPOINT, data points to an audioformat structure */

+/* for QUIRK_STANDARD_INTERFACE, data is NULL */
+
 /*
  */

@@ -194,10 +198,10 @@

 unsigned int snd_usb_combine_bytes(unsigned char *bytes, int size);

-void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype, int iface, int altsetting);
-void *snd_usb_find_csint_desc(void *descstart, int desclen, void *after, u8 dsubtype, int iface, int altsetting);
+void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype);
+void *snd_usb_find_csint_desc(void *descstart, int desclen, void *after, u8 dsubtype);

-int snd_usb_create_mixer(snd_usb_audio_t *chip, int ctrlif, unsigned char *buffer, int buflen);
+int snd_usb_create_mixer(snd_usb_audio_t *chip, int ctrlif);

 int snd_usb_create_midi_interface(snd_usb_audio_t *chip, struct usb_interface *iface, const snd_usb_audio_quirk_t *quirk);
 void snd_usbmidi_disconnect(struct list_head *p);
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.17
diff -u -r1.17 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	25 Feb 2003 17:04:43 -0000	1.17
+++ alsa-kernel/usb/usbquirks.h	28 Feb 2003 10:34:19 -0000
@@ -26,6 +26,11 @@
  * In a perfect world, this file would be empty.
  */

+/*
+ * Use this for devices where other interfaces are standard compliant,
+ * to prevent the quirk being applied to those interfaces. (To work with
+ * hotplugging, bDeviceClass must be set to USB_CLASS_PER_INTERFACE.)
+ */
 #define USB_DEVICE_VENDOR_SPEC(vend, prod) \
 	.match_flags = USB_DEVICE_ID_MATCH_VENDOR | \
 		       USB_DEVICE_ID_MATCH_PRODUCT | \
@@ -226,16 +231,10 @@
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
@@ -507,15 +506,33 @@
 	}
 },
 {
-	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0025),
+	/*
+	 * This quirk is for the "Advanced Driver" mode. If off, the UA-20
+	 * has ID 0x0026 and is standard compliant, but has only 16-bit PCM
+	 * and no MIDI.
+	 */
+	USB_DEVICE(0x0582, 0x0025),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-20",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0001
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const snd_usb_audio_quirk_t[]) {
+			{
+				.ifnum = 1,
+				.type = QUIRK_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
 		}
 	}
 },
Index: alsa-kernel/usb/usbmixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmixer.c,v
retrieving revision 1.16
diff -u -r1.16 usbmixer.c
--- alsa-kernel/usb/usbmixer.c	31 Jan 2003 15:21:32 -0000	1.16
+++ alsa-kernel/usb/usbmixer.c	28 Feb 2003 11:28:08 -0000
@@ -182,7 +182,7 @@

 	p = NULL;
 	while ((p = snd_usb_find_desc(state->buffer, state->buflen, p,
-				      USB_DT_CS_INTERFACE, state->ctrlif, -1)) != NULL) {
+				      USB_DT_CS_INTERFACE)) != NULL) {
 		if (p[0] >= 4 && p[2] >= INPUT_TERMINAL && p[2] <= EXTENSION_UNIT && p[3] == unit)
 			return p;
 	}
@@ -1462,20 +1462,21 @@
  *
  * walk through all OUTPUT_TERMINAL descriptors to search for mixers
  */
-int snd_usb_create_mixer(snd_usb_audio_t *chip, int ctrlif, unsigned char *buffer, int buflen)
+int snd_usb_create_mixer(snd_usb_audio_t *chip, int ctrlif)
 {
 	unsigned char *desc;
 	mixer_build_t state;
 	int err;
 	const struct usbmix_ctl_map *map;
 	struct usb_device_descriptor *dev = &chip->dev->descriptor;
+	struct usb_host_interface *hostif = &chip->dev->actconfig->interface[ctrlif].altsetting[0];

 	strcpy(chip->card->mixername, "USB Mixer");

 	memset(&state, 0, sizeof(state));
 	state.chip = chip;
-	state.buffer = buffer;
-	state.buflen = buflen;
+	state.buffer = hostif->extra;
+	state.buflen = hostif->extralen;
 	state.ctrlif = ctrlif;
 	state.vendor = dev->idVendor;
 	state.product = dev->idProduct;
@@ -1489,7 +1490,7 @@
 	}

 	desc = NULL;
-	while ((desc = snd_usb_find_csint_desc(buffer, buflen, desc, OUTPUT_TERMINAL, ctrlif, -1)) != NULL) {
+	while ((desc = snd_usb_find_csint_desc(hostif->extra, hostif->extralen, desc, OUTPUT_TERMINAL)) != NULL) {
 		if (desc[0] < 9)
 			continue; /* invalid descriptor? */
 		set_bit(desc[3], state.unitbitmap);  /* mark terminal ID as visited */




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
