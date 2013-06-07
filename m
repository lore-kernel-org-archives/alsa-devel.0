From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: WM8962: Set CLKREG_OVD if GP5_FN is
 not its reset value
Date: Fri, 7 Jun 2013 15:39:05 +0100
Message-ID: <20130607143905.GT31367@sirena.org.uk>
References: <1370607258-4750-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6490606273429994033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C5A622656FE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 16:39:09 +0200 (CEST)
In-Reply-To: <1370607258-4750-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============6490606273429994033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IOdQuxhrWjbL7fBD"
Content-Disposition: inline


--IOdQuxhrWjbL7fBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2013 at 08:14:18PM +0800, Nicolin Chen wrote:

Please use subject lines appropriate for the thing you're changing.

> According to WM8962 datasheet, the GP5_FN bit of R516 (GPIO 5) depends on
> the CLKREG_OVD bit of R8 (Clocking2):

> "Note that GPIO5 functions are only supported when CLKREG_OVD=1. When
> CLKREG_OVD=0, the contents of Register R516 must not be changed from
> the default value."

> So set CLKREG_OVD bit before regcache_sync() updates the GP5_FN bit to a
> non-reset value.

You're missing a whole batch of handling of device reset here - look at
how we handle things on power on.

--IOdQuxhrWjbL7fBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsfCGAAoJELSic+t+oim9VOUP/iFS3+yNM7v0iPYjwckmbvJR
YEmF1852qQCEbYmTPWzHMtBQ+Bazm/aXp1xbsyKkD0BDdJmP7p8ysqz89/PaqPe2
qPKwYuBBJ+uLwLxqrA0cIMYaU4pFTt44Xo3/xrLibbiN57oWtMUB7FlyG+DI4MXM
73t+mnn3SxMODx89TeVvAQ+QLFOU447XNuc3kFqZcfUlfSLSiHzwDhF68mriMZrK
OPAc25Q33bf0TCeOH7Opm074PivNI95B7Lgipl5i188wHaqRXolPeUspY1Re6mgq
OeIyl6Fd9BAMm1WzAGojkUKSUFUFzhLL6faH86W5TfIynnH/1gBYQIR4p9XlUase
0vK5dwMDBVj1jY+0F0GLnOSVdQsegWXZo+TKMOmW/qljRl9EGQpz1yAPmd7obMDI
yQdRmKL4xH2T3RyM7L77X25v6xafzYGWzRgJ5NBQBdVQybO2bsahmW+HbaIVoM6O
Dvw6tHnIIn4g9qpmb0/aOuOvmdcmf75xqX6+nA6pw9fqc6LedXjxbNrF8qHgoVRR
Zz7xoRy4joxnAcrXnIAQWQvEmtaJ7fqOhe4yF9gq1JQoBb15c6/385U2XKmUeRrV
ty9ODmcApU4tlWhE+JuKvKSG7628vcT7pX1tQWM87NsZvA9UyaDUZC+yWDzPO4CK
WhLcKz242fkIM/ZptQ6z
=MSZ9
-----END PGP SIGNATURE-----

--IOdQuxhrWjbL7fBD--

--===============6490606273429994033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6490606273429994033==--
