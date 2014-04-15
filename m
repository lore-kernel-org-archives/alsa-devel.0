From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l51: split i2c from codec driver
Date: Tue, 15 Apr 2014 23:58:29 +0100
Message-ID: <20140415225829.GM12304@sirena.org.uk>
References: <1397594973-6947-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6666787221113885083=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 582D0260799
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 00:58:41 +0200 (CEST)
In-Reply-To: <1397594973-6947-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============6666787221113885083==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V/VNt6jARIhH3MER"
Content-Disposition: inline


--V/VNt6jARIhH3MER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 03:49:33PM -0500, Brian Austin wrote:
> This patch removes the i2c bus code from the codec driver and creates seperate i2c driver.

Applied, thanks but there was some fuzz applying - please check it came
out OK and that you were submitting against current code.

--V/VNt6jARIhH3MER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTbmRAAoJELSic+t+oim9G1cP/2muYZKS37b/fJAfwDJYjOpt
A9VlLZiR0kcVRkiWKQf9mYQ/w5JtcHTN2bnb5Fs+3kXBf3cUa0LbjfaPzlBDJSQ0
QZoRwlritPr6EAOcsQE+K5kvfGRyy3z3Ip64eaLtblAot9iLgqkkHXsRFzYNEExr
LHMNYTRIq34NxSAEd/JnvzwW35mY92Wz6mveJYW81sDzAeu+jdsUv8sRZQTr5aNA
FDg6HxQeUgrk/1Q+LJWlNF50CGTqXSjiX/de7ejOuiPlXCkCJwEJo/vS+pTeIcsd
mN7L4PZ0tmkMgdjXEDZsIoB8L3a6mi1YyU83ANyHUk5cqIbwwqBZOux8JnqLkUx/
R3y5XbnF1UApejP8pZKb2T74H1b5ULyoIwAuh8tgjmFAciIop1DmEDBJnYm1954p
WKZTgrirPKPP2k9iNMoOK+yhnq7+8Tawe99IBFEC1Ijre4V+ckkA4mjpBMGofi2z
v3oiYzHkFiiuk2m1pHVk3Stm97uO+MPwqOqN62chu1uzZfPgQ57zBXSQTJuuzuj2
AV9xzGm5vb89LuK75uPk7RL4JSFbmYwxxkEiECfO8G/RqDaiERdGx04v3WdK/Sk/
k+bLrNr3+PhlRWhA0NgML6LtBhdOnITVDm5a5694UTU4XfqjS304qtF5rS4ZibRQ
JqLRzN9mH+9YrSOYEhno
=p5bI
-----END PGP SIGNATURE-----

--V/VNt6jARIhH3MER--

--===============6666787221113885083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6666787221113885083==--
