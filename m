From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: kirkwood: simplify clock handling
Date: Tue, 24 Sep 2013 20:05:34 +0100
Message-ID: <20130924190534.GJ12758@n2100.arm.linux.org.uk>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130924210442.6f617798@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id EBD93261A2C
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 21:05:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130924210442.6f617798@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 24, 2013 at 09:04:42PM +0200, Jean-Francois Moine wrote:
> So, the probe code should be:
> 
> 	/* check first if an external clock is declared */
> 	priv->extclk = devm_clk_get(&pdev->dev, "extclk");
> 	if (!IS_ERR(priv->extclk)) {
> 		... use the external clock ...
> 	} else {
> 
> 		/* get the first clock which must be the dco */
> 		priv->clk = devm_clk_get(&pdev->dev, NULL);
> 		if (IS_ERR(priv->clk))
> 			.. error, no clock ..
> 		.. use the internal dco ...
> 	}

Actually no - we need to get and enable the internal clock so that we can
access the registers - the Dove locks solid if you access the audio block
registers without its internal clock to the audio block enabled.
