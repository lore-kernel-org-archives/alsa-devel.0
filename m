From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 05/10] arm: dts: sun8i: split Allwinner
 H3 .dtsi
Date: Mon, 30 Jan 2017 10:09:10 +0100
Message-ID: <20170130090910.cer2nvedq3tjleih@lukather>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
 <20170129023331.62106-6-icenowy@aosc.xyz>
 <2b8672bc-58ae-66a9-46d7-c7f3c5825a9d@arm.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uz4qhpp6t4hzqdua"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBN4FXTCAKGQEGDKQDFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <2b8672bc-58ae-66a9-46d7-c7f3c5825a9d-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--uz4qhpp6t4hzqdua
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 01:42:40AM +0000, Andr=C3=A9 Przywara wrote:
> > +&ccu {
> > +	compatible =3D "allwinner,sun8i-h3-ccu";
> > +};
>=20
> I believe this kind of sharing nodes is a bit frowned upon in connection
> with sharing .dtsi's. If the compatible name differs, I think it
> deserves to be a separate node spelt out in each SoC's .dtsi.
> This also makes the DT more readable, since a reader doesn't have to
> refer to two files to see what's in that node.
>=20
> > =20
> > -		codec_analog: codec-analog@01f015c0 {
> > -			compatible =3D "allwinner,sun8i-h3-codec-analog";
> > -			reg =3D <0x01f015c0 0x4>;
> > -		};
> > +&mmc0 {
> > +	compatible =3D "allwinner,sun7i-a20-mmc";
> > +	clocks =3D <&ccu CLK_BUS_MMC0>,
> > +		 <&ccu CLK_MMC0>,
> > +		 <&ccu CLK_MMC0_OUTPUT>,
> > +		 <&ccu CLK_MMC0_SAMPLE>;
> > +	clock-names =3D "ahb",
> > +		      "mmc",
> > +		      "output",
> > +		      "sample";
>=20
> This applies even more here, since the MMC controllers also have
> different clock requirements.
>=20
> So why can't we just leave the CCU, MMC and possibly the pinctrl nodes
> completely out of the shared h3-h5.dtsi and introduce them from scratch
> in the SoC specific .dtsi?
>=20
> I think we still have enough identical nodes to justify this kind of
> .dtsi sharing.

We did it that way in the past in order to reduce the unneeded
duplication, but I can definitely understand your point. We'll wait
for the DT maintainers answer on this one.

Thanks,
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

--uz4qhpp6t4hzqdua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYjwK2AAoJEBx+YmzsjxAgJtoQAJirwMZxRPmaDWq3PwYeWi9E
nhFRKMhj8jWBpbdAqFdSZuoDnv7VXEixUb8aAsvNWfi461jcDN70FgkXxSBIBOmk
Cy/pyxzs4V42X1JtTXSjIVrgyEOWYPu+38RhytI9hIiptsbvfSO2sQGPRoFGcNlW
PXFL9/sfMRemTK7mRJSQeY/xKbKZ5vJ+j9OmRbTDygas5SDB4MTyYxB3JYeUfoXi
QVjlyUroYR3BO/0nM9GLiOS1x1pevBG58xpgZaP2cOoR1XDXFgIf1RLvicHQxoTj
LLCCfyNT6HzfCivffYKfVnlZ34Oyj1ao1RRzYSd83y9lNSSrC/8rabbxb2bCgUeC
ltnyKg13TxCRt1sWxdF7ZyyIupxevyHqlZzNzWI5SkgCK6ko1xJGVDrgL3bYieot
b9Ll4pZ0h9UiiZh5u9boqa0LnZ2NrhCSDlPuchG/z21VKyrwHzqS+XHEBr1DOfke
x0DcP33237BvrbYDhAtIP7w5Hj7UXLWYVQex3o9fX+jqZn589rr84l7w4YUpuKeb
ToZYw6nDqxQ3gmOTWutFdBBuDxM0qc5M5ZQ9xcF6Q2s4kKV7LRR5gveC+3tM7Toq
Y/JJHNEZUYGi2iZmmSJn+h16SJjupnxUlSP96AmrPSokxzwSE77qvGxmKtnQtkLB
7796/d/1WtuKQdAzPs+W
=n00M
-----END PGP SIGNATURE-----

--uz4qhpp6t4hzqdua--
