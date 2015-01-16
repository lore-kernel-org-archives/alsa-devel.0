From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: Replace depends on
 REGMAP_I2C with depends on I2C
Date: Fri, 16 Jan 2015 19:06:01 +0000
Message-ID: <20150116190601.GJ3856@sirena.org.uk>
References: <1421435056-29413-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3195412272723203618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E58AE260427
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 20:06:17 +0100 (CET)
In-Reply-To: <1421435056-29413-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3195412272723203618==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline


--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2015 at 08:04:16PM +0100, Lars-Peter Clausen wrote:
> regmap is a library function that gets selected by drivers that need it. No
> driver modules should depend on it, since this can create dependency loops.

Applied, thanks.

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUuWEYAAoJECTWi3JdVIfQyKwH/32YtlnqUyLSvMsn3vhvMLXc
uKouSvSHjBV7y1eUMdIaWjWzRraZHrIWT15/9lOmF+aybptTjlR8xKrKEbNm1o2+
PGhKvVhZ1d8bWuMWoZ3wDeRl0g0HzcwR3K5vTSzD5seyqGvZtL0xoefjsQU6C5pz
K/8hFShYYhBcr5vupnzG8iErP7ats/tKCyxqv7FjZIRM9Y/Y6ZcZkie02o/Q+03E
xZfl3oygUu17QwSn4ZkIk6qqT8OmfgLfxMc+NjU5LCiTa82UFrgWoE6cBCshlbpP
xq99ipcWvxZSfiF8Wk4sTxFIPBMEZC3I0r5V4c1hKNxmGb7Kil24u0uUXgNeSgU=
=sAV9
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--

--===============3195412272723203618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3195412272723203618==--
