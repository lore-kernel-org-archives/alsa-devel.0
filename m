From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH v2 2/3] ARM: mx28evk: set a initial clock
	rate for saif
Date: Thu, 8 Sep 2011 08:03:17 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77223E900@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1315403858-9904-1-git-send-email-b29396@freescale.com>
	<1315403858-9904-3-git-send-email-b29396@freescale.com>
	<20110907182142.GY28816@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C1EB24802
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 10:03:24 +0200 (CEST)
In-Reply-To: <20110907182142.GY28816@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
> Sent: Thursday, September 08, 2011 2:22 AM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; lrg@ti.com; linux-arm-
> kernel@lists.infradead.org; w.sang@pengutronix.de
> Subject: Re: [PATCH v2 2/3] ARM: mx28evk: set a initial clock rate for
> saif
> =

> On Wed, Sep 07, 2011 at 09:57:37PM +0800, Dong Aisheng wrote:
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> >
> > ---
> > No changes since v1.
> >
> > Note this patch still needs another patch from Wolfram to work.
> > I send out it in this series as
> > [PATCH 3/3] arm: mxs: disable clock-gates when setting saif-clocks
> If your patch 2 depends on patch 3 there is something fishy.
Yes, because the original saif clk setting code has some issues
Which can be fixed in patch 3.
 =

> >
> > As discussed with Wolfram, that patch may still have some later work
> > to do. However, we just send out it for testers to work first.
> > ---
> >  arch/arm/mach-mxs/clock-mx28.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c
> > b/arch/arm/mach-mxs/clock-mx28.c index f0c7cb6..33cc2ff 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -826,6 +826,15 @@ int __init mx28_clocks_init(void)
> >  	clk_set_parent(&saif0_clk, &pll0_clk);
> >  	clk_set_parent(&saif1_clk, &pll0_clk);
> >
> > +	/*
> > +	 * Set an initial clk rate for saif's internal logic to work
> properly,
> > +	 * this is especially for the saif working on EXTMASTER mode that
> who
> > +	 * uses other saif's BITCLK&LRCLK but it still needs a basic clk
> which
> > +	 * should be bigger enough for its internal logic.
> This is not a proper (German) English sentence. Maybe this is better?:
> =

> 	Set an initial clock rate for the saif internal logic to work
> 	properly. This is important when working in EXTMASTER mode that
> 	uses the other saif's BITCLK&LRCLK but it still needs a basic
> 	clock which should be fast enough for the internal logic.
Yes, I think it's better. :)
I will change like that.

> > +	 */
> > +	clk_set_rate(&saif0_clk, 24000000);
> > +	clk_set_rate(&saif1_clk, 24000000);
> > +
> Do you need to check for clk_set_rate returning -ESOMETHING here?
Basically this rate setting will not fail in clock_init.
I noticed arch/arm/mach-mx5/clock-mx51-mx53.c also used like this.
Should I add an error checking here?

Regards
Dong Aisheng
