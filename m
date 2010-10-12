From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Tue, 12 Oct 2010 12:26:00 +0200
Message-ID: <20101012102600.GB7159@buzzloop.caiaq.de>
References: <4CAAD212.9090805@ladisch.de> <4CAC804A.8040806@showlabor.de>
	<4CAC89EA.8080207@ladisch.de> <4CACA471.2000504@showlabor.de>
	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
	<4CADB077.3060907@showlabor.de> <4CAEB9AC.1060208@ladisch.de>
	<20101012071831.GA7159@buzzloop.caiaq.de>
	<4CB419D0.70808@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 84D78244C6
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 12:26:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CB419D0.70808@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 10:18:24AM +0200, Felix Homann wrote:
> Am 12.10.2010 09:18, schrieb Daniel Mack:
> >
> >Felix, can you add a
> >
> >   printk(KERN_WARNING "%s() is_playback %d fill_max %d syncpipe %d\n",
> >   	 __func__, is_playback, subs->fill_max, subs->syncpipe);
> >
> >at the end of set_format() in pcm.c and send us the output?
> 
> 
> Here you go:

Thanks for testing! 

> [195791.510900] set_format() is_playback 0 fill_max 0 syncpipe 0
> [195791.513495] set_format() is_playback 1 fill_max 0 syncpipe 0

Ok, This is what I expected - however, these details aren't enough to
tell whether the device is using implicit feedback, it could also mean
that the OUT endpoint can take any amount of data and applies some kind
of audio data resampling, for example.

So we have to rely on the "usage" fields of the isochronous IN endpoints
and add quirks for all other devices.

> >I have an untested patch ready which should add support for implicit
> >feedback, but I'm uncertain about the condition when to activate this
> >mode.
> 
> That sounds great. I'm looking forward to give it a try!

I attached a patch below, only compile-tested. Please also check the USB
ID again, as I'm not sure whether you sent the right lsusb dump (the
device name looks suspicious).

If that doesn't work, try debugging the value returned by
urb.c:snd_usb_audio_next_packet_size(). For your device, you should end
up in the "subs->stream->implicit_feedback" branch.


Thanks,
Daniel



diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index da2ed77..7825676 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -352,6 +352,11 @@ struct usb_endpoint_descriptor {
 #define USB_ENDPOINT_NUMBER_MASK	0x0f	/* in bEndpointAddress */
 #define USB_ENDPOINT_DIR_MASK		0x80
 
+#define USB_ENDPOINT_USAGE_MASK		0x30
+#define USB_ENDPOINT_USAGE_DATA		0x00
+#define USB_ENDPOINT_USAGE_FEEDBACK	0x10
+#define USB_ENDPOINT_USAGE_IMPLICIT_FB	0x20	/* Implicit feedback Data endpoint */
+
 #define USB_ENDPOINT_SYNCTYPE		0x0c
 #define USB_ENDPOINT_SYNC_NONE		(0 << 2)
 #define USB_ENDPOINT_SYNC_ASYNC		(1 << 2)
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 1febf2f..f91974e 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -71,6 +71,8 @@ struct snd_usb_substream {
 	unsigned int fill_max: 1;	/* fill max packet size always */
 	unsigned int txfr_quirk:1;	/* allow sub-frame alignment */
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
+	unsigned int frame_count;	/* for capture streams acting as implicit
+					 * feedback source */
 
 	unsigned int running: 1;	/* running status */
 
@@ -101,6 +103,8 @@ struct snd_usb_stream {
 	unsigned int fmt_type;		/* USB audio format type (1-3) */
 	struct snd_usb_substream substream[2];
 	struct list_head list;
+	unsigned int implicit_feedback: 1; 	/* stream uses its capture data
+						   substream to clock its playback substream */
 };
 
 #endif /* __USBAUDIO_CARD_H */
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f49756c..7710021 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -289,6 +289,11 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX)
 		subs->fill_max = 1;
 
+	if (!is_playback &&
+	    (fmt->ep_attr & USB_ENDPOINT_XFERTYPE_MASK) == USB_ENDPOINT_XFER_ISOC &&
+	    (fmt->ep_attr & USB_ENDPOINT_USAGE_MASK) == USB_ENDPOINT_USAGE_IMPLICIT_FB)
+		subs->stream->implicit_feedback = 1;
+
 	if ((err = snd_usb_init_pitch(subs->stream->chip, subs->interface, alts, fmt)) < 0)
 		return err;
 
@@ -382,6 +387,7 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 
 	subs->cur_audiofmt = NULL;
 	subs->cur_rate = 0;
+	subs->frame_count = 0;
 	subs->period_bytes = 0;
 	if (!subs->stream->chip->shutdown)
 		snd_usb_release_substream_urbs(subs, 0);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9a9da09..7fbc315 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -591,6 +591,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x041e, 0x3f0a): /* E-Mu Tracker Pre */
 		set_format_emu_quirk(subs, fmt);
 		break;
+	case USB_ID(0x0763, 0x2081): /*  Midiman M-Audio RunTime DFU */
+		subs->stream->implicit_feedback = 1;
+		break;
 	}
 }
 
diff --git a/sound/usb/urb.c b/sound/usb/urb.c
index 8deeaad..84362a4 100644
--- a/sound/usb/urb.c
+++ b/sound/usb/urb.c
@@ -462,6 +462,8 @@ static int retire_capture_urb(struct snd_usb_substream *subs,
 			// continue;
 		}
 		bytes = urb->iso_frame_desc[i].actual_length;
+		if (subs->stream->implicit_feedback)
+			subs->frame_count += bytes_to_frames(runtime, bytes);
 		frames = bytes / stride;
 		if (!subs->txfr_quirk)
 			bytes = frames * stride;
@@ -502,12 +504,26 @@ static int retire_capture_urb(struct snd_usb_substream *subs,
 }
 
 /*
- * Process after capture complete when paused.  Nothing to do.
+ * Process after capture complete when paused. We need to count the number of
+ * bytes received and increase subs->frame_count in case this capture stream
+ * is used as implicit feedback source.
  */
 static int retire_paused_capture_urb(struct snd_usb_substream *subs,
 				     struct snd_pcm_runtime *runtime,
 				     struct urb *urb)
 {
+	if (subs->stream->implicit_feedback) {
+		unsigned long flags;
+		unsigned int i, bytes = 0;
+
+		for (i = 0; i < urb->number_of_packets; i++)
+			bytes += urb->iso_frame_desc[i].actual_length;
+
+		spin_lock_irqsave(&subs->lock, flags);
+		subs->frame_count += bytes_to_frames(runtime, bytes);
+		spin_unlock_irqrestore(&subs->lock, flags);
+	}
+
 	return 0;
 }
 
@@ -630,13 +646,28 @@ static int retire_playback_sync_urb_hs_emu(struct snd_usb_substream *subs,
 /* determine the number of frames in the next packet */
 static int snd_usb_audio_next_packet_size(struct snd_usb_substream *subs)
 {
+	if (subs->stream->implicit_feedback) {
+		unsigned int frames;
+		unsigned long flags;
+		struct snd_usb_substream *capture =
+			&subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE];
+
+		if (WARN_ONCE(!capture, "implicit feedback with no capture stream is impossible"))
+			return 0;
+
+		spin_lock_irqsave(&capture->lock, flags);
+		frames = min(capture->frame_count, subs->maxframesize);
+		capture->frame_count -= frames;
+		spin_unlock_irqrestore(&capture->lock, flags);
+
+		return frames;
+	}
+
 	if (subs->fill_max)
 		return subs->maxframesize;
-	else {
-		subs->phase = (subs->phase & 0xffff)
-			+ (subs->freqm << subs->datainterval);
-		return min(subs->phase >> 16, subs->maxframesize);
-	}
+
+	subs->phase = (subs->phase & 0xffff) + (subs->freqm << subs->datainterval);
+	return min(subs->phase >> 16, subs->maxframesize);
 }
 
 /*
@@ -959,6 +990,24 @@ int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int c
 {
 	struct snd_usb_substream *subs = substream->runtime->private_data;
 
+	if (subs->stream->implicit_feedback) {
+		/* for capture streams used as implicitc feedback source for
+		 * other streams, we must not stop the stream. instead, we
+		 * just put it to pause mode.
+		 */
+
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			subs->ops.retire = retire_capture_urb;
+			return 0;
+		case SNDRV_PCM_TRIGGER_STOP:
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			subs->ops.retire = retire_paused_capture_urb;
+			return 0;
+		}
+	}
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		subs->ops.retire = retire_capture_urb;
@@ -986,7 +1035,23 @@ int snd_usb_substream_prepare(struct snd_usb_substream *subs,
 	/* for playback, submit the URBs now; otherwise, the first hwptr_done
 	 * updates for all URBs would happen at the same time when starting */
 	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		struct snd_usb_substream *capture =
+			&subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE];
+
 		subs->ops.prepare = prepare_nodata_playback_urb;
+
+		/* if this stream is in implicit feedback mode, start the
+		 * capture stream now as the playback stream relies on the
+		 * amount of data we see on the capture IN endpoint.
+		 */
+		if (subs->stream->implicit_feedback && !capture->running) {
+			int ret;
+			capture->ops.retire = retire_paused_capture_urb;
+			ret = start_urbs(capture, runtime);
+			if (ret)
+				return ret;
+		}
+
 		return start_urbs(subs, runtime);
 	}
