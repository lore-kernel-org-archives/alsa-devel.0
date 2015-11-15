From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/3] ALSA: usb-audio: prevent CH345 multiport
	output SysEx	corruption
Date: Sun, 15 Nov 2015 22:38:29 +0100
Message-ID: <5648FB55.1000406@ladisch.de>
References: <5648FAED.8020300@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B5C17261615
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 22:39:23 +0100 (CET)
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

The CH345 USB MIDI chip has two output ports.  However, they are
multiplexed through one pin, and the number of ports cannot be reduced
even for hardware that implements only one connector, so for those
devices, data sent to either port ends up on the same hardware output.
This becomes a problem when both ports are used at the same time, as
longer MIDI commands (such as SysEx messages) are likely to be
interrupted by messages from the other port, and thus to get lost.

It would not be possible for the driver to detect how many ports the
device actually has, except that in practice, _all_ devices built with
the CH345 have only one port.  So we can just ignore the device's
descriptors, and hardcode one output port.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
Cc: stable@vger.kernel.org
---
 sound/usb/midi.c         |    3 +++
 sound/usb/quirks-table.h |   11 +++++++++++
 sound/usb/quirks.c       |    1 +
 sound/usb/usbaudio.h     |    1 +
 4 files changed, 16 insertions(+)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 68e9f9a..010094a 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2379,6 +2379,9 @@ int snd_usbmidi_create(struct snd_card *card,

 		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
 		break;
+	case QUIRK_MIDI_CH345:
+		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
+		break;
 	default:
 		dev_err(&umidi->dev->dev, "invalid quirk type %d\n",
 			quirk->type);
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 1a1e2e4..c60a776 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2829,6 +2829,17 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	.idProduct = 0x1020,
 },

+/* QinHeng devices */
+{
+	USB_DEVICE(0x1a86, 0x752d),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "QinHeng",
+		.product_name = "CH345",
+		.ifnum = 1,
+		.type = QUIRK_MIDI_CH345
+	}
+},
+
 /* KeithMcMillen Stringport */
 {
 	USB_DEVICE(0x1f38, 0x0001),
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 75a9d4b..f529102 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -538,6 +538,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_CME] = create_any_midi_quirk,
 		[QUIRK_MIDI_AKAI] = create_any_midi_quirk,
 		[QUIRK_MIDI_FTDI] = create_any_midi_quirk,
+		[QUIRK_MIDI_CH345] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 15a1271..b665d85 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -95,6 +95,7 @@ enum quirk_type {
 	QUIRK_MIDI_AKAI,
 	QUIRK_MIDI_US122L,
 	QUIRK_MIDI_FTDI,
+	QUIRK_MIDI_CH345,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UAXX,
