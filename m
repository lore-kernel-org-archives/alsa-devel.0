From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tlv320aic32x4: Fix regmap
	range_min
Date: Wed, 15 Jan 2014 23:13:10 +0000
Message-ID: <20140115231310.GM15567@sirena.org.uk>
References: <1389805962-18670-1-git-send-email-mpa@pengutronix.de>
 <1389805962-18670-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6650204567408791101=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BCA926157F
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 00:13:19 +0100 (CET)
In-Reply-To: <1389805962-18670-2-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============6650204567408791101==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2MeieX8lS1K8IJ9W"
Content-Disposition: inline


--2MeieX8lS1K8IJ9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2014 at 06:12:40PM +0100, Markus Pargmann wrote:
> range_min is the lowest address in the virtual register range. This is
> the first register with address 0, not the first register of page 1.

Applied, thanks.

--2MeieX8lS1K8IJ9W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1xYDAAoJELSic+t+oim97BUP/1FcwEgxGb6IdEZ/8fjU36R1
5i3fQG55Xqck2Cmpa4vquGXuXOBxjGEHerX9VfpZg/J5S5i7b+X/sUpr2D18iywo
kK7Tm0GpVlWxJx5jolWE0kgj4Vmdx1/69NZBIsLAO1ZIV/yjLAT81G7PQ26PJ+a2
J6ufB9Fa/8HcuM769FAYxyhxHlYrjAqagIXdgJSgNyHAx7jFoBUxDrlTLDLRBDwZ
CUL0f0GChozsPZWEuepSzuuszVoSU5nQ8+arljEbAa4e8hRrWy+BjCyPjlpr6Od1
icE93mAk8iq0NNW3CAm6bNvPMyLHfVLBkm/LV1ntR2qTMgswdjbr3uWcpF6BqaRt
MZ3jd6P4zM4wgw/UemExkNJJkWpbWUyTCqLpHHcRKtTBCDCzxC33nIBjuyyowkbl
zdTgFECqSHB1v1f84OhZbJITNWsMfbmFwNEo0eShjZ7RCjFtzMs6O8xtbbl+yMNq
S3E9g6FE4YfdX+eF7F3vlmkEW7ox62KQ6/Ig8ZcCFWlEJYZcOCqQSq4caJ4tevTt
+yxBBYGDcw00ZkBLDiPyApVf9bxFWWWf2o8Oi7C6UHFximP52GQdGoR9JlaYBG5L
TJOwmQpDs1e8mUBTd0zF+J4i9oUFVqj5vJWPZ9W5LvED1Ymz4vdlCa4rxDGqFp7t
RtA98o4A+xzNk1d4+8K5
=cjUw
-----END PGP SIGNATURE-----

--2MeieX8lS1K8IJ9W--

--===============6650204567408791101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6650204567408791101==--
