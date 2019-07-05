From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Date: Fri, 5 Jul 2019 07:03:47 +0000
Message-ID: <VE1PR04MB64796C22C2D41B9A45E726BEE3F50@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>=20
> > +
> > +     /* restore registers by regcache_sync */
> > +     fsl_esai_register_restore(esai_priv);
> > +
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > +                        ESAI_xCR_xPR_MASK, 0);
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> > +                        ESAI_xCR_xPR_MASK, 0);
>=20
> And just for curious, can (or shall) we stuff this personal reset to the =
reset()
> function? I found this one is a part of the reset routine being mentioned=
 in
> the RM -- it was done after ESAI reset is done via ECR register.
>=20

There is a problem to do this, TPR/RPR need to be clear after configure the=
 control
register. (TCCR, TCR). So it seems not only one place (reset function) need=
 to be
changed.

Best regards
Wang shengjiu
