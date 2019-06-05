From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Date: Wed, 5 Jun 2019 10:29:37 +0000
Message-ID: <VE1PR04MB6479D7512EDE1217228033CAE3160@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi
> > > > > Sounds like a bug to me...should fix it first by marking the
> > > > > data registers as volatile.
> > > > >
> > > > The ETDR is a writable register, it is not volatile. Even we
> > > > change it to Volatile, I don't think we can't avoid this issue.
> > > > for the regcache_sync Just to write this register, it is correct be=
havior.
> > >
> > > Is that so? Quoting the comments of regcache_sync():
> > > "* regcache_sync - Sync the register cache with the hardware.
> > >  *
> > >  * @map: map to configure.
> > >  *
> > >  * Any registers that should not be synced should be marked as
> > >  * volatile."
> > >
> > > If regcache_sync() does sync volatile registers too as you said, I
> > > don't mind having this FIFO reset WAR for now, though I think this
> > > mismatch between the comments and the actual behavior then should
> get people's attention.
> > >
> > > Thank you
> >
> > ETDR is not volatile,  if we mark it is volatile, is it correct?
>=20
> Well, you have a point -- it might not be ideally true, but it sounds lik=
e a
> correct fix to me according to this comments.
>=20
> We can wait for Mark's comments or just send a patch to the mail list for
> review.
>=20
> Thanks you

I test this patch, we don't need to reset the FIFO, and regcache_sync didn'=
t
Write the ETDR even the EDTR is not volatile.  This fault maybe caused by
Legacy, in the beginning we add this patch in internal branch, there maybe
Something cause this issue, but now can't reproduced.=20

So I will remove the reset of FIFO.

Best regards
Wang Shengjiu =20
