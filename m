From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 18 Apr 2019 10:21:11 +0000
Message-ID: <VE1PR04MB64798FB86DFEBD85E1784DF2E3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi
>=20
>=20
> On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:
> > In imx8 when systerm enter suspend state, the power of subsystem will
> > be off, the clock enable state will be lost and register configuration
>=20
> Just for curiosity, we had similar situation on imx6sx, so we added
> suspend/resume with regcache. Why will the clock enable state be lost too=
?
> Does CCM on imx8 (might not be called CCM
> though) have any difference? What about clock rate settings?
>=20
> > will be lost. So the driver need to enter runtime suspend state in
> > suspend.
>=20
> > With this implementation the suspend function almost same as runtime
> > suspend function, so remove the suspend function, just use
> > pm_runtime_force_suspend instead, and same for the resume function.
> >
> > And also need to move clock enablement to runtime resume and clock
> > disablement to runtime suspend.
>=20
>=20
> > -static int fsl_esai_suspend(struct device *dev)
> > -     regcache_cache_only(esai->regmap, true);
> > -     regcache_mark_dirty(esai->regmap);
>=20
> > +static int fsl_esai_runtime_resume(struct device *dev)
> >       regcache_cache_only(esai->regmap, false);
> > +     regcache_mark_dirty(esai->regmap);
>=20
> Why move the regcache_mark_dirty from suspend to resume?
> (I am not saying it's wrong but wondering if this is the  preferable way.=
)

Seems I should not do this change.
I will remain regcache_mark_dirty(esai->regmap); at its old place.

Best regards
Wang shengjiu=20
