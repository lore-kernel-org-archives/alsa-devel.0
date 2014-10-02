From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Fix compilation warning for !PM
Date: Thu, 2 Oct 2014 11:53:25 +0100
Message-ID: <20141002105325.GQ4273@sirena.org.uk>
References: <1412234823-31433-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x9l1eQe8PlYqUxyS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412234823-31433-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--x9l1eQe8PlYqUxyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 09:27:03AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The rt286_index_sync() function is only called in the resume path. If PM
> is disabled it becomes unused and shouldn't be built either.

Applied, thanks.

--x9l1eQe8PlYqUxyS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULS6kAAoJECTWi3JdVIfQLiUH/A36WaRUays1fzr42uwaD431
l3tQEVY2WO73YEBmvDFBI7qoHzPSdfa0Hq/hHGp+NIEH/wXFkkwiiXf81Ltuiq1j
6kRjY6K8XabyK8NKax5VVIe5CQLPmPn6tzJ7V1q6OPM+BKPJIl5S3v/YJuDgx1a5
ZvtkTsAD0romg/JtQrugQrNR1FMb92EnXeQqYyf5gNz8G+ZQGWWrSwfSfEvEq5nr
hsJaMtezACdV5z73rZ+U78G2jfJ47J9OIOUbrIc0a5RVyuFmHCdIKRv4KMDOEpWJ
S0sYUBU25iolM9XtTTVWl8tY3oDyGHq5pXivhf5KRHzvw1ajVKsZfnYBHcQdZ1A=
=VLA3
-----END PGP SIGNATURE-----

--x9l1eQe8PlYqUxyS--
