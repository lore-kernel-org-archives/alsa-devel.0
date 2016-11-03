From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 13/14] ARM: dts: sun6i: hummingbird: Enable internal
 audio codec
Date: Thu, 3 Nov 2016 09:45:43 +0100
Message-ID: <20161103084543.m4zvwhscpaa3y5ay@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-14-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kjyfkte5fkrtyg5s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103075556.29018-14-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: alsa-devel@alsa-project.org


--kjyfkte5fkrtyg5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 03:55:55PM +0800, Chen-Yu Tsai wrote:
> The Hummingbird A31 has headset and line in audio jacks and an onboard
> mic routed to the pins for the SoC's internal codec. The line out pins
> are routed to an onboard speaker amp, whose output is available on a
> pin header.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/=
dts/sun6i-a31-hummingbird.dts
> index 9a74637f677f..48c041b75aab 100644
> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> @@ -69,6 +69,19 @@
>  	};
>  };
> =20
> +&codec {
> +	allwinner,audio-routing =3D
> +		"Headphone", "HP",
> +		"Speaker", "LINEOUT",
> +		"LINEIN", "Line In",
> +		"MIC1", "Mic",
> +		"MIC2", "Headset Mic",
> +		"Mic",	"MBIAS",
> +		"Headset Mic", "HBIAS";
> +	allwinner,pa-gpios =3D <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
> +	status =3D "okay";
> +};
> +
>  &cpu0 {
>  	cpu-supply =3D <&reg_dcdc3>;
>  };
> @@ -152,6 +165,13 @@
>  };
> =20
>  &pio {
> +	codec_pa_pin: codec_pa_pin@0 {
> +		allwinner,pins =3D "PH22";
> +		allwinner,function =3D "gpio_out";
> +		allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +

This pin group isn't used anywhere. Because of the strict thing in
pinctrl, I'd say it's better to not set it, but then, the pin group is
useless.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--kjyfkte5fkrtyg5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYGvkzAAoJEBx+YmzsjxAgp3AP/jkxPwQwxdWRvwes5ych6t2j
IrKwvvLfpCdynZSSzrcCcx3yRM4MHEpLWQ6UD3sdtChCCv3RgDZGluRi56j65Gow
YhMDMAkt9wVwdOe6aCbwpUQbX/CPEph0mrOspvTrV9n4L4ORl+W6GslZJOduLsWR
5j8o21mfgCUmcHsML2FMcoYI8By1FnhmJP24cUc/r2aKK1URbTS6ty9zLKmewfKd
MDWx6g7ddqICs2FjbMQKoFVJOdz+782CUrJVO7HZ4Mez7ZcL6EQsAC1kDwuWS1Mg
8FrDfDgzEy2uiBgkoMHyB2I2z1YMaTmSi5Cb95/1FSHXCuF80WRCkozeM8aWUlAz
Kq3avc9b+YHJlUPLCHMY64ncQS/4osi9WNjyjsWSYedmiAjiP1GwNBxiJk5zgfAI
YjiJSS2tZ3y9TQ45rXh/tg+ITogTLdgc8BY8f4BqEdaOBx955whbr15H/kPAoNZ+
CixyWa8R36+3MYKCsagl2kTtEOlJAZvD7defzUI2DcSxvf1AcLMwo/AUZLkbgRVc
4W3ov/Vu6DcE4esxH/7ffFTKmN3iUM+6hhx45dlx7m0e4G53qgUKy3/pFLr++iDW
2T6kDqf4ghc6hxOF3kF50+UVICnVkny/RJ2uyBjv5cAlrWIqzsp8RYjxvEYj2gFo
1wg0GhZbp6DoQvdFurPu
=nzmc
-----END PGP SIGNATURE-----

--kjyfkte5fkrtyg5s--
