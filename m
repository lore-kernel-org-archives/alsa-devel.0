From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: wm9713: fix regmap free path
Date: Mon, 22 Feb 2016 11:53:51 +0900
Message-ID: <20160222025351.GM18327@sirena.org.uk>
References: <1455997470-12307-1-git-send-email-robert.jarzmik@free.fr>
 <56C98DA3.4000701@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4dlmIwqylWgRDx7z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C98DA3.4000701@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--4dlmIwqylWgRDx7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 21, 2016 at 11:12:51AM +0100, Lars-Peter Clausen wrote:
> On 02/20/2016 08:44 PM, Robert Jarzmik wrote:

> > Fix this by removing the doubled regmap free.

> The correct fix is to use the non devm variant of regmap_init_ac97() in this
> case. Device managed functions should only be used from inside a struct
> device probe function.

Gah, didn't notice that we allocate in the non-default probe function :/
Dropped.

--4dlmIwqylWgRDx7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyng+AAoJECTWi3JdVIfQ4MsH/AtTtAZ54y4G8c8zPORC8567
rIRfz4mYzO/u20UdPM0GTd5bbpFfhKy1Cq9RWygj8c45cJ9EGvzA3/5YqxX0qxq+
GJMD61vrZBVQrKlRYEyEw/mNxTnvCi2Z04MO3C7NdrkHQqOH6KbeVXFobCMTYe9q
S7udqcylh7u+WALXUVJOe/pRSG8fYkENihI/Jw+SeYX9IfMT7iHuXDhMytX3tE69
anMsEuDY/0mjLdVcTbJib7VogAzH2qtITVnGGf+FOoR+F0ax6rqaV7UpO31Ww6Ve
MTYRy5vjjWUY7X/B9U2l2c4brNZaVWctQ5gg2mGDVqoevvQNPxH8wLLlIVwNarU=
=d88V
-----END PGP SIGNATURE-----

--4dlmIwqylWgRDx7z--
