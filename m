From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Date: Mon, 8 Jul 2019 17:58:10 -0700
Message-ID: <20190709005809.GA28003@Asurada-Nvidia.nvidia.com>
References: <VE1PR04MB64796C22C2D41B9A45E726BEE3F50@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64796C22C2D41B9A45E726BEE3F50@VE1PR04MB6479.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 05, 2019 at 07:03:47AM +0000, S.j. Wang wrote:
> > 
> > > +
> > > +     /* restore registers by regcache_sync */
> > > +     fsl_esai_register_restore(esai_priv);
> > > +
> > > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > > +                        ESAI_xCR_xPR_MASK, 0);
> > > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> > > +                        ESAI_xCR_xPR_MASK, 0);
> > 
> > And just for curious, can (or shall) we stuff this personal reset to the reset()
> > function? I found this one is a part of the reset routine being mentioned in
> > the RM -- it was done after ESAI reset is done via ECR register.
> > 
> 
> There is a problem to do this, TPR/RPR need to be clear after configure the control
> register. (TCCR, TCR). So it seems not only one place (reset function) need to be
> changed.

Do you know (or remember) why we suddenly involve this TPR/PRP?
The driver has no problem so far, even if we don't have them.

The "personal reset" sounds like a feature that we would use to
reset TX or RX individually, while this hw_reset() does a full
reset for both TX and RX. So I wonder whether they're necessary.
