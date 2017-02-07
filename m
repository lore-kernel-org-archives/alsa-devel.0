From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v3 04/10] clk: sunxi-ng: add support for
 Allwinner H5 SoC
Date: Tue, 7 Feb 2017 16:56:05 +0100
Message-ID: <20170207155605.f2k44gr56ywehz3t@lukather>
References: <20170207000838.8UJeKISe@smtp2p.mail.yandex.net>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ncoqq3u2mcjsuyi5"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBFW447CAKGQETS7HC5Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170207000838.8UJeKISe-8ttnI0T0xQU0PDqKvflMoHmW9unr2Ajn@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ncoqq3u2mcjsuyi5
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 10:02:04PM +0800, Icenowy Zheng wrote:
> > >=C2=A0 static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] =3D {=20
> > >=C2=A0 [RST_USB_PHY0] =3D=C2=A0 { 0x0cc, BIT(0) },=20
> > >=C2=A0 [RST_USB_PHY1] =3D=C2=A0 { 0x0cc, BIT(1) },=20
> > > @@ -791,6 +910,7 @@ static struct ccu_reset_map sunxi_h3_h5_ccu_reset=
s[] =3D {=20
> > >=C2=A0 [RST_BUS_UART2] =3D=C2=A0 { 0x2d8, BIT(18) },=20
> > >=C2=A0 [RST_BUS_UART3] =3D=C2=A0 { 0x2d8, BIT(19) },=20
> > >=C2=A0 [RST_BUS_SCR0] =3D=C2=A0 { 0x2d8, BIT(20) },=20
> > > + [RST_BUS_SCR1] =3D=C2=A0 { 0x2d8, BIT(21) },=20
> >
> > That reset line is not valid on the H3.=20
>=20
> So I should split a H3 reset array and a H5 one?

Ideally, yes.

> (I modelled after ccu-sun5i.c, which shares one reset array)

They all share the same reset lines.

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

--ncoqq3u2mcjsuyi5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYme4VAAoJEBx+YmzsjxAgMQ0QAJ6jQL66cPjxo42RqrezKJnY
hX5LcNeVppi/6innzyewHL04c+w7w8df5f/yj8s+DPu3EMo4Bl/mgaWaUROENvOV
bINqyZTyUCEzoI5EuIEcBfjeNJMluE/u6k/2pAl5f8EqeywfaJutnrVOxVy2JnfS
rYesN2fk6839XS6alMojcgAaPjV2nqO10e+OhYpaLgRY1bl6D23qpiGO4126aJW+
Q5GtWfPwMUnkNmbGcvNtmm0PwvH4Bo1B/27d372PEI9V2IiRgp3gyT8Nm+UIRPEd
eeevL8MEtWrbhcoKeWwR4T5sf1tgoKMBN0cNjiWwbTgXr71cUNJ9gVzV+tuZHcnn
FSRpTe3B8bxI0M43IBjOzKxri4V9cN/2t1jCu6dMBI6i54q/vrbNLHb1OskgJe6P
A+Lt24psQ7YC66EqgKJzpZx2yVdQ7xDCC6ZGRSNA0XA6WC4jZfYGZvZEF5wMz5HS
XUdspVIeYkSvZetQufG40a1Fvq6AARE8rH8Mvd/LOuwaxz29xfxlFfc+MKSvPkW/
54jIxkSgZGaJbm4NYD2IUfBJAvxiq5UUi2Mq04urMBKmqWdT1XIRgEl4TEWxa4E1
TCcgd+wf8OVAFtnXj5/EyjWUNJslcFnPH+SYWjqkUtzE1DvP6Yikzmzp9IeGTcdR
v6Ik84G2gvLX5P/g5SN3
=usYJ
-----END PGP SIGNATURE-----

--ncoqq3u2mcjsuyi5--
