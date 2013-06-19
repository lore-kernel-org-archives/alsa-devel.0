From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] sound/sgtl5000: fix codec register
 initial values and handling
Date: Wed, 19 Jun 2013 16:26:48 +0100
Message-ID: <20130619152648.GW1403@sirena.org.uk>
References: <51B749F5.3010907@freescale.com>
 <1371647766-4900-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2663053382607385510=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 93AB8261AF4
 for <alsa-devel@alsa-project.org>; Wed, 19 Jun 2013 17:26:56 +0200 (CEST)
In-Reply-To: <1371647766-4900-1-git-send-email-oskar@scara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oskar Schirmer <oskar@scara.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Wolfram Sang <w.sang@pengutronix.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Zeng Zhaoming <zengzm.kernel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--===============2663053382607385510==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8JMtXNYTIIy8Rvxv"
Content-Disposition: inline


--8JMtXNYTIIy8Rvxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2013 at 01:16:06PM +0000, Oskar Schirmer wrote:

This is a set of three unrelated changes, they should be sent as three
separate patches.

> Further, mask computation in declarative part is obviously wrong:
> Fix FRAC DIVISOR to provide an 11 bit mask correctly.

What makes you say that this is obviously wrong?  It's not entirely
clear.

> -#define SGTL5000_PLL_FRAC_DIV_MASK		0x0700
> +#define SGTL5000_PLL_FRAC_DIV_MASK		0x07ff

Based on your changelog I was expecting a mask with only two bits set
here?

--8JMtXNYTIIy8Rvxv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwc21AAoJELSic+t+oim9WvMP/ijace/A0w4dhmAuFiLXvObG
73OtHF13uQG/4jrJTcmYe/3C8MuYcgcSLmHHe91+z05zXbgr7JUP7QEGqccfjwkO
YaMx9RBuh+UsG0gfOnjCcPJ2SO1vf1tk8LrExMfqipwLxF+C0yPEI+2uqlqLRkkG
GQwyY3+YOXFsYYdGTOUwHAvgLzGUEq208Y7Ajlbc6NZdCebIY825Njr0IlAQ6wT3
PkYF2LZNiPPF4uc+UaqH5JCHY69LlXFLlDwPhq9Uqtj3jPYtLyeDYJ6l+eOIHjXR
yk3yQE0lW87AH7Q2T8MF+76Io0X6oQPRVouvDYHtE8znnx1fyK9gl6g6taz4FMF1
DYSGMlNlCIG7NzbYtoarPKyuavaKIKdjtUrqvsA2isvJmAqzbpT/WyE2i2TUPhPi
c1ITtKdGI2qfb3Fuz2CnC/MKhn3YcFRikgN9J0tEjBGFsnhmexbccPYo8AArkqsa
rLHBm4x0oEm1TuIu1gRhQ3mRLGF2XgonV4K7yt0q0OLgi3CDqX9oQh4iUKIuiMXN
KmpPOjY2kyrNsm9fHedMmK9LktUfHvtTbyPzZF/SkMFr06Xlc6XNZgkEwL5oKL0e
HTiaCo/u7fqjBFGchPAZPI6ADSRbKhim3AWkJbbmSErknKu1NccjJ2cy2KEm4AvA
JrVnr4HqBCNAxP8OYEap
=L+gf
-----END PGP SIGNATURE-----

--8JMtXNYTIIy8Rvxv--

--===============2663053382607385510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2663053382607385510==--
