From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH v2 07/10] dt-bindings: sound: Add sun8i
 audio documentation
Date: Wed, 18 Jan 2017 01:14:30 +0800
Message-ID: <20170117201444.EZDei40D@smtp2h.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBEVC7HBQKGQEMXSAC3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?ISO-8859-1?Q?Myl=E8ne_Josserand?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org


2017=E5=B9=B41=E6=9C=8818=E6=97=A5 00:51=E4=BA=8E Maxime Ripard <maxime.rip=
ard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,=20
>
> On Tue, Jan 17, 2017 at 03:02:27PM +0100, Myl=C3=A8ne Josserand wrote:=20
> > Add the documentation for dt-binding of the digital audio codec driver=
=20
> > and the audio card driver for Sun8i SoCs.=20
> >=20
> > Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@free-electrons.c=
om>=20
>
> One small comment below,=20
>
> > ---=20
> >=C2=A0 .../devicetree/bindings/sound/sun8i-codec.txt=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 76 ++++++++++++++++++++++=20
> >=C2=A0 1 file changed, 76 insertions(+)=20
> >=C2=A0 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-=
codec.txt=20
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec.txt b/=
Documentation/devicetree/bindings/sound/sun8i-codec.txt=20
> > new file mode 100644=20
> > index 000000000000..ce3c05219e33=20
> > --- /dev/null=20
> > +++ b/Documentation/devicetree/bindings/sound/sun8i-codec.txt=20
> > @@ -0,0 +1,76 @@=20
> > +Allwinner SUN8I audio codec=20
> > +------------------------------------=20
> > +=20
> > +On Sun8i SoCs, and particularly on A33, the audio is separated in=20
>
> Technically that's not true on all the SoCs of the sun8i family, but=20
> only a few of them (A33 and H3 iirc).=20

H3 is still the old-style sunxi codec.

I think A64 has the same digital codec part (but A64's analog part is diffe=
rent)

>
> This driver is only made for the A33 at the moment, so you should only=20
> mention it (and you should rename that file as well).=20
>
> Once done,=20
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=20
>
> Thanks,=20
> Maxime=20
>
>
> > +different parts:=20
> > + =C2=A0 - A DAI driver. It uses the "sun4i-i2s" driver which is=20
> > + =C2=A0 documented here:=20
> > + =C2=A0 Documentation/devicetree/bindings/sound/sun4i-i2s.txt=20
> > + =C2=A0 - An analog part of the codec which is handled as PRCM registe=
rs.=20
> > + =C2=A0 See Documentation/devicetree/bindings/sound/sun8i-codec-analog=
.txt=20
> > + =C2=A0 - An digital part of the codec which is documented in this cur=
rent=20
> > + =C2=A0 binding documentation.=20
> > + =C2=A0 - And finally, an audio card which links all the above compone=
nts.=20
> > + =C2=A0 The simple-audio card will be used.=20
> > + =C2=A0 See Documentation/devicetree/bindings/sound/simple-card.txt=20
> > +=20
> > +This bindings documentation exposes Sun8i codec (digital part).=20
> > +=20
> > +Required properties:=20
> > +- compatible: must be "allwinner,sun8i-a33-codec"=20
> > +- reg: must contain the registers location and length=20
> > +- interrupts: must contain the codec interrupt=20
> > +- clocks: a list of phandle + clock-specifer pairs, one for each entry=
=20
> > +=C2=A0 in clock-names.=20
> > +- clock-names: should contain followings:=20
> > +=C2=A0=C2=A0 - "bus": the parent APB clock for this controller=20
> > +=C2=A0=C2=A0 - "mod": the parent module clock=20
> > +=20
> > +Example:=20
> > +codec: codec@01c22e00 {=20
> > + #sound-dai-cells =3D <0>;=20
> > + compatible =3D "allwinner,sun8i-a33-codec";=20
> > + reg =3D <0x01c22e00 0x400>;=20
> > + interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;=20
> > + clock-names =3D "bus", "mod";=20
> > + status =3D "disabled";=20
> > +};=20
> > +=20
> > +Here is an example to add a sound card and the codec binding on sun8i =
SoCs that=20
> > +are similar to A33 using simple-card:=20
> > +=20
> > + sound {=20
> > + compatible =3D "simple-audio-card";=20
> > + simple-audio-card,name =3D "Sun8i Audio Card";=20
> > + simple-audio-card,format =3D "i2s";=20
> > + simple-audio-card,frame-master =3D <&link_codec>;=20
> > + simple-audio-card,bitclock-master =3D <&link_codec>;=20
> > + simple-audio-card,mclk-fs =3D <512>;=20
> > + simple-audio-card,aux-devs =3D <&codec_analog>;=20
> > + simple-audio-card,routing =3D=20
> > + "Left DAC", "Digital Left DAC",=20
> > + "Right DAC", "Digital Right DAC";=20
> > +=20
> > + simple-audio-card,cpu {=20
> > + sound-dai =3D <&dai>;=20
> > + };=20
> > +=20
> > + link_codec: simple-audio-card,codec {=20
> > + sound-dai =3D <&codec>;=20
> > + };=20
> > +=20
> > + soc@01c00000 {=20
> > + [...]=20
> > +=20
> > + codec: codec@01c22e00 {=20
> > + #sound-dai-cells =3D <0>;=20
> > + compatible =3D "allwinner,sun8i-a33-codec";=20
> > + reg =3D <0x01c22e00 0x400>;=20
> > + interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;=20
> > + clock-names =3D "bus", "mod";=20
> > + status =3D "disabled";=20
> > + };=20
> > + };=20
> > +=20
> > --=20
> > 2.11.0=20
> >=20
>
> --=20
> Maxime Ripard, Free Electrons=20
> Embedded Linux and Kernel engineering=20
> http://free-electrons.com
>
> _______________________________________________=20
> linux-arm-kernel mailing list=20
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org=20
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
