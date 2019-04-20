From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Date: Sat, 20 Apr 2019 07:23:59 +0000
Message-ID: <AM0PR04MB646884E539AD85971FD255AEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi.

>=20
> On Fri, Apr 19, 2019 at 10:23:56AM +0000, S.j. Wang wrote:
> > Unify the supported input and output rate, add the 12kHz/24kHz/128kHz
> > to the support list
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_asrc.c | 32 +++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c index
> > 2c4bbc3499db..0d06e738264a 100644
> > --- a/sound/soc/fsl/fsl_asrc.c
> > +++ b/sound/soc/fsl/fsl_asrc.c
> > @@ -27,13 +27,14 @@
> >       dev_dbg(&asrc_priv->pdev->dev, "Pair %c: " fmt, 'A' + index,
> > ##__VA_ARGS__)
> >
> >  /* Corresponding to process_option */ -static int
> > supported_input_rate[] =3D {
> > -     5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 8820=
0,
> > -     96000, 176400, 192000,
> > +static unsigned int supported_asrc_rate[] =3D {
> > +     5512, 8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 4800=
0,
> > +     64000, 88200, 96000, 128000, 176400, 192000,
> >  };
> >
> > -static int supported_asrc_rate[] =3D {
> > -     8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 960=
00,
> 176400, 192000,
> > +static struct snd_pcm_hw_constraint_list fsl_asrc_rate_constraints =3D=
 {
> > +     .count =3D ARRAY_SIZE(supported_asrc_rate),
> > +     .list =3D supported_asrc_rate,
> >  };
> >
> >  /**
> > @@ -293,11 +294,11 @@ static int fsl_asrc_config_pair(struct
> fsl_asrc_pair *pair)
> >       ideal =3D config->inclk =3D=3D INCLK_NONE;
> >
> >       /* Validate input and output sample rates */
> > -     for (in =3D 0; in < ARRAY_SIZE(supported_input_rate); in++)
> > -             if (inrate =3D=3D supported_input_rate[in])
> > +     for (in =3D 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
> > +             if (inrate =3D=3D supported_asrc_rate[in])
> >                       break;
>=20
> Not sure if we still need it upon having hw_constraint. Maybe m2m needs i=
t?
Yes.
Best regards
Wang shengjiu
