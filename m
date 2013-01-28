From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] Revert "ASoC: fsl: fix multiple
 definition of init_module"
Date: Mon, 28 Jan 2013 14:49:20 +0800
Message-ID: <20130128064918.GC5683@opensource.wolfsonmicro.com>
References: <1359354343-1711-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1979582282128350832=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73A722650D1
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 07:49:27 +0100 (CET)
In-Reply-To: <1359354343-1711-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org


--===============1979582282128350832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2013 at 02:25:42PM +0800, Shawn Guo wrote:
> This reverts commit 25b8d31488a3fb3611651991969526b2ea475764.
>=20
> While the commit fixes multiple init_module definition error with
> module build, it breaks build when both imx-pcm-fiq and imx-pcm-dma
> are built in as below.

Applied both, thanks.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBh9eAAoJELSic+t+oim9XzgP/jSb2kcvj8MCMALXO4aBchaM
ZffhemyfRIPe0CtH61VrDr4Q+G2aHH7uPDG6vvB3sKP6Noprw4k4YPLPhaEMWV0X
na7HPubgjJ/Fb7N64wa7rBTDin9IFGBMTlAjUZYQBTmBe43HRSvgBJXWjsuUWmb4
nNJRSy07sSyNP89AL6Wr0IVfdwiz1Lk0NbWf8sThmMnEXDzxYdide94BEbrqpmru
sRMT4SFqB/bgoZuk2Kn3iUhzS6zQ3KexKBp9yxH2HgNoIMZuGBcWFU+X5uFoO/9A
jFZj8LtMYPOlJe/lKoseixW5eMC04WVoNcGynOjGebhbQIawD7khKbB/y8eQPMAX
tYxNThfocD8XnK1lKsUEGO4Dj7MCB29xmKFOUAArBv6kWRfuXkOa7pC+EafAWXNB
LboIeUkTNLzHgNJNZQQXEOKno0KP19C6U8+VWNujLeq5TGORyWGuPADoETNmhcv5
fp9F67YUAAX0P796cLFe7ESQlUNk6rzf4aPeRHX0ZmN5DFqL05b+rJwC51StmT8Z
xuJLHh5lZW3Zah/xhh3+OnYDRW9d1d2hm21AUjaYcua7W2676m/lMIcl3mV/ceUi
nqW0s5b6D5a9CwIj/XLQqweUYuCUPgFWOsYsLZKt9Ohy+wuBXc2DBsVLeIR3twsa
juc7kJNFCJGNkWp2iP14
=9cAB
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--

--===============1979582282128350832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1979582282128350832==--
