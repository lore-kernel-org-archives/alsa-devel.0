From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH v2 03/10] dt-bindings: sound: Add new reset
 compatible for sun4i-i2s
Date: Wed, 18 Jan 2017 01:10:00 +0800
Message-ID: <20170117201016.A5fiHT0P@smtp2p.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBBNA7HBQKGQEFBY27TY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?ISO-8859-1?Q?Myl=E8ne_Josserand?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


2017=E5=B9=B41=E6=9C=8817=E6=97=A5 22:02=E4=BA=8E Myl=C3=A8ne Josserand <my=
lene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> Add a new compatible for sun4i-i2s driver to handle some
> SoCs that have a reset line that must be asserted/deasserted.
>
> This new compatible, "allwinner,sun6i-a31-i2s", requires two
> properties:
> - resets: phandle to the reset line
> - reset-names: the name of the reset line ("rst").
> Except these differences, the compatible is identical to previous one
> which will not handle a reset line.

But I think the IP block is identical, right?

Should a new compatible be added only for reset-line?

>
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
> .../devicetree/bindings/sound/sun4i-i2s.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 23 ++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Docu=
mentation/devicetree/bindings/sound/sun4i-i2s.txt
> index 7a2c0945fd22..f673206e309b 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -7,6 +7,7 @@ Required properties:
>
> - compatible: should be one of the following:
> =C2=A0=C2=A0=C2=A0 - "allwinner,sun4i-a10-i2s"
> +=C2=A0=C2=A0 - "allwinner,sun6i-a31-i2s" for controller with reset lines
> - reg: physical base address of the controller and length of memory mappe=
d
> =C2=A0=C2=A0 region.
> - interrupts: should contain the I2S interrupt.
> @@ -19,7 +20,13 @@ Required properties:
> =C2=A0=C2=A0=C2=A0 - "mod" : module clock for the I2S controller
> - #sound-dai-cells : Must be equal to 0
>
> +Required properties for the following compatibles:
> + - "allwinner,sun6i-a31-i2s"
> +- resets: phandle to the reset line for this codec
> +- reset-names: Contains the reset signal name "rst"
> +
> Example:
> +For "allwinner,sun4i-a10-i2s":
>
> i2s0: i2s@01c22400 {
> #sound-dai-cells =3D <0>;
> @@ -32,3 +39,19 @@ i2s0: i2s@01c22400 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <&dma SUN4I_DMA_NORMAL 3>;
> dma-names =3D "rx", "tx";
> };
> +
> +For "allwinner,sun6i-a31-i2s":
> +
> +dai: dai@01c22c00 {
> + #sound-dai-cells =3D <0>;
> + compatible =3D "allwinner,sun6i-a31-i2s";
> + reg =3D <0x01c22c00 0x200>;
> + interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> + clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> + clock-names =3D "apb", "mod";
> + resets =3D <&ccu RST_BUS_CODEC>;
> + reset-names =3D "rst";
> + dmas =3D <&dma 15>, /* AUDIO_CODEC port */
> + <&dma 15>; /* AUDIO_CODEC port */
> + dma-names =3D "rx", "tx";
> +};
> --=20
> 2.11.0
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
