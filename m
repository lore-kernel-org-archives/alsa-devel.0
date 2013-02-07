From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Trouble about Roland UA-55 and snd-usb-audio module
Date: Thu, 07 Feb 2013 21:35:09 +0100
Message-ID: <51140FFD.3060907@ladisch.de>
References: <50A349A5.6010403@firebuntu.com> <50A34C36.7080506@ladisch.de>
 <50A56FE6.3050009@firebuntu.com> <loom.20130109T124035-460@post.gmane.org>
 <50FC3009.9070401@ladisch.de> <loom.20130125T202229-943@post.gmane.org>
 <loom.20130128T221942-836@post.gmane.org> <5106F107.90704@ladisch.de>
 <loom.20130131T042847-100@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 2C3432652FA
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 21:36:07 +0100 (CET)
In-Reply-To: <loom.20130131T042847-100@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Smeefer <smeefer@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Smeefer wrote:
> The latest AV Linux kernel version is 3.0.47-avl-10. I will find out if this
> is close to bleeding edge like i hope it is!

In theory, implicit feedback support was added in kernel 3.5, but there
have been lots of important bugfixes since then, so I've just based it
on 3.8-rc6:

--8<---------------------------------------------------------------->8--
The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.alsa-project.org/alsa-kprivate.git full-roland-support

for you to fetch changes up to 59f42365d5e06ec5f0660e3062ab14eaa03bdc31:

  ALSA: usb-audio: detect PCM streams on all recent Roland devices (2013-02-07 21:09:01 +0100)

----------------------------------------------------------------
Clemens Ladisch (4):
      ALSA: usb-audio: store protocol version in struct audioformat
      ALSA: usb-audio: detect implicit feedback on Roland devices
      ALSA: usb-audio: detect MIDI ports on all recent Roland devices
      ALSA: usb-audio: detect PCM streams on all recent Roland devices

 sound/usb/card.h         |  1 +
 sound/usb/clock.c        |  4 +---
 sound/usb/format.c       | 34 +++++++++---------------------
 sound/usb/format.h       |  2 +-
 sound/usb/midi.c         | 41 ++++++++++++++++++++++++++++++++++++
 sound/usb/pcm.c          | 43 ++++++++++++++++++++++++++++++++++---
 sound/usb/quirks-table.h | 25 ++++++++++++++++++++++
 sound/usb/quirks.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/stream.c       | 13 +++++++++++-
 sound/usb/usbaudio.h     |  2 ++
 10 files changed, 188 insertions(+), 32 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 8a751b4..76907e2 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -21,6 +21,7 @@ struct audioformat {
 	unsigned char endpoint;		/* endpoint */
 	unsigned char ep_attr;		/* endpoint attributes */
 	unsigned char datainterval;	/* log_2 of data packet interval */
+	unsigned char protocol;		/* UAC_VERSION_1/2 */
 	unsigned int maxpacksize;	/* max. packet size */
 	unsigned int rates;		/* rate bitmasks */
 	unsigned int rate_min, rate_max;	/* min/max rates */
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 5e634a2..787f097 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -301,9 +301,7 @@ int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
 			     struct usb_host_interface *alts,
 			     struct audioformat *fmt, int rate)
 {
-	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
-
-	switch (altsd->bInterfaceProtocol) {
+	switch (fmt->protocol) {
 	case UAC_VERSION_1:
 	default:
 		return set_sample_rate_v1(chip, iface, alts, fmt, rate);
diff --git a/sound/usb/format.c b/sound/usb/format.c
index e831ee4..ae1198b 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -43,13 +43,12 @@
  */
 static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 				     struct audioformat *fp,
-				     int format, void *_fmt,
-				     int protocol)
+				     int format, void *_fmt)
 {
 	int sample_width, sample_bytes;
 	u64 pcm_formats;

-	switch (protocol) {
+	switch (fp->protocol) {
 	case UAC_VERSION_1:
 	default: {
 		struct uac_format_type_i_discrete_descriptor *fmt = _fmt;
@@ -354,11 +353,8 @@ err:
  */
 static int parse_audio_format_i(struct snd_usb_audio *chip,
 				struct audioformat *fp, int format,
-				struct uac_format_type_i_continuous_descriptor *fmt,
-				struct usb_host_interface *iface)
+				struct uac_format_type_i_continuous_descriptor *fmt)
 {
-	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
-	int protocol = altsd->bInterfaceProtocol;
 	int pcm_format, ret;

 	if (fmt->bFormatType == UAC_FORMAT_TYPE_III) {
@@ -380,8 +376,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 		}
 		fp->formats = 1uLL << pcm_format;
 	} else {
-		fp->formats = parse_audio_format_i_type(chip, fp, format,
-							fmt, protocol);
+		fp->formats = parse_audio_format_i_type(chip, fp, format, fmt);
 		if (!fp->formats)
 			return -EINVAL;
 	}
@@ -391,11 +386,8 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 	 * proprietary class specific descriptor.
 	 * audio class v2 uses class specific EP0 range requests for that.
 	 */
-	switch (protocol) {
+	switch (fp->protocol) {
 	default:
-		snd_printdd(KERN_WARNING "%d:%u:%d : invalid protocol version %d, assuming v1\n",
-			   chip->dev->devnum, fp->iface, fp->altsetting, protocol);
-		/* fall through */
 	case UAC_VERSION_1:
 		fp->channels = fmt->bNrChannels;
 		ret = parse_audio_format_rates_v1(chip, fp, (unsigned char *) fmt, 7);
@@ -420,12 +412,9 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
  */
 static int parse_audio_format_ii(struct snd_usb_audio *chip,
 				 struct audioformat *fp,
-				 int format, void *_fmt,
-				 struct usb_host_interface *iface)
+				 int format, void *_fmt)
 {
 	int brate, framesize, ret;
-	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
-	int protocol = altsd->bInterfaceProtocol;

 	switch (format) {
 	case UAC_FORMAT_TYPE_II_AC3:
@@ -445,11 +434,8 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip,

 	fp->channels = 1;

-	switch (protocol) {
+	switch (fp->protocol) {
 	default:
-		snd_printdd(KERN_WARNING "%d:%u:%d : invalid protocol version %d, assuming v1\n",
-			   chip->dev->devnum, fp->iface, fp->altsetting, protocol);
-		/* fall through */
 	case UAC_VERSION_1: {
 		struct uac_format_type_ii_discrete_descriptor *fmt = _fmt;
 		brate = le16_to_cpu(fmt->wMaxBitRate);
@@ -475,17 +461,17 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip,

 int snd_usb_parse_audio_format(struct snd_usb_audio *chip, struct audioformat *fp,
 			       int format, struct uac_format_type_i_continuous_descriptor *fmt,
-			       int stream, struct usb_host_interface *iface)
+			       int stream)
 {
 	int err;

 	switch (fmt->bFormatType) {
 	case UAC_FORMAT_TYPE_I:
 	case UAC_FORMAT_TYPE_III:
-		err = parse_audio_format_i(chip, fp, format, fmt, iface);
+		err = parse_audio_format_i(chip, fp, format, fmt);
 		break;
 	case UAC_FORMAT_TYPE_II:
-		err = parse_audio_format_ii(chip, fp, format, fmt, iface);
+		err = parse_audio_format_ii(chip, fp, format, fmt);
 		break;
 	default:
 		snd_printd(KERN_INFO "%d:%u:%d : format type %d is not supported yet\n",
diff --git a/sound/usb/format.h b/sound/usb/format.h
index 387924f..60b6682 100644
--- a/sound/usb/format.h
+++ b/sound/usb/format.h
@@ -4,6 +4,6 @@
 int snd_usb_parse_audio_format(struct snd_usb_audio *chip,
 			       struct audioformat *fp, int format,
 			       struct uac_format_type_i_continuous_descriptor *fmt,
-			       int stream, struct usb_host_interface *iface);
+			       int stream);

 #endif /*  __USBAUDIO_FORMAT_H */
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 34b9bb7..3508360 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1959,6 +1959,44 @@ static int snd_usbmidi_detect_yamaha(struct snd_usb_midi* umidi,
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
@@ -2171,6 +2209,9 @@ int snd_usbmidi_create(struct snd_card *card,
 	case QUIRK_MIDI_YAMAHA:
 		err = snd_usbmidi_detect_yamaha(umidi, &endpoints[0]);
 		break;
+	case QUIRK_MIDI_ROLAND:
+		err = snd_usbmidi_detect_roland(umidi, &endpoints[0]);
+		break;
 	case QUIRK_MIDI_MIDIMAN:
 		umidi->usb_protocol_ops = &snd_usbmidi_midiman_ops;
 		memcpy(&endpoints[0], quirk->data,
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index d82e378..3c2f9f5 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -199,13 +199,11 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 		       struct usb_host_interface *alts,
 		       struct audioformat *fmt)
 {
-	struct usb_interface_descriptor *altsd = get_iface_desc(alts);
-
 	/* if endpoint doesn't have pitch control, bail out */
 	if (!(fmt->attributes & UAC_EP_CS_ATTR_PITCH_CONTROL))
 		return 0;

-	switch (altsd->bInterfaceProtocol) {
+	switch (fmt->protocol) {
 	case UAC_VERSION_1:
 	default:
 		return init_pitch_v1(chip, iface, alts, fmt);
@@ -297,6 +295,33 @@ static int deactivate_endpoints(struct snd_usb_substream *subs)
 	return 0;
 }

+static int search_roland_implicit_fb(struct usb_device *dev, int ifnum,
+				     struct usb_host_interface **alts,
+				     unsigned int *ep)
+{
+	struct usb_interface *iface;
+	struct usb_interface_descriptor *altsd;
+	struct usb_endpoint_descriptor *epd;
+
+	iface = usb_ifnum_to_if(dev, ifnum);
+	if (!iface || iface->num_altsetting < 2)
+		return -ENOENT;
+	*alts = &iface->altsetting[1];
+	altsd = get_iface_desc(*alts);
+	if (altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC ||
+	    altsd->bInterfaceSubClass != 2 ||
+	    altsd->bInterfaceProtocol != 1 ||
+	    altsd->bNumEndpoints < 1)
+		return -ENOENT;
+	epd = get_endpoint(*alts, 0);
+	if (!usb_endpoint_is_isoc_in(epd) ||
+	    (epd->bmAttributes & USB_ENDPOINT_USAGE_MASK) !=
+					USB_ENDPOINT_USAGE_IMPLICIT_FB)
+		return -ENOENT;
+	*ep = epd->bEndpointAddress;
+	return 0;
+}
+
 /*
  * find a matching format and set up the interface
  */
@@ -389,6 +414,18 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 			goto add_sync_ep;
 		}
 	}
+	if (is_playback &&
+	    attr == USB_ENDPOINT_SYNC_ASYNC &&
+	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+	    altsd->bInterfaceSubClass == 2 &&
+	    altsd->bInterfaceProtocol == 2 &&
+	    altsd->bNumEndpoints == 1 &&
+	    USB_ID_VENDOR(subs->stream->chip->usb_id) == 0x0582 /* Roland */ &&
+	    search_roland_implicit_fb(dev, altsd->bInterfaceNumber + 1,
+				      &alts, &ep) >= 0) {
+		implicit_fb = 1;
+		goto add_sync_ep;
+	}

 	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
 	     (!is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 64d25a7..4bf53d5 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1953,6 +1953,31 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+/* this catches most recent vendor-specific Roland devices */
+{
+	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+	               USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x0582,
+	.bInterfaceClass    = USB_CLASS_VENDOR_SPEC,
+	.bInterfaceSubClass = USB_SUBCLASS_AUDIOSTREAMING,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_ROLAND
+	}
+},
+{
+	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+	               USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor = 0x0582,
+	.bInterfaceClass    = USB_CLASS_VENDOR_SPEC,
+	.bInterfaceSubClass = USB_SUBCLASS_MIDISTREAMING,
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_MIDI_ROLAND
+	}
+},

 /* Guillemot devices */
 {
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2c97185..9209d4d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -173,6 +173,59 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	return 0;
 }

+static int create_roland_audio_quirk(struct snd_usb_audio *chip,
+				     struct usb_interface *iface,
+				     struct usb_driver *driver,
+				     const struct snd_usb_audio_quirk *quirk)
+{
+	struct usb_host_interface *alts;
+	struct usb_interface_descriptor *altsd;
+	struct usb_endpoint_descriptor *epd;
+
+	/*
+	 * Most Roland audio streaming interfaces have more or less standard
+	 * descriptors, but older devices might lack descriptors, and future
+	 * ones might change, so ensure that we fail silently if the interface
+	 * doesn't look exactly right.
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
+	/* must be correctly marked as input/output */
+	switch (altsd->bInterfaceProtocol) {
+	case 0:
+		break;
+	case 1:
+		if (!usb_endpoint_dir_in(epd))
+			return -ENODEV;
+		break;
+	case 2:
+		if (!usb_endpoint_dir_out(epd))
+			return -ENODEV;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	/* must have format descriptors */
+	if (!snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL,
+				     UAC_FORMAT_TYPE))
+		return -ENODEV;
+
+	return create_standard_audio_quirk(chip, iface, driver, NULL);
+}
+
 /*
  * Create a stream for an Edirol UA-700/UA-25/UA-4FX interface.
  * The only way to detect the sample rate is by looking at wMaxPacketSize.
@@ -304,6 +357,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_STANDARD_INTERFACE] = create_any_midi_quirk,
 		[QUIRK_MIDI_FIXED_ENDPOINT] = create_any_midi_quirk,
 		[QUIRK_MIDI_YAMAHA] = create_any_midi_quirk,
+		[QUIRK_MIDI_ROLAND] = create_any_midi_quirk,
 		[QUIRK_MIDI_MIDIMAN] = create_any_midi_quirk,
 		[QUIRK_MIDI_NOVATION] = create_any_midi_quirk,
 		[QUIRK_MIDI_RAW_BYTES] = create_any_midi_quirk,
@@ -313,6 +367,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_FTDI] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
+		[QUIRK_AUDIO_ROLAND] = create_roland_audio_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
 		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
 		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index ad181d5..6e837b7 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -507,6 +507,16 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		if (snd_usb_apply_interface_quirk(chip, iface_no, altno))
 			continue;

+		/*
+		 * Roland audio streaming interfaces are marked with protocols
+		 * 0/1/2, but are UAC 1 compatible.
+		 */
+		if (USB_ID_VENDOR(chip->usb_id) == 0x0582 &&
+		    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+		    altsd->bInterfaceSubClass == USB_SUBCLASS_AUDIOSTREAMING &&
+		    protocol <= 2)
+			protocol = UAC_VERSION_1;
+
 		chconfig = 0;
 		/* get audio formats */
 		switch (protocol) {
@@ -630,6 +640,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
 		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
 		fp->datainterval = snd_usb_parse_datainterval(chip, alts);
+		fp->protocol = protocol;
 		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
 		fp->channels = num_channels;
 		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
@@ -671,7 +682,7 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 		}

 		/* ok, let's parse further... */
-		if (snd_usb_parse_audio_format(chip, fp, format, fmt, stream, alts) < 0) {
+		if (snd_usb_parse_audio_format(chip, fp, format, fmt, stream) < 0) {
 			kfree(fp->rate_table);
 			kfree(fp->chmap);
 			kfree(fp);
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 1ac3fd9..4313747 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -74,6 +74,7 @@ enum quirk_type {
 	QUIRK_MIDI_STANDARD_INTERFACE,
 	QUIRK_MIDI_FIXED_ENDPOINT,
 	QUIRK_MIDI_YAMAHA,
+	QUIRK_MIDI_ROLAND,
 	QUIRK_MIDI_MIDIMAN,
 	QUIRK_MIDI_NOVATION,
 	QUIRK_MIDI_RAW_BYTES,
@@ -84,6 +85,7 @@ enum quirk_type {
 	QUIRK_MIDI_FTDI,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
+	QUIRK_AUDIO_ROLAND,
 	QUIRK_AUDIO_EDIROL_UAXX,
 	QUIRK_AUDIO_ALIGN_TRANSFER,
 	QUIRK_AUDIO_STANDARD_MIXER,
