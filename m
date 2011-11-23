From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: Re: [PATCH 2/5] ASoC: OMAP4: omap-dmic: Initial support for OMAP DMIC
Date: Wed, 23 Nov 2011 16:00:23 +0200
Message-ID: <3755917.L7uBQxiu6F@barack>
References: <1321970520-8909-1-git-send-email-peter.ujfalusi@ti.com> <1619032.uInsqOQfdX@barack> <20111123105806.GA21073@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20111123105806.GA21073@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 23 November 2011 10:58:07 Mark Brown wrote:
> This just seems like it's making the code needlessly complex - there'=
s
> no harm in holding the reference if you don't enable/disable the cloc=
k
> and it makes this function much simpler.

OK.

> > We enable the clocks at dai_startup for the DMIC (and disable them =
on
> > dai_shutdown). We can not reparent while the clocks are enabled.
> > This is the reason for this part.
>=20
> That sounds like the enable is happening too early, then.

This only enables the clock for the DMIC block, the clock for the exter=
nal=20
DMIC will start at trigger time (and stop as well).
In order to access to DMIC registers we need clocks, and the clocks are=
=20
enabled for the duration we have capture stream open.
I would think this is acceptable.

> If that's what you're doing then it seems like the machine drivers
> should be use set_sysclk() (or perhaps even the clk API) to set up th=
e
> rate they're looking for from the visible clock rather than fiddling
> about with magic divider values.  That way they can say exactly what
> they want directly in terms of the result they're looking for.

In OMAP4 DMIC the divider can not be chosen freely.
The clock provided to the external microphones will depend on the selec=
ted=20
DMIC_FCLK, and the divider.
If I ask the machine driver to ask for specific speed for the external =
mic,=20
the writer of the machine driver anyways have to look up the table from=
 the=20
TRM for the possible frequencies. So instead of providing magic divider=
 it has=20
to provide magic speed.
I can do that if you prefer that way, but it just going to 'complicate'=
 the=20
driver a bit (well not that much, we just will have different way of lo=
oking=20
up the register value for the divider, and it will be done in=20
omap_dmic_set_dai_sysclk instead of omap_dmic_set_clkdiv).

--
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
