From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [Alsa-devel] [PATCH]: better
	X-Station/Speedio/ReMOTE25 support
Date: Wed, 26 Jan 2005 17:47:43 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501261653180.2217-100000@studcom.urz.uni-halle.de>
References: <20050124021152.705b6aa8.ccb@acm.org>
Reply-To: "The Linux Audio Developers' Mailing List"
	<linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
In-Reply-To: <20050124021152.705b6aa8.ccb-HInyCGIudOg@public.gmane.org>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=help>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Errors-To: linux-audio-dev-bounces-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
To: The Linux Audio Developers' Mailing List <linux-audio-dev-oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org>
Cc: alsa-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Charles C. Bennett, Jr. wrote:
> The patch should apply cleanly to any kernel tree with
> ALSA 1.7 and build just fine.

The driver had some little changes in version 1.0.8.  Additionally,
I've been adding yet another protocol (for MOTU devices), and this
resulted in too many quirky "if"s sprinkled all over the code, so I've
rewritten the handling of the MIDI protocol stuff with callbacks.

I had some code for the Novation protocol for several weeks, but
didn't find any testers who actually tested it -- so you're now my
victim.  ;-)


This patch is against the current ALSA CVS.  If you modifiy your
kernel, you need only the changes below alsa-kernel/.  If you don't
have the CVS version, you can get the patched files from
<http://www.informatik.uni-halle.de/~ladischc/usbmidi.tar.gz>.


Best regards,
Clemens

-- 
Index: alsa-driver/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.15
diff -u -r1.15 usbmidi.c
--- alsa-driver/usb/usbmidi.c	20 Jan 2005 17:25:30 -0000	1.15
+++ alsa-driver/usb/usbmidi.c	26 Jan 2005 15:56:47 -0000
@@ -13,7 +13,6 @@
 #ifdef OLD_USB
 #define snd_usb_complete_callback(x) __old_ ## x
 static void __old_snd_usbmidi_in_urb_complete(struct urb* urb);
-static void __old_snd_usbmidi_in_midiman_complete(struct urb* urb);
 static void __old_snd_usbmidi_out_urb_complete(struct urb* urb);
 #endif

@@ -25,11 +24,6 @@
 	snd_usbmidi_in_urb_complete(urb, NULL);
 }

-static void __old_snd_usbmidi_in_midiman_complete(struct urb* urb)
-{
-	snd_usbmidi_in_midiman_complete(urb, NULL);
-}
-
 static void __old_snd_usbmidi_out_urb_complete(struct urb* urb)
 {
 	snd_usbmidi_out_urb_complete(urb, NULL);
Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.114
diff -u -r1.114 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	17 Jan 2005 17:41:34 -0000	1.114
+++ alsa-kernel/usb/usbaudio.c	26 Jan 2005 15:56:47 -0000
@@ -2965,6 +2965,8 @@
 	case QUIRK_MIDI_FIXED_ENDPOINT:
 	case QUIRK_MIDI_YAMAHA:
 	case QUIRK_MIDI_MIDIMAN:
+	case QUIRK_MIDI_NOVATION:
+	case QUIRK_MIDI_MOTU:
 		return snd_usb_create_midi_interface(chip, iface, quirk);
 	case QUIRK_COMPOSITE:
 		return create_composite_quirk(chip, iface, quirk);
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.36
diff -u -r1.36 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	17 Jan 2005 17:41:38 -0000	1.36
+++ alsa-kernel/usb/usbaudio.h	26 Jan 2005 15:56:47 -0000
@@ -158,6 +158,8 @@
 #define QUIRK_AUDIO_EDIROL_UA700_UA25	7
 #define QUIRK_AUDIO_EDIROL_UA1000	8
 #define QUIRK_IGNORE_INTERFACE		9
+#define QUIRK_MIDI_NOVATION		10
+#define QUIRK_MIDI_MOTU			11

 typedef struct snd_usb_audio_quirk snd_usb_audio_quirk_t;
 typedef struct snd_usb_midi_endpoint_info snd_usb_midi_endpoint_info_t;
@@ -172,7 +174,10 @@

 /* data for QUIRK_MIDI_FIXED_ENDPOINT */
 struct snd_usb_midi_endpoint_info {
-	int8_t out_ep, in_ep;	/* ep number, 0 autodetect */
+	int8_t   out_ep;	/* ep number, 0 autodetect */
+	uint8_t  out_interval;	/* interval for interrupt endpoints */
+	int8_t   in_ep;
+	uint8_t  in_interval;
 	uint16_t out_cables;	/* bitmask */
 	uint16_t in_cables;	/* bitmask */
 };
@@ -191,7 +196,9 @@

 /* for QUIRK_AUDIO_EDIROL_UA700_UA25/UA1000, data is NULL */

-/* for QUIRK_IGNORE_INTERFACE, data is null */
+/* for QUIRK_IGNORE_INTERFACE, data is NULL */
+
+/* for QUIRK_MIDI_NOVATION and _MOTU, data is NULL */

 /*
  */
Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.35
diff -u -r1.35 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	29 Nov 2004 14:09:48 -0000	1.35
+++ alsa-kernel/usb/usbmidi.c	26 Jan 2005 15:56:47 -0000
@@ -1,7 +1,7 @@
 /*
  * usbmidi.c - ALSA USB MIDI driver
  *
- * Copyright (c) 2002-2004 Clemens Ladisch
+ * Copyright (c) 2002-2005 Clemens Ladisch
  * All rights reserved.
  *
  * Based on the OSS usb-midi driver by NAGANO Daisuke,
@@ -77,11 +77,18 @@
 typedef struct usbmidi_out_port usbmidi_out_port_t;
 typedef struct usbmidi_in_port usbmidi_in_port_t;

+struct usb_protocol_ops {
+	void (*input)(snd_usb_midi_in_endpoint_t*, uint8_t*, int);
+	void (*output)(snd_usb_midi_out_endpoint_t*);
+	void (*output_packet)(struct urb*, uint8_t, uint8_t, uint8_t, uint8_t);
+};
+
 struct snd_usb_midi {
 	snd_usb_audio_t *chip;
 	struct usb_interface *iface;
 	const snd_usb_audio_quirk_t *quirk;
 	snd_rawmidi_t* rmidi;
+	struct usb_protocol_ops* usb_protocol_ops;
 	struct list_head list;

 	struct snd_usb_midi_endpoint {
@@ -156,23 +163,59 @@
 }

 /*
- * Receives a USB MIDI packet.
+ * Receives a chunk of MIDI data.
  */
-static void snd_usbmidi_input_packet(snd_usb_midi_in_endpoint_t* ep,
-				     uint8_t packet[4])
+static void snd_usbmidi_input_data(usbmidi_in_port_t* port,
+				   uint8_t* data, int length)
 {
-	int cable = packet[0] >> 4;
-	usbmidi_in_port_t* port = &ep->ports[cable];
-
 	if (!port->substream) {
-		snd_printd("unexpected port %d!\n", cable);
+		snd_printd("unexpected port in input!\n");
 		return;
 	}
 	if (!port->substream->runtime ||
 	    !port->substream->runtime->trigger)
 		return;
-	snd_rawmidi_receive(port->substream, &packet[1],
-			    snd_usbmidi_cin_length[packet[0] & 0x0f]);
+	snd_rawmidi_receive(port->substream, data, length);
+}
+
+static void snd_usbmidi_standard_input(snd_usb_midi_in_endpoint_t* ep,
+				       uint8_t* buffer, int buffer_length)
+{
+	int i;
+
+	for (i = 0; i + 3 < buffer_length; i += 4)
+		if (buffer[i] != 0) {
+			usbmidi_in_port_t* port = &ep->ports[buffer[i] >> 4];
+			int length = snd_usbmidi_cin_length[buffer[i] & 0x0f];
+			snd_usbmidi_input_data(port, &buffer[i + 1], length);
+		}
+}
+
+static void snd_usbmidi_midiman_input(snd_usb_midi_in_endpoint_t* ep,
+				      uint8_t* buffer, int buffer_length)
+{
+	int i;
+
+	for (i = 0; i + 3 < buffer_length; i += 4)
+		if (buffer[i + 3] != 0) {
+			usbmidi_in_port_t* port = &ep->ports[buffer[i + 3] >> 4];
+			int length = buffer[i + 3] & 3;
+			snd_usbmidi_input_data(port, &buffer[i], length);
+		}
+}
+
+static void snd_usbmidi_novation_input(snd_usb_midi_in_endpoint_t* ep,
+				       uint8_t* buffer, int buffer_length)
+{
+	if (buffer_length < 2 || !buffer[0] || buffer_length < buffer[0] + 1)
+		return;
+	snd_usbmidi_input_data(&ep->ports[0], &buffer[2], buffer[0] - 1);
+}
+
+static void snd_usbmidi_motu_input(snd_usb_midi_in_endpoint_t* ep,
+				   uint8_t* buffer, int buffer_length)
+{
+	snd_usbmidi_input_data(&ep->ports[0], buffer, buffer_length);
 }

 /*
@@ -183,12 +226,8 @@
 	snd_usb_midi_in_endpoint_t* ep = urb->context;

 	if (urb->status == 0) {
-		uint8_t* buffer = (uint8_t*)ep->urb->transfer_buffer;
-		int i;
-
-		for (i = 0; i + 4 <= urb->actual_length; i += 4)
-			if (buffer[i] != 0)
-				snd_usbmidi_input_packet(ep, &buffer[i]);
+		ep->umidi->usb_protocol_ops->input(ep, urb->transfer_buffer,
+						   urb->actual_length);
 	} else {
 		if (snd_usbmidi_urb_error(urb->status) < 0)
 			return;
@@ -200,38 +239,6 @@
 	}
 }

-/*
- * Converts the data read from a Midiman device to standard USB MIDI packets.
- */
-static void snd_usbmidi_in_midiman_complete(struct urb* urb, struct pt_regs *regs)
-{
-	if (urb->status == 0) {
-		uint8_t* buffer = (uint8_t*)urb->transfer_buffer;
-		int i;
-
-		for (i = 0; i + 4 <= urb->actual_length; i += 4) {
-			if (buffer[i + 3] != 0) {
-				/*
-				 * snd_usbmidi_input_packet() doesn't check the
-				 * contents of the message, so we simply use
-				 * some random CIN with the desired length.
-				 */
-				static const uint8_t cin[4] = {
-					0x0, 0xf, 0x2, 0x3
-				};
-				uint8_t ctl = buffer[i + 3];
-				buffer[i + 3] = buffer[i + 2];
-				buffer[i + 2] = buffer[i + 1];
-				buffer[i + 1] = buffer[i + 0];
-				buffer[i + 0] = (ctl & 0xf0) | cin[ctl & 3];
-			} else {
-				buffer[i + 0] = 0;
-			}
-		}
-	}
-	snd_usbmidi_in_urb_complete(urb, regs);
-}
-
 static void snd_usbmidi_out_urb_complete(struct urb* urb, struct pt_regs *regs)
 {
 	snd_usb_midi_out_endpoint_t* ep = urb->context;
@@ -244,27 +251,25 @@
 }

 /*
- * Converts standard USB MIDI packets to what Midman devices expect.
+ * Adds one Midiman packet to the output buffer.
  */
-static void snd_usbmidi_convert_to_midiman(struct urb* urb)
+static void snd_usbmidi_output_midiman_packet(struct urb* urb, uint8_t p0,
+					      uint8_t p1, uint8_t p2, uint8_t p3)
 {
-	uint8_t* buffer = (uint8_t*)urb->transfer_buffer;
-	int i;

-	for (i = 0; i + 4 <= urb->transfer_buffer_length; i += 4) {
-		uint8_t cin = buffer[i];
-		buffer[i + 0] = buffer[i + 1];
-		buffer[i + 1] = buffer[i + 2];
-		buffer[i + 2] = buffer[i + 3];
-		buffer[i + 3] = (cin & 0xf0) | snd_usbmidi_cin_length[cin & 0x0f];
-	}
+	uint8_t* buf = (uint8_t*)urb->transfer_buffer + urb->transfer_buffer_length;
+	buf[0] = p1;
+	buf[1] = p2;
+	buf[2] = p3;
+	buf[3] = (p0 & 0xf0) | snd_usbmidi_cin_length[p0 & 0x0f];
+	urb->transfer_buffer_length += 4;
 }

 /*
  * Adds one USB MIDI packet to the output buffer.
  */
-static inline void output_packet(struct urb* urb,
-	       			 uint8_t p0, uint8_t p1, uint8_t p2, uint8_t p3)
+static void snd_usbmidi_output_standard_packet(struct urb* urb, uint8_t p0,
+					       uint8_t p1, uint8_t p2, uint8_t p3)
 {

 	uint8_t* buf = (uint8_t*)urb->transfer_buffer + urb->transfer_buffer_length;
@@ -282,6 +287,8 @@
 				      uint8_t b, struct urb* urb)
 {
 	uint8_t p0 = port->cable;
+	void (*output_packet)(struct urb*, uint8_t, uint8_t, uint8_t, uint8_t) =
+		port->ep->umidi->usb_protocol_ops->output_packet;

 	if (b >= 0xf8) {
 		output_packet(urb, p0 | 0x0f, b, 0, 0);
@@ -371,31 +378,72 @@
 }

 /*
- * Moves data from one substream buffer to the URB transfer buffer.
+ * These functions move data from substream buffers to the URB transfer buffer.
  */
-static void snd_usbmidi_transmit(snd_usb_midi_out_endpoint_t* ep, int port_idx)
+
+static void snd_usbmidi_standard_output(snd_usb_midi_out_endpoint_t* ep)
 {
 	struct urb* urb = ep->urb;
-	usbmidi_out_port_t* port = &ep->ports[port_idx];
+	int p;

-	while (urb->transfer_buffer_length < ep->max_transfer) {
-		uint8_t b;
-		if (snd_rawmidi_transmit_peek(port->substream, &b, 1) != 1) {
-			port->active = 0;
-			break;
+	/* FIXME: lower-numbered ports can starve higher-numbered ports */
+	for (p = 0; p < 0x10; ++p) {
+		usbmidi_out_port_t* port = &ep->ports[p];
+		if (!port->active)
+			continue;
+		while (urb->transfer_buffer_length + 3 < ep->max_transfer) {
+			uint8_t b;
+			if (snd_rawmidi_transmit(port->substream, &b, 1) != 1) {
+				port->active = 0;
+				break;
+			}
+			snd_usbmidi_transmit_byte(port, b, urb);
 		}
-		snd_usbmidi_transmit_byte(port, b, urb);
-		snd_rawmidi_transmit_ack(port->substream, 1);
 	}
 }

+static void snd_usbmidi_novation_output(snd_usb_midi_out_endpoint_t* ep)
+{
+	uint8_t* transfer_buffer;
+	int count;
+
+	if (!ep->ports[0].active)
+		return;
+	transfer_buffer = ep->urb->transfer_buffer;
+	count = snd_rawmidi_transmit(ep->ports[0].substream,
+				     &transfer_buffer[2],
+				     ep->max_transfer - 2);
+	if (count < 1) {
+		ep->ports[0].active = 0;
+		return;
+	}
+	transfer_buffer[0] = 0;
+	transfer_buffer[1] = count;
+	ep->urb->transfer_buffer_length = 2 + count;
+}
+
+static void snd_usbmidi_motu_output(snd_usb_midi_out_endpoint_t* ep)
+{
+	int count;
+
+	if (!ep->ports[0].active)
+		return;
+	count = snd_rawmidi_transmit(ep->ports[0].substream,
+				     ep->urb->transfer_buffer,
+				     ep->max_transfer);
+	if (count < 1) {
+		ep->ports[0].active = 0;
+		return;
+	}
+	ep->urb->transfer_buffer_length = count;
+}
+
 /*
  * This is called when some data should be transferred to the device
  * (from one or more substreams).
  */
 static void snd_usbmidi_do_output(snd_usb_midi_out_endpoint_t* ep)
 {
-	int p;
 	struct urb* urb = ep->urb;
 	unsigned long flags;

@@ -406,14 +454,9 @@
 	}

 	urb->transfer_buffer_length = 0;
-	for (p= 0; p < 0x10; ++p)
-		if (ep->ports[p].active)
-			snd_usbmidi_transmit(ep, p);
+	ep->umidi->usb_protocol_ops->output(ep);

 	if (urb->transfer_buffer_length > 0) {
-		if (ep->umidi->quirk && ep->umidi->quirk->type == QUIRK_MIDI_MIDIMAN)
-			snd_usbmidi_convert_to_midiman(urb);
-
 		urb->dev = ep->umidi->chip->dev;
 		snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
 	}
@@ -427,6 +470,28 @@
 	snd_usbmidi_do_output(ep);
 }

+static struct usb_protocol_ops snd_usbmidi_standard_ops = {
+	.input = snd_usbmidi_standard_input,
+	.output = snd_usbmidi_standard_output,
+	.output_packet = snd_usbmidi_output_standard_packet,
+};
+
+static struct usb_protocol_ops snd_usbmidi_midiman_ops = {
+	.input = snd_usbmidi_midiman_input,
+	.output = snd_usbmidi_standard_output,
+	.output_packet = snd_usbmidi_output_midiman_packet,
+};
+
+static struct usb_protocol_ops snd_usbmidi_novation_ops = {
+	.input = snd_usbmidi_novation_input,
+	.output = snd_usbmidi_novation_output,
+};
+
+static struct usb_protocol_ops snd_usbmidi_motu_ops = {
+	.input = snd_usbmidi_motu_input,
+	.output = snd_usbmidi_motu_output,
+};
+
 static int snd_usbmidi_output_open(snd_rawmidi_substream_t* substream)
 {
 	snd_usb_midi_t* umidi = substream->rmidi->private_data;
@@ -511,57 +576,6 @@
 }

 /*
- * For Roland devices, use the alternate setting which uses interrupt
- * transfers for input.
- */
-static struct usb_endpoint_descriptor* snd_usbmidi_get_int_epd(snd_usb_midi_t* umidi)
-{
-	struct usb_interface* intf;
-	struct usb_host_interface *hostif;
-	struct usb_interface_descriptor* intfd;
-
-	if (umidi->chip->dev->descriptor.idVendor != 0x0582)
-		return NULL;
-	intf = umidi->iface;
-	if (!intf || intf->num_altsetting != 2)
-		return NULL;
-
-	hostif = &intf->altsetting[0];
-	intfd = get_iface_desc(hostif);
-	if (intfd->bNumEndpoints != 2 ||
-	    (get_endpoint(hostif, 0)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK ||
-	    (get_endpoint(hostif, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK)
-		return NULL;
-
-	hostif = &intf->altsetting[1];
-	intfd = get_iface_desc(hostif);
-	if (intfd->bNumEndpoints != 2 ||
-	    (get_endpoint(hostif, 0)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK ||
-	    (get_endpoint(hostif, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_INT)
-		return NULL;
-
-	snd_printdd(KERN_INFO "switching to altsetting %d with int ep\n",
-		    intfd->bAlternateSetting);
-	usb_set_interface(umidi->chip->dev, intfd->bInterfaceNumber,
-			  intfd->bAlternateSetting);
-	return get_endpoint(hostif, 1);
-}
-
-static struct usb_endpoint_descriptor* snd_usbmidi_get_midiman_int_epd(snd_usb_midi_t* umidi)
-{
-	struct usb_interface* intf = umidi->iface;
-	struct usb_host_interface *hostif;
-	struct usb_interface_descriptor *intfd;
-	if (!intf)
-		return NULL;
-	hostif = &intf->altsetting[0];
-	intfd = get_iface_desc(hostif);
-	if (intfd->bNumEndpoints < 1)
-		return NULL;
-	return get_endpoint(hostif, 0);
-}
-
-/*
  * Creates an input endpoint.
  */
 static int snd_usbmidi_in_endpoint_create(snd_usb_midi_t* umidi,
@@ -569,7 +583,6 @@
 					  snd_usb_midi_endpoint_t* rep)
 {
 	snd_usb_midi_in_endpoint_t* ep;
-	struct usb_endpoint_descriptor* int_epd;
 	void* buffer;
 	unsigned int pipe;
 	int length;
@@ -580,17 +593,12 @@
 		return -ENOMEM;
 	ep->umidi = umidi;

-	if (umidi->quirk && umidi->quirk->type == QUIRK_MIDI_MIDIMAN)
-		int_epd = snd_usbmidi_get_midiman_int_epd(umidi);
-	else
-		int_epd = snd_usbmidi_get_int_epd(umidi);
-
 	ep->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!ep->urb) {
 		snd_usbmidi_in_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	if (int_epd)
+	if (ep_info->in_interval)
 		pipe = usb_rcvintpipe(umidi->chip->dev, ep_info->in_ep);
 	else
 		pipe = usb_rcvbulkpipe(umidi->chip->dev, ep_info->in_ep);
@@ -600,10 +608,10 @@
 		snd_usbmidi_in_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	if (int_epd)
+	if (ep_info->in_interval)
 		usb_fill_int_urb(ep->urb, umidi->chip->dev, pipe, buffer, length,
 				 snd_usb_complete_callback(snd_usbmidi_in_urb_complete),
-				 ep, int_epd->bInterval);
+				 ep, ep_info->in_interval);
 	else
 		usb_fill_bulk_urb(ep->urb, umidi->chip->dev, pipe, buffer, length,
 				  snd_usb_complete_callback(snd_usbmidi_in_urb_complete),
@@ -660,16 +668,25 @@
 		snd_usbmidi_out_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	pipe = usb_sndbulkpipe(umidi->chip->dev, ep_info->out_ep);
-	ep->max_transfer = usb_maxpacket(umidi->chip->dev, pipe, 1) & ~3;
+	if (ep_info->out_interval)
+		pipe = usb_sndintpipe(umidi->chip->dev, ep_info->out_ep);
+	else
+		pipe = usb_sndbulkpipe(umidi->chip->dev, ep_info->out_ep);
+	ep->max_transfer = usb_maxpacket(umidi->chip->dev, pipe, 1);
 	buffer = kmalloc(ep->max_transfer, GFP_KERNEL);
 	if (!buffer) {
 		snd_usbmidi_out_endpoint_delete(ep);
 		return -ENOMEM;
 	}
-	usb_fill_bulk_urb(ep->urb, umidi->chip->dev, pipe, buffer,
-			  ep->max_transfer,
-			  snd_usb_complete_callback(snd_usbmidi_out_urb_complete), ep);
+	if (ep_info->out_interval)
+		usb_fill_int_urb(ep->urb, umidi->chip->dev, pipe, buffer,
+				 ep->max_transfer,
+				 snd_usb_complete_callback(snd_usbmidi_out_urb_complete),
+				 ep, ep_info->out_interval);
+	else
+		usb_fill_bulk_urb(ep->urb, umidi->chip->dev, pipe, buffer,
+				  ep->max_transfer,
+				  snd_usb_complete_callback(snd_usbmidi_out_urb_complete), ep);

 	spin_lock_init(&ep->buffer_lock);
 	tasklet_init(&ep->tasklet, snd_usbmidi_out_tasklet, (unsigned long)ep);
@@ -819,6 +836,9 @@
 	/* M-Audio MidiSport 8x8 */
 	{0x0763, 0x1031, 8, "%s Control"},
 	{0x0763, 0x1033, 8, "%s Control"},
+	/* MOTU Fastlane */
+	{0x07fd, 0x0001, 0, "%s MIDI A"},
+	{0x07fd, 0x0001, 1, "%s MIDI B"},
 };

 static void snd_usbmidi_init_substream(snd_usb_midi_t* umidi,
@@ -928,7 +948,8 @@
 	for (i = 0; i < intfd->bNumEndpoints; ++i) {
 		hostep = &hostif->endpoint[i];
 		ep = get_ep_desc(hostep);
-		if ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK)
+		if ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK &&
+		    (ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_INT)
 			continue;
 		ms_ep = (struct usb_ms_endpoint_descriptor*)hostep->extra;
 		if (hostep->extralen < 4 ||
@@ -944,6 +965,8 @@
 				}
 			}
 			endpoints[epidx].out_ep = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+			if ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT)
+				endpoints[epidx].out_interval = ep->bInterval;
 			endpoints[epidx].out_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
 			snd_printdd(KERN_INFO "EP %02X: %d jack(s)\n",
 				    ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
@@ -955,6 +978,8 @@
 				}
 			}
 			endpoints[epidx].in_ep = ep->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+			if ((ep->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT)
+				endpoints[epidx].in_interval = ep->bInterval;
 			endpoints[epidx].in_cables = (1 << ms_ep->bNumEmbMIDIJack) - 1;
 			snd_printdd(KERN_INFO "EP %02X: %d jack(s)\n",
 				    ep->bEndpointAddress, ms_ep->bNumEmbMIDIJack);
@@ -964,38 +989,93 @@
 }

 /*
- * If the endpoints aren't specified, use the first bulk endpoints in the
- * first alternate setting of the interface.
+ * On Roland devices, use the second alternate setting to be able to use
+ * the interrupt input endpoint.
+ */
+static void snd_usbmidi_switch_roland_altsetting(snd_usb_midi_t* umidi)
+{
+	struct usb_interface* intf;
+	struct usb_host_interface *hostif;
+	struct usb_interface_descriptor* intfd;
+
+	intf = umidi->iface;
+	if (!intf || intf->num_altsetting != 2)
+		return;
+
+	hostif = &intf->altsetting[1];
+	intfd = get_iface_desc(hostif);
+	if (intfd->bNumEndpoints != 2 ||
+	    (get_endpoint(hostif, 0)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK ||
+	    (get_endpoint(hostif, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_INT)
+		return;
+
+	snd_printdd(KERN_INFO "switching to altsetting %d with int ep\n",
+		    intfd->bAlternateSetting);
+	usb_set_interface(umidi->chip->dev, intfd->bInterfaceNumber,
+			  intfd->bAlternateSetting);
+}
+
+/*
+ * Try to find any usable endpoints in the interface.
  */
-static int snd_usbmidi_detect_endpoint(snd_usb_midi_t* umidi,
-				       snd_usb_midi_endpoint_info_t* endpoint)
+static int snd_usbmidi_detect_endpoints(snd_usb_midi_t* umidi,
+					snd_usb_midi_endpoint_info_t* endpoint,
+					int max_endpoints)
 {
 	struct usb_interface* intf;
 	struct usb_host_interface *hostif;
 	struct usb_interface_descriptor* intfd;
 	struct usb_endpoint_descriptor* epd;
-	int i;
+	int i, out_eps = 0, in_eps = 0;
+
+	if (umidi->chip->dev->descriptor.idVendor == 0x0582)
+		snd_usbmidi_switch_roland_altsetting(umidi);

 	intf = umidi->iface;
 	if (!intf || intf->num_altsetting < 1)
 		return -ENOENT;
 	hostif = intf->altsetting;
 	intfd = get_iface_desc(hostif);
-	if (intfd->bNumEndpoints < 1)
-		return -ENOENT;

 	for (i = 0; i < intfd->bNumEndpoints; ++i) {
 		epd = get_endpoint(hostif, i);
-		if ((epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK)
+		if ((epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_BULK &&
+		    (epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_INT)
 			continue;
-		if (!endpoint->out_ep && endpoint->out_cables &&
-		    (epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT)
-			endpoint->out_ep = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-		if (!endpoint->in_ep && endpoint->in_cables &&
-		    (epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_IN)
-			endpoint->in_ep = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+		if (out_eps < max_endpoints &&
+		    (epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT) {
+			endpoint[out_eps].out_ep = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+			if ((epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT)
+				endpoint[out_eps].out_interval = epd->bInterval;
+			++out_eps;
+		}
+		if (in_eps < max_endpoints &&
+		    (epd->bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_IN) {
+			endpoint[in_eps].in_ep = epd->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+			if ((epd->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_INT)
+				endpoint[in_eps].in_interval = epd->bInterval;
+			++in_eps;
+		}
 	}
-	return 0;
+	return (out_eps || in_eps) ? 0 : -ENOENT;
+}
+
+/*
+ * Detects the endpoints for one-port-per-endpoint protocols.
+ */
+static int snd_usbmidi_detect_per_port_endpoints(snd_usb_midi_t* umidi,
+						 snd_usb_midi_endpoint_info_t* endpoints)
+{
+	int err, i;
+
+	err = snd_usbmidi_detect_endpoints(umidi, endpoints, MIDI_MAX_ENDPOINTS);
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		if (endpoints[i].out_ep)
+			endpoints[i].out_cables = 0x0001;
+		if (endpoints[i].in_ep)
+			endpoints[i].in_cables = 0x0001;
+	}
+	return err;
 }

 /*
@@ -1034,7 +1114,7 @@
 	if (!endpoint->in_cables && !endpoint->out_cables)
 		return -ENOENT;

-	return snd_usbmidi_detect_endpoint(umidi, endpoint);
+	return snd_usbmidi_detect_endpoints(umidi, endpoint, 1);
 }

 /*
@@ -1098,11 +1178,11 @@
 		return err;

 	ep_info.in_ep = get_endpoint(hostif, 0)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
+	ep_info.in_interval = get_endpoint(hostif, 0)->bInterval;
 	ep_info.in_cables = endpoint->in_cables;
 	err = snd_usbmidi_in_endpoint_create(umidi, &ep_info, &umidi->endpoints[0]);
 	if (err < 0)
 		return err;
-	umidi->endpoints[0].in->urb->complete = snd_usb_complete_callback(snd_usbmidi_in_midiman_complete);

 	if (endpoint->out_cables > 0x0001) {
 		ep_info.out_ep = get_endpoint(hostif, 4)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
@@ -1203,6 +1283,7 @@
 	umidi->chip = chip;
 	umidi->iface = iface;
 	umidi->quirk = quirk;
+	umidi->usb_protocol_ops = &snd_usbmidi_standard_ops;

 	/* detect the endpoint(s) to use */
 	memset(endpoints, 0, sizeof(endpoints));
@@ -1213,16 +1294,25 @@
 		case QUIRK_MIDI_FIXED_ENDPOINT:
 			memcpy(&endpoints[0], quirk->data,
 			       sizeof(snd_usb_midi_endpoint_info_t));
-			err = snd_usbmidi_detect_endpoint(umidi, &endpoints[0]);
+			err = snd_usbmidi_detect_endpoints(umidi, &endpoints[0], 1);
 			break;
 		case QUIRK_MIDI_YAMAHA:
 			err = snd_usbmidi_detect_yamaha(umidi, &endpoints[0]);
 			break;
 		case QUIRK_MIDI_MIDIMAN:
+			umidi->usb_protocol_ops = &snd_usbmidi_midiman_ops;
 			memcpy(&endpoints[0], quirk->data,
 			       sizeof(snd_usb_midi_endpoint_info_t));
 			err = 0;
 			break;
+		case QUIRK_MIDI_NOVATION:
+			umidi->usb_protocol_ops = &snd_usbmidi_novation_ops;
+			err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
+			break;
+		case QUIRK_MIDI_MOTU:
+			umidi->usb_protocol_ops = &snd_usbmidi_motu_ops;
+			err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
+			break;
 		default:
 			snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 			err = -ENXIO;
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.40
diff -u -r1.40 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	21 Jan 2005 08:32:12 -0000	1.40
+++ alsa-kernel/usb/usbquirks.h	26 Jan 2005 15:56:47 -0000
@@ -1018,16 +1018,25 @@

 /* Mark of the Unicorn devices */
 {
-	/* thanks to Woodley Packard <sweaglesw-xkjw8jzYmaJgTr1v86gaP5cPDiHTxzko@public.gmane.org> */
+	/* thanks to Robert A. Lerche <ral 'at' msbit.com> */
 	USB_DEVICE(0x07fd, 0x0001),
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "MOTU",
 		.product_name = "Fastlane",
-		.ifnum = 1,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.out_cables = 0x0003,
-			.in_cables  = 0x0003
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const snd_usb_audio_quirk_t[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_MIDI_MOTU
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
 		}
 	}
 },
@@ -1053,6 +1062,35 @@
 	}
 },

+/* Novation EMS devices */
+{
+	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Novation",
+		.product_name = "ReMOTE Audio/XStation",
+		.ifnum = 4,
+		.type = QUIRK_MIDI_NOVATION
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0002),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Novation",
+		.product_name = "Speedio",
+		.ifnum = 3,
+		.type = QUIRK_MIDI_NOVATION
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x1235, 0x4661),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Novation",
+		.product_name = "ReMOTE25",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_NOVATION
+	}
+},
+
 {
 	/*
 	 * Some USB MIDI devices don't have an audio control interface,
