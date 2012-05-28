From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Use
 clk_prepare_enable/clk_disable_unprepare
Date: Mon, 28 May 2012 15:51:39 +0100
Message-ID: <20120528145139.GJ4032@opensource.wolfsonmicro.com>
References: <1337977640-18845-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7491168086048001513=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5964024376
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 16:51:41 +0200 (CEST)
In-Reply-To: <1337977640-18845-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: philippe.retornaz@epfl.ch, s.hauer@pengutronix.de, shawn.guo@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7491168086048001513==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MP5ln1Rcf9Bvi+ZW"
Content-Disposition: inline


--MP5ln1Rcf9Bvi+ZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2012 at 05:27:20PM -0300, Fabio Estevam wrote:
> Fix the following kernel crash:

Applied, thanks.

--MP5ln1Rcf9Bvi+ZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw5DsAAoJEBus8iNuMP3dswEP+gKwrugwQpQWmK2Yyv1giXEd
93lMe6x9FrpiwnwrVj/Ljn2j0/gF6muYrEvVOEmufan+bHKpeEVXTIK5fliIMxtB
SGu0pkCNjWs/zuBBhD/9jJvKxfRc1ipBmd6FkYxWQGXp5c0nGC9wqjaNHc9jmkCz
K/zz/ZMsAQMt6W5z409Z60DXIOy9sR6G44F0oe0UyAWRtn7t6k0ziARUdQ8F35qn
JG6P8fYxwHYurYw3Wu6QgB/PgV+wyfo9UssJNGARRmagfVWbmA9CoQ5Dbu9XJ3cc
0SFKK2CoU7JRyESRu9YN77jrX8tj1M+MUl8eS8OkRj8W0tAqMFbcu++2nm/lzZRC
8ocGQU6c/mKHvdei0XRtAKKPfVpAZq5eXMB3Wzw5Lg7fneTyTuk58j/+pKtRvi8e
h2VgkJEc10a47+BRsl02QTuQv0oQPmkRNNaQ/PeQUSkOmyK09b/B+wfa5fRONyn7
nzBfBh3eM/Hud8G2hMuduZIINc2MbTT28OQ7ETf8AVYg4a/6/ua3VwGzfOf8DJNW
KHtwPUiMm4TsYoK/LHvDyDqavw0LkyKHlwAkrFSKoNAgKCJEQl2jXn+eJZmBe70G
A0KgnJSphyleIC+S+g33ylclmKSAHNiGVsJFWGX+zZOMbOmFDx7gXAhIXggNyeUx
wUdcavfU0hhyhjRp7eMs
=22lA
-----END PGP SIGNATURE-----

--MP5ln1Rcf9Bvi+ZW--

--===============7491168086048001513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7491168086048001513==--
