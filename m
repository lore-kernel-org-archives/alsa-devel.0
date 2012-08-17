From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Lockups reading from i.MX51 SSI registers
Date: Fri, 17 Aug 2012 23:27:38 +0100
Message-ID: <20120817222738.GH18871@opensource.wolfsonmicro.com>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1911546348417369748=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 015EF266189
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 23:57:54 +0200 (CEST)
In-Reply-To: <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Christoph Fritz <chf.fritz@googlemail.com>, Sascha Hauer <kernel@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1911546348417369748==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 17, 2012 at 04:08:47PM -0300, Fabio Estevam wrote:

> Also, for the playback to work you need to install the SDMA firmware.

This is deadlocking during boot, I'm getting nowhere near trying
playback.

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLsVPAAoJEFJkBDiqVpZ4e/wP/2pRde/XNgap31fNouq3maJ5
Q9qV/ZbMYFNzHtDFRunYajQrhsTaJq9plvo06tVbK+TbsC5QgQ+ozVFSR6KA5+bN
JogucOFJ6PA1GZdLgxVgOnYzVniqGvJU01I7NyuEkEqoSE+x7ilm7avs4x4xk904
tYsst0Am9CC04LizWGiGRCzj+hGBu8vYVM3LDZyVlD2Fo61bi8cZgb8RT5sl/jgB
cvxVzUHnJ1/D639CAsAWSrpdJn5Fw7nRN9tqRiaVn55TXtSSFVcqhrNriiWDb5aZ
WRQDcCfY+Z1xkK30psyqiGFCDC8RdIR1FKkTsGgbUSbMRSuUQeMoQQb32NVMZij9
fEcVV9VFUqbaERNQQ0xyzN1e2tKwE3w67vW7g7VBbiJxYCW90gZXF9JdGmq1QAmO
H3eusvNPjffPq7YHmmYSLL30LYA1JKM99OhF6mTvdFzhC9nZ9JwpANF4e7SluVuT
JyV/3K+/lSZfR2JuLBuIJnryPT6bqFvalnh5MHO4Prj8FfBMAirRAiY2LL9JJo/1
OylB2bQK/VvcH1PRwTwCV9W2lzgdFqaXofDaHvcx4gHuCbWeXSIwPXUjZPN4EQOE
AOUPcWe6GxarJ3qy9ldC4Ee1BSsaBluKP+XAJlolwN35hrs/hnU6zxxSg+4662vG
60BNLSHjF/vtnU04G5E4
=r+yi
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--

--===============1911546348417369748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1911546348417369748==--
