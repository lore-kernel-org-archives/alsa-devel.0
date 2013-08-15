From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Thu, 15 Aug 2013 12:06:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308151136180.905-100000@iolanthe.rowland.org>
References: <520AA657.5010704@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <520AA657.5010704-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 13 Aug 2013, Daniel Mack wrote:

> > Does this seem reasonable?
> 
> I think so, yes. But I'd like to comment on the actual patch, and also
> give it a try first of course. It took me some days to gather my setup
> again, but if you send a revised version, I hope to be able to test it
> in the next days.

On Wed, 14 Aug 2013, Eldad Zack wrote:

> I can also test the revised patch on the weekend. My device uses
> implicit feedback though.

Thanks guys.  I won't have anything ready for testing for some time; 
this is still pretty much in the discussion and design stage.


On Tue, 13 Aug 2013, Clemens Ladisch wrote:

> > -   maxsize = ((ep->freqmax + 0xffff) * (frame_bits >> 3))
> > -                           >> (16 - ep->datainterval);
> > +   maxsize = ((ep->freqmax + 0xffff) >> (16 - ep->datainterval))
> > +                   * (frame_bits >> 3);
>
> What do you assume prevents firmware writers from splitting frames
> across packages?  The specification?  Sanity?  :)  (see txfr_quirk)

Three things.  First, I was thinking mostly about playback endpoints,
not recording endpoints, and the code in prepare_playback_urb() doesn't
split frames.

Second, even for recording endpoints, it doesn't make sense for the 
device to split frames across packets, since the data samples making up 
the frame are all collected at the same time.  (Or if they aren't 
collected at the same time, the device has got a nasty phase problem.)

Third, the calculation already overestimates the clock rate by 25%.  
(The corresponding calculation for a slow clock assumes only a 12%
deviation.)  The length difference caused by a partial frame pales in
comparison to this excess, and it seemed better to keep the calculation
sensible.

> > The difference is that this version tries always to keep a period's
> > worth of bytes in the USB hardware queue.
>
> Having truncated URBs is possible only when URBs are shorter than one
> period,

No.  URBs are truncated when a full-sized URB would extend at least one
packet beyond the end of a frame.  Even then, the frame end actually
occurs somewhere in the middle of the last packet of the truncated URB.

> so I think that a queue length of at least two periods, together
> with a minimum period size, should ensure the isochrounous scheduling
> threshold.

This depends on how long a period is.  Assumptions about the length 
should be avoided.


On Wed, 14 Aug 2013, Clemens Ladisch wrote:

> > After more thought, I decided that patch does too much.  It's not
> > necessary to keep track of the number of packets.  Instead, the driver
> > should always try to keep as much data in the USB hardware queue as it
> > is allowed to.
>
> This is what the current code does (i.e., re-submitting all URBs in
> their completion handler).

But that isn't as much as is allowed.  Consider an example where each 
URB is 8 uframes, a period is 1 ms, and the buffer size is 4 periods.  
The driver will allocate 2 or 3 URBs and keep them all busy, but it is 
allowed to use as many as 4.

> > In other words, there should be enough URBs so that an entire ALSA
> > buffer can be queued at any time, subject only to the limit on the
> > maximum number of URBs and packets.
>
> The URB queue adds latency, so it should never be made too big, even
> for big ALSA buffers.  Once we have reached a queue length that is
> practically guaranteed to be safe from underruns, more URBs do not make
> sense.  (The current limit of 24 ms is somewhat arbitrary.)

I agree.  The total queue size should be limited by:

	a maximum total number of URBs,

	a maximum total number of packets,

	a maximum reasonable latency (maybe smaller than 24 ms),

	and the ALSA buffer size.

All these factors should be taken into account, and whatever the final
value ends up being, the queue should be kept as close to it as
possible.  If the user specifies a buffer size so small that the
scheduling threshold is violated and an underrun occurs, it's the
user's own fault.

The difficulty arises because (for playback endpoints) URBs don't have
fixed numbers of packets and the packets don't have fixed numbers of
frames.  The numbers change to avoid sending too much data to the
device in a single packet and to avoid going beyond the end of an ALSA
period in a single URB.

This means that the driver should overestimate the number of URBs 
required, and submit them as needed to keep the queue full.  If this 
means that sometimes a completion callback doesn't submit anything and 
other times it submits more than one URB, so be it.

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

Yeah, that's one of the things that got changed in my patch.

> And while we're at it: the default number of packets per URB was chosen  
> before the driver had the ability to estimate the delay from the current
> frame number; it should now be quite safe to increase it.

I don't understand how this delay estimation is supposed to work, or 
what it is meant to accomplish.  Can you explain?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
