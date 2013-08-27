From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Tue, 27 Aug 2013 12:50:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308271246130.1810-100000@iolanthe.rowland.org>
References: <521C5315.3030207@ladisch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <521C5315.3030207-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, James Stone <jamesmstone-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Aug 2013, Clemens Ladisch wrote:

> There is no reasoning about capture endpoints.
> 
> The driver cannot control how many samples actually end up in a capture
> packet, so it is possible that URBs end up being one USB frame longer
> than a period, in which case the ALSA period interrupts will accumulate
> delays of up to one period, or that URBs end up being one USB frame
> shorter than a period, in which case the ALSA period interrupt will be
> delayed to the end of the _next_ URB.
> 
> The current algorithm uses very short capture URBs to ensure that _some_
> URB is completed as soon as possible after a period ends.
> 
> Your patch makes things worse for running jackd at lower latencies
> because playback and capture period interrupts are expected to be more
> or less synchronous (jackd waits for both interrupts before acting on
> one period).  With only two periods per buffer and the capture period
> interrupt randomly delayed by up to one period, the time available for
> processing one period is reduced to zero.
> 
> I'd suggest to keep the old calculation for capture URBs.  It would
> make sense to use longer capture URBs only if the period size is
> relatively large.

Okay.  What about playback endpoints with implicit sync?  The current 
driver treats them the same as capture endpoints.  Is that really the 
right thing to do?

> Note: for capturing, the number of URBs has no effect on latency and
> just reduces the risk of overruns, so it is desirable to make the queue
> as long as possible (for a given URB length).

Sure.  It looks like the only limit that will matter here is MAX_URBS.

> > Not having heard any responses to the patch posted last Wednesday,
> 
> Sorry, my #patches / free_time quotient is rather large.

Me too.  And don't forget bug reports.  :-)

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
