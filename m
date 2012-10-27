From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: sam9g20_wm8731: convert to device tree support
Date: Sat, 27 Oct 2012 23:12:05 +0100
Message-ID: <20121027221204.GL4564@opensource.wolfsonmicro.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <1350901079-18307-4-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ybNbZnZ8tziJ7D6"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1350901079-18307-4-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org


--4ybNbZnZ8tziJ7D6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 06:17:58PM +0800, Bo Shen wrote:
> Covert sam9g20 wm8731 to device tree support
> And enable it through dts file
>  =20
>   Tested on sam9g20 EK board

This needs to add binding documentation for the board.

> +	dai: dai {
> +		compatible =3D "atmel,atmel-ssc-dai";
> +		atmel,dai-master =3D <&ssc0>;
> +	};

This looks wrong - this is a Linux-specific virtual device sitting on
top of the SSC which is the actual physical device.  The usual patterns
would be something like have the machine driver register the DAI based
on the SSC specified in the bindings (much like how you're handling the
platform already).

--4ybNbZnZ8tziJ7D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjFwpAAoJELSic+t+oim9vRkQAJsIx+TBrM0+Of00c95zpjh/
A5MLpFAKKZTzxJ2CqhGwi6o8rL21GoKPF2kyIivDC9UY6HnDL7ysSP8rytwaxveT
rdqcg+2qr9fOJR+Pm1TiC56DmJdAqxBNe9+1h2wxwEGmBLaT8WCHFERyTTw6PmoS
xX9vLnAZhcY6eTC2FQ1rFW/naR5iQ2QZbYAyir7bvsX4TbJe930eCg2OnVBAj3Ee
aV6oofaIinxFd9wk/FJGRzJkruIU+o4ScQ0aa5/3wkFURhghXBx7Jvy8fp/fH2d9
qkmSykJsY5TjhEB1iQnJtyFC0MX5dSUY8BWj5q4g1atzMFY4KALu3gZtwa+Ag/nO
Y/42WxH78a2MyG2qZ0KcqABdKGovOdb5mY2f1mVQyRwJNjrpxtKbRdPZFyLPlyx2
oZHrC0n9hGhpcc7W9KDeZWKLvUyQaNb6PGxDRA3kxPF9hjE1/3ODu5VePIqbwQec
1vUAjMiycelOi+ngjA5YpGxFe5G3JV/e1h+fUo4o/vy5BvdTNGEebUwGWmqq+pgN
3DZf98GRfMuY1YiMHSO0emCswofI2C9QaiI+vGQyRNEjWHUqHHyz1XeMgvcuM5/z
5mJLq7J8IIc2nK+MhvnGkIx8EpqkqOCg+p0kPtu27TMKmEPJbWZnOfqbJ65XCFHT
b/Go7YimgBHmEoSJKZQ4
=FY/O
-----END PGP SIGNATURE-----

--4ybNbZnZ8tziJ7D6--
