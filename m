From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm9712: Fix build due to missing
 definition of "runtime"
Date: Tue, 10 Apr 2012 22:32:26 +0100
Message-ID: <20120410213226.GS7499@opensource.wolfsonmicro.com>
References: <1334093394-18105-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8540468852371189187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA3C710404E
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 23:32:28 +0200 (CEST)
In-Reply-To: <1334093394-18105-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8540468852371189187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yBTw3iMQSKDA2CaE"
Content-Disposition: inline


--yBTw3iMQSKDA2CaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 06:29:54PM -0300, Fabio Estevam wrote:
> Fix the following build error:
>=20
> sound/soc/codecs/wm9712.c:482:32: error: 'runtime' undeclared (first use =
in this function)
> sound/soc/codecs/wm9712.c:499:33: error: 'runtime' undeclared (first use =
in this function)

No, fix the code to not rely on runtime.

--yBTw3iMQSKDA2CaE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPhKbiAAoJEBus8iNuMP3dm9EP/2hHDPTpbDbvmusKXaVCv7ZP
h72w9Ef0W353LF3Ht4+gReGWPBW0xl7WPtJakZJgmUI2Oj7nizKAGN2aHDBdtXw9
QT1V9ZS/BIzBw4W79hYQ7ICGHSzf2p3czjaOsU+/jIXeLy+R2yuZPi+auRBt7cud
8UXQOW0xwYtn22cNt1lhGJ2b2jUmBoeowdfgn46M6MQxy/SNaO/5sbLgeQPBNMbZ
9ucyL0uLXkQUUYF7djpsNI7hZvtAScrXFut4DHbqSLNYdrqaY7Yo2CHPNYvTJ9u9
85hnA1dfgbVr1/ly9wV77Tb78RK19CQTtw+Tx+nRTW8sKUa5V6pfyM+e4dTzXyRg
KVpZU6XwFbH1WQYcIXmkrgJeapEbX6ey+EQ2QjslP1TYDu9DTiCb0FI9kltvGk13
b7hob0KyuQgkLUmTqb1m1hpVL5bYA2B/fCb17XlGG8K3DZkkuXYTFcgOOKAInmKR
X/fA1boqYq4BqX2qlSxI2RxzxPWmgy0RjmsHEhca8x+mbgjG1nqUeGhojgqdUjAh
F6qVNHJQOtFlm5TiRlF5pFsn7fm6RtlmoN4sDDIIzk6xJXUkpj9k1sf2EF16UFrI
HRXvdmvJP9fRfgAm6/dINlSkpPdFkW6JGf4fu4UVD2V1GK4w1LUSAHTFJDpLYpTt
ee53ABj2E+XQKpGRwJIv
=eMZL
-----END PGP SIGNATURE-----

--yBTw3iMQSKDA2CaE--

--===============8540468852371189187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8540468852371189187==--
