From: Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] dt-bindings: ASoC: rsnd: Add device tree support for
 r8a774[35]
Date: Wed, 13 Dec 2017 13:14:39 +0000
Message-ID: <KL1PR06MB1702225AD5F7BF8737C97A85B8350@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1513102155-47925-1-git-send-email-biju.das@bp.renesas.com>
 <20171213122052.GG6416@sirena.org.uk>
 <CAMuHMdVY5PwEvZYBzC_f-W_n9ATST4_tfPBO4CakYo-93DvLtA@mail.gmail.com>
 <20171213125531.GJ6416@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171213125531.GJ6416@sirena.org.uk>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

Thanks for the feedback, I will send a v2.

Regards,
Biju

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: 13 December 2017 12:56
> To: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Biju Das <biju.das@bp.renesas.com>; Liam Girdwood
> <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Simon Horman <horms@verge.net.au>; Magnus
> Damm <magnus.damm@gmail.com>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; ALSA Development Mailing List <alsa-
> devel@alsa-project.org>; Linux-Renesas <linux-renesas-soc@vger.kernel.org=
>
> Subject: Re: [PATCH] dt-bindings: ASoC: rsnd: Add device tree support for
> r8a774[35]
>
> On Wed, Dec 13, 2017 at 01:34:40PM +0100, Geert Uytterhoeven wrote:
>
> > The confusing part here is that for most[*] subsystems, patches
> > touching only DT bindings should have a "dt-bindings" prefix, while
> > patches touching both DT bindings and driver code should have the drive=
rs'
> subsystem prefix.
>
> > [*] I think you're about the only maintainer who insists on patches
> > touching only DT bindings having the drivers' subsystem prefix, which
> > people tend to forget, if they're even aware of that rule...
>
> > Can we improve this?
>
> This is something Rob's been pushing which seems like a step back to me s=
o I've
> been pushing back on it - it's causing problems for me spotting things I =
need to
> look at and later on in review (including my scripting, which does pay at=
tention
> to subject lines).  I suspect I'm at the upper end of people getting lots=
 of
> irrelevant stuff in copy which doesn't help here.


[https://www2.renesas.eu/media/email/unicef_2017.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
