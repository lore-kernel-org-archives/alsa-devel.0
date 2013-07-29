From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Mon, 29 Jul 2013 11:00:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307291041410.1479-100000@iolanthe.rowland.org>
References: <s5hvc3tfzt7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hvc3tfzt7.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Jul 2013, Takashi Iwai wrote:

> > The existing code has a problem: Under some conditions the URB queue
> > will be too short.  EHCI requires at least 10 microframes on the queue
> > at all times (even when an URB is completing and is therefore no longer
> > on the queue) to avoid underruns.  Well, 9 microframes is probably good
> > enough, but I'll use 10 to be safe.  A typical arrangement of 2 URBs
> > each with 8 packets each (at 1 packet/uframe) violates this constraint,
> > and I have seen underruns in practice.
> > 
> > The patch below fixes this problem and drastically simplifies the 
> > calculation.  How does it look?
> 
> Looks good through a quick glance.  But I'd rather like to let review
> Clemens and Daniel as I already forgot the old voodoo logic of the
> current driver code :)

Okay.

To recap, the bug I want to fix is that snd-usb-audio does not always
keep the USB hardware queue sufficiently full.  (There is at least one
other minor bug -- the driver uses MAX_PACKS instead of MAX_PACKS_HS
for high-speed devices.)

Clemens remarked some time ago that keeping the queue full would be
trivial, if only he knew how full it needed to be.  The answer to that
is given above.  I have been trying to make the appropriate changes,
but I'm not finding it "trivial".  :-(  Partly because I don't fully
understand all the constraints that are already present, but also
because it isn't a straightforward calculation.

For a recording endpoint, it truly is simple because then the number of 
packets per URB never changes (as far as I can tell).

For a playback endpoint, the number of packets gets reduced when 
necessary, to insure that none of the packets in the URB starts after 
the end of the current ALSA period.  Since a period is defined in terms 
of the number of samples (ALSA frames) rather than an absolute time, 
the end of the period depends on the size of the packets.  And this 
size can vary if the output endpoint has a feedback endpoint.

The current driver seems to assume that endpoints with an _implicit_
feedback endpoint won't have variable-length packets.  I don't
understand why not; doesn't queue_pending_output_urbs() make the packet
sizes match the sizes from the corresponding feedback endpoint?

I'd appreciate any advice you can offer.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
