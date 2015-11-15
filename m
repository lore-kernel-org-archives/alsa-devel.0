From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/3] ALSA: usb-audio: work around CH345 input
	SysEx corruption
Date: Sun, 15 Nov 2015 22:39:08 +0100
Message-ID: <5648FB7C.9060500@ladisch.de>
References: <5648FAED.8020300@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2C9DB2606FE
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 22:40:05 +0100 (CET)
In-Reply-To: <5648FAED.8020300@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

One of the many faults of the QinHeng CH345 USB MIDI interface chip is
that it does not handle received SysEx messages correctly -- every second
event packet has a wrong code index number, which is the one from the last
seen message, instead of 4.  For example, the two messages "FE F0 01 02 03
04 05 06 07 08 09 0A 0B 0C 0D 0E F7" result in the following event
packets:

correct:       CH345:
0F FE 00 00    0F FE 00 00
04 F0 01 02    04 F0 01 02
04 03 04 05    0F 03 04 05
04 06 07 08    04 06 07 08
04 09 0A 0B    0F 09 0A 0B
04 0C 0D 0E    04 0C 0D 0E
05 F7 00 00    05 F7 00 00

A class-compliant driver must interpret an event packet with CIN 15 as
having a single data byte, so the other two bytes would be ignored.  The
message received by the host would then be missing two bytes out of six;
in this example, "F0 01 02 03 06 07 08 09 0C 0D 0E F7".

These corrupted SysEx event packages contain only data bytes, while the
CH345 uses event packets with a correct CIN value only for messages with
a status byte, so it is possible to distinguish between these two cases by
checking for the presence of this status byte.

(Other bugs in the CH345's input handling, such as the corruption resulting
from running status, cannot be worked around.)

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
Cc: stable@vger.kernel.org
---
 sound/usb/midi.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 010094a..5b4c58c 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -174,6 +174,8 @@ struct snd_usb_midi_in_endpoint {
 		u8 running_status_length;
 	} ports[0x10];
 	u8 seen_f5;
+	bool in_sysex;
+	u8 last_cin;
 	u8 error_resubmit;
 	int current_port;
 };
@@ -468,6 +470,39 @@ static void snd_usbmidi_maudio_broken_running_status_input(
 }

 /*
+ * QinHeng CH345 is buggy: every second packet inside a SysEx has not CIN 4
+ * but the previously seen CIN, but still with three data bytes.
+ */
+static void ch345_broken_sysex_input(struct snd_usb_midi_in_endpoint *ep,
+				     uint8_t *buffer, int buffer_length)
+{
+	unsigned int i, cin, length;
+
+	for (i = 0; i + 3 < buffer_length; i += 4) {
+		if (buffer[i] == 0 && i > 0)
+			break;
+		cin = buffer[i] & 0x0f;
+		if (ep->in_sysex &&
+		    cin == ep->last_cin &&
+		    (buffer[i + 1 + (cin == 0x6)] & 0x80) == 0)
+			cin = 0x4;
+#if 0
+		if (buffer[i + 1] == 0x90) {
+			/*
+			 * Either a corrupted running status or a real note-on
+			 * message; impossible to detect reliably.
+			 */
+		}
+#endif
+		length = snd_usbmidi_cin_length[cin];
+		snd_usbmidi_input_data(ep, 0, &buffer[i + 1], length);
+		ep->in_sysex = cin == 0x4;
+		if (!ep->in_sysex)
+			ep->last_cin = cin;
+	}
+}
+
+/*
  * CME protocol: like the standard protocol, but SysEx commands are sent as a
  * single USB packet preceded by a 0x0F byte.
  */
@@ -660,6 +695,12 @@ static struct usb_protocol_ops snd_usbmidi_cme_ops = {
 	.output_packet = snd_usbmidi_output_standard_packet,
 };

+static struct usb_protocol_ops snd_usbmidi_ch345_broken_sysex_ops = {
+	.input = ch345_broken_sysex_input,
+	.output = snd_usbmidi_standard_output,
+	.output_packet = snd_usbmidi_output_standard_packet,
+};
+
 /*
  * AKAI MPD16 protocol:
  *
@@ -2380,6 +2421,7 @@ int snd_usbmidi_create(struct snd_card *card,
 		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
 	case QUIRK_MIDI_CH345:
+		umidi->usb_protocol_ops = &snd_usbmidi_ch345_broken_sysex_ops;
 		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
 	default:
