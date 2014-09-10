From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Wed, 10 Sep 2014 18:01:42 +0800
Message-ID: <20140910100141.GA17326@audiosh1>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140909195928.GA5224@Asurada>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mpa@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 09, 2014 at 12:59:29PM -0700, Nicolin Chen wrote:
> On Tue, Sep 09, 2014 at 02:37:42PM -0500, Timur Tabi wrote:
> > On 09/09/2014 01:38 PM, Nicolin Chen wrote:
> > >make sure to have the call for imx only because it seems that
> > >the other platforms do not depend on the clock.
> > 
> > Although I doubt anyone will every add support for clocks to PowerPC "side"
> > of this driver, I would prefer to avoid IMX-specific changes. Instead, the
> > code should check if a clock is available.  That's why I suggested this
> > change:
> > 
> > -	if (ssi_private->soc->imx)
> > +	if (!IS_ERR(ssi_private->clk))
> 
> Hmm.... I think the following change may be better?
> 
> probe() {
> 	....
> +	/*
> +	 * Initially mark the clock to NULL for all platforms so that later
> +	 * clk_prepare_enable() will ignore and return 0 for non-clock cases.
> +	 */
> +	ssi_private->clk = NULL;
> 	.....
> 	fsl_ssi_imx_probe();
> }
ssi_private is initialized to zero in beginning of probe. I think no need to
add this change here.

wang shengjiu
> 
> In this way, all platforms, not confined to imx any more, will be able
> to call clk_prepare_enable(). Then we don't need an extra platform check
> before calling it.
