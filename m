From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 15/19] ASoC: tlv320aic31xx: Reset
 registers during power up
Date: Fri, 1 Dec 2017 13:37:23 +0000
Message-ID: <20171201133723.vlxqci4paw7szjce@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-16-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5743097874822792831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 252C3266E3C
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 14:37:27 +0100 (CET)
In-Reply-To: <20171129213300.20021-16-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============5743097874822792831==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hd5vczuwjnxdaxvf"
Content-Disposition: inline


--hd5vczuwjnxdaxvf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 29, 2017 at 03:32:56PM -0600, Andrew F. Davis wrote:

> +		gpiod_set_value(aic31xx->gpio_reset, 1);
> +		ndelay(10); /* At least 10ns */
> +		gpiod_set_value(aic31xx->gpio_reset, 0);

_cansleep(), this isn't being done from interrupt context.

> +	} else {
> +		ret = regmap_write(aic31xx->regmap, AIC31XX_RESET, 1);
> +		if (ret < 0)
> +			dev_err(aic31xx->dev, "Could not reset device\n");

Print the error to help people doing debug.

--hd5vczuwjnxdaxvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohWxMACgkQJNaLcl1U
h9B9kQf+Ki3cGrbVjouLiV7OqgE6Xk6UmVuiw0UgJe4lUVq1LZw1Sy4AUF4vnbRy
db0qZT8+zZvx77S3FRam4Nw9BLM1dYlxV+wUkTnRw4LKcXSC8e9uIz58vi/tNhcb
iK/yXdpE8OL4S0nkw2BCvYT4V7SbpHDK7coE5XkDa+29IbRq13hpG44M87z7ZBXO
0Oiu5DQqC43YvKpf67WlfahvgS1M6RKFYwsjIkxZZeMrRRB9CsKgfTN3Xj8pJscQ
nXW8FhE30ccvZKC3rgWWo2gFIz4aQkX4Pl9Zz1lHe0lZDwTuh1mdHg6rEdK38l6z
Ov5EIDpxS9TOaKPaV+pmi/IQ4PMPEA==
=wltU
-----END PGP SIGNATURE-----

--hd5vczuwjnxdaxvf--

--===============5743097874822792831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5743097874822792831==--
