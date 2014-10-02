From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tas2552: Fix compilation warning for !PM_RUNTIME
Date: Thu, 2 Oct 2014 11:52:20 +0100
Message-ID: <20141002105220.GP4273@sirena.org.uk>
References: <1412234880-8308-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gbLSGltGDiWAAjZc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412234880-8308-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--gbLSGltGDiWAAjZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 09:28:00AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The tas2552_sw_shutdown() function is only used by runtime suspend
> support, so only build it when necessary.

Applied, thanks.

--gbLSGltGDiWAAjZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULS5kAAoJECTWi3JdVIfQYbMH/jgBHPKRJKTu1OUNrBvXO0Xi
4fXF/Hc1DZhbwjVZkj2N4Umg8JnsUZktGx+2bn94QEGQcYEGgN9VajgDDy51DhV+
sXh+Als3s+EJWVLEg3OXxM2TxD3MfTFWOIBPhv/WTlgnLtD7Fb3rxpZvxGdrzHbV
b4uPBlhy+9wJ/sJUrrkL10lx8ajFTKBnbpQwupZfOTsoedNDxzAhkV9xghf6oKta
W04/v/+8qgMT6gxbwLlJxBqQ/C7JpJHlk2hpWxzvhtwg8g0nupqDcP3k99172Rkq
jlwjA4BpJ7astqNVEE0LdQpOvlchAJa4AuZlZZkYYCf3xOWl92/GZ3UfvxM1KFs=
=5VDg
-----END PGP SIGNATURE-----

--gbLSGltGDiWAAjZc--
