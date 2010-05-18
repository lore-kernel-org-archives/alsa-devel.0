From: Krzysztof Foltman <wdev@foltman.com>
Subject: [PATCH 1/1] ALSA: usb-audio: add support for Akai MPD16
Date: Tue, 18 May 2010 19:37:56 +0100
Message-ID: <1274207876-3215-1-git-send-email-wdev@foltman.com>
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

The decoding routine is based on own reverse-engineering. It seems to
recognize all the messages that MPD16 sends during normal operation
(that is, via standard MIDI messages).

Configuration (changing pad sensitivity, slider controller and MIDI
notes) is not supported in this version.

Signed-off-by: Krzysztof Foltman <wdev@foltman.com>

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 2c1558c..cce5dbe 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -645,6 +645,33 @@ static struct usb_protocol_ops snd_usbmidi_cme_ops = {
 };
 
 /*
+ * AKAI MPD16 protocol: one or more chunks consisting of first byte of
+ * (0x20 | msg_len) and then a MIDI message (msg_len bytes long)
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
+	while (pos < (unsigned)buffer_length && (buffer[pos] & 0xF8) == 0x20) {
+		int msg_len = buffer[pos] & 0x0f;
+		snd_usbmidi_input_data(ep, 0, &buffer[pos + 1], msg_len);
+		pos += 1 + msg_len;
+	}
+}
+
+static struct usb_protocol_ops snd_usbmidi_akai_ops = {
+	.input = snd_usbmidi_akai_input,
+	.output = snd_usbmidi_standard_output,
+	.output_packet = snd_usbmidi_output_standard_packet,
+};
+
+/*
  * Novation USB MIDI protocol: number of data bytes is in the first byte
  * (when receiving) (+1!) or in the second byte (when sending); data begins
  * at the third byte.
@@ -1434,6 +1461,8 @@ static struct port_info {
 	EXTERNAL_PORT(0x086a, 0x0001, 8, "%s Broadcast"),
 	EXTERNAL_PORT(0x086a, 0x0002, 8, "%s Broadcast"),
 	EXTERNAL_PORT(0x086a, 0x0003, 4, "%s Broadcast"),
+	/* Akai MPD16 */
+	EXTERNAL_PORT(0x09e8, 0x0062, 0, "%s MIDI"),
 	/* Access Music Virus TI */
 	EXTERNAL_PORT(0x133e, 0x0815, 0, "%s MIDI"),
 	PORT_INFO(0x133e, 0x0815, 1, "%s Synth", 0,
@@ -2035,6 +2064,13 @@ int snd_usbmidi_create(struct snd_card *card,
 		umidi->usb_protocol_ops = &snd_usbmidi_cme_ops;
 		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
+	case QUIRK_MIDI_AKAI:
+		umidi->usb_protocol_ops = &snd_usbmidi_akai_ops;
+		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
+		/* endpoint 0 does not carry MIDI data */
+		endpoints[0].out_cables = 0;
+		endpoints[0].in_cables = 0;
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
index 91ddef3..7ecad05 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1973,6 +1973,17 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+/* AKAI devices */
+{
+	USB_DEVICE(0x09e8, 0x0062),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
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
