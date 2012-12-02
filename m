From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/14] ASoC: wm8962: Use
	devm_regmap_init_i2c()
Date: Sun, 2 Dec 2012 13:07:06 +0900
Message-ID: <20121202040705.GO17981@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-12-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1152791279389716127=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7DB2264F02
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:07:10 +0100 (CET)
In-Reply-To: <1353930587-12907-12-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============1152791279389716127==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xTKfHyrFnSV9DG3y"
Content-Disposition: inline


--xTKfHyrFnSV9DG3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:44PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--xTKfHyrFnSV9DG3y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutPdAAoJELSic+t+oim92lMP+wSqUfpafO7VmfYu7BzJzxdl
pvZlj+On+fW6l9Lh6R2e+VfttUKR0kCZI26CygN1WOKD6/5wXl/wrsebA2axj9o/
KAn/koIvTjz7GQkv92qq+6dcAJITbQrsJIPZ518kYZ/gVoctmkfLQzdb5OTtY55M
rozZYcTgMyIUT7n96muxI/T78cGElN0HwMAHUCbmNOx5GlDmGYoutyk87c1ciC4i
pCNVz9Sk4KUNMZcquepqOD2Bh9HjAMlVMOmPcdCJ3WZ2h62X3lEzpi8W6MMLC0VY
Q7Sz+Mi9vubGHfoLSZSKF0CZvlGjqmMHii0OsWANlW+hUizy9KTyK/kW1mBwmzWv
sD41xtKOHnqxrfq3mnZzevB2ay/bpATOEQjC9VChb8jopX9ty4S35NxUiWqhEhzV
SahKom/MdlCXH3JbXJ1piu08INu1QhoviT0Vrn5J3FdXboZnCKo2QFs8PFLreVJu
q17biEEDwrQ75NFdb+2RFUFaiCDoF27o+t8WCk+mHlETYcNUm7BfShfnSyRE4ae/
vXeqLYxASm0alvYeGMzPIjCEVUeHTZEnXKP0fEXmIYl6TwmeoSUbxOYh9RhwYmQq
jZb/xDzbqzEl6ZPZdbIGsOtMnSV/0dtMLCrjYgx0JVyXtnoGPhrO0y5K6xdnRI8f
flIpBZKNhCLPfg/nXTV9
=QGKq
-----END PGP SIGNATURE-----

--xTKfHyrFnSV9DG3y--

--===============1152791279389716127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1152791279389716127==--
