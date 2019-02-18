From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [PATCH V2] ASoC: fsl_esai: fix register setting issue in RIGHT_J
 mode
Date: Mon, 18 Feb 2019 08:21:17 +0000
Message-ID: <VI1PR0402MB3392FCBB2D654C8AF706F3B0E3630@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <2a1997c2cd213ebfde70a2b325644de51e77d159.1550455620.git.shengjiu.wang@nxp.com>
 <20190218080345.GA27289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190218080345.GA27289@kroah.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Thanks, will send the patch again.

Best regards
Wang shengjiu
>=20
> On Mon, Feb 18, 2019 at 02:08:52AM +0000, S.j. Wang wrote:
> > Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> >
> > The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
> > wrong register, correct it.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> > Changes in v2
> > - add Fixes tag and cc stable kernel.
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the stable
> kernel tree.  Please read:
>=20
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fstable-kernel-
> rules.html&amp;data=3D02%7C01%7Cshengjiu.wang%40nxp.com%7C16b1bd8
> d2f1c43b82dd108d695779d87%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C636860738312039576&amp;sdata=3Dl5OkD8ToHrcGa4dbXOuHdFTIF
> pVdN9u5AzCZKj2C5Ew%3D&amp;reserved=3D0
> for how to do this properly.
>=20
> </formletter>
