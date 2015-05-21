From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: How to mix multi input ?
Date: Thu, 21 May 2015 12:05:19 +0100
Message-ID: <20150521110519.GX21577@sirena.org.uk>
References: <87pp5v3jz9.wl%kuninori.morimoto.gx@renesas.com>
 <20150520181306.GP21577@sirena.org.uk>
 <87fv6qu6k5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7297342277641547407=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1057F265756
 for <alsa-devel@alsa-project.org>; Thu, 21 May 2015 13:05:25 +0200 (CEST)
In-Reply-To: <87fv6qu6k5.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7297342277641547407==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hy4a9G0dOYssRJVI"
Content-Disposition: inline


--Hy4a9G0dOYssRJVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 12:20:06AM +0000, Kuninori Morimoto wrote:

> > > codec will be started if one of A/B/C are started,
> > > and it will be stopped if all of A/B/C are stopped.

> > If you connect multiple front ends to one back end this should work
> > (with DAPM routes and so on).  If it doesn't work then that's something
> > that should work.

> I considered about DPCM, but *maybe* this is not goot match for us.
> If my understanding is correct, and if I used DPCM for this,
> all of sound A/B/C are start/stop:ed in same time ?

> ex)
> 	start sound =3D> start A/B/C and codec
> 	stop  sound =3D> stop  A/B/C and codec

> I guess it works if it has this connection

> 	data -> [A] -> [B] -> [C] -> codec

> We would like to do is like this
>=20
> 	                +-+
> 	dataA -> [A] -> |M|
> 	dataB -> [B] -> |I| -> codec
> 	dataC -> [C] -> |X|
> 	                +-+

> 	init          =3D> working:
> 	start sound A =3D> working: codec + A
> 	start sound B =3D> working: codec + A/B (mixed)
> 	stop  sound A =3D> working: codec + B
> 	start sound C =3D> working: codec + B/C (mixed)
> 	stop  sound B =3D> working: codec + C
> 	stop  sound C =3D> working:

> I guess current DPCM doesn't support this ?

What you're describing is what I'd expect to happen - I'd say if that's
not working it's a bug and we should fix it.

--Hy4a9G0dOYssRJVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXbvuAAoJECTWi3JdVIfQkv4H/jI7b/2NuTbz8OTsMfcCIp22
BUuDnewtIlukMtDG17cJ74N12H/AOMy2uNr0AQsj0GVAAVRjFm3uwaq3HmHSKXGu
ZsN3rl0mf+HddOtbL8JWxAqENN8ql9AWewNXcXS49LJ/QfxY1w5NqNUlzdwE05LQ
YXb0ye6NtvlIrWc2MQKVK4y8R/kEDVbp3v/THDtTOt+9QWauibGWepawEt9zI4tk
IwlCTZmLRmxcQVa1BS7WK0vzdkDYjeeP791QW5R6SyGv+X+bnOU0MEZ7MTUhnX5w
goVWhSzXdrXjGBx0ShKNsKbNj8m/Dx58uMf1EigUNfsSi2pAErJkpjbkEP6qcSs=
=TQU+
-----END PGP SIGNATURE-----

--Hy4a9G0dOYssRJVI--

--===============7297342277641547407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7297342277641547407==--
