From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Novation USB-MIDI support
Date: Thu, 20 Jan 2005 12:01:33 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501201157510.401-100000@studcom.urz.uni-halle.de>
References: <200501200321.21151.Pavel.Vondricka@ff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200501200321.21151.Pavel.Vondricka@ff.cuni.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pavel Vondricka <Pavel.Vondricka@ff.cuni.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pavel Vondricka wrote:
> two months ago an employee from Novation offered documentation to the their
> non-standard-compliant MIDI-over-USB protocol in this list. Clemens Ladisch
> was willing to implement it and Eric Dantan Rzewnicki to test it.

The patch against the current CVS is below.  If you don't use CVS, you
can download the four changed files from
<http://www.informatik.uni-halle.de/~ladischc/nov.tar.gz>.

So far, it's completely untested.


HTH
Clemens

-- 
Index: alsa-driver/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usbmidi.c,v
retrieving revision 1.14
diff -u -r1.14 usbmidi.c
--- alsa-driver/usb/usbmidi.c	3 Aug 2004 14:24:05 -0000	1.14
+++ alsa-driver/usb/usbmidi.c	19 Jan 2005 15:07:00 -0000
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
+++ alsa-kernel/usb/usbaudio.c	19 Jan 2005 15:07:01 -0000
@@ -2965,6 +2965,7 @@
 	case QUIRK_MIDI_FIXED_ENDPOINT:
 	case QUIRK_MIDI_YAMAHA:
 	case QUIRK_MIDI_MIDIMAN:
+	case QUIRK_MIDI_NOVATION:
 		return snd_usb_create_midi_interface(chip, iface, quirk);
 	case QUIRK_COMPOSITE:
 		return create_composite_quirk(chip, iface, quirk);
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.36
diff -u -r1.36 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	17 Jan 2005 17:41:38 -0000	1.36
+++ alsa-kernel/usb/usbaudio.h	19 Jan 2005 15:07:01 -0000
@@ -158,6 +158,7 @@
 #define QUIRK_AUDIO_EDIROL_UA700_UA25	7
 #define QUIRK_AUDIO_EDIROL_UA1000	8
 #define QUIRK_IGNORE_INTERFACE		9
+#define QUIRK_MIDI_NOVATION		10

 typedef struct snd_usb_audio_quirk snd_usb_audio_quirk_t;
 typedef struct snd_usb_midi_endpoint_info snd_usb_midi_endpoint_info_t;
@@ -193,6 +194,9 @@

 /* for QUIRK_IGNORE_INTERFACE, data is null */

+/* for QUIRK_MIDI_NOVATION, data is the maximum number of MIDI data bytes
+ * in output packets */
+
 /*
  */

Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.35
diff -u -r1.35 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	29 Nov 2004 14:09:48 -0000	1.35
+++ alsa-kernel/usb/usbmidi.c	19 Jan 2005 15:07:01 -0000
@@ -77,11 +77,17 @@
 typedef struct usbmidi_out_port usbmidi_out_port_t;
 typedef struct usbmidi_in_port usbmidi_in_port_t;

+struct usb_protocol_ops {
+	void (*input)(snd_usb_midi_in_endpoint_t*, uint8_t*, int);
+	void (*output)(snd_usb_midi_out_endpoint_t*);
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
@@ -156,23 +162,53 @@
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
+		snd_printd("unexpected port %d!\n", port);
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
+	for (i = 0; i + 4 <= buffer_length; i += 4)
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
+	for (i = 0; i + 4 <= buffer_length; i += 4)
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
+	if (buffer_length < 2 || buffer_length < buffer[0] + 1)
+		return;
+	snd_usbmidi_input_data(&ep->ports[0], &buffer[2], buffer[0] - 1);
 }

 /*
@@ -183,12 +219,8 @@
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
@@ -200,38 +232,6 @@
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
@@ -389,13 +389,42 @@
 	}
 }

+static void snd_usbmidi_standard_output(snd_usb_midi_out_endpoint_t* ep)
+{
+	int p;
+
+	for (p = 0; p < 0x10; ++p)
+		if (ep->ports[p].active)
+			snd_usbmidi_transmit(ep, p);
+}
+
+static void snd_usbmidi_novation_output(snd_usb_midi_out_endpoint_t* ep)
+{
+	int count;
+	uint8_t buffer[30];
+
+	if (!ep->ports[0].active)
+		return;
+	count = ep->max_transfer - 2;
+	if (count > (int)ep->umidi->quirk->data)
+		count = (int)ep->umidi->quirk->data;
+	count = snd_rawmidi_transmit(ep->ports[0].substream, buffer, count);
+	if (count < 1) {
+		ep->ports[0].active = 0;
+		return;
+	}
+	memset(ep->urb->transfer_buffer, 0, ep->max_transfer);
+	((uint8_t*)ep->urb->transfer_buffer)[1] = count;
+	memcpy(&((uint8_t*)ep->urb->transfer_buffer)[2], buffer, count);
+	ep->urb->transfer_buffer_length = ep->max_transfer;
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

@@ -406,9 +435,7 @@
 	}

 	urb->transfer_buffer_length = 0;
-	for (p= 0; p < 0x10; ++p)
-		if (ep->ports[p].active)
-			snd_usbmidi_transmit(ep, p);
+	ep->umidi->usb_protocol_ops->output(ep);

 	if (urb->transfer_buffer_length > 0) {
 		if (ep->umidi->quirk && ep->umidi->quirk->type == QUIRK_MIDI_MIDIMAN)
@@ -427,6 +454,22 @@
 	snd_usbmidi_do_output(ep);
 }

+static struct usb_protocol_ops snd_usbmidi_standard_ops = {
+	.input = snd_usbmidi_standard_input,
+	.output = snd_usbmidi_standard_output,
+};
+
+static struct usb_protocol_ops snd_usbmidi_midiman_ops = {
+	.input = snd_usbmidi_midiman_input,
+	.output = snd_usbmidi_standard_output,
+	/* output munging is done in snd_usbmidi_convert_to_midiman() */
+};
+
+static struct usb_protocol_ops snd_usbmidi_novation_ops = {
+	.input = snd_usbmidi_novation_input,
+	.output = snd_usbmidi_novation_output,
+};
+
 static int snd_usbmidi_output_open(snd_rawmidi_substream_t* substream)
 {
 	snd_usb_midi_t* umidi = substream->rmidi->private_data;
@@ -1102,7 +1145,6 @@
 	err = snd_usbmidi_in_endpoint_create(umidi, &ep_info, &umidi->endpoints[0]);
 	if (err < 0)
 		return err;
-	umidi->endpoints[0].in->urb->complete = snd_usb_complete_callback(snd_usbmidi_in_midiman_complete);

 	if (endpoint->out_cables > 0x0001) {
 		ep_info.out_ep = get_endpoint(hostif, 4)->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
@@ -1203,6 +1245,7 @@
 	umidi->chip = chip;
 	umidi->iface = iface;
 	umidi->quirk = quirk;
+	umidi->usb_protocol_ops = &snd_usbmidi_standard_ops;

 	/* detect the endpoint(s) to use */
 	memset(endpoints, 0, sizeof(endpoints));
@@ -1221,8 +1264,15 @@
 		case QUIRK_MIDI_MIDIMAN:
 			memcpy(&endpoints[0], quirk->data,
 			       sizeof(snd_usb_midi_endpoint_info_t));
+			umidi->usb_protocol_ops = &snd_usbmidi_midiman_ops;
 			err = 0;
 			break;
+		case QUIRK_MIDI_NOVATION:
+			endpoints[0].out_cables = 0x0001;
+			endpoints[0].in_cables = 0x0001;
+			umidi->usb_protocol_ops = &snd_usbmidi_novation_ops;
+			err = snd_usbmidi_detect_endpoint(umidi, &endpoints[0]);
+			break;
 		default:
 			snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 			err = -ENXIO;
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.39
diff -u -r1.39 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	17 Jan 2005 17:41:38 -0000	1.39
+++ alsa-kernel/usb/usbquirks.h	19 Jan 2005 15:07:01 -0000
@@ -1047,6 +1047,38 @@
 	}
 },

+/* Novation EMS devices */
+{
+	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Novation",
+		.product_name = "XStation", /* "ReMOTE Audio" ??? */
+		.ifnum = 4,
+		.type = QUIRK_MIDI_NOVATION,
+		.data = (const void*)30
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0002),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Novation",
+		.product_name = "Speedio",
+		.ifnum = 3,
+		.type = QUIRK_MIDI_NOVATION,
+		.data = (const void*)12
+	}
+},
+{
+	USB_DEVICE_VENDOR_SPEC(0x1235, 0x4661),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "Novation",
+		.product_name = "ReMOTE25",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_NOVATION,
+		.data = (const void*)30
+	}
+},
+
 {
 	/*
 	 * Some USB MIDI devices don't have an audio control interface,



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
