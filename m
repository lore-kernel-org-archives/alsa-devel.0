From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 05/15] ASoC: phycore-ac97: Add DT support
Date: Tue, 16 Apr 2013 17:23:05 +0200
Message-ID: <20130416152305.GE13272@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
 <1365939779-4507-6-git-send-email-mpa@pengutronix.de>
 <20130416115942.GG26958@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C879D2610A6
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 17:23:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130416115942.GG26958@opensource.wolfsonmicro.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 16, 2013 at 12:59:43PM +0100, Mark Brown wrote:
> On Sun, Apr 14, 2013 at 01:42:49PM +0200, Markus Pargmann wrote:
> 
> > +	/*
> > +	 * This driver doesn't need to know which actual hardware is used.
> > +	 * The audmux driver has knowledge about it's type, and returns
> > +	 * an error if executed on the wrong type of hardware.
> > +	 */
> > +	ret = phycore_ac97_pca100_audmux();
> > +	if (!ret)
> > +		return 0;
> > +
> > +	ret = phycore_ac97_pcm043_audmux();
> 
> The DT really ought to be able to give enough information to figure out
> the audmux configuration.  If we can't do that it rather defeats the
> point of moving to DT...

Yes you are right, I added a phandle "phytec,audmux" to check which
audmux setup function we have to use.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
