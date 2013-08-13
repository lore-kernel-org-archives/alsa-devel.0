From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Tue, 13 Aug 2013 23:54:39 +0200
Message-ID: <520AAB1F.9080505@ladisch.de>
References: <Pine.LNX.4.44L0.1308121218590.1489-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1308121218590.1489-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
> On Mon, 12 Aug 2013, Takashi Iwai wrote:
>> So... Clemens, Daniel, Eldad, could you guys review the latest version
>> of Alan's patch?  I'd love to sort this out for 3.12.
>
> Here's a revised version of the patch (still untested).

> -	maxsize = ((ep->freqmax + 0xffff) * (frame_bits >> 3))
> -				>> (16 - ep->datainterval);
> +	maxsize = ((ep->freqmax + 0xffff) >> (16 - ep->datainterval))
> +			* (frame_bits >> 3);

What do you assume prevents firmware writers from splitting frames
across packages?  The specification?  Sanity?  :)  (see txfr_quirk)

> The difference is that this version tries always to keep a period's
> worth of bytes in the USB hardware queue.

Having truncated URBs is possible only when URBs are shorter than one
period, so I think that a queue length of at least two periods, together
with a minimum period size, should ensure the isochrounous scheduling
threshold.

This isn't tested either.


Regards,
Clemens


 sound/usb/endpoint.c |    3 ++-
 sound/usb/pcm.c      |   16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -638,7 +638,8 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 		if (sync_ep)
 			minsize -= minsize >> 3;
 		minsize = max(minsize, 1u);
-		total_packs = (period_bytes + minsize - 1) / minsize;
+		/* try to make the queue length the same as two periods */
+		total_packs = (2 * period_bytes + minsize - 1) / minsize;
 		/* we need at least two URBs for queueing */
 		if (total_packs < 2) {
 			total_packs = 2;
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1131,10 +1131,22 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 		return err;

 	param_period_time_if_needed = SNDRV_PCM_HW_PARAM_PERIOD_TIME;
-	if (subs->speed == USB_SPEED_FULL)
+	switch (subs->speed) {
+	case USB_SPEED_FULL:
 		/* full speed devices have fixed data packet interval */
 		ptmin = 1000;
-	if (ptmin == 1000)
+		break;
+	case USB_SPEED_HIGH:
+		/*
+		 * Assume we have an EHCI controller with an Isochronous
+		 * Scheduling Threshold of one frame (8 microframes), and
+		 * add 2 microframes for boundary cases.  Increase by 4%
+		 * to have a margin for clock inaccuracies.
+		 */
+		ptmin = max(ptmin, (8 + 2) * 130u);
+		break;
+	}
+	if (ptmin >= 1000)
 		/* if period time doesn't go below 1 ms, no rules needed */
 		param_period_time_if_needed = -1;
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
