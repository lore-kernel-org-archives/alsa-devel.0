From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/14] ASoC: lm49453: Use
	devm_regmap_init_i2c()
Date: Wed, 28 Nov 2012 17:45:18 +0000
Message-ID: <20121128174518.GZ32691@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-8-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0124760261656903017=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E97AF2625E6
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:45:19 +0100 (CET)
In-Reply-To: <1353930587-12907-8-git-send-email-sachin.kamat@linaro.org>
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


--===============0124760261656903017==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E9SPMlsjsjqOlA3h"
Content-Disposition: inline


--E9SPMlsjsjqOlA3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:40PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--E9SPMlsjsjqOlA3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtk2KAAoJELSic+t+oim9Cv0P/AowQdtyjuPU2kHnnIYEgOhm
c8z8B8KngdocO8qI4kFH3nMQqz0YIpuV4PSn2uxsKBKwhYCDWDSPeH7FbY9+Jg/x
kn9swjN0zRPkvBg1a/kM/HEKvZHx9iv2qdtcSku/U7gzturQEkViS7AVUnWPbVrZ
zE/XVBzwp2rsR0cWLtP0gLcXacfUIdy0sX0c4BJXu/26ayURQfCd9yCX1VAWv7V0
11SvTieQWnfs0XJil8npbfn4YWk4O0H482r+LAfTGELpvBUOyo//8WCEnWzYX2iQ
Z809wDktU3FSOznwFJGMT4cVCtNdIgV9WGL1JXZgNohv4ts2Zq6yaw2zaTBluzNW
F5mpNKV2cRDY60NML1Tv9neD4D+JI2AFtJ+gzmz2d5b6LbqliD/gayNJdtClHHbc
9o8MNIbQL9QOQZIUt2pdBFWJzHsaJMH/IsWSiHIcq/eKU7HK6qqn+67BXvVHa1gA
gjAb5wj9jNas2H0Fbb98ggAiYEsouQddxNMickr2T/kOrF68u3MaslnmEno9Ht4p
uwpFD6FGUUo+hjB+Dk2Is62KRgFgCTArGOV7Ycx2q7K018ejTOMBJ0tVkaTatHPy
B1KnDqoO58SxoyZmOGpby8O4cN2sHluJf3vB0j+q4X7Al6nAifFKCHGG/dXJNZAF
IPwPMHFYnJg2oQLF78fh
=38RF
-----END PGP SIGNATURE-----

--E9SPMlsjsjqOlA3h--

--===============0124760261656903017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0124760261656903017==--
