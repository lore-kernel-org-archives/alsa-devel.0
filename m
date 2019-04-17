From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Wed, 17 Apr 2019 09:04:01 +0000
Message-ID: <VE1PR04MB6479AF6501388845572EC268E3250@VE1PR04MB6479.eurprd04.prod.outlook.com>
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
> On Thu, Apr 11, 2019 at 09:39:06AM +0000, S.j. Wang wrote:
>=20
> > +/*
> > + * Select the pre-processing and post-processing options
>=20
> By aligning with other function comments:
> /**
>  * Select the pre-processing and post-processing options
>=20
> > + *
> > + * Fsin: input sample rate
> > + * Fsout: output sample rate
>=20
> I would suggest to use inrate and outrate to keep naming consistent.
>=20
> > + * pre_proc: return value for pre-processing option
> > + * post_proc: return value for post-processing option  */ static int
> > +fsl_asrc_sel_proc(int Fsin, int Fsout, int *pre_proc, int *post_proc)
> > +{
> > +     bool det_out_op2_cond;
> > +     bool det_out_op0_cond;
>=20
> By looking at the comments below. Probably better to rename them
>         bool post_proc_cond2, post_proc_cond0;
>=20
> > +     /* Codition for selection of post-processing */
>=20
> "Codition" -> "Conditions"
>=20
> > +     det_out_op2_cond =3D (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)=
) |
> > +                                     ((Fsin > 56000) & (Fsout <
> > + 56000)));
>=20
> Combining Daniel's comments + indentation alignment:
>         det_out_op2_cond =3D (Fsin * 15 > Fsout * 16 && Fsout < 56000) ||
>                            (Fsin > 56000 && Fsout < 56000);
>=20
> > +     det_out_op0_cond =3D (Fsin * 23 < Fsout * 8);
> > +
> > +     /*
> > +      * unsupported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.
>=20
> Funny thing is that there'd be no point in checking the 16.125, if Tsout =
is
> bigger than 8.125 times of Tsin, i.e. only one condition:
>         Tsout > 8.125 * Tsin
>=20
> > +      * Tsout>16.125*Tsin -> Fsin * 8 > 129 * Fsout
> > +      * Tsout>8.125*Tsin  -> Fsin * 8 > 65 * Fsout
> > +      * Tsout>4.125*Tsin  -> Fsin * 8 > 33 * Fsout
> > +      * Tsout>1.875*Tsin  -> Fsin * 8 > 15 * Fsout
>=20
> Took me a while to understand what it is saying....
>=20
> Better to write like this:
>         /* Does not support cases: Tsout > 8.125 * Tsin */
>         if (Fsin * 8 > 65 * Fsout) {
>                 pair_err("Does not support %d > 8.125 * %d\n", Fsout, Fsi=
n);
>                 return -EINVAL;
>         }
>=20
>         /* Otherwise, select pre_proc between [0, 2] */
>         if (Fsin * 8 > 33 * Fsout)
> > +             *pre_proc =3D 2;
> > +     else if (Fsin * 8 > 15 * Fsout) {
> > +             if (Fsin > 152000)
> > +                     *pre_proc =3D 2;
> > +             else
> > +                     *pre_proc =3D 1;
> > +     } else if (Fsin < 76000)
> > +             *pre_proc =3D 0;
> > +     else if (Fsin > 152000)
> > +             *pre_proc =3D 2;
> > +     else
> > +             *pre_proc =3D 1;
>=20
> <=3D=3D Would look better by moving post_cond calculations here.
>=20
> > +     if (det_out_op2_cond)
> > +             *post_proc =3D 2;
> > +     else if (det_out_op0_cond)
> > +             *post_proc =3D 0;
> > +     else
> > +             *post_proc =3D 1;
>=20
> And we could remove this check below:
> > +     /* unsupported options */
> > +     if (*pre_proc =3D=3D 4 || *pre_proc =3D=3D 5)
> > +             return -EINVAL;
>=20
> So basically we are doing:
>         1) Error out unsupported cases
>         2) Select pre_proc
>         3) Calculate conditions for post_proc
>         4) Select post_proc
>=20
> Thanks

Thanks for reviewing, will send v3.
