From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Thu, 18 Apr 2019 02:37:03 +0000
Message-ID: <AM6PR04MB647093DB49BB13E09B0F181DE3260@AM6PR04MB6470.eurprd04.prod.outlook.com>
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
> Hi Shengjiu,
>=20
> This looks better. Just a couple of more small comments inline.
>=20
> On Wed, Apr 17, 2019 at 09:06:18AM +0000, S.j. Wang wrote:
>=20
> > +static int fsl_asrc_sel_proc(int inrate, int outrate, int *pre_proc,
> > +                          int *post_proc)
>=20
> Just a nit: it looks better by grouping them two-two.
>=20
> static int fsl_asrc_sel_proc(int inrate, int outrate,
>                              int *pre_proc, int *post_proc)
>=20
> > +     /* Condition for selection of post-processing */
> > +     post_proc_cond2 =3D (inrate * 15 > outrate * 16 && outrate < 5600=
0) ||
> > +             (inrate > 56000 && outrate < 56000);
>=20
> Could align the indentation:
>         post_proc_cond2 =3D (inrate * 15 > outrate * 16 && outrate < 5600=
0) ||
>                           (inrate > 56000 && outrate < 56000);
>=20
> Here:
> > +     /* Does not support cases: Tsout > 8.125 * Tsin */
> > +     if (inrate * 8 > 65 * outrate)
> > +             return -EINVAL;
> And here:
> > +     ret =3D fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc)=
;
> > +     if (ret) {
> > +             pair_err("No supported pre-processing options\n");
> > +             return ret;
> > +     }
>=20
> Instead of a general message, I was thinking of a more specific one by
> telling users that the ratio between the two rates isn't supported --
> something similar to what I suggested previously:
>=20
>         pair_err("Does not support %d (input) > 8.125 * %d (output)\n",
>                  outrate, inrate);
>=20
In fsl_asrc_sel_proc,  we can't call the pair_err for there is no
struct fsl_asrc_pair *pair in the argument. Do you think we need to
add this argument?

> Thanks
> Nicolin
