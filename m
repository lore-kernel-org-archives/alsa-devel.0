From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Use specific r/w function
	for DSP mode
Date: Tue, 28 Oct 2014 22:29:15 +0000
Message-ID: <20141028222915.GG18557@sirena.org.uk>
References: <1414378351-2329-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1076031748494035213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7265260443
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 23:29:45 +0100 (CET)
In-Reply-To: <1414378351-2329-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1076031748494035213==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Bd5h60K8hFlO6A9"
Content-Disposition: inline


--/Bd5h60K8hFlO6A9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 27, 2014 at 10:52:31AM +0800, Oder Chiou wrote:

> +	/* Write register */
> +	r[0] = reg & 0xff;
> +	xfer[0].addr = client->addr;
> +	xfer[0].flags = 0;
> +	xfer[0].len = 1;
> +	xfer[0].buf = &r[0];
> +
> +	/* Read data */
> +	xfer[1].addr = client->addr;
> +	xfer[1].flags = I2C_M_RD;
> +	xfer[1].len = 2;
> +	xfer[1].buf = data;
> +
> +	ret = i2c_transfer(client->adapter, xfer, 2);
> +	if (ret != 2) {
> +		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
> +		return -EIO;
> +	}

This looks like standard regmap stuff - what's different?

--/Bd5h60K8hFlO6A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUBi6AAoJECTWi3JdVIfQqKIH/Rd9DREkUtZY9c/ouLNtamyP
eAG9R7eL5VF/cvTBoO9ZFcziP42iS9o+Z+SOu9FmoMlWigcEn2H07mxqFqy4gLho
XI8kkFeWNqgfTNGWNON8uFbO2hlHbKPstzYkj7rWWMGhR9xBiCXJ5Y0YfmPKmu/p
krUljEaEL0McmC0x4A7dnX+CThHNhY+B48xCs1ORLHC59balo2fhbwGD1Os8dJO9
2a0tTbQzhngLxzLwNwPdEO2rLgJM69LPOAn5Xf4aUTM8btHwFWu82ZuDpWNIR4Sd
U+KGPr0rNdzrUhDZrs2FkQk3kaeQQOdCqWyBdPQW1o5IAblRkRF0fESu7gu6YaU=
=42yK
-----END PGP SIGNATURE-----

--/Bd5h60K8hFlO6A9--

--===============1076031748494035213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1076031748494035213==--
