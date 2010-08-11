From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: i.MX SDMA support
Date: Wed, 11 Aug 2010 13:59:36 +0200
Message-ID: <20100811115936.GQ27749@pengutronix.de>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin>
	<20100809121956.GA27749@pengutronix.de>
	<64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
	<20100810131527.GK27749@pengutronix.de>
	<1281449263.3059.53.camel@odin>
	<20100811084213.GN27749@pengutronix.de>
	<1281521394.3080.26.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 6E3E3103868
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 13:59:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281521394.3080.26.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 11, 2010 at 11:09:54AM +0100, Liam Girdwood wrote:
> On Wed, 2010-08-11 at 10:42 +0200, Sascha Hauer wrote:
> > On Tue, Aug 10, 2010 at 03:07:43PM +0100, Liam Girdwood wrote:
> > > On Tue, 2010-08-10 at 15:15 +0200, Sascha Hauer wrote:
> > > 
> > > > I just looked at the i.MX part in the multi-component update and this
> > > > is currently far from being in a working state, so there's still some
> > > > work to do before thinking about possible conflicts...
> > > 
> > > Ok, I don't think it's that far off. Everything builds for i.MX and all
> > > components should register. The part I can't test is the component
> > > probe() and playback/capture.
> > > 
> > > Have you seen an oops ?
> > 
> > Many of them, yes ;)
> > 
> > The following patch puts i.MX (nearly) back into business.
> > 
> 
> Thanks for this.

There are probably some bits for the DMA part missing, I haven't tested
it yet, but will do soon.

> 
> >  	if (ssi->flags & IMX_SSI_USE_AC97)
> > @@ -706,7 +731,7 @@ static struct platform_driver imx_ssi_driver = {
> >  	.remove = __devexit_p(imx_ssi_remove),
> >  
> >  	.driver = {
> > -		.name = "imx-ssi-dai",
> > +		.name = "imx-ssi",
> 
> The reason that the DAI driver name was changed on all platforms to
> include a "-dai" suffix was to distinguish the ASoC SSI driver from a
> generic SSI serial IO driver (i.e. SSI for non audio users). This is
> mainly due to the fact that most audio interfaces on SoC CPUs exist
> within a generic serial interface and are also often used for non audio
> purposes.
> 
> So if this suffix is ok, I guess I would need to update the the
> following too ?

Yes, they have to be updated too. I have some more occurences in my
tree, but a wcgrep imx-ssi should catch them all.

> 
> arch/arm/mach-mx2/devices.c:418:		.name = "imx-ssi",		\
> arch/arm/mach-mx2/clock_imx27.c:656:	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
> arch/arm/mach-mx2/clock_imx27.c:657:	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
> arch/arm/mach-mx3/clock-imx31.c:561:	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
> arch/arm/mach-mx3/clock-imx31.c:562:	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
> arch/arm/mach-mx3/clock-imx35.c:467:	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
> arch/arm/mach-mx3/clock-imx35.c:468:	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
> arch/arm/mach-mx3/devices.c:565:	.name = "imx-ssi",
> arch/arm/mach-mx3/devices.c:572:	.name = "imx-ssi",
> arch/arm/plat-mxc/audmux-v2.c:52:		return "imx-ssi.0";
> arch/arm/plat-mxc/audmux-v2.c:54:		return "imx-ssi.1";
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
