From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5100: match wait_for_completion_timeout return
 type
Date: Mon, 9 Mar 2015 18:16:54 +0000
Message-ID: <20150309181654.GR28806@sirena.org.uk>
References: <1425812227-24172-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGmrTRZxVujQoXMz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425812227-24172-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Axel Lin <axel.lin@ingics.com>, abdoulaye berthe <berthe.ab@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--MGmrTRZxVujQoXMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2015 at 06:57:07AM -0400, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. An
> appropriately named unsigned long is added and the assignment fixed up.

Applied, thanks.

--MGmrTRZxVujQoXMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eOVAAoJECTWi3JdVIfQoHgH/2siguLGN9P0KINqN5v4IJgK
wMWe1nYJu+94sb3Mcz9gNj2x3eLWld+ufBx+Hfu6Pj392nnqZt1vwsDX8d+xQGWM
9boChGNMgBYG2k5IUgra1FFtdHHVKSzKwvdngOKjwlAABrvRtwV/R1PQWSExkPyv
gXw65zju0JNwNH23e1XvWfuVdyb2nITrdu9J88fFEDBzcUCZIovMW8YIAGB5RLv+
TmhEtkZC+UfjH3J/EP38A0PgGneURMIs2Iqd1TUAX/8L9YmXnHYPHyaSJ08PAqPs
h34xI1sTyj5F0oGlUUgSUsbM7xYuTjGsS7DuR1IrGLnDbPwRt0qreaBW+K29EIo=
=9oTZ
-----END PGP SIGNATURE-----

--MGmrTRZxVujQoXMz--
