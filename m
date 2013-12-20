From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 4/9] ASoC: fsl-ssi: Fix interrupt
	mapping and release
Date: Fri, 20 Dec 2013 11:31:52 +0100
Message-ID: <20131220103152.GI23493@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-5-git-send-email-mpa@pengutronix.de>
 <20131220090527.GB15246@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 820F8265452
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 11:32:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131220090527.GB15246@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On Fri, Dec 20, 2013 at 05:05:28PM +0800, Nicolin Chen wrote:
> Hi Markus,
> 
> On Wed, Dec 18, 2013 at 12:57:40PM +0100, Markus Pargmann wrote:
> > irqs should only be requested/released with enabled DMA and not on MX21.
> > MX21 has some special register write configurations, so we do not add
> > support for statistics on mx21 for the moment.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  sound/soc/fsl/fsl_ssi.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> > @@ -227,13 +228,15 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
> >  
> >  	if (sisr & CCSR_SSI_SISR_RFRC) {
> >  		ssi_private->stats.rfrc++;
> > -		sisr2 |= CCSR_SSI_SISR_RFRC;
> > +		if (ssi_private->hw_type != FSL_SSI_MX51)
> > +			sisr2 |= CCSR_SSI_SISR_RFRC;
> >  		ret = IRQ_HANDLED;
> >  	}
> >  
> >  	if (sisr & CCSR_SSI_SISR_TFRC) {
> >  		ssi_private->stats.tfrc++;
> > -		sisr2 |= CCSR_SSI_SISR_TFRC;
> > +		if (ssi_private->hw_type != FSL_SSI_MX51)
> > +			sisr2 |= CCSR_SSI_SISR_TFRC;
> 
> I had a hard time on this part of modification because I just saw the commit
> comments 'not on MX21' until I checked the RM of imx35, which should be same
> as imx21 one: RFRC and RFRC became non-writeable since imx51. The should be
> the reason here right?

mx21 has actually no writable bits in SISR at all, it's the same for
imx27 and imx31. imx35 would actually work with the current
fsl_ssi_isr().

However I just realised that only imx35 has all 6 bits writeable right?
So I added another hw_type MX35 to get irq stats working for all imx's.

> 
> And just for curiosity, is there any wrong with this part, like causing SSI
> mis-behavior?

Yes it doesn't work for all SoCs:
f0377086 ASoC: fsl: disable ssi irq for imx

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
