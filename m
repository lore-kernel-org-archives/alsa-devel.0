From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
Date: Mon, 11 Jan 2016 14:53:36 +0100
Message-ID: <A156F37A-76CF-4ECF-8C85-162A71877EC5@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org> <20160110115858.GV6588@sirena.org.uk> <39E8C95F-C7DC-46C3-B29A-93A865485942@martin.sperl.org> <4412078.STjb1rKkbV@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4412078.STjb1rKkbV@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Remi Pommarel <repk-lovNVp52yxIDGOk2Oe9MvA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, lFlorian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


> On 11.01.2016, at 14:38, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>=20
> On Sunday 10 January 2016 13:17:17 Martin Sperl wrote:
>>=20
>> What you propose is a major change to the clock framework, so I woul=
d
>> hope that Eric (the original author of this clock-driver) would addr=
ess
>> it.
>>=20
>> Maybe someone has a better idea for a pattern to use to achieve=20
>> the required while maintaining =E2=80=9Csynchronization=E2=80=9D bet=
ween defines
>> inside the dt-binding and the driver.
>=20
> It's funny to look at the register list:
>=20
> #define CM_VPUCTL               0x008
> #define CM_VPUDIV               0x00c
> #define CM_SYSCTL               0x010
> #define CM_SYSDIV               0x014
> #define CM_PERIACTL             0x018
> #define CM_PERIADIV             0x01c
> #define CM_PERIICTL             0x020
> #define CM_PERIIDIV             0x024
> #define CM_H264CTL              0x028
> #define CM_H264DIV              0x02c
>=20
> This one seems completely regular, there is always a pair of CTL and =
DIV
> registers, so I would have guessed that we could just take the index
> of that to completely avoid the need for the header file and just hav=
e
> a lookup table of each index.
>=20
> I can see two possible ways forward:
>=20
> a) deprecate the existing binding and write a new simpler driver to
>   replace it with one that does not need the header. We probably need
>   to keep both drivers around indefinitely though to deal with people
>   that have their own dtb files, so this is a bit awkward.
I was thinking about this as well, but am concerned about the dt-change=
s.

Also initialization order may be an issue, so I have avoided that.

> b) look at all the holes in the table and define new numbers for them
>   now, then remove the count as the driver can simply hardcode the
>   maximum number as it knows it will never change.
There are clocks for most of them - See my patch I sent some time ago.

Right now I have got a working version with the following patches:
817176d clk: bcm2835: add missing clocks
8f74701 clk: bcm2835: enable management of PCM clock
62a7d94 clk: bcm2835: move to a different initialization scheme.

There is one more thing that I would like to do before submitting those
as a patch-set: enable the fractual divider, because right now
we calculate the fractual divider value correctly, but we do not set
the flag to enable it, so we are actually running too fast most
of the times...


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
