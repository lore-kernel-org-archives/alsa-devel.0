From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-codec: Rework and fix headphone routing
Date: Mon, 5 Oct 2015 10:44:35 +0100
Message-ID: <20151005094435.GI12635@sirena.org.uk>
References: <1443965896-6205-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xp2nimoPFnvF0aLh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443965896-6205-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Emilio Lopez <emilio@elopez.com.ar>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Xp2nimoPFnvF0aLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 04, 2015 at 03:38:16PM +0200, Maxime Ripard wrote:

> Most of the boards have their headphone jack directly connected to the
> matching pins of the SoCs. Since most of the time we will have the same
> routing path, it makes sense to put that in the driver, and only have a
> property describing whether that route is enabled or not.

What is the value in having just a dumb jack with no detection
configured?  It doesn't actually do anything...

> It also fixes the following warning messages that were seen so far:
> sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> Headphone Jack

Why are these routes being added separately to adding the jack?  Just
remove the broken routes.

--Xp2nimoPFnvF0aLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEkZ/AAoJECTWi3JdVIfQGfgH/jbWRw+JKvG4NOnm5JJd61L7
v0nppgtFI7P0148MjU2m/+0JDeYGhz6NiKo9pRD5aj6bs0F/Am+/5n5D/75a+yZk
AoStdRjFeD8Tei+QhDSNjhL5gwkUSWJrn0RL53sHal3a5tt8RtVjCHX748j9/0rP
rg7CZjrASlg5YMzVKMwSJ4L7Up/8hRKoIYoJhj4cAAQQitCQ5ch4XbGy4pzzWEqm
CToXpBgTgF/WZf6midNXpJXuDUHKZsjcjxOyDMLp1+d0SyFieo10FQTqeVqe4AIm
uuDn0N6YfG1RSS/hNUtW+WnewdJoYdYedanFI7HGaT5yfB8guqyMJU1zMt+7JWM=
=8bJT
-----END PGP SIGNATURE-----

--Xp2nimoPFnvF0aLh--
