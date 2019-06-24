From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt1308: Add RT1308 amplifier
	driver
Date: Mon, 24 Jun 2019 14:27:02 +0100
Message-ID: <20190624132702.GM5316@sirena.org.uk>
References: <1561381680-5250-1-git-send-email-derek.fang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5516767230248695233=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43BF5F8065B
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2019 15:27:14 +0200 (CEST)
In-Reply-To: <1561381680-5250-1-git-send-email-derek.fang@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: derek.fang@realtek.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, bard.liao@intel.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5516767230248695233==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tIeJbwHNpP5qezKJ"
Content-Disposition: inline


--tIeJbwHNpP5qezKJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2019 at 09:08:00PM +0800, derek.fang@realtek.com wrote:

> +static struct i2c_driver rt1308_i2c_driver = {
> +	.driver = {
> +		.name = "rt1308",
> +		.owner = THIS_MODULE,
> +#if defined(CONFIG_OF)
> +		.of_match_table = rt1308_of_match,
> +#endif

As I said last time this should be using of_match_ptr().

--tIeJbwHNpP5qezKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Qz6YACgkQJNaLcl1U
h9BNiwf7Bg7JrAQrr+LiuJIgysAFPBjqs3vwAy/qXb0hUzSyd/rHgdj3FFF/bkU4
odRFoqQXlLjuimvFZ1x5ygsmCVP25ZYRFg2tR3bs9dUuMMR+KzWs0ZoKBekuIJeH
PGfKe9oVxAqk2Mii3vuU/1qz7chaTRjQrEDGgyFbce4POY/wvPBwDPz/r6xqTGi2
mT9zsVIdAJrfDe66QsgIvZOpHxJwCqUZ2DKvbjXmjg6/pCcosJ2UDl7wvm8gklzM
KtpJzLvnXIPTAic4mCHwKZrVj0UILDfQBoCMnWFq5lxC4YckV55DoEr4VC0wWRZO
Pl+dYC5KbNPl/M5B5XePwarjTMr8OQ==
=XXu9
-----END PGP SIGNATURE-----

--tIeJbwHNpP5qezKJ--

--===============5516767230248695233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5516767230248695233==--
