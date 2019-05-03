From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/5] ASoC: sun4i-spdif: Add support for
	H6 SoC
Date: Fri, 3 May 2019 16:54:35 +0200
Message-ID: <20190503145435.jziomr3sqxp6jbpd@flea>
References: <20190419191730.9437-1-peron.clem@gmail.com>
 <20190419191730.9437-3-peron.clem@gmail.com>
 <20190502082526.c5zo4uzceqzizbxo@flea>
 <CAJiuCcdFUPBsXfKtDLt-p6Edx-7JrST9d0C=ofCU4CL8ZxwcsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3672828247969754182=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7603DF8075A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 16:54:41 +0200 (CEST)
In-Reply-To: <CAJiuCcdFUPBsXfKtDLt-p6Edx-7JrST9d0C=ofCU4CL8ZxwcsA@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3672828247969754182==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f5z2x6ysmbssgmgl"
Content-Disposition: inline


--f5z2x6ysmbssgmgl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 11:39:24AM +0200, Cl=E9ment P=E9ron wrote:
> > > @@ -169,16 +181,25 @@ struct sun4i_spdif_dev {
> > >       struct snd_soc_dai_driver cpu_dai_drv;
> > >       struct regmap *regmap;
> > >       struct snd_dmaengine_dai_dma_data dma_params_tx;
> > > +     const struct sun4i_spdif_quirks *quirks;
> >
> > I guess this will generate a warning since the structure hasn't been
> > defined yet?
>
> It's a pointer to a structure so no warning from the compiler.

Damn, I was convinced just declaring a pointer to a structure would
result to a gcc warning. Nevermind then.

> > > @@ -405,22 +426,26 @@ static struct snd_soc_dai_driver sun4i_spdif_da=
i =3D {
> > >       .name =3D "spdif",
> > >  };
> > >
> > > -struct sun4i_spdif_quirks {
> > > -     unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA confi=
g */
> > > -     bool has_reset;
> > > -};
> > > -
> > >  static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks =3D {
> > >       .reg_dac_txdata =3D SUN4I_SPDIF_TXFIFO,
> > > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> > >  };
> > >
> > >  static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks =3D {
> > >       .reg_dac_txdata =3D SUN4I_SPDIF_TXFIFO,
> > > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> > >       .has_reset      =3D true,
> > >  };
> > >
> > >  static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks =3D {
> > >       .reg_dac_txdata =3D SUN8I_SPDIF_TXFIFO,
> > > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> > > +     .has_reset      =3D true,
> > > +};
> > >
> > > +static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks =3D {
> > > +     .reg_dac_txdata =3D SUN8I_SPDIF_TXFIFO,
> > > +     .reg_fctl_ftx   =3D SUN50I_H6_SPDIF_FCTL_FTX,
> > >       .has_reset      =3D true,
> >
> > The reg_dac_txdata and reg_fctl_ftx changes here should also be part
> > of a separate patch.
>
> You mean the reg_fctl_ftx quirk and the H6 introduction should be split ?

Yep

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f5z2x6ysmbssgmgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXMxWKwAKCRDj7w1vZxhR
xTheAQD9sE7A0WEHij5Wf1qBjNLpFuz3ZidjjR2KW3BxB9EWSgD/fmxUP0w8djKy
bpfpawxYsCpDiDgb1b2tfBSFbXO87wE=
=ry69
-----END PGP SIGNATURE-----

--f5z2x6ysmbssgmgl--

--===============3672828247969754182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3672828247969754182==--
