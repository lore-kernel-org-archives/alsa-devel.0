From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: docs: add clocking examples for DAI formats
Date: Mon, 18 Apr 2016 14:03:13 +0100
Message-ID: <20160418130313.GD3217@sirena.org.uk>
References: <AM4PR02MB12998486C09055D610F9077FBC6B0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lg8eXa+brxrbjAbR"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM4PR02MB12998486C09055D610F9077FBC6B0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peda@lysator.liu.se" <peda@lysator.liu.se>
List-Id: alsa-devel@alsa-project.org


--Lg8eXa+brxrbjAbR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 12:55:23PM +0000, Peter Rosin wrote:
> Mark Brown wrote:

> > There is an actual spec for I2S which is going to be clearer than ASCII
> > art:

> >    https://www.sparkfun.com/datasheets/BreakoutBoards/I2SBUS.pdf

> > is the first hit on google (there's a bunch of electrical stuff in there
> > that gets roundly ignord these days but the clocking stuff is in there).

> Yes, but where are the equivalent docs for the other formats?

There aren't any (beyond the usual references to the Wolfson datasheets
which I'd suggest should be in here) but that doesn't mean we should
ignore this spec when we have it.

> > In general I'd rather have some words rather than just pictures, ASCII
> > art as the only thing is pretty hard to read.

> I'll post a v2 with some words about each format. Or will you reject
> anything with ASCII art?

So long as it's comprehensible.

--Lg8eXa+brxrbjAbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFNsQAAoJECTWi3JdVIfQtMYH/2pAYR1IvTvdX50ewrdf/8rT
ORZoFzCXuwDY++w3xmTvS8ilbWkTbSxI6QuWwqz9kOuL9EW9gdkft0Jp0OTQNATz
3dpjxiS/K8g+0W3DgXBTomI/2hZSc/eoInJvT1SX2cUcYwg5BFPVkU5e7dh98/zv
u1mO0lUIGkmrom9Mu/oNorKC64Kz19Rl3X8tLG1xcdyLlfLAg4j8kwcyjTENdNsm
IMaeob55J/q9MpSF7cXE2RizIHttTz167y8nyPZJxJhYOk/dyfDGVJGWuOS0zjBP
KaP4ro2Sia+abniKuN57L3NOjGKSdkv9sL14KbsLUVNrRzWQkkbgSLlbI7Khps4=
=uCVJ
-----END PGP SIGNATURE-----

--Lg8eXa+brxrbjAbR--
