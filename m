From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 1/9] ASoC: fsl-ssi: Fix probe error
	handling
Date: Fri, 20 Dec 2013 10:52:23 +0100
Message-ID: <20131220095223.GG23493@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-2-git-send-email-mpa@pengutronix.de>
 <20131219130334.GZ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CDC9F265325
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 10:52:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131219130334.GZ31886@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Dec 19, 2013 at 01:03:34PM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 12:57:37PM +0100, Markus Pargmann wrote:
> > This patch fixes the error handling in the fsl-ssi probe function.
> 
> This doesn't apply against current code, please check and resend.

Okay, I will rebase on your topic/fsl again.

> 
> >  error_irqmap:
> > -	irq_dispose_mapping(ssi_private->irq);
> > +	if (ssi_private->use_dma && !of_device_is_compatible(pdev->dev.of_node,
> > +				"fsl,imx21-ssi"))
> > +		irq_dispose_mapping(ssi_private->irq);
> 
> This test is icky, a flag set when we create the mapping would be neter.

Fixed.

Thanks,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
