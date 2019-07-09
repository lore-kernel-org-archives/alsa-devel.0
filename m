From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Date: Tue, 9 Jul 2019 03:38:36 +0000
Message-ID: <VE1PR04MB64797B5172DB5EC9EBA8232BE3F10@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> > > > +
> > > > +     /* restore registers by regcache_sync */
> > > > +     fsl_esai_register_restore(esai_priv);
> > > > +
> > > > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > > > +                        ESAI_xCR_xPR_MASK, 0);
> > > > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> > > > +                        ESAI_xCR_xPR_MASK, 0);
> > >
> > > And just for curious, can (or shall) we stuff this personal reset to
> > > the reset() function? I found this one is a part of the reset
> > > routine being mentioned in the RM -- it was done after ESAI reset is
> done via ECR register.
> > >
> >
> > There is a problem to do this, TPR/RPR need to be clear after
> > configure the control register. (TCCR, TCR). So it seems not only one
> > place (reset function) need to be changed.
>=20
> Do you know (or remember) why we suddenly involve this TPR/PRP?
> The driver has no problem so far, even if we don't have them.
>=20
> The "personal reset" sounds like a feature that we would use to reset TX =
or
> RX individually, while this hw_reset() does a full reset for both TX and =
RX.
> So I wonder whether they're necessary.

The hw_reset flow is suggested by design team, so involve TRP/RPP is from
them, I don't know the detail.

Best regards
Wang shengjiu =20
