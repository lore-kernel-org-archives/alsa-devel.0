From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/6] ALSA: snd-usb: switch over to new endpoint
	streaming logic
Date: Thu, 12 Apr 2012 13:51:12 +0200
Message-ID: <1334231475-20980-4-git-send-email-zonque@gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id D70562417E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Apr 2012 13:51:25 +0200 (CEST)
In-Reply-To: <1334231475-20980-1-git-send-email-zonque@gmail.com>
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
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

With the previous commit that added the new streaming model, all
endpoint and streaming related code is now in endpoint.c, and pcm.c
only acts as a wrapper for handling the packet's payload.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.c     |    8 +-
 sound/usb/card.h     |    4 +
 sound/usb/endpoint.c |   40 -----
 sound/usb/endpoint.h |    3 -
 sound/usb/pcm.c      |  418 +++++++++++++++++++++++++++++++++++++++++---------
 sound/usb/stream.c   |   31 ++++-
 6 files changed, 385 insertions(+), 119 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 6bc88b7..d5b5c33 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -131,8 +131,9 @@ static void snd_usb_stream_disconnect(struct list_head *head)
 		subs = &as->substream[idx];
 		if (!subs->num_formats)
 			continue;
-		snd_usb_release_substream_urbs(subs, 1);
 		subs->interface = -1;
+		subs->data_endpoint = NULL;
+		subs->sync_endpoint = NULL;
 	}
 }
 
@@ -350,6 +351,7 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
 	chip->usb_id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
 			      le16_to_cpu(dev->descriptor.idProduct));
 	INIT_LIST_HEAD(&chip->pcm_list);
+	INIT_LIST_HEAD(&chip->ep_list);
 	INIT_LIST_HEAD(&chip->midi_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
@@ -567,6 +569,10 @@ static void snd_usb_audio_disconnect(struct usb_device *dev,
 		list_for_each(p, &chip->pcm_list) {
 			snd_usb_stream_disconnect(p);
 		}
+		/* release the endpoint resources */
+		list_for_each(p, &chip->ep_list) {
+			snd_usb_endpoint_free(p);
+		}
 		/* release the midi resources */
 		list_for_each(p, &chip->midi_list) {
 			snd_usbmidi_disconnect(p);
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 9acbd4a..8a08687 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -145,6 +145,10 @@ struct snd_usb_substream {
 	struct snd_urb_ctx syncurb[SYNC_URBS];	/* sync urb table */
 	char *syncbuf;				/* sync buffer for all sync URBs */
 	dma_addr_t sync_dma;			/* DMA address of syncbuf */
+	/* data and sync endpoints for this stream */
+	struct snd_usb_endpoint *data_endpoint;
+	struct snd_usb_endpoint *sync_endpoint;
+	unsigned long flags;
 
 	u64 formats;			/* format bitmasks (all or'ed) */
 	unsigned int num_formats;		/* number of supported audio formats (list) */
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 56f1810..c7f9bcf 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -912,46 +912,6 @@ void snd_usb_init_substream(struct snd_usb_stream *as,
 	subs->fmt_type = fp->fmt_type;
 }
 
-int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_usb_substream *subs = substream->runtime->private_data;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		subs->ops.prepare = prepare_playback_urb;
-		return 0;
-	case SNDRV_PCM_TRIGGER_STOP:
-		return deactivate_urbs_old(subs, 0, 0);
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		subs->ops.prepare = prepare_nodata_playback_urb;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int cmd)
-{
-	struct snd_usb_substream *subs = substream->runtime->private_data;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		subs->ops.retire = retire_capture_urb;
-		return start_urbs(subs, substream->runtime);
-	case SNDRV_PCM_TRIGGER_STOP:
-		return deactivate_urbs_old(subs, 0, 0);
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		subs->ops.retire = retire_paused_capture_urb;
-		return 0;
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		subs->ops.retire = retire_capture_urb;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 int snd_usb_substream_prepare(struct snd_usb_substream *subs,
 			      struct snd_pcm_runtime *runtime)
 {
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index 9f083d7..e540768 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -15,9 +15,6 @@ void snd_usb_release_substream_urbs(struct snd_usb_substream *subs, int force);
 int snd_usb_substream_prepare(struct snd_usb_substream *subs,
 			      struct snd_pcm_runtime *runtime);
 
-int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substream, int cmd);
-int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int cmd);
-
 
 #define SND_USB_ENDPOINT_TYPE_DATA     0
 #define SND_USB_ENDPOINT_TYPE_SYNC     1
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 0eed611..0f10783 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -16,6 +16,7 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/ratelimit.h>
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
 #include <linux/usb/audio-v2.h>
@@ -34,6 +35,9 @@
 #include "clock.h"
 #include "power.h"
 
+#define SUBSTREAM_FLAG_DATA_EP_STARTED	0
+#define SUBSTREAM_FLAG_SYNC_EP_STARTED	1
+
 /* return the estimated delay based on USB frame counters */
 snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
 				    unsigned int rate)
@@ -208,6 +212,84 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 	}
 }
 
+static int start_endpoints(struct snd_usb_substream *subs)
+{
+	int err;
+
+	if (!subs->data_endpoint)
+		return -EINVAL;
+
+	if (!test_and_set_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags)) {
+		struct snd_usb_endpoint *ep = subs->data_endpoint;
+
+		snd_printdd(KERN_DEBUG "Starting data EP @%p\n", ep);
+
+		ep->data_subs = subs;
+		err = snd_usb_endpoint_start(ep);
+		if (err < 0) {
+			clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags);
+			return err;
+		}
+	}
+
+	if (subs->sync_endpoint &&
+	    !test_and_set_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags)) {
+		struct snd_usb_endpoint *ep = subs->sync_endpoint;
+
+		snd_printdd(KERN_DEBUG "Starting sync EP @%p\n", ep);
+
+		ep->sync_slave = subs->data_endpoint;
+		err = snd_usb_endpoint_start(ep);
+		if (err < 0) {
+			clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static void stop_endpoints(struct snd_usb_substream *subs,
+			   int force, int can_sleep, int wait)
+{
+	if (test_and_clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags))
+		snd_usb_endpoint_stop(subs->sync_endpoint,
+				      force, can_sleep, wait);
+
+	if (test_and_clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags))
+		snd_usb_endpoint_stop(subs->data_endpoint,
+				      force, can_sleep, wait);
+}
+
+static int activate_endpoints(struct snd_usb_substream *subs)
+{
+	if (subs->sync_endpoint) {
+		int ret;
+
+		ret = snd_usb_endpoint_activate(subs->sync_endpoint);
+		if (ret < 0)
+			return ret;
+	}
+
+	return snd_usb_endpoint_activate(subs->data_endpoint);
+}
+
+static int deactivate_endpoints(struct snd_usb_substream *subs)
+{
+	int reta, retb;
+
+	reta = snd_usb_endpoint_deactivate(subs->sync_endpoint);
+	retb = snd_usb_endpoint_deactivate(subs->data_endpoint);
+
+	if (reta < 0)
+		return reta;
+
+	if (retb < 0)
+		return retb;
+
+	return 0;
+}
+
 /*
  * find a matching format and set up the interface
  */
@@ -232,40 +314,11 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (fmt == subs->cur_audiofmt)
 		return 0;
 
-	/* close the old interface */
-	if (subs->interface >= 0 && subs->interface != fmt->iface) {
-		if (usb_set_interface(subs->dev, subs->interface, 0) < 0) {
-			snd_printk(KERN_ERR "%d:%d:%d: return to setting 0 failed\n",
-				dev->devnum, fmt->iface, fmt->altsetting);
-			return -EIO;
-		}
-		subs->interface = -1;
-		subs->altset_idx = 0;
-	}
-
-	/* set interface */
-	if (subs->interface != fmt->iface || subs->altset_idx != fmt->altset_idx) {
-		if (usb_set_interface(dev, fmt->iface, fmt->altsetting) < 0) {
-			snd_printk(KERN_ERR "%d:%d:%d: usb_set_interface failed\n",
-				   dev->devnum, fmt->iface, fmt->altsetting);
-			return -EIO;
-		}
-		snd_printdd(KERN_INFO "setting usb interface %d:%d\n", fmt->iface, fmt->altsetting);
-		subs->interface = fmt->iface;
-		subs->altset_idx = fmt->altset_idx;
-	}
-
-	/* create a data pipe */
-	ep = fmt->endpoint & USB_ENDPOINT_NUMBER_MASK;
-	if (is_playback)
-		subs->datapipe = usb_sndisocpipe(dev, ep);
-	else
-		subs->datapipe = usb_rcvisocpipe(dev, ep);
-	subs->datainterval = fmt->datainterval;
-	subs->syncpipe = subs->syncinterval = 0;
-	subs->maxpacksize = fmt->maxpacksize;
-	subs->syncmaxsize = 0;
-	subs->fill_max = 0;
+	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
+						   alts, fmt->endpoint, subs->direction,
+						   SND_USB_ENDPOINT_TYPE_DATA);
+	if (!subs->data_endpoint)
+		return -EINVAL;
 
 	/* we need a sync pipe in async OUT or adaptive IN mode */
 	/* check the number of EP, since some devices have broken
@@ -276,6 +329,15 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
 	     (! is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
 	    altsd->bNumEndpoints >= 2) {
+		switch (subs->stream->chip->usb_id) {
+		case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
+		case USB_ID(0x0763, 0x2081):
+			ep = 0x81;
+			iface = usb_ifnum_to_if(dev, 2);
+			alts = &iface->altsetting[1];
+			goto add_sync_ep;
+		}
+
 		/* check sync-pipe endpoint */
 		/* ... and check descriptor size before accessing bSynchAddress
 		   because there is a version of the SB Audigy 2 NX firmware lacking
@@ -295,28 +357,16 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 				   dev->devnum, fmt->iface, fmt->altsetting);
 			return -EINVAL;
 		}
-		ep &= USB_ENDPOINT_NUMBER_MASK;
-		if (is_playback)
-			subs->syncpipe = usb_rcvisocpipe(dev, ep);
-		else
-			subs->syncpipe = usb_sndisocpipe(dev, ep);
-		if (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
-		    get_endpoint(alts, 1)->bRefresh >= 1 &&
-		    get_endpoint(alts, 1)->bRefresh <= 9)
-			subs->syncinterval = get_endpoint(alts, 1)->bRefresh;
-		else if (snd_usb_get_speed(subs->dev) == USB_SPEED_FULL)
-			subs->syncinterval = 1;
-		else if (get_endpoint(alts, 1)->bInterval >= 1 &&
-			 get_endpoint(alts, 1)->bInterval <= 16)
-			subs->syncinterval = get_endpoint(alts, 1)->bInterval - 1;
-		else
-			subs->syncinterval = 3;
-		subs->syncmaxsize = le16_to_cpu(get_endpoint(alts, 1)->wMaxPacketSize);
-	}
-
-	/* always fill max packet size */
-	if (fmt->attributes & UAC_EP_CS_ATTR_FILL_MAX)
-		subs->fill_max = 1;
+add_sync_ep:
+		subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
+							   alts, ep, !subs->direction,
+							   SND_USB_ENDPOINT_TYPE_SYNC);
+
+		if (!subs->sync_endpoint)
+			return -EINVAL;
+
+		subs->data_endpoint->sync_master = subs->sync_endpoint;
+	}
 
 	if ((err = snd_usb_init_pitch(subs->stream->chip, subs->interface, alts, fmt)) < 0)
 		return err;
@@ -390,12 +440,22 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	if (changed) {
 		mutex_lock(&subs->stream->chip->shutdown_mutex);
 		/* format changed */
-		snd_usb_release_substream_urbs(subs, 0);
-		/* influenced: period_bytes, channels, rate, format, */
-		ret = snd_usb_init_substream_urbs(subs, params_period_bytes(hw_params),
-						  params_rate(hw_params),
-						  snd_pcm_format_physical_width(params_format(hw_params)) *
-							params_channels(hw_params));
+		stop_endpoints(subs, 0, 0, 0);
+		deactivate_endpoints(subs);
+
+		ret = activate_endpoints(subs);
+		if (ret < 0)
+			goto unlock;
+
+		ret = snd_usb_endpoint_set_params(subs->data_endpoint, hw_params, fmt,
+						  subs->sync_endpoint);
+		if (ret < 0)
+			goto unlock;
+
+		if (subs->sync_endpoint)
+			ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
+							  hw_params, fmt, NULL);
+unlock:
 		mutex_unlock(&subs->stream->chip->shutdown_mutex);
 	}
 
@@ -415,7 +475,7 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	subs->cur_rate = 0;
 	subs->period_bytes = 0;
 	mutex_lock(&subs->stream->chip->shutdown_mutex);
-	snd_usb_release_substream_urbs(subs, 0);
+	stop_endpoints(subs, 0, 1, 1);
 	mutex_unlock(&subs->stream->chip->shutdown_mutex);
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
@@ -435,19 +495,28 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		return -ENXIO;
 	}
 
+	if (snd_BUG_ON(!subs->data_endpoint))
+		return -EIO;
+
 	/* some unit conversions in runtime */
-	subs->maxframesize = bytes_to_frames(runtime, subs->maxpacksize);
-	subs->curframesize = bytes_to_frames(runtime, subs->curpacksize);
+	subs->data_endpoint->maxframesize =
+		bytes_to_frames(runtime, subs->data_endpoint->maxpacksize);
+	subs->data_endpoint->curframesize =
+		bytes_to_frames(runtime, subs->data_endpoint->curpacksize);
 
 	/* reset the pointer */
 	subs->hwptr_done = 0;
 	subs->transfer_done = 0;
-	subs->phase = 0;
 	subs->last_delay = 0;
 	subs->last_frame_number = 0;
 	runtime->delay = 0;
 
-	return snd_usb_substream_prepare(subs, runtime);
+	/* for playback, submit the URBs now; otherwise, the first hwptr_done
+	 * updates for all URBs would happen at the same time when starting */
+	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		return start_endpoints(subs);
+
+	return 0;
 }
 
 static struct snd_pcm_hardware snd_usb_hardware =
@@ -842,16 +911,171 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream, int direction)
 
 static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 {
+	int ret;
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_usb_substream *subs = &as->substream[direction];
 
-	if (!as->chip->shutdown && subs->interface >= 0) {
-		usb_set_interface(subs->dev, subs->interface, 0);
-		subs->interface = -1;
-	}
+	stop_endpoints(subs, 0, 0, 0);
+	ret = deactivate_endpoints(subs);
 	subs->pcm_substream = NULL;
 	snd_usb_autosuspend(subs->stream->chip);
-	return 0;
+
+	return ret;
+}
+
+/* Since a URB can handle only a single linear buffer, we must use double
+ * buffering when the data to be transferred overflows the buffer boundary.
+ * To avoid inconsistencies when updating hwptr_done, we use double buffering
+ * for all URBs.
+ */
+static void retire_capture_urb(struct snd_usb_substream *subs,
+			       struct urb *urb)
+{
+	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
+	unsigned int stride, frames, bytes, oldptr;
+	int i, period_elapsed = 0;
+	unsigned long flags;
+	unsigned char *cp;
+
+	stride = runtime->frame_bits >> 3;
+
+	for (i = 0; i < urb->number_of_packets; i++) {
+		cp = (unsigned char *)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
+		if (urb->iso_frame_desc[i].status && printk_ratelimit()) {
+			snd_printdd(KERN_ERR "frame %d active: %d\n", i, urb->iso_frame_desc[i].status);
+			// continue;
+		}
+		bytes = urb->iso_frame_desc[i].actual_length;
+		frames = bytes / stride;
+		if (!subs->txfr_quirk)
+			bytes = frames * stride;
+		if (bytes % (runtime->sample_bits >> 3) != 0) {
+#ifdef CONFIG_SND_DEBUG_VERBOSE
+			int oldbytes = bytes;
+#endif
+			bytes = frames * stride;
+			snd_printdd(KERN_ERR "Corrected urb data len. %d->%d\n",
+							oldbytes, bytes);
+		}
+		/* update the current pointer */
+		spin_lock_irqsave(&subs->lock, flags);
+		oldptr = subs->hwptr_done;
+		subs->hwptr_done += bytes;
+		if (subs->hwptr_done >= runtime->buffer_size * stride)
+			subs->hwptr_done -= runtime->buffer_size * stride;
+		frames = (bytes + (oldptr % stride)) / stride;
+		subs->transfer_done += frames;
+		if (subs->transfer_done >= runtime->period_size) {
+			subs->transfer_done -= runtime->period_size;
+			period_elapsed = 1;
+		}
+		spin_unlock_irqrestore(&subs->lock, flags);
+		/* copy a data chunk */
+		if (oldptr + bytes > runtime->buffer_size * stride) {
+			unsigned int bytes1 =
+					runtime->buffer_size * stride - oldptr;
+			memcpy(runtime->dma_area + oldptr, cp, bytes1);
+			memcpy(runtime->dma_area, cp + bytes1, bytes - bytes1);
+		} else {
+			memcpy(runtime->dma_area + oldptr, cp, bytes);
+		}
+	}
+
+	if (period_elapsed)
+		snd_pcm_period_elapsed(subs->pcm_substream);
+}
+
+static void prepare_playback_urb(struct snd_usb_substream *subs,
+				 struct urb *urb)
+{
+	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
+	struct snd_urb_ctx *ctx = urb->context;
+	unsigned int counts, frames, bytes;
+	int i, stride, period_elapsed = 0;
+	unsigned long flags;
+
+	stride = runtime->frame_bits >> 3;
+
+	frames = 0;
+	urb->number_of_packets = 0;
+	spin_lock_irqsave(&subs->lock, flags);
+	for (i = 0; i < ctx->packets; i++) {
+		counts = ctx->packet_size[i];
+		/* set up descriptor */
+		urb->iso_frame_desc[i].offset = frames * stride;
+		urb->iso_frame_desc[i].length = counts * stride;
+		frames += counts;
+		urb->number_of_packets++;
+		subs->transfer_done += counts;
+		if (subs->transfer_done >= runtime->period_size) {
+			subs->transfer_done -= runtime->period_size;
+			period_elapsed = 1;
+			if (subs->fmt_type == UAC_FORMAT_TYPE_II) {
+				if (subs->transfer_done > 0) {
+					/* FIXME: fill-max mode is not
+					 * supported yet */
+					frames -= subs->transfer_done;
+					counts -= subs->transfer_done;
+					urb->iso_frame_desc[i].length =
+						counts * stride;
+					subs->transfer_done = 0;
+				}
+				i++;
+				if (i < ctx->packets) {
+					/* add a transfer delimiter */
+					urb->iso_frame_desc[i].offset =
+						frames * stride;
+					urb->iso_frame_desc[i].length = 0;
+					urb->number_of_packets++;
+				}
+				break;
+			}
+		}
+		if (period_elapsed &&
+		    !snd_usb_endpoint_implict_feedback_sink(subs->data_endpoint)) /* finish at the period boundary */
+			break;
+	}
+	bytes = frames * stride;
+	if (subs->hwptr_done + bytes > runtime->buffer_size * stride) {
+		/* err, the transferred area goes over buffer boundary. */
+		unsigned int bytes1 =
+			runtime->buffer_size * stride - subs->hwptr_done;
+		memcpy(urb->transfer_buffer,
+		       runtime->dma_area + subs->hwptr_done, bytes1);
+		memcpy(urb->transfer_buffer + bytes1,
+		       runtime->dma_area, bytes - bytes1);
+	} else {
+		memcpy(urb->transfer_buffer,
+		       runtime->dma_area + subs->hwptr_done, bytes);
+	}
+	subs->hwptr_done += bytes;
+	if (subs->hwptr_done >= runtime->buffer_size * stride)
+		subs->hwptr_done -= runtime->buffer_size * stride;
+	runtime->delay += frames;
+	spin_unlock_irqrestore(&subs->lock, flags);
+	urb->transfer_buffer_length = bytes;
+	if (period_elapsed)
+		snd_pcm_period_elapsed(subs->pcm_substream);
+}
+
+/*
+ * process after playback data complete
+ * - decrease the delay count again
+ */
+static void retire_playback_urb(struct snd_usb_substream *subs,
+			       struct urb *urb)
+{
+	unsigned long flags;
+	struct snd_pcm_runtime *runtime = subs->pcm_substream->runtime;
+	int stride = runtime->frame_bits >> 3;
+	int processed = urb->transfer_buffer_length / stride;
+
+	spin_lock_irqsave(&subs->lock, flags);
+	if (processed > runtime->delay)
+		runtime->delay = 0;
+	else
+		runtime->delay -= processed;
+	spin_unlock_irqrestore(&subs->lock, flags);
 }
 
 static int snd_usb_playback_open(struct snd_pcm_substream *substream)
@@ -874,6 +1098,56 @@ static int snd_usb_capture_close(struct snd_pcm_substream *substream)
 	return snd_usb_pcm_close(substream, SNDRV_PCM_STREAM_CAPTURE);
 }
 
+static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substream,
+					      int cmd)
+{
+	struct snd_usb_substream *subs = substream->runtime->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		subs->data_endpoint->prepare_data_urb = prepare_playback_urb;
+		subs->data_endpoint->retire_data_urb = retire_playback_urb;
+		return 0;
+	case SNDRV_PCM_TRIGGER_STOP:
+		stop_endpoints(subs, 0, 0, 0);
+		return 0;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		subs->data_endpoint->prepare_data_urb = NULL;
+		subs->data_endpoint->retire_data_urb = NULL;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int err;
+	struct snd_usb_substream *subs = substream->runtime->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		err = start_endpoints(subs);
+		if (err < 0)
+			return err;
+
+		subs->data_endpoint->retire_data_urb = retire_capture_urb;
+		return 0;
+	case SNDRV_PCM_TRIGGER_STOP:
+		stop_endpoints(subs, 0, 0, 0);
+		return 0;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		subs->data_endpoint->retire_data_urb = NULL;
+		return 0;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		subs->data_endpoint->retire_data_urb = retire_capture_urb;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static struct snd_pcm_ops snd_usb_playback_ops = {
 	.open =		snd_usb_playback_open,
 	.close =	snd_usb_playback_close,
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 5ff8010..6b7d7a2 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -73,6 +73,31 @@ static void snd_usb_audio_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
+/*
+ * initialize the substream instance.
+ */
+
+static void snd_usb_init_substream(struct snd_usb_stream *as,
+				   int stream,
+				   struct audioformat *fp)
+{
+	struct snd_usb_substream *subs = &as->substream[stream];
+
+	INIT_LIST_HEAD(&subs->fmt_list);
+	spin_lock_init(&subs->lock);
+
+	subs->stream = as;
+	subs->direction = stream;
+	subs->dev = as->chip->dev;
+	subs->txfr_quirk = as->chip->txfr_quirk;
+
+	snd_usb_set_pcm_ops(as->pcm, stream);
+
+	list_add_tail(&fp->list, &subs->fmt_list);
+	subs->formats |= fp->formats;
+	subs->num_formats++;
+	subs->fmt_type = fp->fmt_type;
+}
 
 /*
  * add this endpoint to the chip instance.
@@ -94,9 +119,9 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 		if (as->fmt_type != fp->fmt_type)
 			continue;
 		subs = &as->substream[stream];
-		if (!subs->endpoint)
+		if (!subs->data_endpoint)
 			continue;
-		if (subs->endpoint == fp->endpoint) {
+		if (subs->data_endpoint->ep_num == fp->endpoint) {
 			list_add_tail(&fp->list, &subs->fmt_list);
 			subs->num_formats++;
 			subs->formats |= fp->formats;
@@ -109,7 +134,7 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 		if (as->fmt_type != fp->fmt_type)
 			continue;
 		subs = &as->substream[stream];
-		if (subs->endpoint)
+		if (subs->data_endpoint)
 			continue;
 		err = snd_pcm_new_stream(as->pcm, stream, 1);
 		if (err < 0)
-- 
1.7.7.6
