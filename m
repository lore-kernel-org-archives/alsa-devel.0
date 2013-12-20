From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 5/9] ASoC: fsl-ssi: Add offline_config
	flag
Date: Fri, 20 Dec 2013 11:08:53 +0100
Message-ID: <20131220100853.GH23493@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-6-git-send-email-mpa@pengutronix.de>
 <20131219131643.GA31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2B92E265358
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 11:09:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131219131643.GA31886@sirena.org.uk>
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

On Thu, Dec 19, 2013 at 01:16:43PM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 12:57:41PM +0100, Markus Pargmann wrote:
> 
> > +	/*
> > +	 * imx51 and later SoCs have a slightly different IP that allows the
> > +	 * SSI configuration while the SSI unit is running.
> > +	 *
> > +	 * More important, it is necessary on those SoCs to configure the
> > +	 * sperate TX/RX DMA bits just before starting the stream
> > +	 * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
> > +	 * sends any DMA requests to the SDMA unit, otherwise it is not defined
> > +	 * how the SDMA unit handles the DMA request.
> > +	 *
> > +	 * SDMA units are present on devices starting at imx35 but the imx35
> > +	 * reference manual states that the DMA bits should not be changed
> > +	 * while the SSI unit is running (SSIEN). So we support the necessary
> > +	 * online configuration of fsl-ssi starting at imx51.
> > +	 */
> > +	if (hw_type != FSL_SSI_MX51)
> > +		ssi_private->offline_config = true;
> > +
> 
> This is really confusing.  I'd expect a switch statement here
> enumerating the pre-i.MX51 hardware types otherwise if there's a new
> variant added it'll do the wrong thing - the comment sounds like the
> opposite of the test.

Fixed.

Thanks,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
