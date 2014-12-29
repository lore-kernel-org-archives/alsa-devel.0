From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V3 02/10] ASoC: qcom: Document MAX98357A bindings
Date: Mon, 29 Dec 2014 16:07:47 +0000
Message-ID: <20141229160747.GS17800@sirena.org.uk>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
 <1419439330-2303-3-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gkgJxwboLHM70d2C"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419439330-2303-3-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--gkgJxwboLHM70d2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2014 at 08:42:02AM -0800, Kenneth Westfield wrote:
> From: Kenneth Westfield <kwestfie@codeaurora.org>
>=20
> Add documentation to the sound directory of the
> device-tree bindings for the Maxim MAX98357A audio
> codec driver.

Your subject line says "qcom" but this isn't a Qualcomm thing...

> +Required properties:
> +- compatible  : "maxim,max98357a"
> +- sdmode-gpios: Phandle to the GPIO specifier for the GPIO -> DAC SDMODE=
 pin

> +max98357a {
> +	compatible =3D "maxim,max98357a";
> +	sdmode-gpios =3D <&qcom_pinmux 25 0>;

A GPIO specifier is not a phandle (as your example shows).  Just say
it's a GPIO specifier.

--gkgJxwboLHM70d2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoXxSAAoJECTWi3JdVIfQxLkH/iwTP9U3hQUJH34aOYKe8aOV
AdzM3w9X5V9JNJQxPNZIkkN1wK1a4w6I6z+7vDF6716i8ZnkdAHvjf/iGI/okVz6
j75vHg0AZZWTv/U8KGkEnoJj14mqH7CZe3SPdFXGjHMKwpB3ZDF9F58rFjtjJks0
//oMA7tzYVfdoEtBz9hZ7e4WCFYfMe77O7wlNgY2dwwA7TNr338VSAQIa2yaKVcV
kM1e4e3nORiZgI8vcRVj16/y4P2QjoIMKYloQuvPSRXs4TUBA1T8rfvyl37NoJnt
FHCBvjUhneFRHRcaAUYmHO/Bsf/cIX0j/EzMWA4iOINKmP5+X3nA3cbjlVC8kj4=
=y4ng
-----END PGP SIGNATURE-----

--gkgJxwboLHM70d2C--
