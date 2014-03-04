From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8753: Remove superfluous
	'codec->cache_sync = 1'
Date: Tue, 4 Mar 2014 12:04:50 +0800
Message-ID: <20140304040450.GD2411@sirena.org.uk>
References: <1393678004-17427-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8277112669464478462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B28DA2656CE
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 05:05:03 +0100 (CET)
In-Reply-To: <1393678004-17427-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8277112669464478462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lS0Z/zpizLfakKcP"
Content-Disposition: inline


--lS0Z/zpizLfakKcP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 01:46:44PM +0100, Lars-Peter Clausen wrote:
> The wm8763 driver uses regmap for IO which means that codec->cache_sync is not
> used. The line was added in commit d3398ff ('ASoC: Convert WM8753 to direct
> regmap API usage'). Presumably this was meant to be regcache_mark_dirty(), but
> since we already call regcache_mark_dirty() in the core when suspending the
> CODEC it is safe to just remove the line.

Applied, thanks.

--lS0Z/zpizLfakKcP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFVDfAAoJELSic+t+oim9DbEP/RP+eY5x3OXj1DxYn1f1Tgu/
J1JyaMYf7kbohiTMdOUBsVYIGstwu311VLaYLtxnjyYExSwjHxKA5cDBAJeMiBvu
y18tnXYChiQng8M66lAiS7vvlq+e+Y6YI7Q37VbWrcsRZUHzslOgj7UoApTs65lC
Z607muOn+Uhu57qUy62pPzzr8kVL5R/ZgpR7Wa4CgliQI2c+qeVNHeRASwynvkCB
3JZzxTEByZW/dmfNoPfZ/PX6RMci0CvGGFYnXvwiw7rH/21kN3JQmQo8eEMJsLtD
ozHRFuw4VVmRX4iJQwra6yKiafuY5rTkwbsjFmal5DtaJTHgdArkrXKFt3Blc7Sq
T6eb5sLb0ZUK1sLBVOGAdWx3rH3s+N1meU1V21KgAzM0BUfoj1d3LsLL/zISDdb3
Hfo9bR6PIuN80RhbCn7ywzlQKvuzJNoCOGjpN1uniCbBJ/okQw5YdMUwRC8iOsgu
XIPXFp7rTKP2dn+V0faYPHHt38sZcIZVa7KX3OEMUoF9kLmRQaFQg5wjTS7U0Hp8
uG1pYP6OtAUgTrcunGTNRx71O8hhWkhA1w9Ye7KhxM7/9zmksd4BEE2bT9PYXPW5
/csMQmKh5q+DzXfLPsqZvs0rPOLhFl1XRRKcDeXOeZTpQQ88Wy8eOkPGQmotWgFY
9+9EGGbMQPlQRIKshcLm
=z9D7
-----END PGP SIGNATURE-----

--lS0Z/zpizLfakKcP--

--===============8277112669464478462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8277112669464478462==--
