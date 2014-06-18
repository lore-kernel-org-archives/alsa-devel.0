From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v11 2/8] ASoC: core: Generic ac97 link reset functions
Date: Wed, 18 Jun 2014 23:19:33 +0200
Message-ID: <20140618211933.GD32450@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
 <20140618184234.GA27312@sfrouter>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140618184234.GA27312@sfrouter>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "S. Fricke" <silvio.fricke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Silvio,

On Wed, Jun 18, 2014 at 08:42:34PM +0200, S. Fricke wrote:
>=20
> Hi Markus,
>=20
> I'm fighting with your ac97 pinctrl configuration per dts.=20
>=20
> > [...]
> > +ssi {
> > +	...
> > +
> > +	pinctrl-names =3D "default", "ac97-running", "ac97-reset", "ac97-warm=
-reset";
> > +	pinctrl-0 =3D <&ac97link_running>;
> > +	pinctrl-1 =3D <&ac97link_running>;
> > +	pinctrl-2 =3D <&ac97link_reset>;
> > +	pinctrl-3 =3D <&ac97link_warm_reset>;
> > +	ac97-gpios =3D <&gpio3 20 0 &gpio3 22 0 &gpio3 28 0>;
>=20
> I see here the gpios for sync, sdata and reset. On my board I have two sd=
ata
> lines (sdata-in and sdata-out) which line should I specify here for this =
setting?

Try to use sdata-out. This is the only data output line. sdata-in is the
input to the SoC so we don't have to use this for an AC97 reset.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTogJlAAoJEEpcgKtcEGQQ5X4P/jqJ87EWIJxGcJQzUq1zUe0Q
NN+4nttrjLst+QfkBGVxEvGBIcJKhNxuSzs19koB9iA9irzcZQpC1iHTXLGOikxx
z3rYmkbBn2WwHnNypt8nHzr4pVikv8n6C+q9y2cXIr1Z4yBmanQ/0+FPe0onc7Mc
ECNmQAogMcbtkPEhFFLOYAwtFbA0haqjcOYbC8J8uFLCTvagcMPO/VZ2sMcERc4B
VZtCDivDEqhTphq8hsFJEw40OG9trwYriNTAkIl6EVdrkyZ2DCeDmhlEQ5vnxU5u
axUWbe5qUWn1XTmEIjRP0GSkbPXJJI3MHTQ+6WbrPkObv6IZWe1KuDnbIQjuMCj1
BNm7Zs0iAmYji+kL6dkvbkgtuH2eC1yL3hxsCj70AZF45zPuRy7qGS8gRFaFEyPt
E3Jd+k6y8DNUhf0ivfp3vY7eibnMUReziPN2rVh5DFrpAlObZPN+CKdNLfmItEc+
y4K88y9T/LTfjvEkPvqlfmUILnpeR2PsAuXsSKjJlQLgKKVvPD00QmE8U132jjir
L+z3U8pzm/OxnzHpT7RiZIrYBJ7hfcWExgPIw62sN10g7I8+oi8CDFX3UfllVtSU
z1N2u2Iaxl+UgylSkdMKuZEI8IMswpArzE8vmthIkvnfm73tThEbMJEXoIJY6a8l
i8dSkVo6cbS6vMaSEghA
=+4wK
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
