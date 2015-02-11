From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix the incorrect limitation of the bit
 clock rate
Date: Wed, 11 Feb 2015 13:46:16 +0800
Message-ID: <20150211054616.GR2593@finisterre.sirena.org.uk>
References: <1423632703-3683-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tV/+6PImfyFtriLg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423632703-3683-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, scerveau@voxtok.com
List-Id: alsa-devel@alsa-project.org


--tV/+6PImfyFtriLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2015 at 09:31:43PM -0800, Nicolin Chen wrote:
> According to i.MX Reference Manual, the bit-clock frequency generated
> by SSI must be never greater than 1/5 of the peripheral clock frequency.

Applied, thanks.

--tV/+6PImfyFtriLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2uynAAoJECTWi3JdVIfQHZEH/jBxRyu9zzA7Jj8gey9y/UzC
KLbbYSPkBtiuGMR8dy3UtgIRYRTPpYL7JZRllPxhbvVopRm6dly74XpK5yUm5YHn
nQ+gn6y8IKLaIjC1+xu2OghuiFdcgXT4izCXuykMc06IThgg7OApAjFqRY1fOPKg
NPM5s7g+01bhFUI93B6kLXULX6CbSDM9bOjQ8RmaJ9XCPh/WqCTpQ7JmDkxxTu63
zwJrjT6hLhUcvHnvlnxuKyLrBiQzVdFtBY2nP0wpcXiMREydy3tDVhUrgbu42n6k
KM+OzAyYNWRqYEqKTSkQHlQ4n1Fr2e2gNMi56/jUvfVGDjjvMouNI3Pnyrsj7zU=
=rR+k
-----END PGP SIGNATURE-----

--tV/+6PImfyFtriLg--
