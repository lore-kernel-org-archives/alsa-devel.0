From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Add snd_soc_of_parse_audio_routing()
Date: Sat, 14 Feb 2015 14:32:12 +0900
Message-ID: <20150214053212.GK9110@finisterre.sirena.org.uk>
References: <1423776602-28585-1-git-send-email-nicoleotsuka@gmail.com>
 <20150214043153.GC9110@finisterre.sirena.org.uk>
 <20150214050245.GA3305@Alpha>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8kI7hWEHMS8Z+7/0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150214050245.GA3305@Alpha>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--8kI7hWEHMS8Z+7/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2015 at 09:02:46PM -0800, Nicolin Chen wrote:
> On Sat, Feb 14, 2015 at 01:31:53PM +0900, Mark Brown wrote:

> > How about having it just record that it should parse the given property
> > when the table in the card is being handleed rather than overwrite that?

> You mean adding another pair of dapm_routes with num_dapm_routes for
> Device Tree or something like that?

That should work, I had been thinking of just recording where to parse
=66rom and deferring the parse entirely.

--8kI7hWEHMS8Z+7/0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3t3TAAoJECTWi3JdVIfQbxAIAIF9a/Dxq/sULB7yful9tsKq
x96qHUmt83AKFmGzUkF+4qJpch9wlgLv8dK20ntFWmOqXqOXDNW7TrW7st2QYr2t
SMEWO2C97tNOyACVG5MZGaKE8tBiCj3cr80POfWZ90uL9ckyINCW5XOQdvW4GkmC
/iV7RpnViuGPBDRmzlHE4sYoxvcxI9cHItDRGMsyeuQTWYfSdNMGcjIvebzUcGQ/
gA5411gLRYDf3X2VorYnwScy7Q3OXolx3DzLS7adYpTKWqoA9SRn4a3Lf5fIFUmN
/QUDOTOkX4ky0xZY8iA62a84STSUwdBlnTDxSyOamIlt91kziOkaYuupmhKxuIc=
=Suph
-----END PGP SIGNATURE-----

--8kI7hWEHMS8Z+7/0--
