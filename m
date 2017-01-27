From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: Re: [PATCH v2 6/9] arm64: dts: allwinner: add
 Allwinner H5 .dtsi
Date: Sat, 28 Jan 2017 00:03:27 +0800
Message-ID: <20170127190350.3aiSkR8d@smtp2m.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBB366VXCAKGQE3GFLTPA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


2017=E5=B9=B41=E6=9C=8827=E6=97=A5 23:58=E4=BA=8E Maxime Ripard <maxime.rip=
ard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jan 26, 2017 at 11:48:56PM +0800, Icenowy Zheng wrote:=20
> > + mmc@01c0f000 {=20
>
> Please use a label based syntax here too.=20
>
> > + compatible =3D "allwinner,sun50i-a64-mmc",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0 "allwinner,sun5i-a13-mmc";=20
>
> The compatibility with the A13 has never been true, and the compatible=20
> should be "allwinner,sun50i-h5-mmc", "allwinner,sun50i-a64-mmc".=20
>
> > + clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;=20
> > + clock-names =3D "ahb", "mmc";=20
> > + };=20
> > +=20
> > + mmc@01c10000 {=20
> > + compatible =3D "allwinner,sun50i-a64-mmc",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0 "allwinner,sun5i-a13-mmc";=20
> > + clocks =3D <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;=20
> > + clock-names =3D "ahb", "mmc";=20
> > + };=20
> > +=20
> > + mmc@01c11000 {=20
> > + compatible =3D "allwinner,sun50i-a64-mmc",=20
>
> And this is very likely to use the emmc compatible.=20
>
> > + =C2=A0=C2=A0=C2=A0=C2=A0 "allwinner,sun5i-a13-mmc";=20
> > + clocks =3D <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;=20
> > + clock-names =3D "ahb", "mmc";=20
> > + };=20
> > +=20
> > + clock@01c20000 {=20
> > + compatible =3D "allwinner,sun50i-h5-ccu",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0 "allwinner,sun8i-h3-ccu";=20
> > + };=20
>
> If it doesn't have the same clocks, it's not compatible with the H3.=20

I'll drop it.

It's from the original patch from Andre.

>
> Maxime=20
>
> --=20
> Maxime Ripard, Free Electrons=20
> Embedded Linux and Kernel engineering=20
> http://free-electrons.com=20
>
> --=20
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.=20
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org=20
> For more options, visit https://groups.google.com/d/optout.=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
