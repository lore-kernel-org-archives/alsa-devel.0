From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Wed, 24 Jul 2013 11:43:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307241138180.1313-100000@iolanthe.rowland.org>
References: <s5hob9skmgs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hob9skmgs.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Jul 2013, Takashi Iwai wrote:

> > I don't understand.  Consider a simple playback example.  Suppose the
> > user wants to keep the latency low, so he requests 2 periods per
> > buffer.  snd-usb-audio ignores this value and decides to use 10 URBs,
> > which is equivalent to setting the buffer size to 10 periods.
> 
> You don't have to fill all 10 URBs to start the stream...

Maybe you don't have to, but it looks the driver does just that.  From
snd_usb_endpoint_start():

	if (snd_usb_endpoint_implicit_feedback_sink(ep)) {
		for (i = 0; i < ep->nurbs; i++) {
			struct snd_urb_ctx *ctx = ep->urb + i;
			list_add_tail(&ctx->ready_list, &ep->ready_playback_urbs);
		}

		return 0;
	}

	for (i = 0; i < ep->nurbs; i++) {
		struct urb *urb = ep->urb[i].urb;

		if (snd_BUG_ON(!urb))
			goto __error;

		if (usb_pipeout(ep->pipe)) {
			prepare_outbound_urb(ep, urb->context);
		} else {
			prepare_inbound_urb(ep, urb->context);
		}

		err = usb_submit_urb(urb, GFP_ATOMIC);
		if (err < 0) {
			snd_printk(KERN_ERR "cannot submit urb %d, error %d: %s\n",
				   i, err, usb_error_string(err));
			goto __error;
		}
		set_bit(i, &ep->active_mask);
	}

In this case, I'm particularly considering what happens when 
snd_usb_endpoint_implicit_feedback_sink(ep) is false.

Besides, what's the reason for allocating 10 URBs if you're not going 
to submit more than 2 of them at a time?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
