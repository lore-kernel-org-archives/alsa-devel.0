From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Tue, 26 Aug 2014 07:25:58 +0100
Message-ID: <20140826062558.GR17528@sirena.org.uk>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com>
 <874mx7iqgt.wl%kuninori.morimoto.gx@renesas.com>
 <53F9A6EE.5070005@metafoo.de>
 <871ts4nmki.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RdTaDyjgticwLCHG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <871ts4nmki.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--RdTaDyjgticwLCHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2014 at 05:04:20PM -0700, Kuninori Morimoto wrote:

> > That's something we need to fix, but I don't think removing the stream =
names=20
> > is the right way to do this. In a multi CODEC environment you'll quite=
=20
> > likely end up with widgets of the same name. Ideally a route endpoint w=
ould=20
> > be expressed by a tuple of DT node and pin name. But I don't think it i=
s=20
> > possible to mix integer and string elements in a property.

It's not.  Now that we have preprocessor support it's a lot easier to
just use numbers though - the legibility problems from just using raw
numbers in big tables don't apply so much any more.

> Thank you for your advice.
> "DT node and name" seems nice idea, but it works on DT case only ?
> Anyway, I re-consider about this too.
> It can be trial and error...

I think that for hardware which has fairly monolithic audio blocks using
DPCM it might be worth thinking about providing a way for the DT to look
like the DT for a simple I2S DAI with the driver for the IP in the SoC
filling in all the structure needed by DPCM.

--RdTaDyjgticwLCHG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/ChyAAoJELSic+t+oim9EYgP/1FTi/A7BcQ/cPVBwIhrw6+o
mQuET220BPwdztxgxxE62g6tza7knk4brNJrg+K7S4OdjeI6lydFLZuMhg07uqlg
C98UiuO2/Vl11PD4TIu1s4+7bzAElFdveDQgdt+7R7LJjRh+Y3NmgaQRqhzhTPDM
jaG9IwT5n3J2NEA/9wtWZHbmUGtctBeQ5ljnUFFGNg67ZyfO9beC/Mv6KxJCWyKI
5D7A9ylKxhsTLePpVqHV6D1ey6ocNf72PYLHhEwhKVCJu3Hl+skuMgH7NW6eeUyB
6zCfdyU4GR6P21g2ikvtJJMLD3F9BVNIxgerTyhPp55+QTkO9r6suX1QKGSh9X88
8Oavj8yfPiHIEdvl+FfsFwSCRVlQP47xENw0qcVF/NIVxchIWyEhNZPva/V3stUm
KI3NgXN24ITENWKpfU6BQtTXN3bKn/uTbTnuolosJYN+Atmrkh7ZhkP7l4BMZBzI
ZZWUr2c62svCxLFgDFsdZsJmnr3eA23JWCEJhWJdeykGbIaxi1pboqcnKIBZyGSL
LmqJMUb40iZVCT3iaAwy7piimkbWdu4JzA62hHKSIr9fWkrKhsDOTbbTZa2BaqnC
u8nsOFichH2wmsZudpECV0MK3WyO13XMfoOz+sA2h935Cq1HOjrXNyJokcxXa/sU
QDUJDRxGkD8cuLxHlvwu
=OQYc
-----END PGP SIGNATURE-----

--RdTaDyjgticwLCHG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
