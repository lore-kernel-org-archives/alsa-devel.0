From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4271: claim reset GPIO in bus
	probe function
Date: Thu, 20 Feb 2014 01:36:48 +0900
Message-ID: <20140219163648.GV2669@sirena.org.uk>
References: <1392815154-24728-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7483649282430182650=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5370C265A8D
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:37:11 +0100 (CET)
In-Reply-To: <1392815154-24728-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: brian.austin@cirrus.com, subaparts@yandex.ru, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============7483649282430182650==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GBbZKOOHjRR5T/3z"
Content-Disposition: inline


--GBbZKOOHjRR5T/3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 02:05:54PM +0100, Daniel Mack wrote:
> Move the GPIO acquisition from the codec to the bus probe functions.

Applied, thanks.

--GBbZKOOHjRR5T/3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBN2cAAoJELSic+t+oim9jxkQAJYKgeCcJ3qM1AhhIAESvDWi
2UFgucc0wOIW+mt9sQBrpmCZOQwZPx7X5DejbaEqZ1u4i6HfA/xRkcgF6OUL5MkB
EccLSQcOaRxFvUagf3FQMO2hMN9iyWV7uKzAAyJ7LHNOhS7qPBfeUhMKFSbUeRWY
VjZwAr+yS5YbKEXJkT4YReD0RY9veult82DYodBM3KpG5S+LntZDWDeKeZtsm0nP
b10VMl+Q+1uhVBotpPc8ESelPLCOSgx2ZEGbLK6CwjUWGWnnTPJv5lvvsKuy3946
QiQoSgHtsYwIHRm2WK0VOoG6ABGvoLiso0Aywx59b11y3vWHiesf7xYPfqvl2HIe
pGgvg5Voey8IpUvHy+GRFDHdP/0y2dDXQfgGZBuUbCEAy8+StL0A7yhJ1mBaFk7M
ZG8B4ICokMKP6nCtYaTthQlE2pGZQ2plEJZ/EferCCPiHC+t8Tf0dSF03Kc4S2x0
PlGLIjRNP1Q1Z2G65n/wddT6eV7vYQ8hCXGTc0aJMq6jDn8kmOHUTIJTOBBLRg63
E+jXd6sdaelzoBLrL0HxjVqimHObKnruxYoV+tgZOmHUFxpwe6Dipfg1h+K3ix3n
tbjGWKwoE9Gf4xTzOVRXdeF0VCuBZ2PsaaP6Z85YuVeYU6Xz81sZJb76crdRscvs
s4Ij9QQGOpB9dCCrfKZ0
=yord
-----END PGP SIGNATURE-----

--GBbZKOOHjRR5T/3z--

--===============7483649282430182650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7483649282430182650==--
