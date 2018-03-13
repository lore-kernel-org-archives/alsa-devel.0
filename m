From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 4/6] ASoC: sun4i-i2s: Add multi-lane functionality
Date: Tue, 13 Mar 2018 09:00:26 +0100
Message-ID: <20180313080026.jtag4w46koxzeqe2@flea>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-5-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nh7dgmyajoxjq4ck"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180312155753.9478-5-codekipper@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: codekipper@gmail.com
Cc: wens@csie.org, linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it
List-Id: alsa-devel@alsa-project.org


--nh7dgmyajoxjq4ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 04:57:51PM +0100, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> The i2s block supports multi-lane i2s output however this functionality
> is only possible in earlier SoCs where the pins are exposed and for
> the i2s block used for HDMI audio on the later SoCs.
>=20
> To enable this functionality, an optional property has been added to
> the bindings.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  3 ++
>  sound/soc/sunxi/sun4i-i2s.c                        | 48 ++++++++++++++++=
+-----
>  2 files changed, 41 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Docu=
mentation/devicetree/bindings/sound/sun4i-i2s.txt
> index 48addef65b8f..3f966ac61b9e 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -33,6 +33,9 @@ Optional properties:
>  				configured to extend the slot width to the
>  				value specified. Min 8, Max 32.
> =20
> +- allwinner,playback-channels:  if this property is present then the num=
ber
> +				of available channels is extended and the
> +				outputs enabled.

Isn't it something that is fixed for each generation of SoCs? Can't we
attach it to the compatible?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nh7dgmyajoxjq4ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqnhRkACgkQ0rTAlCFN
r3S+3w//ZH9+Cn0CVP0kX4Z6rnxQ2/llxBEqFjSV31AvMAFKWJoHS6ns0Q1Oxewr
tlFdL2vqxwxfIXghHCo0ODyrAQY6eDP1hM/5YPjVXEHn97OMPWDD2QkTre/cW1TX
ISlPe2O5kp856G/g7NLxCx1mZATHgW/lUTxR7ucuM15iFjnXkq3ERhc5NEWZPBuD
DWIOU7YZXO8nU3fMR96pFgRvLI+m68z1yhG8EIR+TlJ8ThyLuZIev2emBNctECV9
+SugvmLmNf7+awlB3Tou2WIgKQf+xRS/hu8jzycCqtFPYycMz2IcH8duFGVVYIL5
UlfInicoc+RNUHOsVoVQdO34+blDXqRs+r46pn0R81iJ/JJ+9DlO375SSQ5Bs3dY
0jO7nKtgo2Pi7k+wzVaRvyqk2jOvOet0/pm5D82Ntp0/BB+NYxuwxRdaOvgEq1po
m1Iympg2i8R7qpw0aaufreLwbtY9FYRZiXNb6sVTtGq+tRtzMdPx5sKw1nasKUpR
Uyd+9ZajkiBu+d/ZgFUEv7lzISiyP2FJeo9t87Ro7Hx1HbLVmCY8ZVIADd//FENm
KQdLrmMOqu3GEDs6jkMk1MZcQ55HVeuz8RGHc97su7tNbXQsfQZYYGnr9rlLU8Jm
RFVK9jGdcFJK3S8GE1jv9wqcMZJHle52OGBUjP6CXlf5NTlK4Dc=
=un5m
-----END PGP SIGNATURE-----

--nh7dgmyajoxjq4ck--
