From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: kirkwood: simplify clock handling
Date: Tue, 24 Sep 2013 21:24:15 +0200
Message-ID: <20130924192415.GD16106@pengutronix.de>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130924210442.6f617798@armhf>
 <20130924190534.GJ12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C3FE0261ACD
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 21:24:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130924190534.GJ12758@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 24, 2013 at 08:05:34PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 24, 2013 at 09:04:42PM +0200, Jean-Francois Moine wrote:
> > So, the probe code should be:
> > =

> > 	/* check first if an external clock is declared */
> > 	priv->extclk =3D devm_clk_get(&pdev->dev, "extclk");
> > 	if (!IS_ERR(priv->extclk)) {
> > 		... use the external clock ...
> > 	} else {
> > =

> > 		/* get the first clock which must be the dco */
> > 		priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> > 		if (IS_ERR(priv->clk))
> > 			.. error, no clock ..
> > 		.. use the internal dco ...
> > 	}
> =

> Actually no - we need to get and enable the internal clock so that we can
> access the registers - the Dove locks solid if you access the audio block
> registers without its internal clock to the audio block enabled.
So what is the plan here? Apply Russell's patch and then just drop the
devm_clk_put? Do you have a pointer to that patch? Then I'd follow up
with a patch for devm_clk_put.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
