From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use
	devm_clk_get
Date: Tue, 5 Jun 2012 11:03:16 +0100
Message-ID: <20120605100316.GG23408@opensource.wolfsonmicro.com>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
	<20120605064714.GL30400@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3917714881316546507=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 663D1245C1
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 12:03:18 +0200 (CEST)
In-Reply-To: <20120605064714.GL30400@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, dong.aisheng@linaro.org, Richard Zhao <richard.zhao@freescale.com>, kernel@pengutronix.de, shawn.guo@linaro.org, timur@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3917714881316546507==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2012 at 08:47:14AM +0200, Sascha Hauer wrote:

> Have you tried compiling this on PowerPC? devm_clk_get is only available
> with CONFIG_CLKDEV_LOOKUP, I think on PowerPC this is not the case.

I've not, but I guess there will be an issue.  I'd say the fix here is
on the PowerPC side - it's not good to have to have Kconfig bodges for
things like this in individual drivers.  Ideally we'd add clkdev
support...

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzdlMAAoJEBus8iNuMP3dcRYP/ApJVVTWpD64Lj4XZgIxd6lO
BFuQMsF+nS3nYDPhGlHgZIqug5gdR26vYJTvWPYdPp1s78T5SMU499Qx71m/D8Td
1Krly6QakyIZrAODlZ1gIsY07oFNa96eU1KkECANdqnPZLxdzl7/GtPYlKxnLNCp
g5L48+/HHDO9xOy6fAbeHNpTEenSgmYR9uFFDj8lldmORs5sMKc4EXxSbA+U+LAy
KExXqkSokLpMhrTz4WhMfFAQ1NL7BXSZNWzUGpcsFhLIGHUw2PDqFJvM/ejacpF8
eESsUeEt0daM5LJ0O3ZVaOaM0pW9pxyegfAU8hHWTeNDXPLE94rxDiDsu4n0Djen
lKP+MV48ajZ3Di20liTCV9AGxXD3uPXoLHE5hIUSAOHE42vXMXaqsEmswNWz4NNt
JljpAq1rvXsOML4fAub3PodOH3pyvB66sSusM+/f6RJt3+JOeShGyRAIBFOb97Ht
NwRtRFwVwNDGdIvKSan6LVjx6PUNf3cIxo2J3jicd1J3Vb9Fmc5jyyJMezT5xalf
Nu0pHmfAqt9zqbV2DD4hABIkM/NBEeb01erDJXYzqZmWK2gLsZO/zLv4fQRGENhT
OC7cqKGDgJP/4KCRCHINoD2HLHgiCHkegFazN0H9EQkW5g+1cqBBnZdL9wd1Be3O
rLIfR0zEae5jJcBaZsn0
=Zq5w
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

--===============3917714881316546507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3917714881316546507==--
