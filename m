From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Support for selecting system clocks by ID
Date: Tue, 16 Feb 2016 11:13:46 -0800
Message-ID: <20160216191346.2278.725@quark.deferred.io>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk> <56C2F00C.8080809@ti.com>
 <20160216134233.GN18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160216134233.GN18327@sirena.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, linux-clk@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: alsa-devel@alsa-project.org

Quoting Mark Brown (2016-02-16 05:42:33)
> On Tue, Feb 16, 2016 at 11:46:52AM +0200, Peter Ujfalusi wrote:
> 
> > As for codecs, tlv320aic3106 is also pretty simple device from the outside, it
> > can receive it's reference clock via:
> > MCLK pin, GPIO2 pin or it can use the BCLK from the bus. Based on the incoming
> > frequency it can use it directly or it needs to use the internal PLL to
> > generate the cocks.
> > It can output generated clock via GPIO1
> 
> That already sounds like there is room for configuration and hooking
> into a wider clock tree - we've got three different source options and
> an output plus a PLL that can presumably take in non-audio rates.

+1

It is quite easy for existing drivers to become clock providers. Please
see struct isp_xclk in:

drivers/media/platform/omap3isp/isp.h
drivers/media/platform/omap3isp/isp.c

CCF is intentionally designed as a library, meaning that you don't need
to create a new struct device to register clocks. Feel free to BYOD
(bring your own device).

Then your IP block clocks (McASP in this case) can hook into the
system-wide clock tree (e.g. where some of the parent clocks come from).

> 
> > I don't think it will bring any clarity or features we miss right now if we
> > try to move CPU and codec drivers to clk API. IMHO.

CPU drivers? Peter, you wrote the CCF clock provider driver for DRA7
ATL, so I'm not sure what you mean here.

> 
> You happen to be looking at a particularly simple system but things do
> scale up and there's not a clear cutoff point which would allow us to
> make a clear distinction between things that might get used in a simple
> system and things that might need something more complex.  This seems
> particularly important when we're adding things to simple-card, we want
> it to be usable with as many different devices as possible.

The original patches didn't hit my inbox, only the last two replies. Can
someone fill me in on the DT side of this discussion? Why are DT
bindings needed here? Are other devices besides McASP consuming the
clocks provided by McASP?

DT can also be a good candidate for doing per-board (or per-use case)
clock configuration via the assigned-clocks, assigned-clock-rates, and
assigned-clock-parents properties.

Regards,
Mike
