From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs35l32: avoid uninitialized variable access
Date: Sat, 5 Mar 2016 14:39:34 +0900
Message-ID: <20160305053934.GI18327@sirena.org.uk>
References: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nmwC0J/XBWGmXIEM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--nmwC0J/XBWGmXIEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 25, 2016 at 06:07:32PM +0100, Arnd Bergmann wrote:

> -		if (i2c_client->dev.of_node) {
> +		if (IS_ENABLED(CONFIG_OF) && i2c_client->dev.of_node) {

This feels it's going to be happening a lot and we should probably have
a dev_has_of_node() helper that does the IS_ENABLED() check.

--nmwC0J/XBWGmXIEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW2nEVAAoJECTWi3JdVIfQz3kH/iY5JOxvcwxxRrBL1Q3/zbLY
O0k8wB4lQflPxptU0FWl1TP1jnDw0fKiU24JHcxiMu8YO+1l8VGPJZe0XDILFO0m
K1I6OivNWEEYEYJeZa2jcFgDFp03XIzonE4y20ITODIWV4XIsC6MglVEN6UsLYv2
dazMqga/vtNr2CmOVKo0Z37m38cmRqrpTqfqtnaZJ/OhDgGfxBIw8pUc399zQnsD
lDgUOg8ogbBJWKclVzhITEwkG5WTVq2K5K6Xzn/ZtJ8Hv2ybjJA0MoldJmgP3O+b
a0PkktfRwfVKYg1YZHVJ8TQdnnG0/3F9SKGMlZETI3BE8UHkFjzCvoXU78xvTgQ=
=OkgC
-----END PGP SIGNATURE-----

--nmwC0J/XBWGmXIEM--
