From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Buffer size for ALSA USB PCM audio
Date: Mon, 29 Jul 2013 14:20:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1307291400450.1479-100000@iolanthe.rowland.org>
References: <51F6A262.6010800@ladisch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51F6A262.6010800-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Jul 2013, Clemens Ladisch wrote:

> Alan Stern wrote:
> > Clemens remarked some time ago that keeping the queue full would be
> > trivial, if only he knew how full it needed to be.  The answer to that
> > is given above.  I have been trying to make the appropriate changes,
> > but I'm not finding it "trivial".
> 
> What I meant was that it would be trivial to change the lower bound of
> the period size (from which many queueing parameters are derived).

I doubt that would help.  What really matters here is the relation
between urb_packs (the maximum number of packets in an URB) and the
number of packets in a period (which can vary as the device's clock
frequency drifts).

For a bizarre example of sort of thing that can happen, suppose 
urb_packs is 8 and and a period always consists of 8 packets.  Then to 
occupy 10 uframes requires two URBs (assuming one packet per uframe).

But now suppose a period might need 9 packets (say because the device's 
clock frequency is a little low, so it consumes samples less quickly 
and therefore a fixed number of samples takes more time).  Then to 
occupy 10 uframes, two URBs would no longer be enough, because the 
numbers of packets in successive URBs could be 8, 1, 8, etc.  Two 
URBs would occupy only 9 uframes.

> > The current driver seems to assume that endpoints with an _implicit_
> > feedback endpoint won't have variable-length packets.
> 
> That's likely to be a bug.

data_ep_set_params() checks snd_usb_endpoint_implicit_feedback_sink() 
in three places.  It looks like only the second place is correct.

Can you verify whether the other two are right, and explain to me if 
they are?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
