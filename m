From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: sound: Add new reset
 compatible for sun4i-i2s
Date: Tue, 17 Jan 2017 17:46:36 +0100
Message-ID: <20170117164636.qhkxvqcs7l732wxk@lukather>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-4-mylene.josserand@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cfzbmitlkifb4uic"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB54U7HBQKGQEMZKTXWI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170117140230.23142-4-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--cfzbmitlkifb4uic
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 03:02:23PM +0100, Myl=C3=A8ne Josserand wrote:
> Add a new compatible for sun4i-i2s driver to handle some
> SoCs that have a reset line that must be asserted/deasserted.
>=20
> This new compatible, "allwinner,sun6i-a31-i2s", requires two
> properties:
> 	- resets: phandle to the reset line
> 	- reset-names: the name of the reset line ("rst").
> Except these differences, the compatible is identical to previous one
> which will not handle a reset line.
>=20
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
>  .../devicetree/bindings/sound/sun4i-i2s.txt        | 23 ++++++++++++++++=
++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Docu=
mentation/devicetree/bindings/sound/sun4i-i2s.txt
> index 7a2c0945fd22..f673206e309b 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -7,6 +7,7 @@ Required properties:
> =20
>  - compatible: should be one of the following:
>     - "allwinner,sun4i-a10-i2s"
> +   - "allwinner,sun6i-a31-i2s" for controller with reset lines

That's not only for controllers with reset lines, but for the
controllers found in the A31 (and later). I'd simply drop the last
part of that line.

>  - reg: physical base address of the controller and length of memory mapp=
ed
>    region.
>  - interrupts: should contain the I2S interrupt.
> @@ -19,7 +20,13 @@ Required properties:
>     - "mod" : module clock for the I2S controller
>  - #sound-dai-cells : Must be equal to 0
> =20
> +Required properties for the following compatibles:
> +		- "allwinner,sun6i-a31-i2s"
> +- resets: phandle to the reset line for this codec
> +- reset-names: Contains the reset signal name "rst"

You don't need reset-names if there's a single reset line.

> +
>  Example:
> +For "allwinner,sun4i-a10-i2s":
> =20
>  i2s0: i2s@01c22400 {
>  	#sound-dai-cells =3D <0>;
> @@ -32,3 +39,19 @@ i2s0: i2s@01c22400 {
>  	       <&dma SUN4I_DMA_NORMAL 3>;
>  	dma-names =3D "rx", "tx";
>  };
> +
> +For "allwinner,sun6i-a31-i2s":
> +
> +dai: dai@01c22c00 {
> +	#sound-dai-cells =3D <0>;
> +	compatible =3D "allwinner,sun6i-a31-i2s";
> +	reg =3D <0x01c22c00 0x200>;
> +	interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +	clock-names =3D "apb", "mod";
> +	resets =3D <&ccu RST_BUS_CODEC>;
> +	reset-names =3D "rst";
> +	dmas =3D <&dma 15>, /* AUDIO_CODEC port */
> +		<&dma 15>; /* AUDIO_CODEC port */
> +	dma-names =3D "rx", "tx";
> +};

And we already have an example, so there's no need to add a new one
either.

Thanks!
Maxime

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

--cfzbmitlkifb4uic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfkpsAAoJEBx+YmzsjxAg3i4QAIeSP1QjdxbRrXzNFADo00Nz
vT1DqDV/M+JelnUIlz4Tbd5iszDnAbn61gp0qoXyq4VsB65dq3O+q+GIfdEd9G9g
mgQd6KgzMYTVxtCEAhrditQEKLiHHirRS+0HHaiMAKODAD6cMNYXQpt3HZf2/95d
0CBt+rgzt1XMfc/QhQpnwmI44LfcTUSQpg0y/Tuz6HcRsYJu94gnVLP2Sbf2y7HH
kgb18/H5tEtlsQZeo7maeEcOTJi5hAIF60uaG/xoTngfdPce2r3mKanuNQU5CQEN
UkWcMx/uQXy/doFAhrzMDCsQIwL+Qo2aC+RUn+HRfEuKSDRv3Pe3jQxnRljlW5HP
xTeeoZv+tIvU15bt310T3ODRQPaOA/2r5+mLEqBoWg+xx5oih+7WHDI4NwHOmDCS
Ix6kMPJHwdzT3FVgpMr9CqklKSh6Yz4QmEmyCeADIGrPnrX2PKCsNL5qQ2207vdc
augKIQvDpJmxFJTHQaPVxm3xQEcGu+DUhqTlQNrpa3iewosc7HeJuKMpqtwVRLmk
WKhEzpMbChKaQrsHyBiu8fDMC88nxbt41OnFtmkrCdd7SuWs1IT6R3m3ioJ7KzMn
6L4oz/xZ2ko4TKlAX+NSs4OgaVdgTYs003oxbAl6PZtsiB6yZ4DBKywnc9GcgYTI
ZNRD7K2x43UlMDkjZ+LR
=lqJ0
-----END PGP SIGNATURE-----

--cfzbmitlkifb4uic--
