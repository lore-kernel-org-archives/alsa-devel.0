From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Wed, 24 Jul 2013 11:22:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307241108180.1313-100000@iolanthe.rowland.org>
References: <s5hsiz4knyf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hsiz4knyf.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Jul 2013, Takashi Iwai wrote:

> At Wed, 24 Jul 2013 10:41:43 -0400 (EDT),
> Alan Stern wrote:
> > 
> > I have been studying the data_ep_set_params() function in
> > sound/usb/endpoint.c.  This is the routine that calculates the number
> > of samples and I/O requests to keep on the USB hardware queue for PCM
> > audio, based on the ALSA parameters.
> > 
> > It uses the PERIOD_BYTES parameter but not BUFFER_BYTES.  In simplified
> > terms (ignoring rounding, boundary cases, and other things), the number
> > of periods per buffer is fixed at 24 for recording and 1 for playback,
> > completely ignoring the user's setting.  If you look at the parameters
> > copied in snd_usb_hw_params() in sound/usb/pcm.c, you'll see what I
> > mean.
> > 
> > Is this really the intended behavior?  It doesn't seem right at all.
> 
> The buffer size doesn't matter for urb setup because the usb-audio
> driver transfers the data by the driver itself at urb completes.
> The buffer size is considered in these callbacks,
> i.e. prepare_playback_urb() and retire_capture_urb().

I don't understand.  Consider a simple playback example.  Suppose the
user wants to keep the latency low, so he requests 2 periods per
buffer.  snd-usb-audio ignores this value and decides to use 10 URBs,
which is equivalent to setting the buffer size to 10 periods.

Now the latency will be five times higher than the user wants, because
data from the user is stored in the next available URB, and it won't
get sent to the hardware until all 9 of the URBs preceding it in the
queue have been sent.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
