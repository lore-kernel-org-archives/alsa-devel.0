From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date: Thu, 8 Aug 2019 13:44:37 +0100
Message-ID: <20190808124437.GD3795@sirena.co.uk>
References: <20190808123655.31520-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808123655.31520-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan.agner@toradex.com>
List-Id: alsa-devel@alsa-project.org


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 02:36:55PM +0200, Stefan Agner wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
>=20
> Deferred probes shouldn't cause error messages in the boot log. Avoid
> printing with dev_err() in case EPROBE_DEFER is the return value.

No, they absolutely should tell the user why they are deferring so the
user has some information to go on when they're trying to figure out why
their device isn't instantiating.

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MGTQACgkQJNaLcl1U
h9AZOgf/ec4pDTD4WicmfgDb6XwsH4eD1aXoxrGSnAB5x5OCvTtls7jFlVUGSmQx
J9Ymtb5GfHoT9di2uTZimz1Pj8K97ahY3Ov4Tebl6pinVRZh9cH7j0L03gaxRDQP
EEVUkju6pq09n9JR8B2F6iIvoZb6YPRZcuOlZInlbwuW+S1hk25rmGvenhsryxgD
JytTBgBlByqutRVIPLSFI1MDLgyGoF5BtgAqqiCP+wccGpa5vSsfpdOY9lPkA/Dz
1J8RvlsWkcJg4Q/YPBAA96CS5IwlX2Cf2EVOs02vTFIldoZub8j/ZMSfhAJhNph8
pUWXwAmBMFjCoV9IoS4b5XlmBjq1Vw==
=Ire8
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
