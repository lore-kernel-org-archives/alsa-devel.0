From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 2/3] ALSA: usb-audio: use a format bitmask per
	alternate setting
Date: Mon, 01 Mar 2010 12:27:44 +0100
Message-ID: <4B8BA4B0.8010401@ladisch.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
	<1267194883-6854-3-git-send-email-daniel@caiaq.de>
	<1267194883-6854-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9C7AD103855
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 12:27:45 +0100 (CET)
In-Reply-To: <1267194883-6854-4-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In preparation for USB audio 2.0 support, change the audioformat
structure so that it uses a bitmask to specify possible formats.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- linux/sound/usb/card.h
+++ linux/sound/usb/card.h
@@ -9,7 +9,7 @@
 
 struct audioformat {
 	struct list_head list;
-	snd_pcm_format_t format;	/* format type */
+	u64 formats;			/* ALSA format bits */
 	unsigned int channels;		/* # channels */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
 	unsigned int frame_size;	/* samples per frame for non-audio */
--- linux/sound/usb/endpoint.c
+++ linux/sound/usb/endpoint.c
@@ -94,7 +94,7 @@ int snd_usb_add_audio_endpoint(struct sn
 		if (subs->endpoint == fp->endpoint) {
 			list_add_tail(&fp->list, &subs->fmt_list);
 			subs->num_formats++;
-			subs->formats |= 1ULL << fp->format;
+			subs->formats |= fp->formats;
 			return 0;
 		}
 	}
@@ -268,7 +268,7 @@ int snd_usb_parse_audio_endpoints(struct
 		 */
 		if (fmt[4] == 1 && fmt[5] == 2 && altno == 2 && num == 3 &&
 		    fp && fp->altsetting == 1 && fp->channels == 1 &&
-		    fp->format == SNDRV_PCM_FORMAT_S16_LE &&
+		    fp->formats == SNDRV_PCM_FMTBIT_S16_LE &&
 		    protocol == UAC_VERSION_1 &&
 		    le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize) ==
 							fp->maxpacksize * 2)
--- linux/sound/usb/format.c
+++ linux/sound/usb/format.c
@@ -319,7 +319,7 @@ static int parse_audio_format_i(struct s
 			return -1;
 	}
 
-	fp->format = pcm_format;
+	fp->formats = 1uLL << pcm_format;
 
 	/* gather possible sample rates */
 	/* audio class v1 reports possible sample rates as part of the
@@ -361,16 +361,16 @@ static int parse_audio_format_ii(struct 
 	switch (format) {
 	case UAC_FORMAT_TYPE_II_AC3:
 		/* FIXME: there is no AC3 format defined yet */
-		// fp->format = SNDRV_PCM_FORMAT_AC3;
-		fp->format = SNDRV_PCM_FORMAT_U8; /* temporarily hack to receive byte streams */
+		// fp->formats = SNDRV_PCM_FMTBIT_AC3;
+		fp->formats = SNDRV_PCM_FMTBIT_U8; /* temporary hack to receive byte streams */
 		break;
 	case UAC_FORMAT_TYPE_II_MPEG:
-		fp->format = SNDRV_PCM_FORMAT_MPEG;
+		fp->formats = SNDRV_PCM_FMTBIT_MPEG;
 		break;
 	default:
 		snd_printd(KERN_INFO "%d:%u:%d : unknown format tag %#x is detected.  processed as MPEG.\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting, format);
-		fp->format = SNDRV_PCM_FORMAT_MPEG;
+		fp->formats = SNDRV_PCM_FMTBIT_MPEG;
 		break;
 	}
 
--- linux/sound/usb/pcm.c
+++ linux/sound/usb/pcm.c
@@ -58,7 +58,9 @@ static struct audioformat *find_format(s
 	list_for_each(p, &subs->fmt_list) {
 		struct audioformat *fp;
 		fp = list_entry(p, struct audioformat, list);
-		if (fp->format != format || fp->channels != channels)
+		if (!(fp->formats & (1uLL << format)))
+			continue;
+		if (fp->channels != channels)
 			continue;
 		if (rate < fp->rate_min || rate > fp->rate_max)
 			continue;
@@ -428,10 +430,15 @@ static int hw_check_valid_format(struct 
 	struct snd_interval *ct = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_mask *fmts = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	struct snd_interval *pt = hw_param_interval(params, SNDRV_PCM_HW_PARAM_PERIOD_TIME);
+	struct snd_mask check_fmts;
 	unsigned int ptime;
 
 	/* check the format */
-	if (!snd_mask_test(fmts, fp->format)) {
+	snd_mask_none(&check_fmts);
+	check_fmts.bits[0] = (u32)fp->formats;
+	check_fmts.bits[1] = (u32)(fp->formats >> 32);
+	snd_mask_intersect(&check_fmts, fmts);
+	if (snd_mask_empty(&check_fmts)) {
 		hwc_debug("   > check: no supported format %d\n", fp->format);
 		return 0;
 	}
@@ -584,7 +591,7 @@ static int hw_rule_format(struct snd_pcm
 		fp = list_entry(p, struct audioformat, list);
 		if (!hw_check_valid_format(subs, params, fp))
 			continue;
-		fbits |= (1ULL << fp->format);
+		fbits |= fp->formats;
 	}
 
 	oldbits[0] = fmt->bits[0];
--- linux/sound/usb/proc.c
+++ linux/sound/usb/proc.c
@@ -79,11 +79,16 @@ static void proc_dump_substream_formats(
 
 	list_for_each(p, &subs->fmt_list) {
 		struct audioformat *fp;
+		snd_pcm_format_t fmt;
 		fp = list_entry(p, struct audioformat, list);
 		snd_iprintf(buffer, "  Interface %d\n", fp->iface);
 		snd_iprintf(buffer, "    Altset %d\n", fp->altsetting);
-		snd_iprintf(buffer, "    Format: %s\n",
-			    snd_pcm_format_name(fp->format));
+		snd_iprintf(buffer, "    Format:");
+		for (fmt = 0; fmt <= SNDRV_PCM_FORMAT_LAST; ++fmt)
+			if (fp->formats & (1uLL << fmt))
+				snd_iprintf(buffer, " %s",
+					    snd_pcm_format_name(fmt));
+		snd_iprintf(buffer, "\n");
 		snd_iprintf(buffer, "    Channels: %d\n", fp->channels);
 		snd_iprintf(buffer, "    Endpoint: %d %s (%s)\n",
 			    fp->endpoint & USB_ENDPOINT_NUMBER_MASK,
--- linux/sound/usb/quirks-table.h
+++ linux/sound/usb/quirks-table.h
@@ -279,7 +279,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = & (const struct audioformat) {
-					.format = SNDRV_PCM_FORMAT_S16_LE,
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 4,
 					.iface = 0,
 					.altsetting = 1,
@@ -296,7 +296,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = & (const struct audioformat) {
-					.format = SNDRV_PCM_FORMAT_S16_LE,
+					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 1,
 					.altsetting = 1,
@@ -580,7 +580,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 0,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = & (const struct audioformat) {
-					.format = SNDRV_PCM_FORMAT_S24_3LE,
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 0,
 					.altsetting = 1,
@@ -597,7 +597,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = & (const struct audioformat) {
-					.format = SNDRV_PCM_FORMAT_S24_3LE,
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 1,
 					.altsetting = 1,
@@ -793,7 +793,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = & (const struct audioformat) {
-					.format = SNDRV_PCM_FORMAT_S24_3LE,
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 1,
 					.altsetting = 1,
@@ -810,7 +810,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = 2,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
 				.data = & (const struct audioformat) {
-					.format = SNDRV_PCM_FORMAT_S24_3LE,
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 2,
 					.altsetting = 1,
--- linux/sound/usb/quirks.c
+++ linux/sound/usb/quirks.c
@@ -174,7 +174,7 @@ static int create_uaxx_quirk(struct snd_
 			     const struct snd_usb_audio_quirk *quirk)
 {
 	static const struct audioformat ua_format = {
-		.format = SNDRV_PCM_FORMAT_S24_3LE,
+		.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 		.channels = 2,
 		.fmt_type = UAC_FORMAT_TYPE_I,
 		.altsetting = 1,
--- linux/sound/usb/urb.c
+++ linux/sound/usb/urb.c
@@ -662,7 +662,7 @@ static int prepare_nodata_playback_urb(s
 	urb->number_of_packets = ctx->packets;
 	urb->transfer_buffer_length = offs * stride;
 	memset(urb->transfer_buffer,
-	       subs->cur_audiofmt->format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0,
+	       runtime->format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0,
 	       offs * stride);
 	return 0;
 }
@@ -924,7 +924,7 @@ void snd_usb_init_substream(struct snd_u
 	snd_usb_set_pcm_ops(as->pcm, stream);
 
 	list_add_tail(&fp->list, &subs->fmt_list);
-	subs->formats |= 1ULL << fp->format;
+	subs->formats |= fp->formats;
 	subs->endpoint = fp->endpoint;
 	subs->num_formats++;
 	subs->fmt_type = fp->fmt_type;
