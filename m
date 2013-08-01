From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add PCM1681 codec driver.
Date: Thu, 1 Aug 2013 10:42:25 +0100
Message-ID: <20130801094225.GJ9858@sirena.org.uk>
References: <1375348498-2941-1-git-send-email-marek.belisko@streamunlimited.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NlM66YnIYV0xathf"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375348498-2941-1-git-send-email-marek.belisko@streamunlimited.com>
Sender: linux-doc-owner@vger.kernel.org
To: Marek Belisko <marek.belisko@gmail.com>
Cc: perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com, lgirdwood@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, zonque@gmail.com, Marek Belisko <marek.belisko@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org


--NlM66YnIYV0xathf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2013 at 11:14:58AM +0200, Marek Belisko wrote:
> PCM1681 can be controlled via I2C, SPI or in bootstrap mode (no control mode). This code add
> support only for I2C mode.

Applied, thanks.  One thing:

> +	if (val != -1) {
> +		regmap_update_bits(priv->regmap, PCM1681_DEEMPH_CONTROL,
> +					PCM1681_DEEMPH_RATE_MASK, val);
> +		enable = 1;
> +	} else
> +		enable = 0;

The style is to have braces on both sides of the else if it's one one.

--NlM66YnIYV0xathf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+i1+AAoJELSic+t+oim9/+kQAIuMRwNqlRDr/MLyfbQVoFUl
Ups4ZAs8mblqDuWYIogYvkQdzWQKQhdoNoi73pXrkcUlcZ4DlJ4LGH+PI2HvH6ZH
5Eia9NBnsxIOv11w6EtcD7P2Ob87AzljcRn0yrnPeLQb4aA8+ic0qkfGRSsob075
+iSYv5ziHLL8jxQ/RTMEF3w6VwaNwpHxxUtgiiBe83jHG+fmL5/BvEN+HSjTMYhn
BU4vIMEQ4UG6LZfe9Sl+MTqvkFoTh6DLjtBZuju2cDkXdmHVjsAQ9hW2+ottAXAk
0kjJP9kXf4ZumNtlKDyvjhd76gzqbnzYLYAZiUkISjNJG7T3KhHddnIn6JgG54yP
oULn1ou/21ogASqhqbqA1X784mK2RTIDnDtPHAwbFp9ixxc62JjYwN1Y6LZU8Wlc
JrOiMOI1LU3G5DrsMGKf/ACNoIp9b04QIl5PA/DMubBU+KG0D+Ao8KVPuWQia0jr
HQRQ6IwTGY9FDwAgGU0cMJPlqjOXsXYTbB0qNC3D+BBgpZIBNpIsixoAzHAkchLR
Rs9bvWpnDcKRpMJnlyVZGGiC6RG92sLzy66QTO4rcC70AsoNClYOwQdZ2R186xY8
Z9Uh6fIg9ChfuKsHKRey8AkAm6qKNfV8wMBD20Xp7LuEX99iZTnnDS2OpNRHLjcs
51yUiZ7JE9LkzFTMNkrw
=yObF
-----END PGP SIGNATURE-----

--NlM66YnIYV0xathf--
