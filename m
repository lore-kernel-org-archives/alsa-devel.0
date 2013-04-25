From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5 01/10] ASoC: phycore-ac97: Add DT support
Date: Thu, 25 Apr 2013 11:35:20 +0800
Message-ID: <20130425033517.GA1276@S2101-09.ap.freescale.net>
References: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
 <1366814199-14827-2-git-send-email-mpa@pengutronix.de>
 <20130424194540.GF32299@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 36D62265CF8
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 05:35:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130424194540.GF32299@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 24, 2013 at 09:45:40PM +0200, Sascha Hauer wrote:
> Hi Markus,
> 
> On Wed, Apr 24, 2013 at 04:36:30PM +0200, Markus Pargmann wrote:
> > Add devicetree support for this audio soc fabric driver.
> > 
> > @@ -32,8 +35,12 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
> >  		.stream_name	= "HiFi",
> >  		.codec_dai_name		= "wm9712-hifi",
> >  		.codec_name	= "wm9712-codec",
> > +#ifdef CONFIG_MACH_IMX27_DT
> > +		.platform_name	= "imx-fiq-pcm-audio",
> > +#else
> >  		.cpu_dai_name	= "imx-ssi.0",
> >  		.platform_name	= "imx-fiq-pcm-audio.0",
> > +#endif
> 
> This doesn't work properly. Compiling the kernel with IMX27_DT enabled
> does not necessarily mean that it also started with dt support.
> 
Right, we should run-time check pdev->dev.of_node to see if it's a DT
boot and set .platform_of_node rather than .platform_name if it is.  But
it's only possible with the cleanup series "ASoC: fsl: imx-pcm driver
cleanup" I just sent being the base.  I hope you can rebase your series
on that :)

Shawn

> Personally I am fine with removing platform based support for this
> driver if it's too much effort to fix it properly, but we shouldn't
> start working with ifdefs here.
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
