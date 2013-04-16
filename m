From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 05/15] ASoC: phycore-ac97: Add DT support
Date: Tue, 16 Apr 2013 12:59:43 +0100
Message-ID: <20130416115942.GG26958@opensource.wolfsonmicro.com>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
 <1365939779-4507-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5915629319957508138=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E6212625D7
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 13:59:47 +0200 (CEST)
In-Reply-To: <1365939779-4507-6-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5915629319957508138==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2013 at 01:42:49PM +0200, Markus Pargmann wrote:

> +	/*
> +	 * This driver doesn't need to know which actual hardware is used.
> +	 * The audmux driver has knowledge about it's type, and returns
> +	 * an error if executed on the wrong type of hardware.
> +	 */
> +	ret = phycore_ac97_pca100_audmux();
> +	if (!ret)
> +		return 0;
> +
> +	ret = phycore_ac97_pcm043_audmux();

The DT really ought to be able to give enough information to figure out
the audmux configuration.  If we can't do that it rather defeats the
point of moving to DT...

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbT0nAAoJELSic+t+oim9AUYP/2KCKO1ef2r3pCJBeILkP9Ia
1pHyI5WI1EmflW3MMBn2KOzOaWYn7xn9a8Dhozi1WR/PDxOkOkIEJyRWgcnYIk3c
K/QKB4PKPKR/xESyuyEZ4Tr2owi22PXhAFs5b2i5iSfTyVzkIieqBq53Z9k+FbT9
vjM4kzV6IeJH9JhvnJ/s7fr28vOpgKxfUUVNv2IB/8XTnTh9nbqeYAvX6Z/uf9/+
g6Ur2wY01sp6p0PnNav7YfQgQupdt5C74Cqpdm8BNHqLlbSOtEyaMYcpeKC8rKYW
JLIVbja9nq8wt9whhJtdxaCEW+OzBWCNLwG/7EqabD7uCy+ANzbHNuxyUAaOFhgm
7cjh0H3WkcXM+8bIiNkw0LmuoTHGxCryumzLIw7pA0PnMGpdnQLYP++YxShUUwUc
Qg+2VE15XMWiR4TtN0I5rVWPAqog2LCNuqCY6YjHpWf94bJvqqt73zRLmNL3IE8W
gfxLkyLXGc1VhO73t6lxZbDFQhGdliQOJYCjQbOszB0BNA+6yMVdUCHRl/BepQVU
PQSWsQYWMPtWOdWGQEASNVQ1sSF4Gti3lZZIsdNMeJdm/A9J8zsqexdKvRoEynmJ
7/Za+Pgp7SMWOhjPKxkMbJG6zZoRkmoiTldeQS85sDUTj90/NvWRo4zl1o/nu8q5
70eq2KLF8Uwfh7hXXo1Y
=EjLn
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--

--===============5915629319957508138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5915629319957508138==--
