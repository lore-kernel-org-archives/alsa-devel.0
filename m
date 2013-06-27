From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 3/7] ALSA: usb-audio: add support for many
	Roland/Yamaha devices
Date: Thu, 27 Jun 2013 22:19:00 +0200
Message-ID: <51CC9E34.4010204@ladisch.de>
References: <51CC9D8B.7060601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A80D7265650
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 22:18:13 +0200 (CEST)
In-Reply-To: <51CC9D8B.7060601@ladisch.de>
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

Add quirks to detect the various vendor-specific descriptors used by
Roland and Yamaha in most of their recent USB audio and MIDI devices.

Together with the previous patch, this should add audio/MIDI support for
the following USB devices:
- Edirol motion dive .tokyo performance package
- Roland MC-808 Synthesizer
- Roland BK-7m Synthesizer
- Roland VIMA JM-5/8 Synthesizer
- Roland SP-555 Sequencer
- Roland V-Synth GT Synthesizer
- Roland Music Atelier AT-75/100/300/350C/500/800/900/900C Organ
- Edirol V-Mixer M-200i/300/380/400/480/R-1000
- BOSS GT-10B Effects Processor
- Roland Fantom G6/G7/G8 Keyboard
- Cakewalk Sonar V-Studio 20/100/700 Audio Interface
- Roland GW-8 Keyboard
- Roland AX-Synth Keyboard
- Roland JUNO-Di/STAGE/Gi Keyboard
- Roland VB-99 Effects Processor
- Cakewalk UM-2G MIDI Interface
- Roland A-500S Keyboard
- Roland SD-50 Synthesizer
- Roland OCTAPAD SPD-30 Controller
- Roland Lucina AX-09 Synthesizer
- BOSS BR-800 Digital Recorder
- Roland DUO/TRI-CAPTURE (EX) Audio Interface
- BOSS RC-300 Loop Station
- Roland JUPITER-50/80 Keyboard
- Roland R-26 Recorder
- Roland SPD-SX Controller
- BOSS JS-10 Audio Player
- Roland TD-11/15/30 Drum Module
- Roland A-49/88 Keyboard
- Roland INTEGRA-7 Synthesizer
- Roland R-88 Recorder

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/midi.c         |  41 +++++++++++
 sound/usb/quirks-table.h |  22 ++++++
 sound/usb/quirks.c       | 175 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/stream.c       |  15 +++-
 sound/usb/usbaudio.h     |   2 +
 5 files changed, 252 insertions(+), 3 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 8e01fa4..63dd054 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1948,6 +1948,44 @@ static int snd_usbmidi_detect_yamaha(struct snd_usb_midi* umidi,
 }

 /*
+ * Detects the endpoints and ports of Roland devices.
+ */
+static int snd_usbmidi_detect_roland(struct snd_usb_midi* umidi,
+				     struct snd_usb_midi_endpoint_info* endpoint)
+{
+	struct usb_interface* intf;
+	struct usb_host_interface *hostif;
+	u8* cs_desc;
+
+	intf = umidi->iface;
+	if (!intf)
+		return -ENOENT;
+	hostif = intf->altsetting;
+	/*
+	 * Some devices have a descriptor <06 24 F1 02 <inputs> <outputs>>,
+	 * some have standard class descriptors, or both kinds, or neither.
+	 */
+	for (cs_desc = hostif->extra;
+	     cs_desc < hostif->extra + hostif->extralen && cs_desc[0] >= 2;
+	     cs_desc += cs_desc[0]) {
+		if (cs_desc[0] >= 6 &&
+		    cs_desc[1] == USB_DT_CS_INTERFACE &&
+		    cs_desc[2] == 0xf1 &&
+		    cs_desc[3] == 0x02) {
+			endpoint->in_cables  = (1 << cs_desc[4]) - 1;
+			endpoint->out_cables = (1 << cs_desc[5]) - 1;
+			return snd_usbmidi_detect_endpoints(umidi, endpoint, 1);
+		} else if (cs_desc[0] >= 7 &&
+			   cs_desc[1] == USB_DT_CS_INTERFACE &&
+			   cs_desc[2] == UAC_HEADER) {
+			return snd_usbmidi_get_ms_info(umidi, endpoint);
+		}
+	}
+
+	return -ENODEV;
+}
+
+/*
  * Creates the endpoints and their ports for Midiman devices.
  */
 static int snd_usbmidi_create_endpoints_midiman(struct snd_usb_midi* umidi,
@@ -2162,6 +2200,9 @@ int snd_usbmidi_create(struct snd_card *card,
 	case QUIRK_MIDI_YAMAHA:
 		err = snd_usbmidi_detect_yamaha(umidi, &endpoints[0]);
 		break;
+	case QUIRK_MIDI_ROLAND:
+		err = snd_usbmidi_detect_roland(umidi, &endpoints[0]);
+		break;
 	case QUIRK_MIDI_MIDIMAN:
 		umidi->usb_protocol_ops = &snd_usbmidi_midiman_ops;
 		memcpy(&endpoints[0], quirk->data,
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 8b75bcf..f1c73fb 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -461,6 +461,17 @@ YAMAHA_DEVICE(0x7000, "DTX"),
 YAMAHA_DEVICE(0x7010, "UB99"),
 #undef YAMAHA_DEVICE
 #undef YAMAHA_INTERFACE
+/* this catches most recent vendor-specific Yamaha devices */
+{
+	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+	               USB_DEVICE_ID_MATCH_INT_CLASS,
+	.idVendor = 0x0499,
+	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUTODETECT
+	}
+},

 /*
  * Roland/RolandED/Edirol/BOSS devices
@@ -2041,6 +2052,17 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+/* this catches most recent vendor-specific Roland devices */
+{
+	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+	               USB_DEVICE_ID_MATCH_INT_CLASS,
+	.idVendor = 0x0582,
+	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUTODETECT
+	}
+},

 /* Guillemot devices */
 {
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3879eae..5363bcc 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
+#include <linux/usb/midi.h>

 #include <sound/control.h>
 #include <sound/core.h>
@@ -175,6 +176,178 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	return 0;
 }

+static int create_auto_pcm_quirk(struct snd_usb_audio *chip,
+				 struct usb_interface *iface,
+				 struct usb_driver *driver)
+{
+	struct usb_host_interface *alts;
+	struct usb_interface_descriptor *altsd;
+	struct usb_endpoint_descriptor *epd;
+	struct uac1_as_header_descriptor *ashd;
+	struct uac_format_type_i_discrete_descriptor *fmtd;
+
+	/*
+	 * Most Roland/Yamaha audio streaming interfaces have more or less
+	 * standard descriptors, but older devices might lack descriptors, and
+	 * future ones might change, so ensure that we fail silently if the
+	 * interface doesn't look exactly right.
+	 */
+
+	/* must have a non-zero altsetting for streaming */
+	if (iface->num_altsetting < 2)
+		return -ENODEV;
+	alts = &iface->altsetting[1];
+	altsd = get_iface_desc(alts);
+
+	/* must have an isochronous endpoint for streaming */
+	if (altsd->bNumEndpoints < 1)
+		return -ENODEV;
+	epd = get_endpoint(alts, 0);
+	if (!usb_endpoint_xfer_isoc(epd))
+		return -ENODEV;
+
+	/* must have format descriptors */
+	ashd = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
+				       UAC_AS_GENERAL);
+	fmtd = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
+				       UAC_FORMAT_TYPE);
+	if (!ashd || ashd->bLength < 7 ||
+	    !fmtd || fmtd->bLength < 8)
+		return -ENODEV;
+
+	return create_standard_audio_quirk(chip, iface, driver, NULL);
+}
+
+static int create_yamaha_midi_quirk(struct snd_usb_audio *chip,
+				    struct usb_interface *iface,
+				    struct usb_driver *driver,
+				    struct usb_host_interface *alts)
+{
+	static const struct snd_usb_audio_quirk yamaha_midi_quirk = {
+		.type = QUIRK_MIDI_YAMAHA
+	};
+	struct usb_midi_in_jack_descriptor *injd;
+	struct usb_midi_out_jack_descriptor *outjd;
+
+	/* must have some valid jack descriptors */
+	injd = snd_usb_find_csint_desc(alts->extra, alts->extralen,
+				       NULL, USB_MS_MIDI_IN_JACK);
+	outjd = snd_usb_find_csint_desc(alts->extra, alts->extralen,
+					NULL, USB_MS_MIDI_OUT_JACK);
+	if (!injd && !outjd)
+		return -ENODEV;
+	if (injd && (injd->bLength < 5 ||
+		     (injd->bJackType != USB_MS_EMBEDDED &&
+		      injd->bJackType != USB_MS_EXTERNAL)))
+		return -ENODEV;
+	if (outjd && (outjd->bLength < 6 ||
+		      (outjd->bJackType != USB_MS_EMBEDDED &&
+		       outjd->bJackType != USB_MS_EXTERNAL)))
+		return -ENODEV;
+	return create_any_midi_quirk(chip, iface, driver, &yamaha_midi_quirk);
+}
+
+static int create_roland_midi_quirk(struct snd_usb_audio *chip,
+				    struct usb_interface *iface,
+				    struct usb_driver *driver,
+				    struct usb_host_interface *alts)
+{
+	static const struct snd_usb_audio_quirk roland_midi_quirk = {
+		.type = QUIRK_MIDI_ROLAND
+	};
+	u8 *roland_desc = NULL;
+
+	/* might have a vendor-specific descriptor <06 24 F1 02 ...> */
+	for (;;) {
+		roland_desc = snd_usb_find_csint_desc(alts->extra,
+						      alts->extralen,
+						      roland_desc, 0xf1);
+		if (!roland_desc)
+			return -ENODEV;
+		if (roland_desc[0] < 6 || roland_desc[3] != 2)
+			continue;
+		return create_any_midi_quirk(chip, iface, driver,
+					     &roland_midi_quirk);
+	}
+}
+
+static int create_std_midi_quirk(struct snd_usb_audio *chip,
+				 struct usb_interface *iface,
+				 struct usb_driver *driver,
+				 struct usb_host_interface *alts)
+{
+	struct usb_ms_header_descriptor *mshd;
+	struct usb_ms_endpoint_descriptor *msepd;
+
+	/* must have the MIDIStreaming interface header descriptor*/
+	mshd = (struct usb_ms_header_descriptor *)alts->extra;
+	if (alts->extralen < 7 ||
+	    mshd->bLength < 7 ||
+	    mshd->bDescriptorType != USB_DT_CS_INTERFACE ||
+	    mshd->bDescriptorSubtype != USB_MS_HEADER)
+		return -ENODEV;
+	/* must have the MIDIStreaming endpoint descriptor*/
+	msepd = (struct usb_ms_endpoint_descriptor *)alts->endpoint[0].extra;
+	if (alts->endpoint[0].extralen < 4 ||
+	    msepd->bLength < 4 ||
+	    msepd->bDescriptorType != USB_DT_CS_ENDPOINT ||
+	    msepd->bDescriptorSubtype != UAC_MS_GENERAL ||
+	    msepd->bNumEmbMIDIJack < 1 ||
+	    msepd->bNumEmbMIDIJack > 16)
+		return -ENODEV;
+
+	return create_any_midi_quirk(chip, iface, driver, NULL);
+}
+
+static int create_auto_midi_quirk(struct snd_usb_audio *chip,
+				  struct usb_interface *iface,
+				  struct usb_driver *driver)
+{
+	struct usb_host_interface *alts;
+	struct usb_interface_descriptor *altsd;
+	struct usb_endpoint_descriptor *epd;
+	int err;
+
+	alts = &iface->altsetting[0];
+	altsd = get_iface_desc(alts);
+
+	/* must have at least one bulk/interrupt endpoint for streaming */
+	if (altsd->bNumEndpoints < 1)
+		return -ENODEV;
+	epd = get_endpoint(alts, 0);
+	if (!usb_endpoint_xfer_bulk(epd) ||
+	    !usb_endpoint_xfer_int(epd))
+		return -ENODEV;
+
+	switch (USB_ID_VENDOR(chip->usb_id)) {
+	case 0x0499: /* Yamaha */
+		err = create_yamaha_midi_quirk(chip, iface, driver, alts);
+		if (err < 0 && err != -ENODEV)
+			return err;
+		break;
+	case 0x0582: /* Roland */
+		err = create_roland_midi_quirk(chip, iface, driver, alts);
+		if (err < 0 && err != -ENODEV)
+			return err;
+		break;
+	}
+
+	return create_std_midi_quirk(chip, iface, driver, alts);
+}
+
+static int create_autodetect_quirk(struct snd_usb_audio *chip,
+				   struct usb_interface *iface,
+				   struct usb_driver *driver,
+				   const struct snd_usb_audio_quirk *quirk)
+{
+	int err;
+
+	err = create_auto_pcm_quirk(chip, iface, driver);
+	if (err == -ENODEV)
+		err = create_auto_midi_quirk(chip, iface, driver);
+	return err;
+}
+
 /*
  * Create a stream for an Edirol UA-700/UA-25/UA-4FX interface.
  * The only way to detect the sample rate is by looking at wMaxPacketSize.
@@ -303,9 +476,11 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 	static const quirk_func_t quirk_funcs[] = {
 		[QUIRK_IGNORE_INTERFACE] = ignore_interface_quirk,
 		[QUIRK_COMPOSITE] = create_composite_quirk,
+		[QUIRK_AUTODETECT] = create_autodetect_quirk,
 		[QUIRK_MIDI_STANDARD_INTERFACE] = create_any_midi_quirk,
 		[QUIRK_MIDI_FIXED_ENDPOINT] = create_any_midi_quirk,
 		[QUIRK_MIDI_YAMAHA] = create_any_midi_quirk,
+		[QUIRK_MIDI_ROLAND] = create_any_midi_quirk,
 		[QUIRK_MIDI_MIDIMAN] = create_any_midi_quirk,
 		[QUIRK_MIDI_NOVATION] = create_any_midi_quirk,
 		[QUIRK_MIDI_RAW_BYTES] = create_any_midi_quirk,
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index df43844..a7adf475 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -493,10 +493,10 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		altsd = get_iface_desc(alts);
 		protocol = altsd->bInterfaceProtocol;
 		/* skip invalid one */
-		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
+		if (((altsd->bInterfaceClass != USB_CLASS_AUDIO ||
+		      (altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIOSTREAMING &&
+		       altsd->bInterfaceSubClass != USB_SUBCLASS_VENDOR_SPEC)) &&
 		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
-		    (altsd->bInterfaceSubClass != USB_SUBCLASS_AUDIOSTREAMING &&
-		     altsd->bInterfaceSubClass != USB_SUBCLASS_VENDOR_SPEC) ||
 		    altsd->bNumEndpoints < 1 ||
 		    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) == 0)
 			continue;
@@ -512,6 +512,15 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		if (snd_usb_apply_interface_quirk(chip, iface_no, altno))
 			continue;

+		/*
+		 * Roland audio streaming interfaces are marked with protocols
+		 * 0/1/2, but are UAC 1 compatible.
+		 */
+		if (USB_ID_VENDOR(chip->usb_id) == 0x0582 &&
+		    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+		    protocol <= 2)
+			protocol = UAC_VERSION_1;
+
 		chconfig = 0;
 		/* get audio formats */
 		switch (protocol) {
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index bc43bca..caabe9b 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -72,9 +72,11 @@ struct snd_usb_audio {
 enum quirk_type {
 	QUIRK_IGNORE_INTERFACE,
 	QUIRK_COMPOSITE,
+	QUIRK_AUTODETECT,
 	QUIRK_MIDI_STANDARD_INTERFACE,
 	QUIRK_MIDI_FIXED_ENDPOINT,
 	QUIRK_MIDI_YAMAHA,
+	QUIRK_MIDI_ROLAND,
 	QUIRK_MIDI_MIDIMAN,
 	QUIRK_MIDI_NOVATION,
 	QUIRK_MIDI_RAW_BYTES,
