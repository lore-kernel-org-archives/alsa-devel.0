From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 5/6] ASoC: tlv320aic32x4: Support for
	master clock
Date: Tue, 28 Jan 2014 11:01:47 +0100
Message-ID: <20140128100147.GE32009@pengutronix.de>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-6-git-send-email-mpa@pengutronix.de>
 <20140127181707.GD11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0C27426519E
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:01:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140127181707.GD11841@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 27, 2014 at 06:17:07PM +0000, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 01:03:09PM +0100, Markus Pargmann wrote:
> 
> >  	case SND_SOC_BIAS_STANDBY:
> > +		/* Switch off master clock */
> > +		if (!IS_ERR(aic32x4->mclk))
> > +			clk_disable_unprepare(aic32x4->mclk);
> > +
> >  		/* Switch off PLL */
> >  		snd_soc_update_bits(codec, AIC32X4_PLLPR,
> >  				    AIC32X4_PLLEN, 0);
> 
> This looks like it's disabling the MCLK before disabling the PLL - if
> the two are being disabled together I would expect to see the other way
> around.

Yes right, should be the other way round, although it doesn't make a
difference.
I will change it for v4.

Thanks,

Markus



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
