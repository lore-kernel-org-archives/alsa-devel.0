From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: wm9090: Use
	devm_regmap_init_i2c()
Date: Sun, 2 Dec 2012 13:04:28 +0900
Message-ID: <20121202040427.GL17981@opensource.wolfsonmicro.com>
References: <1354094032-1701-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8329602936074720525=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA7FF264F02
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:04:32 +0100 (CET)
In-Reply-To: <1354094032-1701-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============8329602936074720525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 28, 2012 at 02:43:52PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutNEAAoJELSic+t+oim9PWUP/2DlxDdwzjY2uy3AQWg7tpJg
UQsS0kFIBAAHM8sQosRpoetJNrGN1y6sJv+qyO3cMAV3hS2+h7kf1wz633UnAqWl
ZFc12+NN+Rtw03tPlsYglwzsD5pfX205N9+Y1GFGuQ26oy6jZX+NZmmJG7E0tY44
XG56RTm52zOA4TVbP7NuM/ZAUDbNMR4ThDO1mZFcVqkZJrQuWoQV2532TxIwYRMu
eb4uNhJYoteotl/E2sQn8Zij+Hs+0wJ2wx6TNgyXF2Zxe+VRAYM2MdDBd7qvqrPQ
lwm1dk+7XedFa4AmAnHb0u+jb4sK3TPk7WoXhP3cDl4EABrWEbJsT8fN/xWdaxfT
r5PctFWUztI7Fh/0J1U5m2xPP5Iy2Nm+dfEuWOORsZnQkq18m/m+5QMKpCHvg3MO
S6ZZIOuXZxd9nLVvUMm3Qwk/jeRoTCVLWpCJgoECwtsPO5BGgmLv7c+5XaLdbfgz
p/2GB9lnCY8g5A7OJ0zxbp6FIJFswbFlHVVLzTuRPOtcmChOtxoKp2QO3UTiZRsU
GQ8GXLEse9IuDSNTobX8C+SPrtUfFlzzXHonv2CP+hsnjltT0J+1zM8bVcXWkwkk
eAduTVfFdO4tscSBI4W+9fPEtNZXhgV2C0Jka7VFCd94rYvRpma5lCO64XvHHy7n
EeMPlG5IZx2PgmEo7ZOS
=epi2
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--

--===============8329602936074720525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8329602936074720525==--
