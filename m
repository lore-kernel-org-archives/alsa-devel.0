From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 06/14] ASoC: Add sun8i digital audio codec
Date: Thu, 6 Oct 2016 20:23:03 +0200
Message-ID: <20161006182303.sftz3c7hjhv7xell@piout.net>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004161549.GO5228@lukather>
 <901741475770017@web21g.yandex.ru>
Reply-To: alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCKYNX7Y3IMBBCFN3K7QKGQEC7BRKMA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <901741475770017-TgaBlLcPqFtxpj1cXAZ9Bg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "tiwai-IBi9RG/b67k@public.gmane.org" <tiwai-IBi9RG/b67k@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dma
List-Id: alsa-devel@alsa-project.org

On 07/10/2016 at 00:06:57 +0800, Icenowy Zheng wrote :
> 05.10.2016, 00:20, "Maxime Ripard" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> > Hi,
> >
> >> =C2=A0+static const struct of_device_id sun8i_codec_of_match[] =3D {
> >> =C2=A0+ { .compatible =3D "allwinner,sun8i-a33-codec" },
> >> =C2=A0+ { .compatible =3D "allwinner,sun8i-a23-codec" },
> >
> > I thought that the A23 and A33 had different codecs? In that case, it
> > wouldn't be a good assumption to make
>=20
> Yes.
>=20
> >
> >> =C2=A0+ {}
> >> =C2=A0+};
> >> =C2=A0+MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
> >> =C2=A0+
> >> =C2=A0+static struct platform_driver sun8i_codec_driver =3D {
> >> =C2=A0+ .driver =3D {
> >> =C2=A0+ .name =3D "sun8i-codec",
> >> =C2=A0+ .owner =3D THIS_MODULE,
> >> =C2=A0+ .of_match_table =3D sun8i_codec_of_match,
> >> =C2=A0+ },
> >> =C2=A0+ .probe =3D sun8i_codec_probe,
> >> =C2=A0+ .remove =3D sun8i_codec_remove,
> >> =C2=A0+};
> >> =C2=A0+module_platform_driver(sun8i_codec_driver);
> >> =C2=A0+
> >> =C2=A0+MODULE_DESCRIPTION("Allwinner A33 (sun8i) codec driver");
> >> =C2=A0+MODULE_AUTHOR("huanxin<huanxin-jFKXxz0WcGyYHARAtoI1EgC/G2K4zDHf@public.gmane.org>");
> >
> > Those obfuscated email adresses are not really helpful :)
>=20
> This kind of email addresses  are kept in many places in mainline kernel.
>=20
> e.g. drivers/mmc/host/sunxi-mmc.c have 'Aaron Maoye <leafy.myeh@reuuimlla=
tech.com>'
>=20

Well, that is only one place and it is a comment, not in the
MODULE_AUTHOR macro. I would agree that it is not useful to have a stale
email address in MODULE_AUTHOR.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
