From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm2200: match wait_for_completion_timeout return
 type
Date: Mon, 9 Mar 2015 18:18:49 +0000
Message-ID: <20150309181849.GT28806@sirena.org.uk>
References: <1425812765-24384-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FxsMg9mYBDvYslEH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425812765-24384-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Xiubo Li <Li.Xiubo@freescale.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--FxsMg9mYBDvYslEH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2015 at 07:06:05AM -0400, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. An
> appropriately named unsigned long is added and the assignment fixed up.

applied, thanks.

--FxsMg9mYBDvYslEH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eQIAAoJECTWi3JdVIfQ2uQH/iK4MKbEkOg9Qdx/tb01NfKQ
B6WzIHqRQv5Zc0JE1on9WgTPJPHhZrlpSg0MxzXovIkHXUN0jRkDdFbOSh/qdoKf
bPWzsxkifmLsNASo7BWEGvetZhzV08NzykpH4e0U5hqLDoAPfjXai45teuvZjHdq
axX5Czx5KlA7A0C4SITpHFWSX8zGyDvoLr4yvp235mGhsc2Fhv1BGlHLqXCQ6uD/
nIIZIJvw/jZooNeRJHqyPLSx/DYk/5nXB5FAbohu2lUzADBZOdNhGYBo99cKNZ0O
HbjiECSuK5oxczBrs+2Vm4uNEnJaGK54iDaGkgL0e2PRauFtHfyq99GVXC0gS24=
=aXON
-----END PGP SIGNATURE-----

--FxsMg9mYBDvYslEH--
