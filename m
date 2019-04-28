From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3] ASoC: fsl_esai: Add pm runtime function
Date: Sun, 28 Apr 2019 02:28:00 +0000
Message-ID: <VE1PR04MB647954050987E2A44F459752E3380@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi  Mark

> On Fri, Apr 26, 2019 at 10:51:15AM +0000, S.j. Wang wrote:
> > > On Mon, Apr 22, 2019 at 02:31:55AM +0000, S.j. Wang wrote:
> > > > Add pm runtime support and move clock handling there.
> > > > Close the clocks at suspend to reduce the power consumption.
>=20
> > > > fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> > > > fsl_esai_resume is replaced by pm_runtime_force_resume.
>=20
> > > This doesn't apply against current code, please check and resend.
>=20
> > Which branch are you using?  I tried for-next and for-linus, both Are
> > successful applied.
>=20
> I'm applying against for-5.2, though if it depends on a patch queued for
> 5.1 that's fine, I can just merge that up - please just resend.  I think =
I did try
> merging 5.1 though...

I think may be caused by the patch " ASoC: fsl_esai: Fix missing break
in switch statement", so I resend them both base on for-5.2.

best regards
wang shengjiu
