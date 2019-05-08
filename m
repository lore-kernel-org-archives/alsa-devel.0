From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/4] ASoC: hdmi-codec: remove function name debug
 traces
Date: Wed, 8 May 2019 15:50:16 +0900
Message-ID: <20190508065016.GP14916@sirena.org.uk>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
 <20190506095815.24578-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n02m2kg9dRU2PhYI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190506095815.24578-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org


--n02m2kg9dRU2PhYI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 11:58:12AM +0200, Jerome Brunet wrote:
> Remove the debug traces only showing the function name on entry.
> The same can be obtained using ftrace.

This is not a bug fix and so shouldn't be the first patch in the series
in order to avoid dependencies from it on anything later in the series
that is actually a fix.

--n02m2kg9dRU2PhYI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSfCcACgkQJNaLcl1U
h9Bw1gf9EiD4X5wN34SmEnGb2xWc86eupYpTqZNCNgAwqJjCRLZcuhCDZA1TI9PU
xowIZkIHkls3NAK5Dd7B3amCe7gLoi6a+SqDDc6rUOLBh31xb4TOUjV1dWU5XpNZ
h6frDMTNAcFeLzRzGYPQwlJLsEXiyA1AxbkMWaqNcElsgWLyXX/wzLErByMf+YB3
ZtkamXUgEXbl2cg0SkOYY2jDX7n9K/lsyB4Lg+DEPBWg3CaeT3BaKfdZtMU69xwQ
LfYL1et4cDwIS9+HpmFWOo9YffqBkgl7gwUFxZ61pc9ud3Xg4pT9XgkU7gcOMQtL
hiqbJbWz4GYqbHE/kQTxbOGNYG02nQ==
=xAAv
-----END PGP SIGNATURE-----

--n02m2kg9dRU2PhYI--
