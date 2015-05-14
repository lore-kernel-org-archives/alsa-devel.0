From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs-ac97: make selectable in config
Date: Thu, 14 May 2015 20:43:02 +0100
Message-ID: <20150514194302.GW2761@sirena.org.uk>
References: <554E8634.2010008@maciej.szmigiero.name>
 <20150512175807.GL3066@sirena.org.uk>
 <5553BAB4.3040209@maciej.szmigiero.name>
 <20150514175351.GQ2761@sirena.org.uk>
 <5554ED71.4040608@metafoo.de>
 <20150514191031.GS2761@sirena.org.uk>
 <5554F65F.7090004@metafoo.de>
 <20150514192847.GV2761@sirena.org.uk>
 <5554F9CF.3020601@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+qS3mlFlwl/01Z8q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5554F9CF.3020601@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--+qS3mlFlwl/01Z8q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2015 at 09:38:55PM +0200, Lars-Peter Clausen wrote:

> select forces a symbol on regardless of whether its dependencies are met or
> not. But for any symbol that is on, no matter whether it was manually
> selected or selected by a 'select' from another symbol, any symbols selected
> by that symbol will be turned on. It's been that way as long as I can
> remember.

Ah, good - that's not always been the case (or perhaps not always
reliably been the case which is about the same thing).

--+qS3mlFlwl/01Z8q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVPrFAAoJECTWi3JdVIfQy2AH/3l2Sjy+Sa3fd4px7djlxTmZ
ijRP3X6v0J8QkP7rnSvoBwlRhoxRS2zBPL+tXsnvR2AvJ/5VqVeCm5BHLQixQ5Em
WJRhp5+tHwRry4JquNV6xuhI2pTRS75Rtau5cf7AxxxB3iQBcx7Xg4g8/W4xdiBm
Tz9DuvOu9TBdbUqxx/h+CefHSzfgb9bxcE//u6HtZNIQoY+q1GJ+F4QtX2xaVLg4
SiUI27oGSBWvef2PzUysuSv2aUKTeiUeYb3/cuKf9RDXOnVBQt4WrN8DaF5NmffO
8aQWmvcdHnrn82XTR9ZtviLVFqzAl1I/KoJxYQgH7bPvA5HY3s9aO7K6Z1f1P54=
=zs0Q
-----END PGP SIGNATURE-----

--+qS3mlFlwl/01Z8q--
