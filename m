From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4 2/3] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Sat, 20 Apr 2019 07:21:22 +0000
Message-ID: <AM0PR04MB6468C972CEBB98BC6E3AD73BE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
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
> On Fri, Apr 19, 2019 at 10:23:53AM +0000, S.j. Wang wrote:
>=20
> > @@ -289,6 +318,12 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pa=
ir
> *pair)
> >               return -EINVAL;
> >       }
> >
> > +     ret =3D fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc)=
;
>=20
> Since the function always return 0, I am thinking of treating this functi=
on as
> a lookup function, and then moving this call right before the register
> settings -- as we have already made sure that both inrate and outrate are
> supported.

Ok.

>=20
> > +     if (ret) {
> > +             pair_err("No supported pre-processing options\n");
> > +             return ret;
> > +     }
>=20
> And probably no longer need this error-out. If there's a new limitation
> related to this function, I believe we can add it to the rate validation
> section as we are doing now -- better to have rate validation code at one
> place.
>=20
Ok.

> > @@ -380,8 +415,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pai=
r
> *pair)
> >       /* Apply configurations for pre- and post-processing */
>=20
> Here:
> -       /* Apply configurations for pre- and post-processing */
> +       /* Select and apply configurations for pre- and post-processing *=
/
> +       fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> >       regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
> >                          ASRCFG_PREMODi_MASK(index) |
> ASRCFG_POSTMODi_MASK(index),
> > -                        ASRCFG_PREMOD(index, process_option[in][out][0=
]) |
> > -                        ASRCFG_POSTMOD(index, process_option[in][out][=
1]));
> > +                        ASRCFG_PREMOD(index, pre_proc) |
> > +                        ASRCFG_POSTMOD(index, post_proc));
