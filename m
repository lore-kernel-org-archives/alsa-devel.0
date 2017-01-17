From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 07/10] dt-bindings: sound: Add sun8i
 audio documentation
Date: Tue, 17 Jan 2017 17:51:24 +0100
Message-ID: <20170117165124.h5rbx3qhvdzwbqup@lukather>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-8-mylene.josserand@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xbl5lavzcfdzlle"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBFUX7HBQKGQEOQ6C3IY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170117140230.23142-8-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--3xbl5lavzcfdzlle
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 17, 2017 at 03:02:27PM +0100, Myl=C3=A8ne Josserand wrote:
> Add the documentation for dt-binding of the digital audio codec driver
> and the audio card driver for Sun8i SoCs.
>=20
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>

One small comment below,

> ---
>  .../devicetree/bindings/sound/sun8i-codec.txt      | 76 ++++++++++++++++=
++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec.txt b/Do=
cumentation/devicetree/bindings/sound/sun8i-codec.txt
> new file mode 100644
> index 000000000000..ce3c05219e33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
> @@ -0,0 +1,76 @@
> +Allwinner SUN8I audio codec
> +------------------------------------
> +
> +On Sun8i SoCs, and particularly on A33, the audio is separated in

Technically that's not true on all the SoCs of the sun8i family, but
only a few of them (A33 and H3 iirc).

This driver is only made for the A33 at the moment, so you should only
mention it (and you should rename that file as well).

Once done,
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,
Maxime


> +different parts:
> +	  - A DAI driver. It uses the "sun4i-i2s" driver which is
> +	  documented here:
> +	  Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +	  - An analog part of the codec which is handled as PRCM registers.
> +	  See Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
> +	  - An digital part of the codec which is documented in this current
> +	  binding documentation.
> +	  - And finally, an audio card which links all the above components.
> +	  The simple-audio card will be used.
> +	  See Documentation/devicetree/bindings/sound/simple-card.txt
> +
> +This bindings documentation exposes Sun8i codec (digital part).
> +
> +Required properties:
> +- compatible: must be "allwinner,sun8i-a33-codec"
> +- reg: must contain the registers location and length
> +- interrupts: must contain the codec interrupt
> +- clocks: a list of phandle + clock-specifer pairs, one for each entry
> +  in clock-names.
> +- clock-names: should contain followings:
> +   - "bus": the parent APB clock for this controller
> +   - "mod": the parent module clock
> +
> +Example:
> +codec: codec@01c22e00 {
> +	#sound-dai-cells =3D <0>;
> +	compatible =3D "allwinner,sun8i-a33-codec";
> +	reg =3D <0x01c22e00 0x400>;
> +	interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +	clock-names =3D "bus", "mod";
> +	status =3D "disabled";
> +};
> +
> +Here is an example to add a sound card and the codec binding on sun8i So=
Cs that
> +are similar to A33 using simple-card:
> +
> +	sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "Sun8i Audio Card";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,frame-master =3D <&link_codec>;
> +		simple-audio-card,bitclock-master =3D <&link_codec>;
> +		simple-audio-card,mclk-fs =3D <512>;
> +		simple-audio-card,aux-devs =3D <&codec_analog>;
> +		simple-audio-card,routing =3D
> +				"Left DAC", "Digital Left DAC",
> +				"Right DAC", "Digital Right DAC";
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&dai>;
> +		};
> +
> +		link_codec: simple-audio-card,codec {
> +			sound-dai =3D <&codec>;
> +		};
> +
> +	soc@01c00000 {
> +		[...]
> +
> +		codec: codec@01c22e00 {
> +			#sound-dai-cells =3D <0>;
> +			compatible =3D "allwinner,sun8i-a33-codec";
> +			reg =3D <0x01c22e00 0x400>;
> +			interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +			clock-names =3D "bus", "mod";
> +			status =3D "disabled";
> +		};
> +	};
> +
> --=20
> 2.11.0
>=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--3xbl5lavzcfdzlle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfkuLAAoJEBx+YmzsjxAguJcQAJmodPGhZfbeLb4IaSjSMByU
nscg5v6R7XNCebSxhcJcQEquyhKnj0gCIxvwGWwe7ZOXKRjo4R3pbChCdfCZ0reB
y1099d6KjXgz4MG+YZ8k0xFa+tVh5cOnai7SCLe1R7zTFqJ3WvEnS2LbhygN+7vD
Cy52d2dVDYNsFgGeK4OoE0ljV7VjACnYGovzeRf7j32cElXZNhrbXXYjX/qGOheG
WrbRXhDfGOWG4bOxBKctoIj1WWsGE0/NqPObbTKbykWecbl9MX1N1/lQ9nTtgR4j
gcOaAwcG4hU3hTqPJ/bDuLydI/lkvBaXDqPbaqNolAPKx4LIAWqd/za9ahO3R4rA
fLB4XFAWBUnPeA4GrT2laiN/4fpnAfQ8awpyg60eCt3uYCgJsk20MlRAlW1JCR5p
NpBvxy2/3SOlkkWvGDWKzHk3gbYlFHdhuzU3ZAzdj7V4brqlpe5M+4WpME13SHaU
kBAUKwC6Ir7Yo3LI7srvMb9sc96tT6uTunwujzsftxJaNYgHTvWttXqtzEQDfk46
UBgksgJXYl2zNGY2JUg1h6UuEkJjp7ucoyy4sAylxM7IA4hHKsgynYsx1FM45hEI
dBK7d2ylqNmtYCyzSM8flVtS7gyQ3ZCAeU2IcJanpC3A03oM6cHz1CdYGuHqSdtU
iwB9dl75wn/IGTQp8guF
=0eLG
-----END PGP SIGNATURE-----

--3xbl5lavzcfdzlle--
