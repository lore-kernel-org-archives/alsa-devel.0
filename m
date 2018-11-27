From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
Date: Tue, 27 Nov 2018 11:50:35 +0000
Message-ID: <20181127115035.GB3206@sirena.org.uk>
References: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Grant Grundler <grundler@chromium.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Benson Leung <bleung@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 06:46:05PM +0000, Ryan Lee wrote:
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---

This really needs a changelog to explain what is going on here, and we
need some more documentation in the code.  It is *extremely* unusual to
have to poll for reset like this, and if the failure mode is I/O errors
that's going to be pretty painful.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv9L4oACgkQJNaLcl1U
h9A9dAf/YNgemguFt+88Dci5UTRiy8trzQVPKNreg51M7R/0pOnk/fyAC76I3xUj
F545w42n+Crp2QiRzn8ONI3Vn4ycdTS9LaUI4jNmubYLQ3cYODGHPREvciFEmpqH
cPoCmhPytfuIwf22bUdMgL2BI13WQDSpJJwskYjz66wcu1HRlZyGLUq7Lk2p+nrR
gr1Rq+2yCCZiUzTs5eEvEwNP07ePngofy7gMNVeuSWzdiT9fBRPEio0rs8+VXvwr
rm+btK3IOGcB6Yc/weV1djHZbxDo6fUhiDS90gSb99sE0J+RX/vhXsjHL+LtYxqJ
wWkk7OOlNy9WknhGx6wmXEnhStRK/A==
=5YXq
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
