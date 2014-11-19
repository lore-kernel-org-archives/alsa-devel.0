From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: ad1980: Remove ac97_read/ac97_write wrappers
Date: Wed, 19 Nov 2014 10:49:57 +0000
Message-ID: <20141119104956.GC22111@sirena.org.uk>
References: <1416336354-32148-1-git-send-email-lars@metafoo.de>
 <1416336354-32148-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aHyShe78FfJzbeER"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416336354-32148-5-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--aHyShe78FfJzbeER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 18, 2014 at 07:45:54PM +0100, Lars-Peter Clausen wrote:
> Since the regmap conversion ac97_read/ac97_write are just simple wrappers
> around snd_soc_read/snd_soc_write. Use those instead directly and remove the
> wrappers.

Applied, thanks.

--aHyShe78FfJzbeER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbHXUAAoJECTWi3JdVIfQH78H+wW+1N1PLGwgco3ZAv7EWEKO
lAGvY+MJTE0mkHkf8gYCbAuHAgXl+RgUQWOwwh4JCZNLqN8c10DISYZz2la4hnTR
Gavww37mDXFv5wV3rE8xZPyoj7sK+3FKzrFzuwc2QoNBXsqIeWyaP2FqygoLBahH
GpmRQ5/ku+8xgibWpuLECUm5V52iwk32ILVvy+hBQfR8SEXzypQWQAqmkgfgv+Xd
nB8DjGogNEz5RyZR78iYUPFCUPNGDwtzkgZkQvLrXaHbSfCUOumTFgBlyEH8UmWC
Uv95JgRrAkc5v/MAF9/o82xxsjVShTmw6vvyPBPcbHO5Ie+dfwVxAtmBBvzelRg=
=/YfP
-----END PGP SIGNATURE-----

--aHyShe78FfJzbeER--
