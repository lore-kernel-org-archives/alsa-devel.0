From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: fix new build warning in fsl_ssi
Date: Tue, 7 Jan 2014 13:00:36 +0000
Message-ID: <20140107130036.GE31886@sirena.org.uk>
References: <3842933.k0ltEqM7B8@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4979079913660561093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B62EB26171F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 14:00:44 +0100 (CET)
In-Reply-To: <3842933.k0ltEqM7B8@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org


--===============4979079913660561093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4cCPO3E9wtcdFvO+"
Content-Disposition: inline


--4cCPO3E9wtcdFvO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2014 at 01:09:48PM +0100, Arnd Bergmann wrote:
> Commit 6873ee464a9f "ASoC: fsl_ssi: Fix printing return code on clk error"
> changed a warning message but got the format string wrong, resulting in
> a warning "sound/soc/fsl/fsl_ssi.c:1196:6: warning: format '%d' expects
> argument of type 'int', but argument 3 has type 'long int' [-Wformat=]".

Fabio sent a fix for this which has already been applied.

--4cCPO3E9wtcdFvO+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy/pwAAoJELSic+t+oim9IlUQAIdUKzeIEiIL9z9QL+4nh2Vm
GM5SXXWOfv3OS0dC9YiT+KV4JAlZ7S86eAtsDc3a36Ak0Lnn5aei0qaFRXekRKf6
rMDAUHwnVZCS1+Z/+rWOy72mW2lWk2+tQacB/gVjbeoCh69W5q+IUKDh/qGmTiI/
O+QOuWfX2lZa2SzT9RyBYK2eZoxm2Rry41xzmYGbt++93uDdMNWwHEnMsoyE3J9Q
xdtImhiCJLNTPSVJLfVcwgwRY3g4BjjvW9Lza1QXCKR4TDdvORgF16fyxz2u7Dhw
XMhGb49MWh+hoKCjQYStjqoCOq2Gyv0g4vOtSI0UL1hDeYuXn6CUQj6gTdAiTPR1
+dfFmL+E0BIfJEfJaWhZmHevzJghk8roseT4aW/xP6YnGQ1bZcsSNafdBFb3Oc7B
CmFNp5e1RgwMDI7JVgf8/uz2JWeu93PpSkbecoHsjXumyfb1jPc1nAGYJxKM/duk
tw7ma2YRfcAuELJm4ZaAQAGBN1LUFuWn+g6KcDZTDHTWvuedamtnF1bW/otVOSvO
9ahAeBgwJmg5gTKSDhs2qxmaIehrW84LAW5gSJ1KtCpPzhD+hb+r+Jck/BP2YiPz
f2ze+/tzX91rlEN4qQIdUmmF6QcjaEg/ZxfEVDJjK7QbUh9sJz5AcXSn8oO69z8m
ls4FhKwr43Ev9YMrfLjD
=ezf8
-----END PGP SIGNATURE-----

--4cCPO3E9wtcdFvO+--

--===============4979079913660561093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4979079913660561093==--
