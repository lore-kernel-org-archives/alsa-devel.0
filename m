From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 5/7] arm64: dts: allwinner: Add SPDIF node for
 Allwinner H6
Date: Sun, 26 May 2019 20:27:18 +0200
Message-ID: <20190526182718.45cqjx6xsu44ycy6@flea>
References: <20190525162323.20216-1-peron.clem@gmail.com>
 <20190525162323.20216-6-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iksylkttz4pes7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190525162323.20216-6-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jagan Teki <jagan@amarulasolutions.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--iksylkttz4pes7dd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2019 at 06:23:21PM +0200, Cl=E9ment P=E9ron wrote:
> The Allwinner H6 has a SPDIF controller called OWA (One Wire Audio).
>
> Only one pinmuxing is available so set it as default.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index f4ea596c82ce..307d3c896ff2 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -83,6 +83,24 @@
>  		method =3D "smc";
>  	};
>
> +	sound_spdif {

This generates a warning in DTC, underscores are not valid characters
for a node name.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iksylkttz4pes7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOrahgAKCRDj7w1vZxhR
xdKwAPsHomOKKXkOdAwjQzfEiGjCGMKndgCW4QIPcHfoGF2i9wEA/n2QpcwvKM+h
v3+J2k21QAGTy70Kmd28V/tnaZEJewM=
=YZ2A
-----END PGP SIGNATURE-----

--iksylkttz4pes7dd--
