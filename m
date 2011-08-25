From: Kristian Amlie <kristian@amlie.name>
Subject: [PATCH] Added support for Starr Labs USB MIDI devices.
Date: Thu, 25 Aug 2011 13:35:07 +0200
Message-ID: <1314272107-15239-1-git-send-email-kristian@amlie.name>
References: <4E5631E1.7050400@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from login.amlie.name (242.80-203-43.nextgentel.com [80.203.43.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DC0F2446A
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 13:35:20 +0200 (CEST)
In-Reply-To: <4E5631E1.7050400@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, zonque@gmail.com
Cc: Kristian Amlie <kristian@amlie.name>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Based on a patch by Daniel Mack.
---
 sound/usb/midi.c         |   29 +++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |   11 +++++++++++
 sound/usb/quirks.c       |    1 +
 sound/usb/usbaudio.h     |    1 +
 4 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index f928910..ec7a799 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -816,6 +816,18 @@ static struct usb_protocol_ops snd_usbmidi_raw_ops = {
 	.output = snd_usbmidi_raw_output,
 };
 
+static void snd_usbmidi_ftdi_input(struct snd_usb_midi_in_endpoint* ep,
+				   uint8_t* buffer, int buffer_length)
+{
+	if (buffer_length > 2)
+		snd_usbmidi_input_data(ep, 0, buffer + 2, buffer_length - 2);
+}
+
+static struct usb_protocol_ops snd_usbmidi_ftdi_ops = {
+	.input = snd_usbmidi_ftdi_input,
+	.output = snd_usbmidi_raw_output,
+};
+
 static void snd_usbmidi_us122l_input(struct snd_usb_midi_in_endpoint *ep,
 				     uint8_t *buffer, int buffer_length)
 {
@@ -2073,6 +2085,13 @@ void snd_usbmidi_input_start(struct list_head* p)
 		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
 }
 
+static int snd_usbmidi_ftdi_command(struct snd_usb_midi *umidi,
+				    u8 command, u16 value, u16 index)
+{
+	return usb_control_msg(umidi->dev, usb_sndctrlpipe(umidi->dev, 0),
+				command, 0x40, value, index, NULL, 0, 1000);
+}
+
 /*
  * Creates and registers everything needed for a MIDI streaming interface.
  */
@@ -2163,6 +2182,16 @@ int snd_usbmidi_create(struct snd_card *card,
 		/* endpoint 1 is input-only */
 		endpoints[1].out_cables = 0;
 		break;
+	case QUIRK_MIDI_FTDI:
+		umidi->usb_protocol_ops = &snd_usbmidi_ftdi_ops;
+
+		/* set baud rate */
+		err = snd_usbmidi_ftdi_command(umidi, 3, 0x60, 0);
+		if (err < 0)
+			break;
+
+		err = snd_usbmidi_detect_per_port_endpoints(umidi, endpoints);
+		break;
 	default:
 		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 		err = -ENXIO;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 0b2ae8e..68ca427 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -39,6 +39,17 @@
 	.idProduct = prod, \
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC
 
+/* Starr Labs MIDI USB device */
+{
+	USB_DEVICE(0x0403, 0xb8d8),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		/* .vendor_name = "STARR LABS", */
+		/* .product_name = "Starr Labs MIDI USB device", */
+		.ifnum = 0,
+		.type = QUIRK_MIDI_FTDI
+	}
+},
+
 /* Creative/Toshiba Multimedia Center SB-0500 */
 {
 	USB_DEVICE(0x041e, 0x3048),
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 090e193..65591df 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -306,6 +306,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_EMAGIC] = create_any_midi_quirk,
 		[QUIRK_MIDI_CME] = create_any_midi_quirk,
 		[QUIRK_MIDI_AKAI] = create_any_midi_quirk,
+		[QUIRK_MIDI_FTDI] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 1e79986..3e2b035 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -80,6 +80,7 @@ enum quirk_type {
 	QUIRK_MIDI_CME,
 	QUIRK_MIDI_AKAI,
 	QUIRK_MIDI_US122L,
+	QUIRK_MIDI_FTDI,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UAXX,
-- 
1.7.3.4
