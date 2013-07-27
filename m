From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v10 1/7] ASoC: core: Generic ac97 link
	reset functions
Date: Sat, 27 Jul 2013 15:55:58 +0200
Message-ID: <20130727135558.GG16871@s25.your-server.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-2-git-send-email-mpa@pengutronix.de>
 <20130727120522.GG9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1DDA2260851
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2013 15:56:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130727120522.GG9858@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 27, 2013 at 01:05:22PM +0100, Mark Brown wrote:
> On Sat, Jul 27, 2013 at 01:31:50PM +0200, Markus Pargmann wrote:
> 
> This is a really nice approach to the problem, just one thing I'd like
> to see changed in the bindings:
> 
> > +ssi {
> > +	...
> > +
> > +	pinctrl-names = "default", "ac97-running", "ac97-reset", "ac97-warm-reset";
> 
> I'd like to see some documentation of this "default" state - I'd expect
> this corresponds to the bus being idle and waiting for a wakeup from the
> CODEC which is definitely a useful state to have for power optimisation
> so it'd be good to bake it into the bindings.
> 
> Alternatively it could be the bus being totally idle with no possibility
> of wakeup in which case it'd be good to say that too then someone can
> add the waiting for wakeup state later.

The "default" state is actually just the default pin state that is set
before the driver is probed. I will remove it from the example. I didn't
add a low power state although it might be usefull and is defined by the
standard.

> 
> Please also note the new list devicetree@vger.kernel.org.

Yes thanks.

Regards,

Markus



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
