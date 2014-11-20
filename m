From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: sigmadsp: Refuse to load firmware files with a
 non-supported version
Date: Thu, 20 Nov 2014 09:56:24 +0000
Message-ID: <20141120095624.GL22111@sirena.org.uk>
References: <1416418148-14803-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tIZwPmdq+hd82jQ"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416418148-14803-1-git-send-email-lars@metafoo.de>
Sender: stable-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--8tIZwPmdq+hd82jQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 06:29:02PM +0100, Lars-Peter Clausen wrote:
> Make sure to check the version field of the firmware header to make sure to
> not accidentally try to parse a firmware file with a different layout.
> Trying to do so can result in loading invalid firmware code to the device.

Applied all, thanks.

--8tIZwPmdq+hd82jQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbbrHAAoJECTWi3JdVIfQNZQH/iv7l0eJJy+9tCh/szo5LfIZ
/4ENPoFJv5HEFnXZIzuQZ0HQf2RC/eUJta7CEjPUAlcbI+7HOMzzaCd6aDfZhD02
hi+AnUYXqWV4jvfYQc1B1MmfWwE64JnPNK2FM3Ake7GD3UjoyVVD/LGqDR3Kmvk1
WomyhYzzKN7/9kdLz5nmJKz9QQ27nY3/P51ZSiW6IsYjakEPeR9mTTtYD7kODml5
cD4pJHFE7VierHYBX6L2D6Z/bmn3pYfCzult5/N59cN3w49sldx1QLhpFSxx1NTh
Sfe4eR8f5gW4BBnyM5c9f6sEhO1y0FMZsV7NuQJeHTvUR/iEx4ECzJsLPNwFJ+8=
=Z2Ri
-----END PGP SIGNATURE-----

--8tIZwPmdq+hd82jQ--
