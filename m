From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3 2/2] ASoC: fsl_esai: recover the channel swap after
 xrun
Date: Thu, 11 Jul 2019 06:09:53 +0000
Message-ID: <VE1PR04MB64798D6D1D9AD9EC206EDCE1E3F30@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


>=20
> Hi Shengjiu,
>=20
> Mostly looks good to me, just some small comments.
>=20
> On Mon, Jul 08, 2019 at 02:38:52PM +0800, shengjiu.wang@nxp.com wrote:
>=20
> > +static void fsl_esai_hw_reset(unsigned long arg) {
> > +     struct fsl_esai *esai_priv =3D (struct fsl_esai *)arg;
> > +     u32 saisr, tfcr, rfcr;
> > +     bool tx =3D true, rx =3D false, enabled[2];
>=20
> Could we swap the lines of u32 and bool? It'd look better.
>=20
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > +                        ESAI_xCR_xPR_MASK, ESAI_xCR_xPR);
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> > +                        ESAI_xCR_xPR_MASK, ESAI_xCR_xPR);
>=20
> Let's add a line of comments for these two:
>         /* Enforce ESAI personal resets for both TX and RX */
>=20
> > +     /*
> > +      * Restore registers by regcache_sync, and ignore
> > +      * return value
> > +      */
>=20
> Could fit into single-line?
>=20
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > +                        ESAI_xCR_xPR_MASK, 0);
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR,
> > +                        ESAI_xCR_xPR_MASK, 0);
> > +
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
> > +                        ESAI_PRRC_PDC_MASK, ESAI_PRRC_PDC(ESAI_GPIO));
> > +     regmap_update_bits(esai_priv->regmap, REG_ESAI_PCRC,
> > +                        ESAI_PCRC_PC_MASK, ESAI_PCRC_PC(ESAI_GPIO));
>=20
> Could remove the blank line and add a line of comments:
>         /* Remove ESAI personal resets by configuring PCRC and PRRC also =
*/
>=20
> Btw, I still feel this personal reset can be stuffed into one of the wrap=
per
> functions. But let's keep this simple for now.
>=20
> > +     regmap_read(esai_priv->regmap, REG_ESAI_SAISR, &saisr);
>=20
> Why do we read saisr here? All its bits would get cleared by the hardware
> reset. If it's a must to clear again, we should add a line of comments to
> emphasize it.

This line can be removed.=20

Best regards
Wang Shengjiu
