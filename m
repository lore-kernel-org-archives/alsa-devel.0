From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] MidiSport 2x4 support
Date: Thu, 05 Dec 2002 09:50:13 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0212050943150.28331-100000@studcom.urz.uni-halle.de>
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
List-Id: alsa-devel@alsa-project.org


This changes the Midiman quirk code to allow a different number of input
and output ports, and adds a quirk for the 2x4.

This isn't tested at all because somebody forgot to include the firmware
loader in the 2x4's Windows driver package. :)


Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.9
diff -u -r1.9 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	25 Nov 2002 18:15:04 -0000	1.9
+++ alsa-kernel/usb/usbaudio.h	5 Dec 2002 08:41:53 -0000
@@ -172,7 +172,8 @@

 /* for QUIRK_MIDI_YAMAHA, data is NULL */

-/* for QUIRK_MIDI_MIDIMAN, data is the number of ports */
+/* for QUIRK_MIDI_MIDIMAN, data points to a snd_usb_midi_endpoint_info
+ * structure (out_cables and in_cables only) */

 /* for QUIRK_ROLAND_UA100, data is NULL */

Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.10
diff -u -r1.10 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	11 Nov 2002 08:58:29 -0000	1.10
+++ alsa-kernel/usb/usbmidi.c	5 Dec 2002 08:41:53 -0000
@@ -892,7 +892,8 @@
 /*
  * Creates the endpoints and their ports for Midiman devices.
  */
-static int snd_usbmidi_create_endpoints_midiman(snd_usb_midi_t* umidi, int ports)
+static int snd_usbmidi_create_endpoints_midiman(snd_usb_midi_t* umidi,
+						snd_usb_midi_endpoint_info_t* endpoint)
 {
 	snd_usb_midi_endpoint_info_t ep_info;
 	struct usb_interface* intf;
@@ -906,7 +907,7 @@
 		return -ENOENT;
 	hostif = intf->altsetting;
 	intfd = get_iface_desc(hostif);
-	if (intfd->bNumEndpoints < (ports > 1 ? 5 : 3)) {
+	if (intfd->bNumEndpoints < (endpoint->out_cables > 0x0001 ? 5 : 3)) {
 		snd_printdd(KERN_ERR "not enough endpoints\n");
 		return -ENOENT;
 	}
@@ -923,7 +924,7 @@
 		snd_printdd(KERN_ERR "endpoint[2] isn't bulk output\n");
 		return -ENXIO;
 	}
-	if (ports > 1) {
+	if (endpoint->out_cables > 0x0001) {
 		epd = get_endpoint(hostif, 4);
 		if ((epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK) != USB_DIR_OUT ||
 		    (epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK) {
@@ -933,31 +934,33 @@
 	}

 	ep_info.epnum = get_endpoint(hostif, 2)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	ep_info.out_cables = 0x5555 & ((1 << ports) - 1);
+	ep_info.out_cables = endpoint->out_cables & 0x5555;
 	err = snd_usbmidi_out_endpoint_create(umidi, &ep_info, &umidi->endpoints[0]);
 	if (err < 0)
 		return err;

 	ep_info.epnum = get_endpoint(hostif, 0)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	ep_info.in_cables = (1 << ports) - 1;
+	ep_info.in_cables = endpoint->in_cables;
 	err = snd_usbmidi_in_endpoint_create(umidi, &ep_info, &umidi->endpoints[0]);
 	if (err < 0)
 		return err;
 	umidi->endpoints[0].in->urb->complete = snd_usbmidi_in_midiman_complete;

-	if (ports > 1) {
+	if (endpoint->out_cables > 0x0001) {
 		ep_info.epnum = get_endpoint(hostif, 4)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-		ep_info.out_cables = 0xaaaa & ((1 << ports) - 1);
+		ep_info.out_cables = endpoint->out_cables & 0xaaaa;
 		err = snd_usbmidi_out_endpoint_create(umidi, &ep_info, &umidi->endpoints[1]);
 		if (err < 0)
 			return err;
 	}

-	for (cable = 0; cable < ports; ++cable) {
-		snd_usbmidi_init_substream(umidi, SNDRV_RAWMIDI_STREAM_OUTPUT, cable,
-					   &umidi->endpoints[cable & 1].out->ports[cable].substream);
-		snd_usbmidi_init_substream(umidi, SNDRV_RAWMIDI_STREAM_INPUT, cable,
-					   &umidi->endpoints[0].in->ports[cable].substream);
+	for (cable = 0; cable < 0x10; ++cable) {
+		if (endpoint->out_cables & (1 << cable))
+			snd_usbmidi_init_substream(umidi, SNDRV_RAWMIDI_STREAM_OUTPUT, cable,
+						   &umidi->endpoints[cable & 1].out->ports[cable].substream);
+		if (endpoint->in_cables & (1 << cable))
+			snd_usbmidi_init_substream(umidi, SNDRV_RAWMIDI_STREAM_INPUT, cable,
+						   &umidi->endpoints[0].in->ports[cable].substream);
 	}
 	return 0;
 }
@@ -1020,6 +1023,8 @@
 			err = snd_usbmidi_detect_yamaha(umidi, &endpoints[0]);
 			break;
 		case QUIRK_MIDI_MIDIMAN:
+			memcpy(&endpoints[0], quirk->data,
+			       sizeof(snd_usb_midi_endpoint_info_t));
 			err = 0;
 			break;
 		default:
@@ -1034,15 +1039,11 @@
 	}

 	/* create rawmidi device */
-	if (quirk && quirk->type == QUIRK_MIDI_MIDIMAN) {
-		in_ports = out_ports = (int)quirk->data;
-	} else {
-		out_ports = 0;
-		in_ports = 0;
-		for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
-			out_ports += snd_usbmidi_count_bits(endpoints[i].out_cables);
-			in_ports += snd_usbmidi_count_bits(endpoints[i].in_cables);
-		}
+	out_ports = 0;
+	in_ports = 0;
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		out_ports += snd_usbmidi_count_bits(endpoints[i].out_cables);
+		in_ports += snd_usbmidi_count_bits(endpoints[i].in_cables);
 	}
 	err = snd_usbmidi_create_rawmidi(umidi, out_ports, in_ports);
 	if (err < 0) {
@@ -1052,7 +1053,7 @@

 	/* create endpoint/port structures */
 	if (quirk && quirk->type == QUIRK_MIDI_MIDIMAN)
-		err = snd_usbmidi_create_endpoints_midiman(umidi, (int)quirk->data);
+		err = snd_usbmidi_create_endpoints_midiman(umidi, &endpoints[0]);
 	else
 		err = snd_usbmidi_create_endpoints(umidi, endpoints);
 	if (err < 0) {
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.8
diff -u -r1.8 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	3 Dec 2002 11:07:10 -0000	1.8
+++ alsa-kernel/usb/usbquirks.h	5 Dec 2002 08:41:53 -0000
@@ -484,7 +484,10 @@
 		.product_name = "MidiSport 2x2",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = (void*) 2
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0003,
+			.in_cables  = 0x0003
+		}
 	}
 },
 {
@@ -494,7 +497,10 @@
 		.product_name = "MidiSport 1x1",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = (void*) 1
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
 	}
 },
 {
@@ -504,7 +510,10 @@
 		.product_name = "Keystation",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = (void*) 1
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
 	}
 },
 {
@@ -514,7 +523,10 @@
 		.product_name = "MidiSport 4x4",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = (void*) 4
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x000f,
+			.in_cables  = 0x000f
+		}
 	}
 },
 {
@@ -524,7 +536,23 @@
 		.product_name = "MidiSport 8x8",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = (void*) 9
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x01ff,
+			.in_cables  = 0x01ff
+		}
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1041),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "M-Audio",
+		.product_name = "MidiSport 2x4",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_MIDIMAN,
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x000f,
+			.in_cables  = 0x0003
+		}
 	}
 },
 {
@@ -534,7 +562,10 @@
 		.product_name = "Quattro",
 		.ifnum = 9,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = (void*) 1
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
 	}
 },
 {
@@ -544,7 +575,10 @@
 		.product_name = "AudioPhile",
 		.ifnum = 9,
 		.type = QUIRK_MIDI_MIDIMAN,
-		.data = (void*) 1
+		.data = & (const snd_usb_midi_endpoint_info_t) {
+			.out_cables = 0x0001,
+			.in_cables  = 0x0001
+		}
 	}
 },




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
