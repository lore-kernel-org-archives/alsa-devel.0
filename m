From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RESENT] [PATCH - Fix Fast Track Ultra series:
 44.1/88.1 kHz 1/Fix playback/capture issues and related	chrashes at 44100
 Hz and 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 02 Sep 2010 13:13:48 +0200
Message-ID: <4C7F86EC.3080604@ladisch.de>
References: <4C32E3B2.5080707@web.de>
	<4C7E1376.9030208@web.de>	<s5hk4n4zgrn.wl%tiwai@suse.de>
	<4C7F6A9B.5010707@ladisch.de>
	<20100902091649.GK17833@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E87F1246B2
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 13:13:19 +0200 (CEST)
In-Reply-To: <20100902091649.GK17833@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On Thu, Sep 02, 2010 at 11:12:59AM +0200, Clemens Ladisch wrote:
> > > > Also, the Interface Class protocol for the device defaults to Vendor 
> > > > Specific Class, but the driver only recognizes Class 1 or 2. The device 
> > > > is really Class 1, so we have to force it to reflect this. There are 4 
> > > > places that we need to set this."
> > 
> > Daniel, this seems to be a regression introduced with the UAC2 changes.
> > The old driver accepted vendor-specific interfaces, if some quirk forced
> > it to look at them.
> 
> Hmm, I don't follow. What's the problem, and why should that be caused
> by the UAC2 changes? Sorry, but I seem to have missed that thread.

I've got several reports that devices no longer work since UAC2 support got
added.  But I've just noticed this is not related to the interface class
but to the interface protocol: the new code added checks for UAC_VERSION_1
or _2, but real devices apparently write just random junk into this field.
(For vendor-specific interfaces, they are actually justified to do so.)

We need something like the following (untested), unless you have a better
idea:

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 9feb00c..d5141a1 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -216,6 +216,10 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 	}
 
 	switch (protocol) {
+	default:
+		snd_printdd(KERN_WARN "unknown interface protocol %#02x, assuming v1\n");
+		/* fall through */
+
 	case UAC_VERSION_1: {
 		struct uac1_ac_header_descriptor *h1 = control_header;
 
@@ -253,10 +257,6 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 
 		break;
 	}
-
-	default:
-		snd_printk(KERN_ERR "unknown protocol version 0x%02x\n", protocol);
-		return -EINVAL;
 	}
 
 	return 0;
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index b853f8d..7754a10 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -295,12 +295,11 @@ int snd_usb_init_sample_rate(struct snd_usb_audio *chip, int iface,
 
 	switch (altsd->bInterfaceProtocol) {
 	case UAC_VERSION_1:
+	default:
 		return set_sample_rate_v1(chip, iface, alts, fmt, rate);
 
 	case UAC_VERSION_2:
 		return set_sample_rate_v2(chip, iface, alts, fmt, rate);
 	}
-
-	return -EINVAL;
 }
 
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index bb9f938..22589b5 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -275,6 +275,12 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 
 		/* get audio formats */
 		switch (protocol) {
+		default:
+			snd_printdd(KERN_WARN "%d:%u:%d: unknown interface protocol %#02x, assuming v1\n",
+				    dev->devnum, iface_no, altno, protocol);
+			protocol = UAC_VERSION_1;
+			/* fall through */
+
 		case UAC_VERSION_1: {
 			struct uac1_as_header_descriptor *as =
 				snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, UAC_AS_GENERAL);
@@ -336,11 +342,6 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 				   dev->devnum, iface_no, altno, as->bTerminalLink);
 			continue;
 		}
-
-		default:
-			snd_printk(KERN_ERR "%d:%u:%d : unknown interface protocol %04x\n",
-				   dev->devnum, iface_no, altno, protocol);
-			continue;
 		}
 
 		/* get format type */
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 4387f54..2ec73dd 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -49,7 +49,8 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 	u64 pcm_formats;
 
 	switch (protocol) {
-	case UAC_VERSION_1: {
+	case UAC_VERSION_1:
+	default: {
 		struct uac_format_type_i_discrete_descriptor *fmt = _fmt;
 		sample_width = fmt->bBitResolution;
 		sample_bytes = fmt->bSubframeSize;
@@ -64,9 +65,6 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		format <<= 1;
 		break;
 	}
-
-	default:
-		return -EINVAL;
 	}
 
 	pcm_formats = 0;
@@ -385,6 +383,7 @@ static int parse_audio_format_i(struct snd_usb_audio *chip,
 	 */
 	switch (protocol) {
 	case UAC_VERSION_1:
+	default:
 		fp->channels = fmt->bNrChannels;
 		ret = parse_audio_format_rates_v1(chip, fp, (unsigned char *) fmt, 7);
 		break;
@@ -434,7 +433,8 @@ static int parse_audio_format_ii(struct snd_usb_audio *chip,
 	fp->channels = 1;
 
 	switch (protocol) {
-	case UAC_VERSION_1: {
+	case UAC_VERSION_1:
+	default: {
 		struct uac_format_type_ii_discrete_descriptor *fmt = _fmt;
 		brate = le16_to_cpu(fmt->wMaxBitRate);
 		framesize = le16_to_cpu(fmt->wSamplesPerFrame);
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index c166db0..0478fa3 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -365,7 +365,7 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request, int v
 
 static int get_ctl_value(struct usb_mixer_elem_info *cval, int request, int validx, int *value_ret)
 {
-	return (cval->mixer->protocol == UAC_VERSION_1) ?
+	return (cval->mixer->protocol != UAC_VERSION_2) ?
 		get_ctl_value_v1(cval, request, validx, value_ret) :
 		get_ctl_value_v2(cval, request, validx, value_ret);
 }
@@ -415,7 +415,7 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 	unsigned char buf[2];
 	int val_len, timeout = 10;
 
-	if (cval->mixer->protocol == UAC_VERSION_1) {
+	if (cval->mixer->protocol != UAC_VERSION_2) {
 		val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
 	} else { /* UAC_VERSION_2 */
 		/* audio class v2 controls are always 2 bytes in size */
@@ -642,7 +642,7 @@ static int check_input_term(struct mixer_build *state, int id, struct usb_audio_
 		term->id = id;
 		switch (hdr[2]) {
 		case UAC_INPUT_TERMINAL:
-			if (state->mixer->protocol == UAC_VERSION_1) {
+			if (state->mixer->protocol != UAC_VERSION_2) {
 				struct uac_input_terminal_descriptor *d = p1;
 				term->type = le16_to_cpu(d->wTerminalType);
 				term->channels = d->bNrChannels;
@@ -1159,7 +1159,7 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 	struct uac_feature_unit_descriptor *hdr = _ftr;
 	__u8 *bmaControls;
 
-	if (state->mixer->protocol == UAC_VERSION_1) {
+	if (state->mixer->protocol != UAC_VERSION_2) {
 		csize = hdr->bControlSize;
 		channels = (hdr->bLength - 7) / csize - 1;
 		bmaControls = hdr->bmaControls;
@@ -1198,7 +1198,7 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 	else
 		first_ch_bits = 0;
 
-	if (state->mixer->protocol == UAC_VERSION_1) {
+	if (state->mixer->protocol != UAC_VERSION_2) {
 		/* check all control types */
 		for (i = 0; i < 10; i++) {
 			unsigned int ch_bits = 0;
@@ -1865,13 +1865,13 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 		return parse_audio_feature_unit(state, unitid, p1);
 	case UAC1_PROCESSING_UNIT:
 	/*   UAC2_EFFECT_UNIT has the same value */
-		if (state->mixer->protocol == UAC_VERSION_1)
+		if (state->mixer->protocol != UAC_VERSION_2)
 			return parse_audio_processing_unit(state, unitid, p1);
 		else
 			return 0; /* FIXME - effect units not implemented yet */
 	case UAC1_EXTENSION_UNIT:
 	/*   UAC2_PROCESSING_UNIT_V2 has the same value */
-		if (state->mixer->protocol == UAC_VERSION_1)
+		if (state->mixer->protocol != UAC_VERSION_2)
 			return parse_audio_extension_unit(state, unitid, p1);
 		else /* UAC_VERSION_2 */
 			return parse_audio_processing_unit(state, unitid, p1);
@@ -1932,7 +1932,7 @@ static int snd_usb_mixer_controls(struct usb_mixer_interface *mixer)
 
 	p = NULL;
 	while ((p = snd_usb_find_csint_desc(hostif->extra, hostif->extralen, p, UAC_OUTPUT_TERMINAL)) != NULL) {
-		if (mixer->protocol == UAC_VERSION_1) {
+		if (mixer->protocol != UAC_VERSION_2) {
 			struct uac1_output_terminal_descriptor *desc = p;
 
 			if (desc->bLength < sizeof(*desc))
@@ -2070,7 +2070,7 @@ static void snd_usb_mixer_interrupt(struct urb *urb)
 	if (urb->status != 0)
 		goto requeue;
 
-	if (mixer->protocol == UAC_VERSION_1) {
+	if (mixer->protocol != UAC_VERSION_2) {
 		struct uac1_status_word *status;
 
 		for (status = urb->transfer_buffer;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 3634ced..3b5135c 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -173,13 +173,12 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 
 	switch (altsd->bInterfaceProtocol) {
 	case UAC_VERSION_1:
+	default:
 		return init_pitch_v1(chip, iface, alts, fmt);
 
 	case UAC_VERSION_2:
 		return init_pitch_v2(chip, iface, alts, fmt);
 	}
-
-	return -EINVAL;
 }
 
 /*
