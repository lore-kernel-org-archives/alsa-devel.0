From: Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Sun, 22 Sep 2013 23:50:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309222343390.4431@anubis>
References: <Pine.LNX.4.44L0.1308291059300.1170-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1308291059300.1170-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: James Stone <jamesmstone-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



On Thu, 29 Aug 2013, Alan Stern wrote:

> On Thu, 29 Aug 2013, James Stone wrote:
> 
> > On Wed, Aug 28, 2013 at 7:46 PM, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> wrote:
> > > On Wed, 28 Aug 2013, Clemens Ladisch wrote:
> > >
> > >> Sorry, what I said applies more to explicit sync endpoints.  When using
> > >> implicit sync, a playback URB is submitted for each completed capture
> > >> URB, with the number of samples per packet identical to the
> > >> corresponding capture packet, so the parameters must be identical.
> > >
> > > Got it.  Below is an updated patch.
> > >
> > > James, the problem you encountered was most likely a result of the
> > > faulty treatment of capture endpoints that Clemens pointed out.  It was
> > > quite obvious in the usbmon traces that the unpatched driver used 8
> > > packets per URB whereas the patched driver used 22.  This updated patch
> > > should fix that problem.
> > >
> > 
> > Works fine. With this, it is possible to get clear playback at 64
> > frames/period too. With vanilla 3.10.9, there was some glitchy
> > distortion to the sound at that latency, so this seems to be an
> > improvement.
> 
> That's good.  What happens if you push frames/period even lower?
> 
> Daniel and Eldad, more testing of the most recent proposed patch would
> be welcome.

Sorry for the long response time but I've been busy lately.

I see a good improvement on my card (M-Audio C400, implicit feedback) -
using a 48 frame period (@48kHz) I get no xruns with jack running without 
clients. Without the patch, the above test generates constant xruns.
I tested the patch with mainline 3.11.0, and let jack run about 5 
minutes.

Thank you for working on this! FWIW, feel free to add:

Tested-by: Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>

Cheers,
Eldad
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
