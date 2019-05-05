From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Date: Sun, 5 May 2019 03:28:59 +0000
Message-ID: <VE1PR04MB64794DF2979F3AD350A9EB3DE3370@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

> Hi Mark,
> On Fri, May 03, 2019 at 01:27:31PM +0900, Mark Brown wrote:
> > On Thu, May 02, 2019 at 09:13:58AM +0000, S.j. Wang wrote:
> >
> > > I am checking, but I don't know why this patch failed in your side.
> > > I Tried to apply this patch on for-5.1, for 5.2,  for-linus  and
> > > for-next, all are Successful.  The git is
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.
> >
> > > I can't reproduce your problem. Is there any my operation wrong?
> >
> > The error message I got was:
> >
> > Applying: ASoC: fsl_esai: Add pm runtime function
> > error: patch failed: sound/soc/fsl/fsl_esai.c:9
> > error: sound/soc/fsl/fsl_esai.c: patch does not apply Patch failed at
> > 0001 ASoC: fsl_esai: Add pm runtime function
> >
> > which is the header addition.  I can't spot any obvious issues
> > visually looking at the patch, only thing I can think is some kind of
> > whitespace damage somewhere.
>=20
> I downloaded this v4 from patchwork and resubmitted a v5 for a test.
> Would you please try to apply that one?
>=20
> If my v5 works vs. having merge conflict at v4, maybe something wrong wit=
h
> Git version of Shengjiu's? I compared my v5 and his
> v4 using vimdiff, there is no much difference of whitespace.
>=20
> Thanks
> Nicolin

We find that maybe it is caused by the Transfer-Encoding format.
We sent the patch by the  --transfer-encoding=3D8bit, but in the receiver s=
ide
it shows:

Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: base64

It may be caused by our company's mail server. We are checking...

Best regards
Wang shengjiu
