From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Samsung: Fix build regressions
 due to gpio re-org
Date: Wed, 22 Jan 2014 16:34:44 +0000
Message-ID: <20140122163444.GJ17314@sirena.org.uk>
References: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
 <1390392043-24387-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2097119467915952092=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 898E12650BA
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 17:34:55 +0100 (CET)
In-Reply-To: <1390392043-24387-2-git-send-email-sachin.kamat@linaro.org>
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
Cc: sbkim73@samsung.com, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2097119467915952092==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a+faJa9bPoiqfmip"
Content-Disposition: inline


--a+faJa9bPoiqfmip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2014 at 05:30:38PM +0530, Sachin Kamat wrote:
> Recent changes through commits c67d0f29262b ("ARM: s3c24xx: get rid
> of custom <mach/gpio.h>"), b0161caa72b6 ("ARM: S3C[24|64]xx: move includes
> back under <mach/> scope"), 364374121b78 ("ARM: s3c24xx: explicit
> dependency on <plat/gpio-cfg.h>") and 41c3548e6da6 ("ARM: s3c64xx: get rid
> of custom <mach/gpio.h>") caused build regressions due to broken
> dependencies. Fix the following errors by including the necessary header
> files explicitly:

Applied, thanks.

--a+faJa9bPoiqfmip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3/MhAAoJELSic+t+oim9ZbAP/21BXmOH11zxqsyn16wXXm86
CBGvCrACysF4UL4zv7+dXQdT0q3HOBhJubIkLNTvPFQidl92F7wAPeFMZ78ZNJxg
ASkbf6Mdza2SJ203+lJ5OuNKZvJoGRoKgte1dbtdUJ2+fIZuk46e1/PVh86eB58G
PoPpX0N1+TpvWDqQnTUltY6qM2aMBe4JoX12yuBgqSeX+ELrW9Mv5riSrB0N1HVY
faHV0X+g9MegselAoG9lm1J9/dicEQ2glPO0K7uUI2QEFAs9JjbcnCCcIO9MFhoO
BjwEpZ2yTUzhCyhJ+dDDbjeu15zV8n2lGZdYc536oMsvzgS8msB4HlApJ3sdpDKW
R+ft2IkvYmhO5RqsMghAzRPnYMKPltMFG3FOkq15xGiGVnY5USd/kS0SbH+PO0ZH
enaTTEKl/MGWnER3uWbTMdn+ZoKtX9qRimcKaWIziWW42KDs1oMOks4q27hVJbsq
AXCxUcugDE/5bsh55uVtjkg7Uiq8pHwthcaCo+gbSOBKHPrNrK9cRBkHqO6vJD2D
1ZUoZVPuZtvVSLFy44kz0W5p3T8VAjCiJymUVoLGxizyTjd1PpxgC8Z2XoU6JgH/
/qvDQ0asC9xUmyDfSPKJOYLvroNFiZg6diHLb2Aqvqa6H3aaUx3CIw8ik6YA526z
YHhbcOffPTdrMpyEYbcU
=c3Wl
-----END PGP SIGNATURE-----

--a+faJa9bPoiqfmip--

--===============2097119467915952092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2097119467915952092==--
