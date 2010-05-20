From: Krzysztof Foltman <wdev@foltman.com>
Subject: [PATCH 1/1] ALSA: usb-audio: add support for Akai MPD16
Date: Thu, 20 May 2010 20:31:10 +0100
Message-ID: <1274383870-5452-1-git-send-email-wdev@foltman.com>
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
index 2c1558c..9c23d89 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -645,6 +645,105 @@ static struct usb_protocol_ops snd_usbmidi_cme_ops = {
 };
 
 /*
+ * AKAI MPD16 protocol:
+ *
+ * For control port (endpoint 1):
+ * ==============================
+ * One or more chunks consisting of first byte of (0x10 | msg_len) and then a
+ * SysEx message (msg_len=9 bytes long).
+ *
+ * For data port (endpoint 2):
+ * ===========================
+ * One or more chunks consisting of first byte of (0x20 | msg_len) and then a
+ * MIDI message (msg_len bytes long)
+ *
+ * Messages sent: Active Sense, Note On, Poly Pressure, Control Change.
+ */
+static void snd_usbmidi_akai_input(struct snd_usb_midi_in_endpoint *ep,
+				   uint8_t *buffer, int buffer_length)
+{
+	unsigned int pos = 0;
+	unsigned int len = (unsigned int)buffer_length;
+	while (pos < len) {
+		unsigned int port = (buffer[pos] >> 4) - 1;
+		unsigned int msg_len = buffer[pos] & 0x0f;
+		pos++;
+		if (pos + msg_len <= len && port < 2)
+			snd_usbmidi_input_data(ep, 0, &buffer[pos], msg_len);
+		pos += msg_len;
+	}
+}
+
+#define MAX_AKAI_SYSEX_LEN 9
+
+static void snd_usbmidi_akai_output(struct snd_usb_midi_out_endpoint *ep,
+				    struct urb *urb)
+{
+	uint8_t *msg;
+	int pos, end, count, buf_end;
+	uint8_t tmp[MAX_AKAI_SYSEX_LEN];
+	struct snd_rawmidi_substream *substream = ep->ports[0].substream;
+
+	if (!ep->ports[0].active)
+		return;
+
+	msg = urb->transfer_buffer + urb->transfer_buffer_length;
+	buf_end = ep->max_transfer - MAX_AKAI_SYSEX_LEN - 1;
+
+	/* only try adding more data when there's space for at least 1 SysEx */
+	while (urb->transfer_buffer_length < buf_end) {
+		count = snd_rawmidi_transmit_peek(substream,
+						  tmp, MAX_AKAI_SYSEX_LEN);
+		if (!count) {
+			ep->ports[0].active = 0;
+			return;
+		}
+		/* try to skip non-SysEx data */
+		for (pos = 0; pos < count && tmp[pos] != 0xF0; pos++)
+			;
+
+		if (pos > 0) {
+			snd_rawmidi_transmit_ack(substream, pos);
+			continue;
+		}
+
+		/* look for the start or end marker */
+		for (end = 1; end < count && tmp[end] < 0xF0; end++)
+			;
+
+		/* next SysEx started before the end of current one */
+		if (end < count && tmp[end] == 0xF0) {
+			/* it's incomplete - drop it */
+			snd_rawmidi_transmit_ack(substream, end);
+			continue;
+		}
+		/* SysEx complete */
+		if (end < count && tmp[end] == 0xF7) {
+			/* queue it, ack it, and get the next one */
+			count = end + 1;
+			msg[0] = 0x10 | count;
+			memcpy(&msg[1], tmp, count);
+			snd_rawmidi_transmit_ack(substream, count);
+			urb->transfer_buffer_length += count + 1;
+			msg += count + 1;
+			continue;
+		}
+		/* less than 9 bytes and no end byte - wait for more */
+		if (count < MAX_AKAI_SYSEX_LEN) {
+			ep->ports[0].active = 0;
+			return;
+		}
+		/* 9 bytes and no end marker in sight - malformed, skip it */
+		snd_rawmidi_transmit_ack(substream, count);
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
@@ -1434,6 +1533,11 @@ static struct port_info {
 	EXTERNAL_PORT(0x086a, 0x0001, 8, "%s Broadcast"),
 	EXTERNAL_PORT(0x086a, 0x0002, 8, "%s Broadcast"),
 	EXTERNAL_PORT(0x086a, 0x0003, 4, "%s Broadcast"),
+	/* Akai MPD16 */
+	CONTROL_PORT(0x09e8, 0x0062, 0, "%s Control"),
+	PORT_INFO(0x09e8, 0x0062, 1, "%s MIDI", 0,
+		SNDRV_SEQ_PORT_TYPE_MIDI_GENERIC |
+		SNDRV_SEQ_PORT_TYPE_HARDWARE),
 	/* Access Music Virus TI */
 	EXTERNAL_PORT(0x133e, 0x0815, 0, "%s MIDI"),
 	PORT_INFO(0x133e, 0x0815, 1, "%s Synth", 0,
@@ -2035,6 +2139,12 @@ int snd_usbmidi_create(struct snd_card *card,
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
