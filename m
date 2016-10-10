From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 05/12] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
Date: Mon, 10 Oct 2016 12:04:44 +0200
Message-ID: <20161010100444.GD3462@lukather>
References: <20161003110804.28235-1-wens@csie.org>
 <20161003110804.28235-6-wens@csie.org>
 <20161003114709.GC5228@lukather>
 <CAGb2v66b_zG=xK_JVBnwY=SPtvJ+c-fZjuugAHUybzZdkkcScg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66b_zG=xK_JVBnwY=SPtvJ+c-fZjuugAHUybzZdkkcScg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 04, 2016 at 12:26:08PM +0800, Chen-Yu Tsai wrote:
> >> +struct sun4i_codec_regs {
> >> +     u32     adc_fifoc;
> >> +     u32     adc_fifos;
> >> +     u32     adc_rxdata;
> >> +};
> >> +
> >>  struct sun4i_codec {
> >>       struct device   *dev;
> >>       struct regmap   *regmap;
> >>       struct clk      *clk_apb;
> >>       struct clk      *clk_module;
> >>       struct gpio_desc *gpio_pa;
> >> +     const struct sun4i_codec_regs *regs;
> >
> > You're reimplementing reg_field here.
>=20
> Are you suggesting we do reg_fields for each register?
> Or all the bit fields separately. The latter would add
> quite a few pointers.

only the one that change, so judging from your structure, only the ADC
fifo control, status and data registers.
> >> +static const struct of_device_id sun4i_codec_of_match[] =3D {
> >> +     {
> >> +             .compatible =3D "allwinner,sun4i-a10-codec",
> >> +             .data =3D &sun4i_codec_quirks,
> >> +     },
> >> +     {
> >> +             .compatible =3D "allwinner,sun6i-a31-codec",
> >> +             .data =3D &sun6i_a31_codec_quirks,
> >> +     },
> >> +     {
> >> +             .compatible =3D "allwinner,sun7i-a20-codec",
> >> +             .data =3D &sun7i_codec_quirks,
> >> +     },
> >> +     {}
> >> +};
> >> +MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
> >> +
> >
> > I don't really like moving blocks of code over and over again,
> > especially in the middle of an unrelated patch.
>=20
> It's not completely unrelated. I want different create_card
> functions for the different SoCs, and that has to be part of the
> quirks, so the quirks and the of_match list have to be moved
> below them. I suppose I could leave the regmap parts in place,
> but keeping them together is nicer.
>=20
> If I split out the addition of the .create_card field and
> code movement into a separate patch, would that be OK?

Yep, that would work.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX+2e8AAoJEBx+YmzsjxAgrn8P/3ypUQoQjS4iE+2EfH0rSKvv
xtBKK+PifvffmOEqTF7cnAh8usYRXD5wl87hlMdtAhgMRJoxHf1yULU9f7/Ipqac
grfKe5e/MtpYHJ0rKPk7Z/G0+ZhW7eCttjKT37zRriE1GXGIq954piA5eNNsatNB
v8E/xvZvsfanhFyFqBODQSnYzw+ZfOFIk6oKFDPvmZBLypA4C7MVX2Ej9h/fcb3S
iFqG1QzY1QEXpmz/UB32Huqix9mZxBcXbfr4i9H0UX348UjFwyEnlJ214w3/h6us
5K0cq/GMpRmxHnwY+zr7NZBdj/lj5o1MyW4NokMMVV4czfcbeTPy6ngmfQUXkYUA
cWrbdApLwjUDl8UJlpKcfcN/Xa/0oXE/MddTmEE9j69ti16/yQM6WXlT+0ri5tK1
83MSrda1dLY/HDdCYSmWB9Ju7/E0wdybGr0SGPooJeRKpm3FUxy4HaVFVPVjhhsY
Ahws7uQnIbHwKhXGZ5d0J3OuQda/OLjBm5aZtoQmhkSU0MULsrjQz2/ndVStgDbf
i/m6fOv+V0Qx5J2Od3/2yXS5tgGmQI5vjRjN2kbhpSPlDOG90moBCGIJqLeklIyJ
5dUhpGdyyJfR17qKWgeVFRPTxClajP80BCgzQdiNTXELrjmdzGv7Ll4hu0FFIgDl
rqxQbxEj/5NqmYf5NI2F
=iuq3
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
