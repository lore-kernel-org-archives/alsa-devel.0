From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add ADAU1977 CODEC driver
Date: Wed, 19 Feb 2014 13:37:46 +0900
Message-ID: <20140219043746.GX2669@sirena.org.uk>
References: <1392735455-21287-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5822688481299781336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F9A52610D7
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 08:53:09 +0100 (CET)
In-Reply-To: <1392735455-21287-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5822688481299781336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EEnv9zyGND1dPpWR"
Content-Disposition: inline


--EEnv9zyGND1dPpWR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:57:35PM +0100, Lars-Peter Clausen wrote:
> This patch adds support for the ADAU1977, ADAU1978 and ADAU1979 audio CODEC
> devices. They are a family of 4-channel differential input audio ADC devices.
> They can be connected to either a SPI or I2C bus. The driver is implemented in
> three modules, one main module (adau1977.ko) which implements the device logic
> and one module each for SPI (adau1977-spi.ko) and I2C (adau1977-i2c.ko) bus
> access.

Applied, thanks.

--EEnv9zyGND1dPpWR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBDUXAAoJELSic+t+oim9Y0YP/2bbFOMPTJzJd8MniUZfJrdv
Ke4SQFX6cRmNvF95S3lU7aCDnK2sHGS7BnHwdlctHRJXUjqpDMZplJ//gc27cdva
ArQ9CfFPfiVanAnN6ZplTwlfBf4kdBTvNnhVu96J8GvB0+FYdLAFJg1DOfKjcm1c
W8hFDPh1XdoHxrq5GPuIMemrU6qAWTzoXa9E4xbD39lShmy9HPgM2+OoHs/+D9tm
UnfvofUHvleG39WXzQylrd6z5amQ4N+wR0rctPrys1Y38IMdeIYUuDoi6ND6Sdqt
peXBQCG0O03Wg/nI0CjHPNIIog7qrwnhYfaJfaU8L67AOy2Z1fQvhoUI1af6raSj
fnu3nVX1WQxO4INTmJ0/OfQ2mrPL0kpUTVCWlFu7qr8VQpH7JkjwE60G5xHtQGAy
enD9fdfh+JIvQphDZLIP5IGasjVQmFAZyxh2eTBWLWqzE/jCn5caEfL9RBfqgMsT
njm+Dsjk6UnjfurctAFQ/Epu1QAkxRbsH+vy1Trm/is17mM7HBYTM9OOphrQdwou
isENHAL+DzYOZiT8hoB7HlB4zTRnY0J4dFGJYsKTIwv5uz8j7cF4a9TtQ6AEAkj5
Q5cYKIBlyCVf+631W7Sb2UQX3E2ni3JEZ+f7RAkoOu4DzXBDHcjsuovCPH4DLKiC
Zu2pEaSDa9N6M9LIsJt5
=JF/r
-----END PGP SIGNATURE-----

--EEnv9zyGND1dPpWR--

--===============5822688481299781336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5822688481299781336==--
