From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv7] dmaengine: Add support for BCM2835
Date: Mon, 18 Nov 2013 15:04:28 +0000
Message-ID: <20131118150428.GK30853@e106331-lin.cambridge.arm.com>
References: <5288E327.8050809@koalo.de>
 <1384768816.14845.186.camel@smile>
 <528A051A.7000703@koalo.de>
 <1384785017.14845.214.camel@smile>
 <20131118145400.GE16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131118145400.GE16735-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Koul, Vinod" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 18, 2013 at 02:54:00PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 18, 2013 at 04:30:17PM +0200, Andy Shevchenko wrote:
> > On Mon, 2013-11-18 at 13:16 +0100, Florian Meier wrote:
> > > >> +	uint32_t chans_available;
> > > > 
> > > > Why uint32_t?
> > > 
> > > Because it is a bit mask of fixed length that directly comes from the
> > > firmware.
> > 
> > Like one already told you in your i2s patch, please, change that to
> > corresponding u* value, namely u32.
> 
> There's no problem with uint32_t vs u32 - either will do.  u32 is the
> pre-stdint.h Linux definition of a 32-bit unsigned integer.  There's
> no reason why uint32_t isn't perfectly acceptable.  It's a matter of
> author taste which gets used.  (Except where modifications are to an
> existing chunk of code using one or the other - where consistency then
> matters more.)

Sorry for being a source of confusion here. I won't push this point in
future.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
