From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm: allow changing the playback/capture rates for
 symmetric links
Date: Thu, 28 Apr 2016 12:10:01 +0100
Message-ID: <20160428111001.GK3217@sirena.org.uk>
References: <1461746959-11443-1-git-send-email-peda@axentia.se>
 <20160427161504.GZ3217@sirena.org.uk>
 <122ca84a-230e-654e-425f-3adb0ca00ec7@axentia.se>
 <20160428103822.GJ3217@sirena.org.uk>
 <s5h8tzyuhad.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ek1zfcGjxpXziO8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h8tzyuhad.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Rosin <peda@axentia.se>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--1ek1zfcGjxpXziO8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 28, 2016 at 01:03:22PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Lots of things just don't work with OSS, we stopped caring about it
> > years ago.  The configuration mechanism just doesn't play nicely with
> > dynamic constraints at all.

> True, but looking at the code there, I wonder how only OSS hits.
> Does ALSA-native API really work as is...?

We've had the code for years without anyone reporting issues so...  the
idiomatic ALSA thing is to set everything in one call which helps a lot.

--1ek1zfcGjxpXziO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIe+IAAoJECTWi3JdVIfQhusH/RVQifdryIbL80+BdwuoFD9P
WEsMl3W7Du0mbKpKBvcU6zVRBhfPBg9N2+Jfp2wOWz8aZIbISetDfg137aDbNc2q
OruVCWjALdZ6XZCmSIDFo4lqURUyNPr/9816eqMxNHD7b/QMtlZQQbb5Y/LKdbKq
bGMZM8JMIDNTDbaQu5Q/pN3i0Kzx73wbkZl6a7CmkpJQ2Suuk2vs9MDmq3pWYvso
P4AtK/3HMlDi++lcBvMBqfplZHjyVBW8hymkNFmiTAsGRUBMNFNohK4EsHhRhU1Q
7Jr8Nim5ydgjQjX6FK/2xAWkRQRUqqua9lsFX4xGnNR7VirTehEUCchoyewGI8k=
=HNK7
-----END PGP SIGNATURE-----

--1ek1zfcGjxpXziO8--
