From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [EXT] Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 2 May 2019 09:13:58 +0000
Message-ID: <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
 <20190502023945.GA19532@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502023945.GA19532@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark

> On Sun, Apr 28, 2019 at 02:24:54AM +0000, S.j. Wang wrote:
> > Add pm runtime support and move clock handling there.
> > Close the clocks at suspend to reduce the power consumption.
> >
> > fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> > fsl_esai_resume is replaced by pm_runtime_force_resume.
>=20
> This doesn't apply against for-5.2 again.  Sorry about this, I think this=
 one is
> due to some messups with my scripts which caused some patches to be
> dropped for a while (and it's likely to be what happened the last time as
> well).  Can you check and resend again please?  Like I say sorry about th=
is, I
> think it's my mistake.

I am checking, but I don't know why this patch failed in your side. I=20
Tried to apply this patch on for-5.1, for 5.2,  for-linus  and for-next, al=
l are
Successful.  The git is git://git.kernel.org/pub/scm/linux/kernel/git/broon=
ie/sound.git.

I can't reproduce your problem. Is there any my operation wrong?

Best regards
Wang shengjiu
