From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 2/6] ASoC: samsung: Add Samsung Low Power
 Audio Subsystem driver
Date: Sat, 2 Jul 2016 10:25:48 +0200
Message-ID: <20160702082548.GF6247@sirena.org.uk>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-3-git-send-email-s.nawrocki@samsung.com>
 <20160629215757.GX6247@sirena.org.uk>
 <577553FE.6080803@samsung.com>
 <20160701150709.GT6247@sirena.org.uk>
 <57769AE5.4050407@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BRF4e1IEQp0HoEFj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57769AE5.4050407-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--BRF4e1IEQp0HoEFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 01, 2016 at 06:31:33PM +0200, Sylwester Nawrocki wrote:

> In the SoC there is a dedicated power domain for the whole audio subsyste=
m=20
> and LPASS also contains a VIC itself. We could try to decompose the LPASS=
=20
> top block into various subsystems but I seriously doubt it's a good way
> forward. I think LPASS should rather be some top level SoC platform entit=
y.

So a MFD then?

--BRF4e1IEQp0HoEFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXd3qLAAoJECTWi3JdVIfQfE8H/04hZD+uFb7+sVT2M7aGLflZ
EUQPE1YeFAhn0zmb+kZrj93TfyfWeaXg1Gzwc4qtPuVzOQl711FDe3KA4PwDmHNp
NPT4CI5+ZYOfFoUvKCh36lD1QSqEBzFKJdWP4MKmG+0DOqzDRP1VJq1C+BhiHqp5
2yEc1eT/CFBYZrdWfz4UVtN8jlrcMZ3Oiij100rK6+9WRcrjz/W/gr78GpDGuG1R
tBmjAzlkjnIvzRvexrMxLqjcV3tCkrL6b7wHkJuEr3PFgj/wbTZ0A9FPIqK1FpxE
rLwusgwdvGWrtq9S50CnGJO8OXv9UI+NoSoO5U4KA3TH5cfAXwTzkaT+tkvUv6g=
=trv5
-----END PGP SIGNATURE-----

--BRF4e1IEQp0HoEFj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
