From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] USB MIDI: fix endpoint detection
Date: Fri, 10 Jan 2003 09:08:47 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301100859410.22560-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


This patch removes the implicit assumption that devices with
QUIRK_MIDI_FIXED_ENDPOINT use the same endpoint number for input and
output pipes. (This broke with the Edirol PCR-30/50.)


Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.11
diff -u -r1.11 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	19 Dec 2002 12:15:23 -0000	1.11
+++ alsa-kernel/usb/usbaudio.h	10 Jan 2003 07:54:56 -0000
@@ -165,7 +165,7 @@

 /* data for QUIRK_MIDI_FIXED_ENDPOINT */
 struct snd_usb_midi_endpoint_info {
-	int16_t epnum;		/* ep number, -1 autodetect */
+	int8_t out_ep, in_ep;	/* ep number, 0 autodetect */
 	uint16_t out_cables;	/* bitmask */
 	uint16_t in_cables;	/* bitmask */
 };
Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.33
diff -u -r1.33 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	7 Jan 2003 10:36:32 -0000	1.33
+++ alsa-kernel/usb/usbaudio.c	10 Jan 2003 07:54:56 -0000
@@ -1953,7 +1953,6 @@
 static int snd_usb_roland_ua100_hack(snd_usb_audio_t *chip)
 {
 	static const snd_usb_midi_endpoint_info_t ep_quirk = {
-		.epnum = -1,
 		.out_cables = 0x0007,
 		.in_cables  = 0x0007
 	};
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.10
diff -u -r1.10 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	5 Dec 2002 19:54:44 -0000	1.10
+++ alsa-kernel/usb/usbquirks.h	10 Jan 2003 07:54:57 -0000
@@ -245,7 +245,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -259,7 +258,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x003f,
 			.in_cables  = 0x003f
 		}
@@ -273,7 +271,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -287,7 +284,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -301,7 +297,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0013,
 			.in_cables  = 0x0013
 		}
@@ -315,7 +310,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -329,7 +323,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -343,7 +336,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0013,
 			.in_cables  = 0x0013
 		}
@@ -357,7 +349,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0007,
 			.in_cables  = 0x0007
 		}
@@ -371,7 +362,6 @@
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -385,7 +375,6 @@
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -399,7 +388,6 @@
 		.ifnum = 2,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -413,7 +401,6 @@
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x003f,
 			.in_cables  = 0x003f
 		}
@@ -427,7 +414,6 @@
 		.ifnum = 3,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -441,7 +427,6 @@
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -455,7 +440,6 @@
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -469,7 +453,6 @@
 		.ifnum = 3,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -483,7 +466,6 @@
 		.ifnum = 0,
 		.type = QUIRK_MIDI_FIXED_ENDPOINT,
 		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.epnum = -1,
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.16
diff -u -r1.16 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	19 Dec 2002 12:15:23 -0000	1.16
+++ alsa-kernel/usb/usbmidi.c	10 Jan 2003 07:54:57 -0000
@@ -579,9 +579,9 @@
 		return -ENOMEM;
 	}
 	if (int_epd)
-		pipe = usb_rcvintpipe(umidi->chip->dev, ep_info->epnum);
+		pipe = usb_rcvintpipe(umidi->chip->dev, ep_info->in_ep);
 	else
-		pipe = usb_rcvbulkpipe(umidi->chip->dev, ep_info->epnum);
+		pipe = usb_rcvbulkpipe(umidi->chip->dev, ep_info->in_ep);
 	length = usb_maxpacket(umidi->chip->dev, pipe, 0);
 	buffer = kmalloc(length, GFP_KERNEL);
 	if (!buffer) {
@@ -652,7 +652,7 @@
 		snd_usbmidi_out_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	pipe = usb_sndbulkpipe(umidi->chip->dev, ep_info->epnum);
+	pipe = usb_sndbulkpipe(umidi->chip->dev, ep_info->out_ep);
 	ep->max_transfer = usb_maxpacket(umidi->chip->dev, pipe, 1) & ~3;
 	buffer = kmalloc(ep->max_transfer, GFP_KERNEL);
 	if (!buffer) {
@@ -737,8 +737,6 @@
 	int out_ports = 0, in_ports = 0;

 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
-		if (!endpoints[i].epnum)
-			continue;
 		if (endpoints[i].out_cables) {
 			err = snd_usbmidi_out_endpoint_create(umidi, &endpoints[i],
 							      &umidi->endpoints[i]);
@@ -812,50 +810,64 @@
 		    ms_ep->bDescriptorType != USB_DT_CS_ENDPOINT ||
 		    ms_ep->bDescriptorSubtype != MS_GENERAL)
 			continue;
-		if (endpoints[epidx].epnum != 0 &&
-		    endpoints[epidx].epnum != (ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK)) {
-			++epidx;
-			if (epidx >= MIDI_MAX_ENDPOINTS) {
-				printk(KERN_WARNING "snd-usb-midi: too many endpoints\n");
-				break;
+		if ((ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK) == USB_DIR_OUT) {
+			if (endpoints[epidx].out_ep) {
+				if (++epidx >= MIDI_MAX_ENDPOINTS) {
+					printk(KERN_WARNING "snd-usb-midi: too many endpoints\n");
+					break;
+				}
 			}
-		}
-		endpoints[epidx].epnum = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-		if (ep->bEndpointAddress & USB_DIR_IN) {
-			endpoints[epidx].in_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
-		} else {
+			endpoints[epidx].out_ep = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 			endpoints[epidx].out_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
+			printk(KERN_INFO "snd-usb-midi: EP %02X: %d jack(s)\n",
+			       ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
+		} else {
+			if (endpoints[epidx].in_ep) {
+				if (++epidx >= MIDI_MAX_ENDPOINTS) {
+					printk(KERN_WARNING "snd-usb-midi: too many endpoints\n");
+					break;
+				}
+			}
+			endpoints[epidx].in_ep = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+			endpoints[epidx].in_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
+			printk(KERN_INFO "snd-usb-midi: EP %02X: %d jack(s)\n",
+			       ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
 		}
-		printk(KERN_INFO "snd-usb-midi: detected %d %s jack(s) on endpoint %d\n",
-		       ms_ep->bNumEmbMIDIJack,
-		       ep->bEndpointAddress & USB_DIR_IN ? "input" : "output",
-		       endpoints[epidx].epnum);
 	}
 	return 0;
 }

 /*
- * If the first endpoint isn't specified, use the first endpoint in the
+ * If the endpoints aren't specified, use the first bulk endpoints in the
  * first alternate setting of the interface.
  */
 static int snd_usbmidi_detect_endpoint(snd_usb_midi_t* umidi,
-			       	       snd_usb_midi_endpoint_info_t* endpoint)
+				       snd_usb_midi_endpoint_info_t* endpoint)
 {
 	struct usb_interface* intf;
 	struct usb_host_interface *hostif;
 	struct usb_interface_descriptor* intfd;
 	struct usb_endpoint_descriptor* epd;
+	int i;

-	if (endpoint->epnum == -1) {
-		intf = umidi->iface;
-		if (!intf || intf->num_altsetting < 1)
-			return -ENOENT;
-		hostif = intf->altsetting;
-		intfd = get_iface_desc(hostif);
-		if (intfd->bNumEndpoints < 1)
-			return -ENOENT;
-		epd = get_endpoint(hostif, 0);
-		endpoint->epnum = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+	intf = umidi->iface;
+	if (!intf || intf->num_altsetting < 1)
+		return -ENOENT;
+	hostif = intf->altsetting;
+	intfd = get_iface_desc(hostif);
+	if (intfd->bNumEndpoints < 1)
+		return -ENOENT;
+
+	for (i = 0; i < intfd->bNumEndpoints; ++i) {
+		epd = get_endpoint(hostif, i);
+		if ((epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK)
+			continue;
+		if (!endpoint->out_ep && endpoint->out_cables &&
+		    (epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT)
+			endpoint->out_ep = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+		if (!endpoint->in_ep && endpoint->in_cables &&
+		    (epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_IN)
+			endpoint->in_ep = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	}
 	return 0;
 }
@@ -892,7 +904,6 @@
 	if (!endpoint->in_cables && !endpoint->out_cables)
 		return -ENOENT;

-	endpoint->epnum = -1;
 	return snd_usbmidi_detect_endpoint(umidi, endpoint);
 }

@@ -940,13 +951,13 @@
 		}
 	}

-	ep_info.epnum = get_endpoint(hostif, 2)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+	ep_info.out_ep = get_endpoint(hostif, 2)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	ep_info.out_cables = endpoint->out_cables & 0x5555;
 	err = snd_usbmidi_out_endpoint_create(umidi, &ep_info, &umidi->endpoints[0]);
 	if (err < 0)
 		return err;

-	ep_info.epnum = get_endpoint(hostif, 0)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+	ep_info.in_ep = get_endpoint(hostif, 0)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	ep_info.in_cables = endpoint->in_cables;
 	err = snd_usbmidi_in_endpoint_create(umidi, &ep_info, &umidi->endpoints[0]);
 	if (err < 0)
@@ -954,7 +965,7 @@
 	umidi->endpoints[0].in->urb->complete = snd_usb_complete_callback(snd_usbmidi_in_midiman_complete);

 	if (endpoint->out_cables > 0x0001) {
-		ep_info.epnum = get_endpoint(hostif, 4)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+		ep_info.out_ep = get_endpoint(hostif, 4)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 		ep_info.out_cables = endpoint->out_cables & 0xaaaa;
 		err = snd_usbmidi_out_endpoint_create(umidi, &ep_info, &umidi->endpoints[1]);
 		if (err < 0)



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
