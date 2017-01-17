From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 08/10] ARM: dts: sun8i: Add audio codec, dai and card
 for A33
Date: Tue, 17 Jan 2017 17:58:47 +0100
Message-ID: <20170117165847.olotkisojwgtdzrz@lukather>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-9-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hdnkyjgi3kxrstdg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170117140230.23142-9-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--hdnkyjgi3kxrstdg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 17, 2017 at 03:02:28PM +0100, Myl=E8ne Josserand wrote:
> Add the audio codec, dai and a simple card to be able to use the
> audio stream of the builtin codec on sun8i SoC.
>=20
> This commit adds also an audio-routing for the sound card node to link
> the analog DAPM widgets (Right/Left DAC) and the digital one's as they
> are created in different drivers.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-a33.dtsi | 47 ++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a=
33.dtsi
> index 63d5181ffff8..fe8a4f4760d2 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -43,6 +43,7 @@
>   */
> =20
>  #include "sun8i-a23-a33.dtsi"
> +#include <dt-bindings/dma/sun4i-a10.h>
> =20
>  / {
>  	cpus {
> @@ -69,6 +70,27 @@
>  		reg =3D <0x40000000 0x80000000>;
>  	};
> =20
> +	sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "Sun8i Audio Card";

You might have several of them if you're using an internal i2s DAI
with a codec too. What about "a33-codec" or something alike?

> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,frame-master =3D <&link_codec>;
> +		simple-audio-card,bitclock-master =3D <&link_codec>;
> +		simple-audio-card,mclk-fs =3D <512>;
> +		simple-audio-card,aux-devs =3D <&codec_analog>;
> +		simple-audio-card,routing =3D
> +				"Left DAC", "Digital Left DAC",
> +				"Right DAC", "Digital Right DAC";

This will be enabled all the time (even if your DAI and codec are
not), which means that the driver will probe and.. do nothing. You
probably want to disable it here.

> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&dai>;
> +		};
> +
> +		link_codec: simple-audio-card,codec {
> +			sound-dai =3D <&codec>;
> +		};
> +	};
> +
>  	soc@01c00000 {
>  		tcon0: lcd-controller@01c0c000 {
>  			compatible =3D "allwinner,sun8i-a33-tcon";
> @@ -116,6 +138,31 @@
>  			reset-names =3D "ahb";
>  		};
> =20
> +		dai: dai@01c22c00 {
> +			#sound-dai-cells =3D <0>;
> +			compatible =3D "allwinner,sun6i-a31-i2s";
> +			reg =3D <0x01c22c00 0x200>;
> +			interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +			clock-names =3D "apb", "mod";
> +			resets =3D <&ccu RST_BUS_CODEC>;
> +			reset-names =3D "rst";
> +			dmas =3D <&dma 15>, /* AUDIO_CODEC port */
> +				<&dma 15>; /* AUDIO_CODEC port */

There's no need for those comments.

Thanks!
Maxime=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--hdnkyjgi3kxrstdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfk1DAAoJEBx+YmzsjxAg82kP/0EzT6oyELoukKksMxcS9DUF
3vn80J+BDgKjtkfBKqhzt4fRJD4nYu4WEPu3NYtFC+TTFj8U9sv/hVbxXLJhDKb/
2QjSCFszx/Yp7zsQOXXaVW7+p6AN2EjKgR2UgOpOfM8ujJn8WAUEW52qZ1EvWG3w
Ug/NA9LEvyYxcoSrFWEp95OHiZsTzFR4566sivfCf6bJKEfXFdh83kKmDZHvFwIm
9xdlCAkd29zWfDPKQwVTzmr7VXw22RRXO4V2VRepZZJ/O/bO7MemRZlqemB3Qj5G
nCZlyCJXxEVYiPPXQSZOlArp2fb/oMmVE29B+y97vXjqCMkDNisAzi+EzS6D+jCh
fgKKBxdtsx7IVaCc+tHH4a3YxaPDK8BSvRRCyqy7pQRFM+zJkdyeEVyJnlWZqqXq
CUO222n0+Uo+cEP53enblizlvHmOzmgLKfaKhfzodh9eqf4mr8p1FUYSckpyJdnd
rpXXsTVA0xzNpL1np4mttNMx4lezsUSDI0Ih9rThHsrQvzDoIbJaJXia22wPfA8g
ONXvJRvp7+p8pXosqj652qe74jNa+sYMJ0ZsTWWQq643e6beWxi+3yPBA1HgL5lN
mW379oPqI1blJTAjDzeliHzXfJg/BN/xLZ3k/en2UzymnaUVwNTerXMtIHEfm3iw
seUU/L5VQvb/XcnYdoaI
=inQh
-----END PGP SIGNATURE-----

--hdnkyjgi3kxrstdg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
