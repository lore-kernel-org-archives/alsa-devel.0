From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Mon, 12 Aug 2013 12:50:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308121218590.1489-100000@iolanthe.rowland.org>
References: <s5hvc3bx85c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hvc3bx85c.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Aug 2013, Takashi Iwai wrote:

> So... Clemens, Daniel, Eldad, could you guys review the latest version
> of Alan's patch?  I'd love to sort this out for 3.12.

Here's a revised version of the patch (still untested).  The difference
is that this version tries always to keep a period's worth of bytes in
the USB hardware queue.  This will provide better protection against
underruns when the period is larger than the queue's minimum
requirement.

Alan Stern


 sound/usb/card.h     |    9 ++
 sound/usb/endpoint.c |  200 ++++++++++++++++++++++++++++++---------------------
 sound/usb/pcm.c      |    4 -
 3 files changed, 132 insertions(+), 81 deletions(-)

Index: usb-3.11/sound/usb/card.h
===================================================================
--- usb-3.11.orig/sound/usb/card.h
+++ usb-3.11/sound/usb/card.h
@@ -4,7 +4,7 @@
 #define MAX_NR_RATES	1024
 #define MAX_PACKS	20
 #define MAX_PACKS_HS	(MAX_PACKS * 8)	/* in high speed mode */
-#define MAX_URBS	8
+#define MAX_URBS	11
 #define SYNC_URBS	4	/* always four urbs for sync */
 #define MAX_QUEUE	24	/* try not to exceed this queue length, in ms */
 
@@ -43,6 +43,8 @@ struct snd_urb_ctx {
 	struct snd_usb_endpoint *ep;
 	int index;	/* index for urb array */
 	int packets;	/* number of packets per urb */
+	int data_packets;		/* current number of data packets */
+	int data_frames;		/* current number of data frames */
 	int packet_size[MAX_PACKS_HS]; /* size of packets for next submission */
 	struct list_head ready_list;
 };
@@ -99,6 +101,11 @@ struct snd_usb_endpoint {
 	int skip_packets;		/* quirks for devices to ignore the first n packets
 					   in a stream */
 
+	unsigned int min_queued_packs;	/* USB hardware queue requirement */
+	unsigned int queued_packs;	/* number of packets on the queue */
+	unsigned int queued_urbs;	/* number of URBs on the queue */
+	unsigned int queued_frames;	/* number of data frames on the queue */
+	int next_urb;			/* next to submit */
 	spinlock_t lock;
 	struct list_head list;
 };
Index: usb-3.11/sound/usb/pcm.c
===================================================================
--- usb-3.11.orig/sound/usb/pcm.c
+++ usb-3.11/sound/usb/pcm.c
@@ -1328,7 +1328,7 @@ static void prepare_playback_urb(struct
 	stride = runtime->frame_bits >> 3;
 
 	frames = 0;
-	urb->number_of_packets = 0;
+	ctx->data_packets = urb->number_of_packets = 0;
 	spin_lock_irqsave(&subs->lock, flags);
 	for (i = 0; i < ctx->packets; i++) {
 		if (ctx->packet_size[i])
@@ -1341,6 +1341,7 @@ static void prepare_playback_urb(struct
 		urb->iso_frame_desc[i].length = counts * ep->stride;
 		frames += counts;
 		urb->number_of_packets++;
+		ctx->data_packets++;
 		subs->transfer_done += counts;
 		if (subs->transfer_done >= runtime->period_size) {
 			subs->transfer_done -= runtime->period_size;
@@ -1370,6 +1371,7 @@ static void prepare_playback_urb(struct
 		    !snd_usb_endpoint_implicit_feedback_sink(subs->data_endpoint)) /* finish at the period boundary */
 			break;
 	}
+	ctx->data_frames = frames;
 	bytes = frames * ep->stride;
 
 	if (unlikely(subs->pcm_format == SNDRV_PCM_FORMAT_DSD_U16_LE &&
Index: usb-3.11/sound/usb/endpoint.c
===================================================================
--- usb-3.11.orig/sound/usb/endpoint.c
+++ usb-3.11/sound/usb/endpoint.c
@@ -203,6 +203,7 @@ static void prepare_outbound_urb(struct
 		} else {
 			/* no data provider, so send silence */
 			unsigned int offs = 0;
+
 			for (i = 0; i < ctx->packets; ++i) {
 				int counts;
 
@@ -217,6 +218,8 @@ static void prepare_outbound_urb(struct
 			}
 
 			urb->number_of_packets = ctx->packets;
+			ctx->data_packets = ctx->packets;
+			ctx->data_frames = offs;
 			urb->transfer_buffer_length = offs * ep->stride;
 			memset(urb->transfer_buffer, ep->silence_value,
 			       offs * ep->stride);
@@ -273,6 +276,7 @@ static inline void prepare_inbound_urb(s
 
 		urb->transfer_buffer_length = offs;
 		urb->number_of_packets = urb_ctx->packets;
+		urb_ctx->data_packets = urb_ctx->packets;
 		break;
 
 	case SND_USB_ENDPOINT_TYPE_SYNC:
@@ -341,6 +345,55 @@ static void queue_pending_output_urbs(st
 	}
 }
 
+/**
+ * snd_submit_urbs: Submit data URBs for endpoints without implicit feedback
+ *
+ * @ep: The endpoint to use
+ * @ctx: Context for the first URB on the queue (or to be queued)
+ *
+ * Submit enough URBs so that when the next one completes, the hardware queue
+ * will still contain sufficiently many packets.
+ *
+ * Note: If the hardware queue is empty (and @ctx refers to the next URB to be
+ * submitted), then ctx->data_packets must be equal to 0.
+ */
+static int snd_submit_urbs(struct snd_usb_endpoint *ep, struct snd_urb_ctx *ctx)
+{
+	int err = 0;
+	unsigned int period_size = ep->data_subs->pcm_substream->runtime->
+			period_size;
+
+	while (ep->queued_urbs < ep->nurbs) {
+		struct snd_urb_ctx *u;
+
+		if (ep->queued_frames >= period_size &&
+				ep->queued_packs - ctx->data_packets >=
+					ep->min_queued_packs)
+			break;
+
+		u = &ep->urb[ep->next_urb];
+		if (usb_pipeout(ep->pipe))
+			prepare_outbound_urb(ep, u);
+		else
+			prepare_inbound_urb(ep, u);
+
+		err = usb_submit_urb(u->urb, GFP_ATOMIC);
+		if (err) {
+			snd_printk(KERN_ERR "cannot submit urb (err = %d: %s)\n",
+					err, usb_error_string(err));
+			break;
+		}
+		set_bit(ep->next_urb, &ep->active_mask);
+		ep->queued_packs += u->data_packets;
+		++ep->queued_urbs;
+		ep->queued_frames += u->data_frames;
+
+		if (++ep->next_urb >= ep->nurbs)
+			ep->next_urb = 0;
+	}
+	return err;
+}
+
 /*
  * complete callback for urbs
  */
@@ -348,20 +401,24 @@ static void snd_complete_urb(struct urb
 {
 	struct snd_urb_ctx *ctx = urb->context;
 	struct snd_usb_endpoint *ep = ctx->ep;
-	int err;
+
+	clear_bit(ctx->index, &ep->active_mask);
+	ep->queued_packs -= ctx->data_packets;
+	--ep->queued_urbs;
+	ep->queued_frames -= ctx->data_frames;
 
 	if (unlikely(urb->status == -ENOENT ||		/* unlinked */
 		     urb->status == -ENODEV ||		/* device removed */
 		     urb->status == -ECONNRESET ||	/* unlinked */
 		     urb->status == -ESHUTDOWN ||	/* device disabled */
 		     ep->chip->shutdown))		/* device disconnected */
-		goto exit_clear;
+		return;
 
 	if (usb_pipeout(ep->pipe)) {
 		retire_outbound_urb(ep, ctx);
 		/* can be stopped during retire callback */
 		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
-			goto exit_clear;
+			return;
 
 		if (snd_usb_endpoint_implicit_feedback_sink(ep)) {
 			unsigned long flags;
@@ -371,28 +428,24 @@ static void snd_complete_urb(struct urb
 			spin_unlock_irqrestore(&ep->lock, flags);
 			queue_pending_output_urbs(ep);
 
-			goto exit_clear;
+			return;
 		}
 
-		prepare_outbound_urb(ep, ctx);
 	} else {
 		retire_inbound_urb(ep, ctx);
 		/* can be stopped during retire callback */
 		if (unlikely(!test_bit(EP_FLAG_RUNNING, &ep->flags)))
-			goto exit_clear;
-
-		prepare_inbound_urb(ep, ctx);
+			return;
 	}
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
-	if (err == 0)
-		return;
+	ctx->data_packets = 0;
+	++ctx;
+	if (ctx >= ep->urb + ep->nurbs)
+		ctx = &ep->urb[0];
 
-	snd_printk(KERN_ERR "cannot submit urb (err = %d)\n", err);
+	if (snd_submit_urbs(ep, ctx) == 0)
+		return;
 	//snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
-
-exit_clear:
-	clear_bit(ctx->index, &ep->active_mask);
 }
 
 /**
@@ -574,7 +627,7 @@ static int data_ep_set_params(struct snd
 			      struct audioformat *fmt,
 			      struct snd_usb_endpoint *sync_ep)
 {
-	unsigned int maxsize, i, urb_packs, total_packs, packs_per_ms;
+	unsigned int maxsize, i, urb_packs, max_packs, packs_per_ms;
 	int is_playback = usb_pipeout(ep->pipe);
 	int frame_bits = snd_pcm_format_physical_width(pcm_format) * channels;
 
@@ -593,8 +646,8 @@ static int data_ep_set_params(struct snd
 
 	/* assume max. frequency is 25% higher than nominal */
 	ep->freqmax = ep->freqn + (ep->freqn >> 2);
-	maxsize = ((ep->freqmax + 0xffff) * (frame_bits >> 3))
-				>> (16 - ep->datainterval);
+	maxsize = ((ep->freqmax + 0xffff) >> (16 - ep->datainterval))
+			* (frame_bits >> 3);
 	/* but wMaxPacketSize might reduce this */
 	if (ep->maxpacksize && ep->maxpacksize < maxsize) {
 		/* whatever fits into a max. size packet */
@@ -608,11 +661,21 @@ static int data_ep_set_params(struct snd
 	else
 		ep->curpacksize = maxsize;
 
-	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL)
+	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL) {
 		packs_per_ms = 8 >> ep->datainterval;
-	else
+
+		/* high speed needs 10 USB uframes on the queue at all times */
+		ep->min_queued_packs = DIV_ROUND_UP(10, 8 / packs_per_ms);
+		max_packs = MAX_PACKS_HS;
+	} else {
 		packs_per_ms = 1;
 
+		/* full speed needs one USB frame on the queue at all times */
+		ep->min_queued_packs = 1;
+		max_packs = MAX_PACKS;
+	}
+	max_packs = min(max_packs, MAX_QUEUE * packs_per_ms);
+
 	if (is_playback && !snd_usb_endpoint_implicit_feedback_sink(ep)) {
 		urb_packs = max(ep->chip->nrpacks, 1);
 		urb_packs = min(urb_packs, (unsigned int) MAX_PACKS);
@@ -625,41 +688,36 @@ static int data_ep_set_params(struct snd
 	if (sync_ep && !snd_usb_endpoint_implicit_feedback_sink(ep))
 		urb_packs = min(urb_packs, 1U << sync_ep->syncinterval);
 
-	/* decide how many packets to be used */
-	if (is_playback && !snd_usb_endpoint_implicit_feedback_sink(ep)) {
-		unsigned int minsize, maxpacks;
-		/* determine how small a packet can be */
-		minsize = (ep->freqn >> (16 - ep->datainterval))
-			  * (frame_bits >> 3);
-		/* with sync from device, assume it can be 12% lower */
-		if (sync_ep)
-			minsize -= minsize >> 3;
-		minsize = max(minsize, 1u);
-		total_packs = (period_bytes + minsize - 1) / minsize;
-		/* we need at least two URBs for queueing */
-		if (total_packs < 2) {
-			total_packs = 2;
-		} else {
-			/* and we don't want too long a queue either */
-			maxpacks = max(MAX_QUEUE * packs_per_ms, urb_packs * 2);
-			total_packs = min(total_packs, maxpacks);
-		}
-	} else {
-		while (urb_packs > 1 && urb_packs * maxsize >= period_bytes)
-			urb_packs >>= 1;
-		total_packs = MAX_URBS * urb_packs;
-	}
+	/* no point having an URB much longer than one period */
+	urb_packs = min(urb_packs, 1 + period_bytes / maxsize);
 
-	ep->nurbs = (total_packs + urb_packs - 1) / urb_packs;
-	if (ep->nurbs > MAX_URBS) {
-		/* too much... */
-		ep->nurbs = MAX_URBS;
-		total_packs = MAX_URBS * urb_packs;
-	} else if (ep->nurbs < 2) {
-		/* too little - we need at least two packets
-		 * to ensure contiguous playback/capture
-		 */
-		ep->nurbs = 2;
+	/*
+	 * We can't tell in advance how many URBs are needed to fill the
+	 * USB hardware queue, because the number of packets per URB is
+	 * variable (it depends on the period size and the device's clock
+	 * frequency).  Instead, get a worst-case overestimate by assuming
+	 * the number of packets alternates between 1 and urb_packs.
+	 *
+	 * The total number of URBs needed is one higher than this, because
+	 * the hardware queue must remain full even while one URB is
+	 * completing (and therefore not on the queue).
+	 *
+	 * Recording endpoints with no sync always use the same number of
+	 * packets per URB, so we can get a better estimate for them.
+	 */
+	if (is_playback || sync_ep)
+		ep->nurbs = 1 + 2 * DIV_ROUND_UP(ep->min_queued_packs,
+				urb_packs + 1);
+	else
+		ep->nurbs = 1 + DIV_ROUND_UP(ep->min_queued_packs, urb_packs);
+
+	/* at least enough URBs to last an entire period */
+	ep->nurbs = max(ep->nurbs, period_bytes / (urb_packs * maxsize));
+	ep->nurbs = min(ep->nurbs, (unsigned) MAX_URBS);
+
+	if (ep->nurbs * urb_packs > max_packs) {
+		/* too much -- URBs have too many packets */
+		urb_packs = max_packs / ep->nurbs;
 	}
 
 	/* allocate and initialize data urbs */
@@ -667,8 +725,8 @@ static int data_ep_set_params(struct snd
 		struct snd_urb_ctx *u = &ep->urb[i];
 		u->index = i;
 		u->ep = ep;
-		u->packets = (i + 1) * total_packs / ep->nurbs
-			- i * total_packs / ep->nurbs;
+		u->packets = urb_packs;
+		u->data_packets = 0;
 		u->buffer_size = maxsize * u->packets;
 
 		if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
@@ -861,30 +919,14 @@ int snd_usb_endpoint_start(struct snd_us
 		return 0;
 	}
 
-	for (i = 0; i < ep->nurbs; i++) {
-		struct urb *urb = ep->urb[i].urb;
-
-		if (snd_BUG_ON(!urb))
-			goto __error;
-
-		if (usb_pipeout(ep->pipe)) {
-			prepare_outbound_urb(ep, urb->context);
-		} else {
-			prepare_inbound_urb(ep, urb->context);
-		}
-
-		err = usb_submit_urb(urb, GFP_ATOMIC);
-		if (err < 0) {
-			snd_printk(KERN_ERR "cannot submit urb %d, error %d: %s\n",
-				   i, err, usb_error_string(err));
-			goto __error;
-		}
-		set_bit(i, &ep->active_mask);
-	}
