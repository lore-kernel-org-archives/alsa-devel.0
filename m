From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_ssi: use platform_get_irq instead of
 irq_of_parse_and_map
Date: Thu, 4 Dec 2014 22:48:29 +0000
Message-ID: <20141204224829.GJ11764@sirena.org.uk>
References: <1417499707-3125-1-git-send-email-jiada_wang@mentor.com>
 <1417499707-3125-3-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417499707-3125-3-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: timur@tabi.org, festevam@gmail.com, lars@metafoo.de, arnd@arndb.de, mpa@pengutronix.de, alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, tiwai@suse.de, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 02, 2014 at 02:55:07PM +0900, Jiada Wang wrote:
> Use platform_get_irq as no mapping needs to be done.
> By using platform_get_irq, driver can avoid to free IRQ manually
> when SSI driver exits.

Fabio sent a version of this before yours so I applied his, I think the
code is the same.

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgOS8AAoJECTWi3JdVIfQ3M8H+wSnaBd8ZqS5scwBA4+nuvOt
Nav08xc13F8K+uyfeIXk0a765aXfhLaMsJXesj8hotgxVb3SEoXOc/EMjvYEA8ol
/+ZGTQISUibE1IA5c5N+eN7duVGEC0H5hM5DwL5VSfM9tNHFKWz1B0yrJwYOj7i0
9wy9oZhymbTYb5jTtlIeRfkg0CUUM/LS8Um7PTjvsfxZEWodYDnZdSeGaWfimHV7
2HeR1XqXTWx/2zTCnZx4pPWlyDNPkEjim7sN31jOMazUDzkxJ3XfhiCPARuDivnF
Lskgc1qbUSnJm93S3rbgA8yZhCn8EQ+ybQu3Krk5Ix60fxWuJVG4N8a0yZa+Iyw=
=a+Pl
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--
