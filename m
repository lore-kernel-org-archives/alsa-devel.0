From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cq93vc: fix cq93vc_get_regmap build
	error
Date: Wed, 30 Apr 2014 18:23:59 -0700
Message-ID: <20140501012359.GH3245@sirena.org.uk>
References: <4308079.So6q7GrfYB@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8313794663166736074=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E0AC26007E
 for <alsa-devel@alsa-project.org>; Thu,  1 May 2014 03:24:27 +0200 (CEST)
In-Reply-To: <4308079.So6q7GrfYB@wuerfel>
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
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8313794663166736074==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 30, 2014 at 11:06:29AM +0200, Arnd Bergmann wrote:
> 49101a25acd69c "ASoC: cq93vc: Remove the set_cache_io() entirely from
> ASoC probe" introduced the cq93vc_get_regmap function that has an
> obvious build error referring to the 'codec' variable that is not
> declared anywhere"

Applied, thanks.

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYaIsAAoJELSic+t+oim91NsP/0GhNAr3UjBZ/tD/7hDg4dEO
g1gnqcd8IXBFstT5a9wWZ0ccLdyh854DUxyWJPtDewdlgez0N+FYOonGVxm41Ons
UogeKYVVPA/XGATJQvMri5steEoXKMrWGgTJJs8lCu1rB2PA3cfVqD46jqHETOOA
2xAgzkvn39bBqpZxle5zm+6W97aYX0nNf9ucTCYV/ZE5JbvXSHEBIezpF58E/J8i
RU62h8r5BiYkj5JlWbxPjHc1Tgc6W87D7590YZXz7EHQAEBOiVxkz0/tylAWF5Zt
o5MACL0vTtlapE5c8kN5qPOkOdaTJ1SUjRgXStTCey99jcc3Eq1dvR6Ug6R9FsZ7
+GSRvq7rOMrFCLLeRPcJdTnEbjMCp7u2fGnwUnzyXu3cHxLKjcH5x4drVZ8M7YdX
/rgohdAOxVk3WLrFiYiYjVVIosbLStPKvHLIwvxk2T/+XYeiPyoA+WAdoh4fp2dK
hMbWdMRZ8JSRdrYds/QCnfiJaL6rtUdijnt5YbPwtLZ0nOIdlFZZtGr9uz+l/BpY
Bpfe349cGPmc/j3ZcKBgU0Czb7j/P5rRpDtE50ZIe/2nhaEfJHAff8thnxnvqvJ/
1E6xe2XazCq/D2PAn82+gXakUHHMlfAhPyW3HWNjv3hAJnrhbaXYwKTLdNGMPDbj
6JyOOEX2N8NL7xgdoFbj
=/FhU
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--

--===============8313794663166736074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8313794663166736074==--
