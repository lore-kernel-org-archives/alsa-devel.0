From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 09/14] ASoC: wm8955: Use
	devm_regmap_init_i2c()
Date: Sun, 2 Dec 2012 13:09:27 +0900
Message-ID: <20121202040925.GQ17981@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-10-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3846626590866244009=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B8342264F02
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:09:30 +0100 (CET)
In-Reply-To: <1353930587-12907-10-git-send-email-sachin.kamat@linaro.org>
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


--===============3846626590866244009==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SRTEifjNkXp0Rce"
Content-Disposition: inline


--4SRTEifjNkXp0Rce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:42PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--4SRTEifjNkXp0Rce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutRrAAoJELSic+t+oim9fRwP+QGt3CN0LgC74BYNULo3Thr0
9+jIJu82VuNr4xxaDScvuoeN7H/CGFkuFPMa5ODG16LmCSy8Z+bj5fZLBV3oMazh
BpDFuIOz+94T9PGi+hF99LldnSk3DHfra1rDF5juLLd2yPqO0agfY5iGBpI++6pW
OSMEAnymoKwKS4bMWa9YeMZ3n2SLNwAMVmRfpmYNWm/H5CAWc5UKR4TGtYvJYVmN
ZbiNqXAuwzkLyKu26i7XXUlKtIRPz5Um2rR+U/LaZtBBAeXnopTijXOQVMCW72Sa
24Lk2Fxu0OYDUjASkYgnScOXDqfXY0tOG6j8tcrrE5tMqH+sWRVGan81X5tAmx5y
XWBDOCDetl6Pj9+OeuUJfOp/+YkDr2zxpyIg4LxDwoX2x6l55c13/mMRlnmiwyaY
dcHWcZvY9Z2EAQRGljbdslQ/t4F77CMCzA1Jy140K1Kp7R1YGrHIYvYX36uX82NG
Yk4b5hsSV9K+iZh4F59LkhANHv1RUH/PGP5WzyCkvwDPBzF0wgJ/x325v+XQFINd
nUCrd9rl/R1rdt9gpHAhcKwKqoPsgg7aQGp7z1+wgaUiJ+yS9zDteioxeeF5lr1T
NZbS8pNC7ylhbiy29WQy4wZNiNUN47qq+BkvrVJyzccWQsgnSM0kBFrHkZFTdh/L
e06A/8jtz2YO13ydmxHp
=/KmW
-----END PGP SIGNATURE-----

--4SRTEifjNkXp0Rce--

--===============3846626590866244009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3846626590866244009==--
