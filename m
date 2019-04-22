From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V5 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Mon, 22 Apr 2019 03:15:34 +0000
Message-ID: <VE1PR04MB6479817B69545A662FFB43B4E3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
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
> On Mon, Apr 22, 2019 at 02:32:35AM +0000, S.j. Wang wrote:
> > When we want to support more sample rate, for example 12kHz/24kHz
> we
> > need update the process_option table, if we want to support more
> > sample rate next time, the table need to be updated again. which is
> > not flexible.
> >
> > We got a function fsl_asrc_sel_proc to replace the table, which can
> > give the pre-processing and post-processing options according to the
> > sample rate.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> A couple of more small comments.
>=20
> And please add this when you resend:
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>=20
> > + * Unsupport cases: Tsout > 8.125 * Tsin, Tsout > 16.125 * Tsin
>=20
> Since we have a ratio validation somewhere else, it's okay to drop this l=
ine -
> - it may confuse people since the function no longer checks these
> unsupported cases.

I add this for may be in the future we forget the limitation. Just for a re=
minder.

Best regards
Wang shengjiu
>=20
> > +static int fsl_asrc_sel_proc(int inrate, int outrate,
>=20
> I think "void" type should be just fine as we made sure there is no
> unsupported cases running in this function.
