From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] ASoC: Support TI Isabelle Audio
	driver
Date: Fri, 1 Jun 2012 13:46:25 +0100
Message-ID: <20120601124624.GM24139@opensource.wolfsonmicro.com>
References: <1338289786-2751-1-git-send-email-MR.Swami.Reddy@ti.com>
	<20120530164008.GO9947@opensource.wolfsonmicro.com>
	<4FC8B476.4030305@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3157656674130024489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1007103F6E
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 14:46:26 +0200 (CEST)
In-Reply-To: <4FC8B476.4030305@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR Swami Reddy <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Deshpande A,
	Vishwas" <Vishwas.A.Deshpande@ti.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3157656674130024489==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="37cJpJlYZwAfNbm5"
Content-Disposition: inline


--37cJpJlYZwAfNbm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2012 at 05:54:22PM +0530, MR Swami Reddy wrote:
> On Wednesday 30 May 2012 10:10 PM, Mark Brown wrote:

> > If this is all you need then you should be able to use the newly
> > introduced dev_get_regmap() to get the regmap back (other drivers should
> > be being updated for this soon).

> The dev_get_regmap() is not found in the 'for-next' or '3.5' branch. So
> this api can't be used with 'for-next' source base. Please advice.=20

It's in Linus' tree so it'll be in for-3.6 just as soon as the merge
window is open.  While the merge window is still open we don't update
anything in for-next except for bug fixes but once the merge window
closes I'll rebase for-3.6 onto -rc1 and add that into for-next.

> > This should really include a list of part numbers - the general
> > expecation people have is that they can just register the part number.

> This audio codec has been referred as 'isabelle' in datasheet and no
> specific part number.

OK, no problem - that's just a bit unusual.

--37cJpJlYZwAfNbm5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPyLj3AAoJEBus8iNuMP3dRzoP/jVgikUfZs2nFVUP7PCYLVIg
pW7/vPwDB3c6oP0AZ5P/6tWGEP3w5Xovhs1MUWCsf0LhF9XDblkD6X7LszSDiF8T
EFkOsqjjC5PaE7b2cJ1XO9cdbc0t7cjMR3cvMMqnj+aZuZCJnb8E+LfGfQqGUrHB
/C3uR6b57wQ3qWAplcH60h3h5pDIltWvmTIkkIK+iIIKTq2gzAawyZ0SLjwlsDJL
tdwaxJ+zNGVDY7ypHqLGsL6rwGvcetpVEBRLjTkxPyns0BOWOTeZeHzrFyqg0M3S
f67Y6kkZvMJugLDgcWAMuB0XcTK2Afw+0io0eF4Sj4Ow5yEJwEvkbtwNeCpFzket
Q2hLP7nGOAd8tAJl8JVZ3C2jhweUJwqdwjHES624b1X/CLNRuUzkpheiaqfpdtCs
undXm2Av9PL8sGifXy3aHa/XnaBuLLb0hkMZinm/yQv5L0ZDXhPIu0kIaACQA+23
cfqB4nyiR6iXqvgOVygYlAs3esQA+dymxMRRL1ZLUIJ7vHbAQIJiOI20E/HA3Dr/
Wpxhfy8Hs/FI36TuewoylvXGQ3KyQSsLO0c9IHxHAHTQ3znpK1bR37H9gx9Q9qSx
zp2HsUwW9rWe0X/B29CnLCMD/0ZnUBWRM6gIa7eWl8bMCfPzGIaFp7okrI8kiAZo
aEyxk5JqK5/5orq4cpvm
=1ED3
-----END PGP SIGNATURE-----

--37cJpJlYZwAfNbm5--

--===============3157656674130024489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3157656674130024489==--
