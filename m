From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Date: Fri, 26 Apr 2019 10:51:15 +0000
Message-ID: <VE1PR04MB64797233B0BFE833550094C3E33E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark

>=20
> On Mon, Apr 22, 2019 at 02:31:55AM +0000, S.j. Wang wrote:
> > Add pm runtime support and move clock handling there.
> > Close the clocks at suspend to reduce the power consumption.
> >
> > fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> > fsl_esai_resume is replaced by pm_runtime_force_resume.
>=20
> This doesn't apply against current code, please check and resend.

Which branch are you using?  I tried for-next and for-linus, both
Are successful applied.

Best regards
Wang shengjiu
