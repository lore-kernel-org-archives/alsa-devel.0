From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: fsl_spdif: remove redundant
 dev_err call in fsl_spdif_probe()
Date: Thu, 29 Aug 2013 13:18:05 +0100
Message-ID: <20130829121805.GZ10783@sirena.org.uk>
References: <CAPgLHd8kBPX2RjLJ3FeXSFpiZjvGyaUM4nmoU0wEVMM7zjfWBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8155881725671465872=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 98FA82654E4
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 14:18:16 +0200 (CEST)
In-Reply-To: <CAPgLHd8kBPX2RjLJ3FeXSFpiZjvGyaUM4nmoU0wEVMM7zjfWBA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, timur@tabi.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============8155881725671465872==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ucH0Tl3ykwO2QBzm"
Content-Disposition: inline


--ucH0Tl3ykwO2QBzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2013 at 08:00:05AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.

Applied, thanks.

--ucH0Tl3ykwO2QBzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHzv6AAoJELSic+t+oim9Hv0QAIVfYLr73m858p7s0zfwD1Jr
ZqBZkIeCJVWr6Z4oZszdbjU0Dmi8Ycq6GiCdODGwZpslKE5j4aS9KA/JsLIysrCr
dB3XX+JXB7Fp1G5EaTU6NdLK9oj3ztQK0kvJSV3WjvOGtJ71TW8239OcmsrZm21Z
Dfy629bXNyXXtbdLqcnRQDu31Kp3Date1yQkOiHXs2daUNuHQ8Ub91Hy3sy+L5l8
vLXfnoPS7RPsqdlhVqz3F6gCM4r9Wukn7f10px838tphVzO1gfwJs7AHspY87u6Q
y0Yw/chlrW1BmXy5r6SUAHpOy5YTD9onjX7vzvTvoRanz6BETASrxfloCX42CIQT
1xA2AxOECuYrQY2Xefbmz+/fd4CjT2cfgCA+rQyXScYjSN+xB5pZ/piIwqYy5nJ+
uKTfezqEq/KluMmb4Zi/DdSYh2OB3LRaOoojF+z+NGF39sT4/cqa/g8siq1mOmaR
oO4brBjJZRtGF61OWgC+oGr4NWm1ZXALa9kjy/0HrYx0S3wlSxLNodH/YFccLjOD
mEnlH3ULP2jPPpNxjTnGy85fdROlYV+GwiL3syMiyJ2JpBnAuvSIklOp9U+htMhC
EfwOREWBD97wY0OAbGKF5HTmljb9ozW2GWRIG7xKFUUtut66RUlw7FOj67VI51xF
F7Dab4cTavfC3Je0tAuY
=rANq
-----END PGP SIGNATURE-----

--ucH0Tl3ykwO2QBzm--

--===============8155881725671465872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8155881725671465872==--
