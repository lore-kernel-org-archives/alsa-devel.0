From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Wed, 21 Aug 2013 17:37:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308211654010.1297-100000@iolanthe.rowland.org>
References: <520BCDBC.2060507@ladisch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <520BCDBC.2060507-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Aug 2013, Clemens Ladisch wrote:

> > In other words, there should be enough URBs so that an entire ALSA
> > buffer can be queued at any time, subject only to the limit on the
> > maximum number of URBs and packets.
> 
> The URB queue adds latency, so it should never be made too big, even
> for big ALSA buffers.  Once we have reached a queue length that is
> practically guaranteed to be safe from underruns, more URBs do not make
> sense.  (The current limit of 24 ms is somewhat arbitrary.)
> 
> > It doesn't make sense to allocate just enough URBs to cover a single
> > period.
> 
> Indeed.  I've used two periods in my recent patch, but I don't really
> know how I would justify this choice in the commit message.  ;-)
> 
> What doesn't make sense either is the current algorithm that computes
> a specific value for the total number of packets (total_packs) and then
> takes great care to allocate the URBs so that this number is reached,
> even if this means that the number of packets per URBs varies.
> 
> And while we're at it: the default number of packets per URB was chosen
> before the driver had the ability to estimate the delay from the current
> frame number; it should now be quite safe to increase it.

Okay, so here's my next attempt.  It's based on a simple idea: All the
difficulty arises from the fact that we don't know beforehand how many
URBs will constitute an ALSA period since for playback endpoints, the
URB sizes can vary.  The problem can be solved simply by setting the
number of URBs per period to a fixed value, and truncating URBs as
needed to make it work.

Briefly, the patch fixes the max number of packets per URB, based on
the minimum packet size.  The only requirement is that no URB should
exceed 8 ms (MAX_PACKS) or the length of a period.  Given this, the
number of URBs per period is fixed, and the number of packets in each
URB is adjusted during playback so that all the URBs end up having
roughly the same number of frames.  As a result, we don't need to
submit variable numbers of URBs in the completion handler after all.

The total number of URBs is limited to 12 (MAX_URBS) and 16 ms worth
(MAX_QUEUE), and it is also restricted so that the total amount of data
in the queue does not exceed the size of an ALSA buffer.  If the user
sets the buffer size too small, he gets what he deserves.

The parameter calculation now ends up being the same for both recording
and playback endpoints.  This may seem odd, but it follows from the
reasoning above.

Although I believe the logic is now sound, the patch itself is 
incomplete.  I don't know the best way of passing the frames/period and 
periods/buffer values, so they are stubbed as 0 with a FIXME comment.  
Maybe you can tell me how to do this properly.

The patch eliminates the use of ep->chip->nrpacks and therefore the
nrpacks module parameter.  Does that matter?  I left the parameter in
place, but now it doesn't do anything.

I'm not sure about the interaction with ep->curpacksize.  I left it
alone, since it looks like it won't affect playback endpoints.

Also, the relations between frames_per_period, period_bytes, and 
frame_bits are a little confusing.  It's not clear to me that they will 
always behave as one would expect, i.e., that period_bytes will always 
be equal to (frame_bits >> 3) * frames_per_period.

Overall, the patch removes more lines of code than it adds.  I think it 
looks pretty good, as far as it goes.  What do you think?

Alan Stern



Index: usb-3.11/sound/usb/card.h
===================================================================
--- usb-3.11.orig/sound/usb/card.h
+++ usb-3.11/sound/usb/card.h
@@ -2,11 +2,11 @@
 #define __USBAUDIO_CARD_H
 
 #define MAX_NR_RATES	1024
-#define MAX_PACKS	20
+#define MAX_PACKS	8		/* per URB */
 #define MAX_PACKS_HS	(MAX_PACKS * 8)	/* in high speed mode */
-#define MAX_URBS	8
+#define MAX_URBS	12
 #define SYNC_URBS	4	/* always four urbs for sync */
-#define MAX_QUEUE	24	/* try not to exceed this queue length, in ms */
+#define MAX_QUEUE	16	/* try not to exceed this queue length, in ms */
 
 struct audioformat {
 	struct list_head list;
@@ -87,6 +87,7 @@ struct snd_usb_endpoint {
 	unsigned int phase;		/* phase accumulator */
 	unsigned int maxpacksize;	/* max packet size in bytes */
 	unsigned int maxframesize;      /* max packet size in frames */
+	unsigned int max_urb_frames;	/* max URB size in frames */
 	unsigned int curpacksize;	/* current packet size in bytes (for capture) */
 	unsigned int curframesize;      /* current packet size in frames (for capture) */
 	unsigned int syncmaxsize;	/* sync endpoint packet size */
@@ -125,6 +126,7 @@ struct snd_usb_substream {
 
 	unsigned int hwptr_done;	/* processed byte position in the buffer */
 	unsigned int transfer_done;		/* processed frames since last period update */
+	unsigned int frame_limit;	/* limits number of packets in URB */
 
 	/* data and sync endpoints for this stream */
 	unsigned int ep_num;		/* the endpoint number */
Index: usb-3.11/sound/usb/pcm.c
===================================================================
--- usb-3.11.orig/sound/usb/pcm.c
+++ usb-3.11/sound/usb/pcm.c
@@ -1330,6 +1330,7 @@ static void prepare_playback_urb(struct
 	frames = 0;
 	urb->number_of_packets = 0;
 	spin_lock_irqsave(&subs->lock, flags);
+	subs->frame_limit += ep->max_urb_frames;
 	for (i = 0; i < ctx->packets; i++) {
 		if (ctx->packet_size[i])
 			counts = ctx->packet_size[i];
@@ -1344,6 +1345,7 @@ static void prepare_playback_urb(struct
 		subs->transfer_done += counts;
 		if (subs->transfer_done >= runtime->period_size) {
 			subs->transfer_done -= runtime->period_size;
+			subs->frame_limit = 0;
 			period_elapsed = 1;
 			if (subs->fmt_type == UAC_FORMAT_TYPE_II) {
 				if (subs->transfer_done > 0) {
@@ -1366,8 +1368,10 @@ static void prepare_playback_urb(struct
 				break;
 			}
 		}
-		if (period_elapsed &&
-		    !snd_usb_endpoint_implicit_feedback_sink(subs->data_endpoint)) /* finish at the period boundary */
+		/* finish at the period boundary or after enough frames */
+		if ((period_elapsed ||
+				subs->transfer_done >= subs->frame_limit) &&
+		    !snd_usb_endpoint_implicit_feedback_sink(ep))
 			break;
 	}
 	bytes = frames * ep->stride;
Index: usb-3.11/sound/usb/endpoint.c
===================================================================
--- usb-3.11.orig/sound/usb/endpoint.c
+++ usb-3.11/sound/usb/endpoint.c
@@ -571,11 +571,14 @@ static int data_ep_set_params(struct snd
 			      snd_pcm_format_t pcm_format,
 			      unsigned int channels,
 			      unsigned int period_bytes,
+			      unsigned int frames_per_period,
+			      unsigned int periods_per_buffer,
 			      struct audioformat *fmt,
 			      struct snd_usb_endpoint *sync_ep)
 {
-	unsigned int maxsize, i, urb_packs, total_packs, packs_per_ms;
-	int is_playback = usb_pipeout(ep->pipe);
+	unsigned int maxsize, minsize, packs_per_ms, max_packs_per_urb;
+	unsigned int max_packs_per_period, urbs_per_period, urb_packs;
+	unsigned int max_urbs, i;
 	int frame_bits = snd_pcm_format_physical_width(pcm_format) * channels;
 
 	if (pcm_format == SNDRV_PCM_FORMAT_DSD_U16_LE && fmt->dsd_dop) {
@@ -608,67 +611,44 @@ static int data_ep_set_params(struct snd
 	else
 		ep->curpacksize = maxsize;
 
-	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL)
+	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL) {
 		packs_per_ms = 8 >> ep->datainterval;
-	else
-		packs_per_ms = 1;
-
-	if (is_playback && !snd_usb_endpoint_implicit_feedback_sink(ep)) {
-		urb_packs = max(ep->chip->nrpacks, 1);
-		urb_packs = min(urb_packs, (unsigned int) MAX_PACKS);
+		max_packs_per_urb = MAX_PACKS_HS >> ep->datainterval;
 	} else {
-		urb_packs = 1;
+		packs_per_ms = 1;
+		max_packs_per_urb = MAX_PACKS;
 	}
-
-	urb_packs *= packs_per_ms;
-
 	if (sync_ep && !snd_usb_endpoint_implicit_feedback_sink(ep))
-		urb_packs = min(urb_packs, 1U << sync_ep->syncinterval);
+		max_packs_per_urb = min(max_packs_per_urb,
+				1U << sync_ep->syncinterval);
 
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
-
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
-	}
+	/* determine how small a packet can be */
+	minsize = (ep->freqn >> (16 - ep->datainterval)) * (frame_bits >> 3);
+	/* with sync from device, assume it can be 12% lower */
+	if (sync_ep)
+		minsize -= minsize >> 3;
+	minsize = max(minsize, 1u);
+
+	/* how many packets will contain an entire ALSA period? */
+	max_packs_per_period = DIV_ROUND_UP(period_bytes, minsize);
+
+	/* how many URBs contain a period, and how many packets in each? */
+	urbs_per_period = DIV_ROUND_UP(max_packs_per_period, max_packs_per_urb);
+	urb_packs = DIV_ROUND_UP(max_packs_per_period, urbs_per_period);
+	ep->max_urb_frames = DIV_ROUND_UP(frames_per_period,
+			urbs_per_period);
+
+	/* try to use enough URBs to contain an entire ALSA buffer */
+	max_urbs = min((unsigned) MAX_URBS,
+			MAX_QUEUE * packs_per_ms / urb_packs);
+	ep->nurbs = min(max_urbs, urbs_per_period * periods_per_buffer);
 
 	/* allocate and initialize data urbs */
 	for (i = 0; i < ep->nurbs; i++) {
 		struct snd_urb_ctx *u = &ep->urb[i];
 		u->index = i;
 		u->ep = ep;
-		u->packets = (i + 1) * total_packs / ep->nurbs
-			- i * total_packs / ep->nurbs;
+		u->packets = urb_packs;
 		u->buffer_size = maxsize * u->packets;
 
 		if (fmt->fmt_type == UAC_FORMAT_TYPE_II)
@@ -790,7 +770,8 @@ int snd_usb_endpoint_set_params(struct s
 	switch (ep->type) {
 	case  SND_USB_ENDPOINT_TYPE_DATA:
 		err = data_ep_set_params(ep, pcm_format, channels,
-					 period_bytes, fmt, sync_ep);
+					 period_bytes, 0, 0, fmt, sync_ep);
+					/* FIXME: buffer size isn't 0! */
 		break;
 	case  SND_USB_ENDPOINT_TYPE_SYNC:
 		err = sync_ep_set_params(ep, fmt);


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
