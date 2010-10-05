From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Tue, 05 Oct 2010 09:21:54 +0200
Message-ID: <4CAAD212.9090805@ladisch.de>
References: <4C9DC7A1.8050001@showlabor.de> <4CA5BF35.2030108@showlabor.de>
	<4CA60C5B.6010809@ladisch.de> <4CA86E1A.30405@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 8CD83103911
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 09:21:12 +0200 (CEST)
In-Reply-To: <4CA86E1A.30405@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>, Alex <lee188@singnet.com.sg>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> Am 01.10.2010 18:29, schrieb Clemens Ladisch:
> > Add an else to the inner if in retire_playback_sync_urb, and log the
> > value of f.
> >
> > The value received in this function should be the desired sample
> > frequency, relative to the USB frame rate.  There are different formats
> > (therefore we have three functions); maybe the FTU uses a fourth one.
> 
> Trying to log the value of f reveals that retire_playback_sync_urb()
> doesn't seem to be called at all.

The entire function or that part of the code?

Anyway, please try the patch below, which makes the driver
autodetect the feedback format.  (The actual format can be
seen in /proc/asound/cardX/stream0 while running.)

Alex, please test this with your widget.


Regards,
Clemens

--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -62,12 +62,14 @@ struct snd_usb_substream {
 	unsigned int syncinterval;  /* P for adaptive mode, 0 otherwise */
 	unsigned int freqn;      /* nominal sampling rate in fs/fps in Q16.16 format */
 	unsigned int freqm;      /* momentary sampling rate in fs/fps in Q16.16 format */
+	int          freqshift;  /* how much to shift the feedback value to get Q16.16 */
 	unsigned int freqmax;    /* maximum sampling rate, used for buffer management */
 	unsigned int phase;      /* phase accumulator */
 	unsigned int maxpacksize;	/* max packet size in bytes */
 	unsigned int maxframesize;	/* max packet size in frames */
 	unsigned int curpacksize;	/* current packet size in bytes (for capture) */
 	unsigned int curframesize;	/* current packet size in frames (for capture) */
+	unsigned int syncmaxsize;	/* sync endpoint packet size */
 	unsigned int fill_max: 1;	/* fill max packet size always */
 	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -237,6 +237,7 @@ static int set_format(struct snd_usb_sub
 	subs->datainterval = fmt->datainterval;
 	subs->syncpipe = subs->syncinterval = 0;
 	subs->maxpacksize = fmt->maxpacksize;
+	subs->syncmaxsize = 0;
 	subs->fill_max = 0;
 
 	/* we need a sync pipe in async OUT or adaptive IN mode */
@@ -283,6 +284,7 @@ static int set_format(struct snd_usb_sub
 			subs->syncinterval = get_endpoint(alts, 1)->bInterval - 1;
 		else
 			subs->syncinterval = 3;
+		subs->syncmaxsize = le16_to_cpu(get_endpoint(alts, 1)->wMaxPacketSize);
 	}
 
 	/* always fill max packet size */
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -132,6 +132,11 @@ static void proc_dump_substream_status(s
 			    ? get_full_speed_hz(subs->freqm)
 			    : get_high_speed_hz(subs->freqm),
 			    subs->freqm >> 16, subs->freqm & 0xffff);
+		if (subs->freqshift != INT_MIN)
+			snd_iprintf(buffer, "    Feedback Format = %d.%d\n",
+				    (subs->syncmaxsize > 3 ? 32 : 24)
+						- (16 - subs->freqshift),
+				    16 - subs->freqshift);
 	} else {
 		snd_iprintf(buffer, "  Status: Stop\n");
 	}
--- a/sound/usb/urb.c
+++ b/sound/usb/urb.c
@@ -225,6 +225,7 @@ int snd_usb_init_substream_urbs(struct s
 	else
 		subs->freqn = get_usb_high_speed_rate(rate);
 	subs->freqm = subs->freqn;
+	subs->freqshift = INT_MIN;
 	/* calculate max. frequency */
 	if (subs->maxpacksize) {
 		/* whatever fits into a max. size packet */
@@ -513,11 +514,10 @@ static int retire_paused_capture_urb(str
 
 
 /*
- * prepare urb for full speed playback sync pipe
+ * prepare urb for playback sync pipe
  *
  * set up the offset and length to receive the current frequency.
  */
-
 static int prepare_playback_sync_urb(struct snd_usb_substream *subs,
 				     struct snd_pcm_runtime *runtime,
 				     struct urb *urb)
@@ -525,103 +525,78 @@ static int prepare_playback_sync_urb(str
 	struct snd_urb_ctx *ctx = urb->context;
 
 	urb->dev = ctx->subs->dev; /* we need to set this at each time */
-	urb->iso_frame_desc[0].length = 3;
+	urb->iso_frame_desc[0].length = min(4u, ctx->subs->syncmaxsize);
 	urb->iso_frame_desc[0].offset = 0;
 	return 0;
 }
 
 /*
- * prepare urb for high speed playback sync pipe
+ * process after playback sync complete
  *
- * set up the offset and length to receive the current frequency.
- */
-
-static int prepare_playback_sync_urb_hs(struct snd_usb_substream *subs,
-					struct snd_pcm_runtime *runtime,
-					struct urb *urb)
-{
-	struct snd_urb_ctx *ctx = urb->context;
-
-	urb->dev = ctx->subs->dev; /* we need to set this at each time */
-	urb->iso_frame_desc[0].length = 4;
-	urb->iso_frame_desc[0].offset = 0;
-	return 0;
-}
-
-/*
- * process after full speed playback sync complete
- *
- * retrieve the current 10.14 frequency from pipe, and set it.
- * the value is referred in prepare_playback_urb().
+ * Full speed devices report feedback values in 10.14 format as samples per
+ * frame, high speed devices in 16.16 format as samples per microframe.
+ * Because the Audio Class 1 spec was written before USB 2.0, many high speed
+ * devices use a wrong interpretation, some others use an entirely different
+ * format.  Therefore, we cannot predict what format any particular device uses
+ * and must detect it automatically.
  */
 static int retire_playback_sync_urb(struct snd_usb_substream *subs,
 				    struct snd_pcm_runtime *runtime,
 				    struct urb *urb)
 {
 	unsigned int f;
+	int shift;
 	unsigned long flags;
 
-	if (urb->iso_frame_desc[0].status == 0 &&
-	    urb->iso_frame_desc[0].actual_length == 3) {
-		f = combine_triple((u8*)urb->transfer_buffer) << 2;
-		if (f >= subs->freqn - subs->freqn / 8 && f <= subs->freqmax) {
-			spin_lock_irqsave(&subs->lock, flags);
-			subs->freqm = f;
-			spin_unlock_irqrestore(&subs->lock, flags);
-		}
-	}
-
-	return 0;
-}
-
-/*
- * process after high speed playback sync complete
- *
- * retrieve the current 12.13 frequency from pipe, and set it.
- * the value is referred in prepare_playback_urb().
- */
-static int retire_playback_sync_urb_hs(struct snd_usb_substream *subs,
-				       struct snd_pcm_runtime *runtime,
-				       struct urb *urb)
-{
-	unsigned int f;
-	unsigned long flags;
-
-	if (urb->iso_frame_desc[0].status == 0 &&
-	    urb->iso_frame_desc[0].actual_length == 4) {
-		f = combine_quad((u8*)urb->transfer_buffer) & 0x0fffffff;
-		if (f >= subs->freqn - subs->freqn / 8 && f <= subs->freqmax) {
-			spin_lock_irqsave(&subs->lock, flags);
-			subs->freqm = f;
-			spin_unlock_irqrestore(&subs->lock, flags);
+	if (urb->iso_frame_desc[0].status != 0 ||
+	    urb->iso_frame_desc[0].actual_length < 3)
+		return 0;
+
+	f = le32_to_cpup((__force __le32 *)urb->transfer_buffer);
+	if (urb->iso_frame_desc[0].actual_length == 3)
+		f &= 0x00ffffff;
+	else
+		f &= 0x0fffffff;
+	if (f == 0)
+		return 0;
+
+	if (unlikely(subs->freqshift == INT_MIN)) {
+		/*
+		 * The first time we see a feedback value, determine its format
+		 * by shifting it left or right until it matches the nominal
+		 * frequency value.  This assumes that the feedback does not
+		 * differ from the nominal value more than +50 % or -25 %.
+		 */
+		shift = 0;
+		while (f < subs->freqn - subs->freqn / 4) {
+			f <<= 1;
+			shift++;
+		}
+		while (f > subs->freqn + subs->freqn / 2) {
+			f >>= 1;
+			shift--;
 		}
+		subs->freqshift = shift;
 	}
+	else if (subs->freqshift >= 0)
+		f <<= subs->freqshift;
+	else
+		f >>= -subs->freqshift;
 
-	return 0;
-}
-
-/*
- * process after E-Mu 0202/0404/Tracker Pre high speed playback sync complete
- *
- * These devices return the number of samples per packet instead of the number
- * of samples per microframe.
- */
-static int retire_playback_sync_urb_hs_emu(struct snd_usb_substream *subs,
-					   struct snd_pcm_runtime *runtime,
-					   struct urb *urb)
-{
-	unsigned int f;
-	unsigned long flags;
-
-	if (urb->iso_frame_desc[0].status == 0 &&
-	    urb->iso_frame_desc[0].actual_length == 4) {
-		f = combine_quad((u8*)urb->transfer_buffer) & 0x0fffffff;
-		f >>= subs->datainterval;
-		if (f >= subs->freqn - subs->freqn / 8 && f <= subs->freqmax) {
-			spin_lock_irqsave(&subs->lock, flags);
-			subs->freqm = f;
-			spin_unlock_irqrestore(&subs->lock, flags);
-		}
+	if (likely(f >= subs->freqn - subs->freqn / 8 && f <= subs->freqmax)) {
+		/*
+		 * If the frequency looks valid, set it.
+		 * This value is referred to in prepare_playback_urb().
+		 */
+		spin_lock_irqsave(&subs->lock, flags);
+		subs->freqm = f;
+		spin_unlock_irqrestore(&subs->lock, flags);
+	} else {
+		/*
+		 * Out of range; maybe the shift value is wrong.
+		 * Reset it so that we autodetect again the next time.
+		 */
+		subs->freqshift = INT_MIN;
 	}
 
 	return 0;
@@ -878,21 +853,6 @@ static struct snd_urb_ops audio_urb_ops[
 	},
 };
 
-static struct snd_urb_ops audio_urb_ops_high_speed[2] = {
-	{
-		.prepare =	prepare_nodata_playback_urb,
-		.retire =	retire_playback_urb,
-		.prepare_sync =	prepare_playback_sync_urb_hs,
-		.retire_sync =	retire_playback_sync_urb_hs,
-	},
-	{
-		.prepare =	prepare_capture_urb,
-		.retire =	retire_capture_urb,
-		.prepare_sync =	prepare_capture_sync_urb_hs,
-		.retire_sync =	retire_capture_sync_urb,
-	},
-};
-
 /*
  * initialize the substream instance.
  */
@@ -909,23 +869,9 @@ void snd_usb_init_substream(struct snd_u
 	subs->direction = stream;
 	subs->dev = as->chip->dev;
 	subs->txfr_quirk = as->chip->txfr_quirk;
-	if (snd_usb_get_speed(subs->dev) == USB_SPEED_FULL) {
-		subs->ops = audio_urb_ops[stream];
-	} else {
-		subs->ops = audio_urb_ops_high_speed[stream];
-		switch (as->chip->usb_id) {
-		case USB_ID(0x041e, 0x3f02): /* E-Mu 0202 USB */
-		case USB_ID(0x041e, 0x3f04): /* E-Mu 0404 USB */
-		case USB_ID(0x041e, 0x3f0a): /* E-Mu Tracker Pre */
-			subs->ops.retire_sync = retire_playback_sync_urb_hs_emu;
-			break;
-		case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra 8  */
-		case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
-			subs->ops.prepare_sync = prepare_playback_sync_urb;
-			subs->ops.retire_sync = retire_playback_sync_urb;
-			break;
-		}
-	}
+	subs->ops = audio_urb_ops[stream];
+	if (snd_usb_get_speed(subs->dev) >= USB_SPEED_HIGH)
+		subs->ops.prepare_sync = prepare_capture_sync_urb_hs;
 
 	snd_usb_set_pcm_ops(as->pcm, stream);
