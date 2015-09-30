From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sun4i-codec: Remove redundant SND_PCM_RATE_KNOT
Date: Wed, 30 Sep 2015 19:38:03 +0100
Message-ID: <20150930183803.GW15635@sirena.org.uk>
References: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443555798-16001-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BcZrms9gUsdgyR6a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443555798-16001-2-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Emilio Lopez <emilio@elopez.com.ar>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--BcZrms9gUsdgyR6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 09:43:18PM +0200, Maxime Ripard wrote:
> The SND_PCM_RATE_KNOT covers all the rate settings, even though some that
> we don't support, while we also list all the rate we support. Simply remove
> it.

I'll apply this but ideally you'd be able to use _KNOT plus some
extra constraints registered in startup() for maximum flexability but
realistically people mostly only use the standard rates anyway.

--BcZrms9gUsdgyR6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDCwKAAoJECTWi3JdVIfQWRMH/3QVikqcZAkXaQSl1jjUcnmx
ivI9rphhcA/T5ZaJGFo828/2og5YRBU/2KxF/l2sCxWpDEV5NwIfEtjBEe8ExPNz
i+Xd8cycFoZriWmdCk19H8f3WVZxVYVNB0m1vkjnRDvGmsWmDrDHEEf2LX3B2Elz
AAJR1z3PvJnwH+hfAKK3iOcgvCugJ2XrDyZUEsG9fbl44YFN/QaNfzz4aUHXooM5
7TJIqeQl2SMkVZ/TIlYVl8lYRt4gSuQ8A0q0a4IjMN1v8mifwOZHYuFa2hqWa1sk
xk3B5msXYof/jaHKZ4fiKJyQNU0tBxL2AdHZbTqv/6pfeIRLbEwi10aa8aRveag=
=Ttw+
-----END PGP SIGNATURE-----

--BcZrms9gUsdgyR6a--
