From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Subject: Re: [PATCHv4] dmaengine: Add support for BCM2835
Date: Thu, 14 Nov 2013 17:32:53 +0100
Message-ID: <CABDT8Wxy-aA5CbZUSXRtod3i_9rBhXqGyGi+tBYGkYtygQmmpw@mail.gmail.com>
References: <5283BC93.1090801@koalo.de>
	<2385512.qcT1vt8HYp@flatron>
	<CABDT8WyUK6tDneDEm0G3o0zJHXaVTZp8JAMxOp5LRKQYG-7Umw@mail.gmail.com>
	<11018682.0TjgocUWod@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <11018682.0TjgocUWod@flatron>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

2013/11/14 Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Thursday 14 of November 2013 17:14:31 Florian Meier wrote:
>> >> >> I am becoming desperate anyway that this migration will ever fully
>> >> >> take place....
>> >> >
>> >> > Why not? It's just a matter of people like you working on this (and
>> >> > addressing some review comments ;)).
>> >>
>> >> The most common comment about this is that people will not put effort in
>> >> the upstream kernel as long as there is no comfortable way for debugging
>> >> in the upstream kernel (i.e. at least USB support).......
>> >
>> > Right, you need USB to have ethernet working. Still, IMHO UART (for
>> > console) + ethernet (for file transfer or NFS root) is the reasonable
>> > setup allowing you to debug further drivers in a comfortable way.
>>
>> I am fine with UART and switching SD cards :-)
>> But apparently this is not generally accepted.
>
> Still, isn't some work on USB support for RPi already going on? I believe
> Matt Porter (now on Cc) has been working on unifying dwc2 host-mode
> driver with Samsung s3c-hsotg device-mode driver (for the same IP) to
> get full OTG support on all applicable platforms.

That sounds great! I never heard about that.
Maybe some day it really happens that Raspbian uses the upstream kernel :-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
