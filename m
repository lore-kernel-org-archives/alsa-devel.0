From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ARM: clk: imx35 sound admux_gate bugfix
Date: Wed, 27 Mar 2013 12:37:00 +0000
Message-ID: <20130327123659.GT18316@opensource.wolfsonmicro.com>
References: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
 <1364383352-27267-3-git-send-email-mpa@pengutronix.de>
 <1364385420.5442.12.camel@pizza.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SENi13OXelf/Rv8V"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1364385420.5442.12.camel@pizza.hi.pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Markus Pargmann <mpa@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--SENi13OXelf/Rv8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2013 at 12:57:00PM +0100, Philipp Zabel wrote:
> Am Mittwoch, den 27.03.2013, 12:22 +0100 schrieb Markus Pargmann:
> > imx-ssi needs admux_gate clock to work on imx35. This patch registers
> > this clock and enables it in the imx-ssi driver.

> I have no idea what the admux_gate really is, but the ssi driver doesn't
> seem like the right place. Isn't this more closely related to the
> imx-audmux.c driver?

This is a patch to the ASoC driver?  I just ignored it since it said it
was an ARM patch...  Anyway, what I'd expect should be happening here is
that the clock API walks up the tree enabling supply clocks - that would
mean that either that code isn't there or there's a missing parent child
relationship in the data.

--SENi13OXelf/Rv8V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUuffAAoJELSic+t+oim9yuMQAIZQztgaAKzDhS/ThktbPaa0
MqEB7Az1hSkW0FYanSSyHZ+EQJewMCXuMrKDrq9dO7q95RYhOS+uXQ/32AlZ9xXE
MI9k2aaHruQXd2Bp1QMkvJZYQuflrlwLJYaBkLQ2NtuCPJ52RNs5tY020KilCn0o
0lRqyF4GN9YiRBtfSH/gupSsWeVgWlOq2IrRXQFmVcYvfXwr9W940G7LT9IholtS
SJTobjc7DUDd3xmy2a+38cam2zWUxAWSwqpmff+kv8dRxD7oF+tC3McsB/HSjGmE
EnfKQseq6GRTi7uskz5uaE0n/wdDAppQsBsbJ0yNOR9MsPI4Be81UokJ4MH8XsEg
sXnlL/MPtbxDvg2Q1DNLr+zVhZQcEaZzansFZ4+ygGckRQ5f7/zTk9c1aKpL4x44
XhYwSLgeUqMFedCyDbN197ztyN8jaRozxK2qhBgAgTAwJUmuTFgrJT1XenaWVfzU
LR4o/iST74KRhi9gPiDumJ/auWItW1FqzwSDFzgtNJUF7eAGvvGMMq8pN16LRWGY
p7vjZemfJJ585eYdFfZZ7e0/3trR0USRfJyf7q+4UcS1B3mM5dWhLQsAYrg3iXaU
SNnWCN0W/b2XcrUkkMZqXIT8nw5OPptNXjurF5FVV4wUi+RMHAT/xWz5LEB84FDK
bwjzjdN8G0J3qgBHhAKM
=Nfil
-----END PGP SIGNATURE-----

--SENi13OXelf/Rv8V--
