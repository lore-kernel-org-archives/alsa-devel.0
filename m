From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/5] ALSA: usbaudio: implement basic set of
	class v2.0 parser
Date: Mon, 22 Feb 2010 23:49:11 +0100
Message-ID: <1266878953-9184-4-git-send-email-daniel@caiaq.de>
References: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E557C103867
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 23:49:46 +0100 (CET)
In-Reply-To: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This adds a number of parsers for audio class v2.0. In particular, the
following internals are different and now handled by the code:

* the number of streaming interfaces is now reported by an interface
  association descriptor. The old approach using a proprietary
  descriptor is deprecated.

* The number of channels per interface is now stored in the AS_GENERAL
  descriptor (used to be part of the FORMAT_TYPE descriptor).

* The list of supported sample rates is no longer stored in a variable
  length appendix of the format_type descriptor but is retrieved from
  the device using a class specific GET_RANGE command.

* Supported sample formats are now reported as 32bit bitmap rather than
  a fixed value. For now, this is worked around by choosing just one of
  them.

* A devices needs to have at least one CLOCK_SOURCE descriptor which
  denotes a clockID that is needed im the class request command.

* Many descriptors (format_type, ...) have changed their layout. Handle
  this by casting the descriptors to the appropriate structs.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/usbaudio.c |  352 +++++++++++++++++++++++++++++++++++++++++---------
 sound/usb/usbaudio.h |    3 +
 2 files changed, 292 insertions(+), 63 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 5d7d659..34dc687 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2422,17 +2422,53 @@ static int is_big_endian_format(struct snd_usb_audio *chip, struct audioformat *
  * @format: the format tag (wFormatTag)
  * @fmt: the format type descriptor
  */
-static int parse_audio_format_i_type(struct snd_usb_audio *chip, struct audioformat *fp,
-				     int format, void *fmt_raw)
+static int parse_audio_format_i_type(struct snd_usb_audio *chip,
+				     struct audioformat *fp,
+				     int format, void *_fmt,
+				     int protocol)
 {
-	int pcm_format;
+	int pcm_format, i;
 	int sample_width, sample_bytes;
-	struct uac_format_type_i_discrete_descriptor *fmt = fmt_raw;
+
+	switch (protocol) {
+	case UAC_VERSION_1: {
+		struct uac_format_type_i_discrete_descriptor *fmt = _fmt;
+		sample_width = fmt->bBitResolution;
+		sample_bytes = fmt->bSubframeSize;
+		break;
+	}
+
+	case UAC_VERSION_2: {
+		struct uac_format_type_i_ext_descriptor *fmt = _fmt;
+		sample_width = fmt->bBitResolution;
+		sample_bytes = fmt->bSubslotSize;
+
+		/*
+		 * FIXME
+		 * USB audio class v2 devices specify a bitmap of possible
+		 * audio formats rather than one fix value. For now, we just
+		 * pick one of them and report that as the only possible
+		 * value for this setting.
+		 * The bit allocation map is in fact compatible to the
+		 * wFormatTag of the v1 AS streaming descriptors, which is why
+		 * we can simply map the matrix.
+		 */
+
+		for (i = 0; i < 5; i++)
+			if (format & (1UL << i)) {
+				format = i + 1;
+				break;
+			}
+
+		break;
+	}
+
+	default:
+		return -EINVAL;
+	}
 
 	/* FIXME: correct endianess and sign? */
 	pcm_format = -1;
-	sample_width = fmt->bBitResolution;
-	sample_bytes = fmt->bSubframeSize;
 
 	switch (format) {
 	case 0: /* some devices don't define this correctly... */
@@ -2446,6 +2482,7 @@ static int parse_audio_format_i_type(struct snd_usb_audio *chip, struct audiofor
 				   sample_width, sample_bytes);
 		}
 		/* check the format byte size */
+		printk(" XXXXX SAMPLE BYTES %d\n", sample_bytes);
 		switch (sample_bytes) {
 		case 1:
 			pcm_format = SNDRV_PCM_FORMAT_S8;
@@ -2500,7 +2537,7 @@ static int parse_audio_format_i_type(struct snd_usb_audio *chip, struct audiofor
 
 /*
  * parse the format descriptor and stores the possible sample rates
- * on the audioformat table.
+ * on the audioformat table (audio class v1).
  *
  * @dev: usb device
  * @fp: audioformat record
@@ -2508,8 +2545,8 @@ static int parse_audio_format_i_type(struct snd_usb_audio *chip, struct audiofor
  * @offset: the start offset of descriptor pointing the rate type
  *          (7 for type I and II, 8 for type II)
  */
-static int parse_audio_format_rates(struct snd_usb_audio *chip, struct audioformat *fp,
-				    unsigned char *fmt, int offset)
+static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audioformat *fp,
+				       unsigned char *fmt, int offset)
 {
 	int nr_rates = fmt[offset];
 
@@ -2565,13 +2602,85 @@ static int parse_audio_format_rates(struct snd_usb_audio *chip, struct audioform
 }
 
 /*
+ * parse the format descriptor and stores the possible sample rates
+ * on the audioformat table (audio class v2).
+ */
+static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
+				       struct audioformat *fp,
+				       struct usb_host_interface *iface)
+{
+	struct usb_device *dev = chip->dev;
+	unsigned char tmp[2], *data;
+	int i, nr_rates, data_size, ret = 0;
+
+	/* get the number of sample rates first by only fetching 2 bytes */
+	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), CS_RANGE,
+			       USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+			       0x0100, chip->clock_id << 8, tmp, sizeof(tmp), 1000);
+
+	if (ret < 0) {
+		snd_printk(KERN_ERR "unable to retrieve number of sample rates\n");
+		goto err;
+	}
+
+	nr_rates = (tmp[1] << 8) | tmp[0];
+	data_size = 2 + 12 * nr_rates;
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* now get the full information */
+	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), CS_RANGE,
+			       USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
+			       0x0100, chip->clock_id << 8, data, data_size, 1000);
+
+	if (ret < 0) {
+		snd_printk(KERN_ERR "unable to retrieve sample rate range\n");
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	fp->rate_table = kmalloc(sizeof(int) * nr_rates, GFP_KERNEL);
+	if (!fp->rate_table) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	fp->nr_rates = 0;
+	fp->rate_min = fp->rate_max = 0;
+
+	for (i = 0; i < nr_rates; i++) {
+		int rate = combine_quad(&data[2 + 12 * i]);
+
+		fp->rate_table[fp->nr_rates] = rate;
+		if (!fp->rate_min || rate < fp->rate_min)
+			fp->rate_min = rate;
+		if (!fp->rate_max || rate > fp->rate_max)
+			fp->rate_max = rate;
+		fp->rates |= snd_pcm_rate_to_rate_bit(rate);
+		fp->nr_rates++;
+	}
+
+err_free:
+	kfree(data);
+err:
+	return ret;
+}
+
+/*
  * parse the format type I and III descriptors
  */
-static int parse_audio_format_i(struct snd_usb_audio *chip, struct audioformat *fp,
-				int format, void *fmt_raw)
+static int parse_audio_format_i(struct snd_usb_audio *chip,
+				struct audioformat *fp,
+				int format, void *_fmt,
+				struct usb_host_interface *iface)
 {
-	int pcm_format;
-	struct uac_format_type_i_discrete_descriptor *fmt = fmt_raw;
+	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
+	struct uac_format_type_i_discrete_descriptor *fmt = _fmt;
+	int protocol = altsd->bInterfaceProtocol;
+	int pcm_format, ret;
 
 	if (fmt->bFormatType == USB_FORMAT_TYPE_III) {
 		/* FIXME: the format type is really IECxxx
@@ -2591,30 +2700,49 @@ static int parse_audio_format_i(struct snd_usb_audio *chip, struct audioformat *
 			pcm_format = SNDRV_PCM_FORMAT_S16_LE;
 		}
 	} else {
-		pcm_format = parse_audio_format_i_type(chip, fp, format, fmt);
+		pcm_format = parse_audio_format_i_type(chip, fp, format, fmt, protocol);
 		if (pcm_format < 0)
 			return -1;
 	}
 
 	fp->format = pcm_format;
-	fp->channels = fmt->bNrChannels;
+
+	/* gather possible sample rates */
+	/* audio class v1 reports possible sample rates as part of the
+	 * proprietary class specific descriptor.
+	 * audio class v2 uses class specific EP0 range requests for that.
+	 */
+	switch (protocol) {
+	case UAC_VERSION_1:
+		fp->channels = fmt->bNrChannels;
+		ret = parse_audio_format_rates_v1(chip, fp, _fmt, 7);
+		break;
+	case UAC_VERSION_2:
+		/* fp->channels is already set in this case */
+		ret = parse_audio_format_rates_v2(chip, fp, iface);
+		break;
+	}
 
 	if (fp->channels < 1) {
 		snd_printk(KERN_ERR "%d:%u:%d : invalid channels %d\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting, fp->channels);
 		return -1;
 	}
-	return parse_audio_format_rates(chip, fp, fmt_raw, 7);
+
+	return ret;
 }
 
 /*
  * parse the format type II descriptor
  */
-static int parse_audio_format_ii(struct snd_usb_audio *chip, struct audioformat *fp,
-				 int format, void *fmt_raw)
+static int parse_audio_format_ii(struct snd_usb_audio *chip,
+				 struct audioformat *fp,
+				 int format, void *_fmt,
+				 struct usb_host_interface *iface)
 {
-	int brate, framesize;
-	struct uac_format_type_ii_discrete_descriptor *fmt = fmt_raw;
+	int brate, framesize, ret;
+	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
+	int protocol = altsd->bInterfaceProtocol;
 
 	switch (format) {
 	case USB_AUDIO_FORMAT_AC3:
@@ -2634,35 +2762,50 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip, struct audioformat
 
 	fp->channels = 1;
 
-	brate = le16_to_cpu(fmt->wMaxBitRate);
-	framesize = le16_to_cpu(fmt->wSamplesPerFrame);
-	snd_printd(KERN_INFO "found format II with max.bitrate = %d, frame size=%d\n", brate, framesize);
-	fp->frame_size = framesize;
-	return parse_audio_format_rates(chip, fp, fmt_raw, 8); /* fmt[8..] sample rates */
+	switch (protocol) {
+	case UAC_VERSION_1: {
+		struct uac_format_type_ii_discrete_descriptor *fmt = _fmt;
+		brate = le16_to_cpu(fmt->wMaxBitRate);
+		framesize = le16_to_cpu(fmt->wSamplesPerFrame);
+		snd_printd(KERN_INFO "found format II with max.bitrate = %d, frame size=%d\n", brate, framesize);
+		fp->frame_size = framesize;
+		ret = parse_audio_format_rates_v1(chip, fp, _fmt, 8); /* fmt[8..] sample rates */
+		break;
+	}
+	case UAC_VERSION_2: {
+		struct uac_format_type_ii_ext_descriptor *fmt = _fmt;
+		brate = le16_to_cpu(fmt->wMaxBitRate);
+		framesize = le16_to_cpu(fmt->wSamplesPerFrame);
+		snd_printd(KERN_INFO "found format II with max.bitrate = %d, frame size=%d\n", brate, framesize);
+		fp->frame_size = framesize;
+		ret = parse_audio_format_rates_v2(chip, fp, iface);
+		break;
+	}
+	}
+
+	return ret;
 }
 
 static int parse_audio_format(struct snd_usb_audio *chip, struct audioformat *fp,
-			      int format, void *fmt_raw, int stream)
+			      int format, unsigned char *fmt, int stream,
+			      struct usb_host_interface *iface)
 {
 	int err;
-	/* we only parse the common header of all format types here,
-	 * so it is safe to take a type_i struct */
-	struct uac_format_type_i_discrete_descriptor *fmt = fmt_raw;
 
-	switch (fmt->bFormatType) {
+	switch (fmt[3]) {
 	case USB_FORMAT_TYPE_I:
 	case USB_FORMAT_TYPE_III:
-		err = parse_audio_format_i(chip, fp, format, fmt);
+		err = parse_audio_format_i(chip, fp, format, fmt, iface);
 		break;
 	case USB_FORMAT_TYPE_II:
-		err = parse_audio_format_ii(chip, fp, format, fmt);
+		err = parse_audio_format_ii(chip, fp, format, fmt, iface);
 		break;
 	default:
 		snd_printd(KERN_INFO "%d:%u:%d : format type %d is not supported yet\n",
-			   chip->dev->devnum, fp->iface, fp->altsetting, fmt->bFormatType);
+			   chip->dev->devnum, fp->iface, fp->altsetting, fmt[3]);
 		return -1;
 	}
-	fp->fmt_type = fmt->bFormatType;
+	fp->fmt_type = fmt[3];
 	if (err < 0)
 		return err;
 #if 1
@@ -2673,7 +2816,7 @@ static int parse_audio_format(struct snd_usb_audio *chip, struct audioformat *fp
 	if (chip->usb_id == USB_ID(0x041e, 0x3000) ||
 	    chip->usb_id == USB_ID(0x041e, 0x3020) ||
 	    chip->usb_id == USB_ID(0x041e, 0x3061)) {
-		if (fmt->bFormatType == USB_FORMAT_TYPE_I &&
+		if (fmt[3] == USB_FORMAT_TYPE_I &&
 		    fp->rates != SNDRV_PCM_RATE_48000 &&
 		    fp->rates != SNDRV_PCM_RATE_96000)
 			return -1;
@@ -2702,10 +2845,10 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 	struct usb_host_interface *alts;
 	struct usb_interface_descriptor *altsd;
 	int i, altno, err, stream;
-	int format;
+	int format = 0, num_channels = 0;
 	struct audioformat *fp = NULL;
 	unsigned char *fmt, *csep;
-	int num;
+	int num, protocol;
 
 	dev = chip->dev;
 
@@ -2722,10 +2865,9 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		num = 4;
 
 	for (i = 0; i < num; i++) {
-		struct uac_as_header_descriptor_v1 *as;
-
 		alts = &iface->altsetting[i];
 		altsd = get_iface_desc(alts);
+		protocol = altsd->bInterfaceProtocol;
 		/* skip invalid one */
 		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
 		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
@@ -2742,7 +2884,7 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		stream = (get_endpoint(alts, 0)->bEndpointAddress & USB_DIR_IN) ?
 			SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 		altno = altsd->bAlternateSetting;
-
+	
 		/* audiophile usb: skip altsets incompatible with device_setup
 		 */
 		if (chip->usb_id == USB_ID(0x0763, 0x2003) && 
@@ -2750,21 +2892,54 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			continue;
 
 		/* get audio formats */
-		as = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, AS_GENERAL);
+		switch (protocol) {
+		case UAC_VERSION_1: {
+			struct uac_as_header_descriptor_v1 *as =
+				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, AS_GENERAL);
+
+			if (!as) {
+				snd_printk(KERN_ERR "%d:%u:%d : AS_GENERAL descriptor not found\n",
+					   dev->devnum, iface_no, altno);
+				continue;
+			}
 
-		if (!as) {
-			snd_printk(KERN_ERR "%d:%u:%d : AS_GENERAL descriptor not found\n",
-				   dev->devnum, iface_no, altno);
-			continue;
+			if (as->bLength < sizeof(*as)) {
+				snd_printk(KERN_ERR "%d:%u:%d : invalid AS_GENERAL desc\n",
+					   dev->devnum, iface_no, altno);
+				continue;
+			}
+
+			format = le16_to_cpu(as->wFormatTag); /* remember the format value */
+			break;
 		}
 
-		if (as->bLength < sizeof(*as)) {
-			snd_printk(KERN_ERR "%d:%u:%d : invalid AS_GENERAL desc\n",
-				   dev->devnum, iface_no, altno);
-			continue;
+		case UAC_VERSION_2: {
+			struct uac_as_header_descriptor_v2 *as =
+				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, AS_GENERAL);
+
+			if (!as) {
+				snd_printk(KERN_ERR "%d:%u:%d : AS_GENERAL descriptor not found\n",
+					   dev->devnum, iface_no, altno);
+				continue;
+			}
+
+			if (as->bLength < sizeof(*as)) {
+				snd_printk(KERN_ERR "%d:%u:%d : invalid AS_GENERAL desc\n",
+					   dev->devnum, iface_no, altno);
+				continue;
+			}
+
+			num_channels = as->bNrChannels;
+			format = le32_to_cpu(as->bmFormats);
+
+			break;
 		}
 
-		format = le16_to_cpu(as->wFormatTag); /* remember the format value */
+		default:
+			snd_printk(KERN_ERR "%d:%u:%d : unknown interface protocol %04x\n",
+				   dev->devnum, iface_no, altno, protocol);
+			continue;
+		}
 
 		/* get format type */
 		fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, FORMAT_TYPE);
@@ -2773,7 +2948,8 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 				   dev->devnum, iface_no, altno);
 			continue;
 		}
-		if (fmt[0] < 8) {
+		if (((protocol == UAC_VERSION_1) && (fmt[0] < 8)) ||
+		    ((protocol == UAC_VERSION_2) && (fmt[0] != 6))) {
 			snd_printk(KERN_ERR "%d:%u:%d : invalid FORMAT_TYPE desc\n",
 				   dev->devnum, iface_no, altno);
 			continue;
@@ -2787,6 +2963,7 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		if (fmt[4] == 1 && fmt[5] == 2 && altno == 2 && num == 3 &&
 		    fp && fp->altsetting == 1 && fp->channels == 1 &&
 		    fp->format == SNDRV_PCM_FORMAT_S16_LE &&
+		    protocol == UAC_VERSION_1 &&
 		    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) ==
 							fp->maxpacksize * 2)
 			continue;
@@ -2815,6 +2992,8 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
 		fp->datainterval = parse_datainterval(chip, alts);
 		fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+		/* num_channels is only set for v2 interfaces */
+		fp->channels = num_channels;
 		if (snd_usb_get_speed(dev) == USB_SPEED_HIGH)
 			fp->maxpacksize = (((fp->maxpacksize >> 11) & 3) + 1)
 					* (fp->maxpacksize & 0x7ff);
@@ -2850,7 +3029,7 @@ static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 		}
 
 		/* ok, let's parse further... */
-		if (parse_audio_format(chip, fp, format, fmt, stream) < 0) {
+		if (parse_audio_format(chip, fp, format, fmt, stream, alts) < 0) {
 			kfree(fp->rate_table);
 			kfree(fp);
 			continue;
@@ -2958,35 +3137,82 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 {
 	struct usb_device *dev = chip->dev;
 	struct usb_host_interface *host_iface;
-	struct uac_ac_header_descriptor_v1 *h1;
+	struct usb_interface_descriptor *altsd;
 	void *control_header;
-	int i;
+	int i, protocol;
 
 	/* find audiocontrol interface */
 	host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
 	control_header = snd_usb_find_csint_desc(host_iface->extra,
 						 host_iface->extralen,
 						 NULL, HEADER);
+	altsd = get_iface_desc(host_iface);
+	protocol = altsd->bInterfaceProtocol;
 
 	if (!control_header) {
 		snd_printk(KERN_ERR "cannot find HEADER\n");
 		return -EINVAL;
 	}
 
-	h1 = control_header;
+	switch (protocol) {
+	case UAC_VERSION_1: {
+		struct uac_ac_header_descriptor_v1 *h1 = control_header;
 
-	if (!h1->bInCollection) {
-		snd_printk(KERN_INFO "skipping empty audio interface (v1)\n");
-		return -EINVAL;
+		if (!h1->bInCollection) {
+			snd_printk(KERN_INFO "skipping empty audio interface (v1)\n");
+			return -EINVAL;
+		}
+
+		if (h1->bLength < sizeof(*h1) + h1->bInCollection) {
+			snd_printk(KERN_ERR "invalid HEADER (v1)\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < h1->bInCollection; i++)
+			snd_usb_create_stream(chip, ctrlif, h1->baInterfaceNr[i]);
+
+		break;
 	}
 
-	if (h1->bLength < sizeof(*h1) + h1->bInCollection) {
-		snd_printk(KERN_ERR "invalid HEADER (v1)\n");
-		return -EINVAL;
+	case UAC_VERSION_2: {
+		struct uac_clock_source_descriptor *cs;
+		struct usb_interface_assoc_descriptor *assoc =
+			usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
+
+		if (!assoc) {
+			snd_printk(KERN_ERR "Audio class v2 interfaces need an interface association\n");
+			return -EINVAL;
+		}
+
+		/* FIXME: for now, we expect there is at least one clock source
+		 * descriptor and we always take the first one.
+		 * We should properly support devices with multiple clock sources,
+		 * clock selectors and sample rate conversion units. */
+
+		cs = snd_usb_find_csint_desc(host_iface->extra, host_iface->extralen,
+						NULL, CLOCK_SOURCE);
+
+		if (!cs) {
+			snd_printk(KERN_ERR "CLOCK_SOURCE descriptor not found\n");
+			return -EINVAL;
+		}
+
+		chip->clock_id = cs->bClockID;
+
+		for (i = 0; i < assoc->bInterfaceCount; i++) {
+			int intf = assoc->bFirstInterface + i;
+
+			if (intf != ctrlif)
+				snd_usb_create_stream(chip, ctrlif, intf);
+		}
+
+		break;
 	}
 
-	for (i = 0; i < h1->bInCollection; i++)
-		snd_usb_create_stream(chip, ctrlif, h1->baInterfaceNr[i]);
+	default:
+		snd_printk(KERN_ERR "unknown protocol version 0x%02x\n", protocol);
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 4f48293..26daf68 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -142,6 +142,9 @@ struct snd_usb_audio {
 	int num_interfaces;
 	int num_suspended_intf;
 
+	/* for audio class v2 */
+	int clock_id;
+
 	struct list_head pcm_list;	/* list of pcm streams */
 	int pcm_devs;
 
-- 
1.6.6.2
