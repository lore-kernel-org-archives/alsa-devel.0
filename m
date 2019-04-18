From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 18 Apr 2019 10:15:24 +0000
Message-ID: <VE1PR04MB6479871F3FC087282D23582DE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

>=20
> On Thu, Apr 18, 2019 at 02:00:12AM -0700, Nicolin Chen wrote:
> > On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:
>=20
> > > In imx8 when systerm enter suspend state, the power of subsystem
> > > will be off, the clock enable state will be lost and register
> > > configuration
>=20
> > Just for curiosity, we had similar situation on imx6sx, so we added
> > suspend/resume with regcache. Why will the clock enable state be lost
> > too? Does CCM on imx8 (might not be called CCM
> > though) have any difference? What about clock rate settings?
>=20
> That sounds like a bug somewhere else - I'd expect that after resume the
> clocking would be restored to the state it was in before suspend.

There is limitation in our internal design. That is in imx8 the power of
subsystem will be disabled at suspend, include the clock state , clock rate=
.=20

I should not add it in comments,  please ignore them, I will change the
description.

This patch is to enable the pm runtime,  so I think it is better to move th=
e
clock operation to pm runtime,  and close the clock at suspend to reduce
the power.

Best regards
Wang shengjiu
