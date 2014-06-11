From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Fix build problem
Date: Thu, 12 Jun 2014 00:34:53 +0100
Message-ID: <20140611233453.GP5099@sirena.org.uk>
References: <1402470832-24889-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0558589101921594675=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E493926571C
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 01:35:08 +0200 (CEST)
In-Reply-To: <1402470832-24889-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Markus Pargmann <mpa@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============0558589101921594675==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8Ioc0IVuiHZoupes"
Content-Disposition: inline


--8Ioc0IVuiHZoupes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2014 at 12:13:52AM -0700, Guenter Roeck wrote:
> Commit 432481220 (ASoC: fsl-ssi: Use regmap) removed struct ccsr_ssi.
> Unfortunately, the structure is still used. This causes
> mpc85xx_smp_defconfig and mpc85xx_defconfig builds to fail with

Applied, thanks,.

--8Ioc0IVuiHZoupes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmOeZAAoJELSic+t+oim9vfUP+gL2Kunt8IHQpb2QCqBnQmCi
c6/4lVq8KM5yBWiAva8iaBvjjKUr1Wt757bDj0NYyJPMt2+mi/3b/Fy0uYZC1Vh7
Y/m5ZsWk6VDcu0fPLLYpsGvTcnCggLbEt+G5W8LFcv/Qijb26x315FnUkwvRd3B0
zMU9V/GfWmfmz4h6+YCMnhYE4b+qIHaAKcBW/qPJmlyWvZKhO4i/Hyz+fbUo+7SU
KiQgts8QUplKmyrHEP9y2pcw+W1swb2wueFDvKSJc+7l+qzgeMjS0yNWemCEybkL
GAvgFB+1V7x4hf+CziefOCkfeCDSkUpSbizZj/c63yKQBDw4afwTuGdcDh9xeHND
1YWHhE2MIiZnr55DjwvILhUHKPGJfZZNXWV2W4T+hGCTU+zX2XJ4Lc9PFUjMQkvO
Z6oa3H7NbKMcg+rCvF7XVhyQv85n7XBofWQIW2wZKGH6M3pn6S3FBW/GWIOM5rMw
tLA++QsvDYyuk4xMfTAnfUQvj6R00p8RrseDxx1CM55aX62OFLgSvwIESZOqQewe
/ZW38o59Iacniwb5vzSBkMx7lu/VULZJEt6BllVenDv6leOB18EH+f9lqnVgp70/
SUQoIo4g7xFyXz0fXDLnss4+K+4eYigwkH4abBRnKIGFwubnjRO3hNAhnOwDlBYW
j/ln3Yw0z3TNkklTE5s9
=Ck1x
-----END PGP SIGNATURE-----

--8Ioc0IVuiHZoupes--

--===============0558589101921594675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0558589101921594675==--
