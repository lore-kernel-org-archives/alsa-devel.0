From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 01/10] ASoC: phycore-ac97: Add DT support
Date: Thu, 25 Apr 2013 13:02:43 +0200
Message-ID: <20130425110243.GA27763@pengutronix.de>
References: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
 <1366814199-14827-2-git-send-email-mpa@pengutronix.de>
 <20130424194540.GF32299@pengutronix.de>
 <20130425033517.GA1276@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 92386265DB6
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 13:03:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130425033517.GA1276@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 25, 2013 at 11:35:20AM +0800, Shawn Guo wrote:
> On Wed, Apr 24, 2013 at 09:45:40PM +0200, Sascha Hauer wrote:
> > Hi Markus,
> > 
> > On Wed, Apr 24, 2013 at 04:36:30PM +0200, Markus Pargmann wrote:
> > > Add devicetree support for this audio soc fabric driver.
> > > 
> > > @@ -32,8 +35,12 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
> > >  		.stream_name	= "HiFi",
> > >  		.codec_dai_name		= "wm9712-hifi",
> > >  		.codec_name	= "wm9712-codec",
> > > +#ifdef CONFIG_MACH_IMX27_DT
> > > +		.platform_name	= "imx-fiq-pcm-audio",
> > > +#else
> > >  		.cpu_dai_name	= "imx-ssi.0",
> > >  		.platform_name	= "imx-fiq-pcm-audio.0",
> > > +#endif
> > 
> > This doesn't work properly. Compiling the kernel with IMX27_DT enabled
> > does not necessarily mean that it also started with dt support.
> > 
> Right, we should run-time check pdev->dev.of_node to see if it's a DT
> boot and set .platform_of_node rather than .platform_name if it is.  But
> it's only possible with the cleanup series "ASoC: fsl: imx-pcm driver
> cleanup" I just sent being the base.  I hope you can rebase your series
> on that :)

The current version of phycore-ac97.c is not a driver, it is just a late
init call. So run-time check is not possible unless I modify the old
part to be a driver and add a device to all board init functions using
ac97. (I would prefer dropping the non-DT part in this case ;) )

Yes I rebased this series onto your cleanups, looks good so far and
platform_of_node works finally.

Thanks,

Markus

> 
> Shawn
> 
> > Personally I am fine with removing platform based support for this
> > driver if it's too much effort to fix it properly, but we shouldn't
> > start working with ifdefs here.
> > 
> > Sascha
> > 
> > 
> > -- 
> > Pengutronix e.K.                           |                             |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
