From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Thu, 25 Jul 2013 10:50:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307251043470.882-100000@iolanthe.rowland.org>
References: <s5hbo5rkpwm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hbo5rkpwm.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Jul 2013, Takashi Iwai wrote:

> > Besides, what's the reason for allocating 10 URBs if you're not going 
> > to submit more than 2 of them at a time?
> 
> I don't know how you deduced 10 urbs in your example,

I made it up.  :-)

>  but in general,
> ep->nurbs is calculated so that the driver can hold at least two
> ep->periods (i.e. double buffer).  The USB audio driver has
> essentially two buffers: an internal hardware buffer via URBs and an
> intermediate buffer via vmalloc.  The latter is exposed to user-space
> and its content is copied to the URBs appropriately via complete
> callbacks.
> 
> Due to this design, we just need two periods for URB buffers,
> ideally, no matter how many periods are used in the latter buffer
> specified by user.  That's why no buffer_size is needed in ep->nurbs 
> estimation.  The actual calculation is, however, a bit more
> complicated to achieve enough fine-grained updates but yet not too big
> buffer size.  I guess this can be simplified / improved.

Ah, that makes sense.  Thanks for the explanation.

The existing code has a problem: Under some conditions the URB queue
will be too short.  EHCI requires at least 10 microframes on the queue
at all times (even when an URB is completing and is therefore no longer
on the queue) to avoid underruns.  Well, 9 microframes is probably good
enough, but I'll use 10 to be safe.  A typical arrangement of 2 URBs
each with 8 packets each (at 1 packet/uframe) violates this constraint,
and I have seen underruns in practice.

The patch below fixes this problem and drastically simplifies the 
calculation.  How does it look?

Alan Stern



Index: usb-3.10/sound/usb/endpoint.c
===================================================================
--- usb-3.10.orig/sound/usb/endpoint.c
+++ usb-3.10/sound/usb/endpoint.c
@@ -575,6 +575,7 @@ static int data_ep_set_params(struct snd
 			      struct snd_usb_endpoint *sync_ep)
 {
 	unsigned int maxsize, i, urb_packs, total_packs, packs_per_ms;
+	unsigned int min_queued_packs, max_packs;
 	int is_playback = usb_pipeout(ep->pipe);
 	int frame_bits = snd_pcm_format_physical_width(pcm_format) * channels;
 
@@ -608,11 +609,21 @@ static int data_ep_set_params(struct snd
 	else
 		ep->curpacksize = maxsize;
 
-	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL)
+	if (snd_usb_get_speed(ep->chip->dev) != USB_SPEED_FULL) {
 		packs_per_ms = 8 >> ep->datainterval;
-	else
+
+		/* high speed needs 10 USB uframes on the queue at all times */
+		min_queued_packs = DIV_ROUND_UP(10, 8 / packs_per_ms);
+		max_packs = MAX_PACKS_HS;
+	} else {
 		packs_per_ms = 1;
 
+		/* full speed needs one USB frame on the queue at all times */
+		min_queued_packs = 1;
+		max_packs = MAX_PACKS;
+	}
+	max_packs = min(max_packs, MAX_QUEUE * packs_per_ms);
+
 	if (is_playback && !snd_usb_endpoint_implicit_feedback_sink(ep)) {
 		urb_packs = max(ep->chip->nrpacks, 1);
 		urb_packs = min(urb_packs, (unsigned int) MAX_PACKS);
@@ -625,42 +636,18 @@ static int data_ep_set_params(struct snd
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
+	/* each URB must fit into one period */
+	urb_packs = min(urb_packs, period_bytes / maxsize);
+	urb_packs = max(1u, urb_packs);
+
+	/* at least one more URB than the minimum queue size */
+	ep->nurbs = 1 + DIV_ROUND_UP(min_queued_packs, urb_packs);
+
+	if (ep->nurbs * urb_packs > max_packs) {
+		/* too much -- URBs have too many packets */
+		urb_packs = max_packs / ep->nurbs;
 	}
+	total_packs = ep->nurbs * urb_packs;
 
 	/* allocate and initialize data urbs */
 	for (i = 0; i < ep->nurbs; i++) {

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
