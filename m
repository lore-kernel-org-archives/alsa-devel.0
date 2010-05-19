From: Krzysztof Foltman <wdev@foltman.com>
Subject: [PATCH 1/1] ALSA: usb-audio: add support for Akai MPD16
Date: Wed, 19 May 2010 21:06:19 +0100
Message-ID: <1274299579-12990-1-git-send-email-wdev@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Krzysztof Foltman <wdev@foltman.com>
List-Id: alsa-devel@alsa-project.org

The decoding/encoding is based on own reverse-engineering. Both control and
data ports are handled. Writing to control port supports SysEx events only,
as this is the only type of messages that MPD16 recognizes.

Signed-off-by: Krzysztof Foltman <wdev@foltman.com>

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 2c1558c..d669feb 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -434,7 +434,7 @@ static void snd_usbmidi_maudio_broken_running_status_input(
 			u8 cin = buffer[i] & 0x0f;
 			struct usbmidi_in_port *port = &ep->ports[cable];
 			int length;
-			
+
 			length = snd_usbmidi_cin_length[cin];
 			if (cin == 0xf && buffer[i + 1] >= 0xf8)
 				; /* realtime msg: no running status change */
@@ -628,13 +628,13 @@ static struct usb_protocol_ops snd_usbmidi_standard_ops = {
 
 static struct usb_protocol_ops snd_usbmidi_midiman_ops = {
 	.input = snd_usbmidi_midiman_input,
-	.output = snd_usbmidi_standard_output, 
+	.output = snd_usbmidi_standard_output,
 	.output_packet = snd_usbmidi_output_midiman_packet,
 };
 
 static struct usb_protocol_ops snd_usbmidi_maudio_broken_running_status_ops = {
 	.input = snd_usbmidi_maudio_broken_running_status_input,
-	.output = snd_usbmidi_standard_output, 
+	.output = snd_usbmidi_standard_output,
 	.output_packet = snd_usbmidi_output_standard_packet,
 };
 
@@ -645,6 +645,110 @@ static struct usb_protocol_ops snd_usbmidi_cme_ops = {
 };
 
 /*
+ * AKAI MPD16 protocol:
+ *
+ * For control port (endpoint 1):
+ * ==============================
+ * One or more chunks consisting of first byte of (0x10 | msg_len) and then a
+ * SysEx message (msg_len=9 bytes long):
+ *
+ *     F0 47 62 60 aa bb cc xx F7 (xx = (aa + bb + cc) & 0x7F)
+ *
+ * aa bb cc
+ * --------
+ * 10 01 7E  edit mode on?
+ * 10 01 00  edit mode off?
+ * 10 04 7F  select bank 1
+ * 10 04 00  select bank 0
+ * 11 pp nn  set pad pp to send note nn
+ * 12 pp ss  set sensitivity on pad pp to ss
+ * 13 00 cc  set slider CC number to cc
+ * 14 00 cc  set MIDI channel to cc
+ * 15 01 pp  request note number for pad pp (returns 20 pp nn)
+ * 15 02 pp  request sensitivity for pad pp (returns 21 pp ss)
+ * 15 03 00  request slider CC number (returns 22 00 cc)
+ * 15 05 00  request MIDI channel number (returns 23 00 cc)
+ *
+ * For data port (endpoint 2):
+ * ===========================
+ * One or more chunks consisting of first byte of (0x20 | msg_len) and then a
+ * MIDI message (msg_len bytes long)
+ *
+ * Messages sent:
+ * 21 FE (active sense)
+ * 23 90 xx xx (note on)
+ * 23 Ax xx xx (polyphonic pressure)
+ * 23 Bx xx xx (control change)
+ */
+static void snd_usbmidi_akai_input(struct snd_usb_midi_in_endpoint *ep,
+				   uint8_t *buffer, int buffer_length)
+{
+	unsigned int pos = 0;
+	unsigned int len = (unsigned int)buffer_length;
+	while (pos < len) {
+		int port = (buffer[pos] >> 4) - 1;
+		unsigned int msg_len = buffer[pos] & 0x0f;
+		pos++;
+		if (pos + msg_len <= len && (port == 0 || port == 1))
+			snd_usbmidi_input_data(ep, 0, &buffer[pos], msg_len);
+		pos += msg_len;
+	}
+}
+
+static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
+				    struct urb *urb)
+{
+	uint8_t *msg;
+	uint8_t *plen = &ep->ports[0].data[0]; /* length so far */
+	int count;
+	uint8_t tmp;
+
+	if (!ep->ports[0].active)
+		return;
+
+	msg = urb->transfer_buffer + urb->transfer_buffer_length;
+
+	/* only try adding more data when there's space for at least 1 SysEx */
+	while (urb->transfer_buffer_length + 16 < ep->max_transfer) {
+		count = snd_rawmidi_transmit(ep->ports[0].substream, &tmp, 1);
+		if (count < 1) {
+			ep->ports[0].active = 0;
+			return;
+		}
+		if (ep->ports[0].state == STATE_UNKNOWN) {
+			/* only accept SysEx'es, skip everything else */
+			if (tmp != 0xF0)
+				continue;
+			/* start accumulating SysEx data */
+			*plen = 0x00;
+			ep->ports[0].state = STATE_SYSEX_0;
+		}
+		if (*plen > 14) {
+			/* SysEx too long, drop it and start over */
+			ep->ports[0].state = STATE_UNKNOWN;
+			continue;
+		}
+		msg[++(*plen)] = tmp;
+		if (tmp == 0xF7) {
+			/* add total size (w/hdr) to length-to-transfer */
+			urb->transfer_buffer_length += 1 + *plen;
+			/* set port number nibble in the header */
+			msg[0] = 0x10 | *plen;
+			msg += 1 + *plen;
+
+			/* go back to waiting for SysEx */
+			ep->ports[0].state = STATE_UNKNOWN;
+			continue;
+		}
+	}
+}
+
+static struct usb_protocol_ops snd_usbmidi_akai_ops = {
+	.input = snd_usbmidi_akai_input,
+	.output = snd_usbmidi_akai_output,
+};
+
+/*
  * Novation USB MIDI protocol: number of data bytes is in the first byte
  * (when receiving) (+1!) or in the second byte (when sending); data begins
  * at the third byte.
@@ -1434,6 +1538,9 @@ static struct port_info {
 	EXTERNAL_PORT(0x086a, 0x0001, 8, "%s Broadcast"),
 	EXTERNAL_PORT(0x086a, 0x0002, 8, "%s Broadcast"),
 	EXTERNAL_PORT(0x086a, 0x0003, 4, "%s Broadcast"),
+	/* Akai MPD16 */
+	CONTROL_PORT(0x09e8, 0x0062, 0, "%s Control"),
+	EXTERNAL_PORT(0x09e8, 0x0062, 1, "%s MIDI"),
 	/* Access Music Virus TI */
 	EXTERNAL_PORT(0x133e, 0x0815, 0, "%s MIDI"),
 	PORT_INFO(0x133e, 0x0815, 1, "%s Synth", 0,
@@ -1707,7 +1814,7 @@ static int snd_usbmidi_detect_endpoints(struct snd_usb_midi* umidi,
 		snd_usbmidi_switch_roland_altsetting(umidi);
 
 	if (endpoint[0].out_ep || endpoint[0].in_ep)
-		return 0;	
+		return 0;
 
 	intf = umidi->iface;
 	if (!intf || intf->num_altsetting < 1)
@@ -1745,7 +1852,7 @@ static int snd_usbmidi_detect_per_port_endpoints(struct snd_usb_midi* umidi,
 						 struct snd_usb_midi_endpoint_info* endpoints)
 {
 	int err, i;
-	
+
 	err = snd_usbmidi_detect_endpoints(umidi, endpoints, MIDI_MAX_ENDPOINTS);
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		if (endpoints[i].out_ep)
@@ -2035,6 +2142,12 @@ int snd_usbmidi_create(struct snd_card *card,
 		umidi->usb_protocol_ops = &snd_usbmidi_cme_ops;
 		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
+	case QUIRK_MIDI_AKAI:
+		umidi->usb_protocol_ops = &snd_usbmidi_akai_ops;
+		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
+		/* endpoint 1 is input-only */
+		endpoints[1].out_cables = 0;
+		break;
 	default:
 		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 		err = -ENXIO;
diff --git a/sound/usb/midi.h b/sound/usb/midi.h
index 2089ec9..2fca80b 100644
--- a/sound/usb/midi.h
+++ b/sound/usb/midi.h
@@ -37,6 +37,8 @@ struct snd_usb_midi_endpoint_info {
 
 /* for QUIRK_MIDI_CME, data is NULL */
 
+/* for QUIRK_MIDI_AKAI, data is NULL */
+
 int snd_usbmidi_create(struct snd_card *card,
 		       struct usb_interface *iface,
 		       struct list_head *midi_list,
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 91ddef3..f8797f6 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1973,6 +1973,17 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+/* AKAI devices */
+{
+	USB_DEVICE(0x09e8, 0x0062),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "AKAI",
+		.product_name = "MPD16",
+		.ifnum = 0,
+		.type = QUIRK_MIDI_AKAI,
+	}
+},
+
 /* TerraTec devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0012),
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 136e5b4..b45e54c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -289,6 +289,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_FASTLANE] = create_any_midi_quirk,
 		[QUIRK_MIDI_EMAGIC] = create_any_midi_quirk,
 		[QUIRK_MIDI_CME] = create_any_midi_quirk,
+		[QUIRK_MIDI_AKAI] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index d679e72..06ebf24 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -74,6 +74,7 @@ enum quirk_type {
 	QUIRK_MIDI_FASTLANE,
 	QUIRK_MIDI_EMAGIC,
 	QUIRK_MIDI_CME,
+	QUIRK_MIDI_AKAI,
 	QUIRK_MIDI_US122L,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
-- 
1.7.0.4
