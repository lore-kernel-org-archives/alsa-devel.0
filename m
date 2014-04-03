From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 11/16] ASoC: fsl-ssi: Fix register
 values when disabling
Date: Thu, 3 Apr 2014 23:11:43 +0100
Message-ID: <20140403221143.GH14763@sirena.org.uk>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-12-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4361608397606973703=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D5A422656F1
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 00:11:59 +0200 (CEST)
In-Reply-To: <1394887464-969-12-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4361608397606973703==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hrQ5MIiBPpJXe8FT"
Content-Disposition: inline


--hrQ5MIiBPpJXe8FT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 15, 2014 at 01:44:19PM +0100, Markus Pargmann wrote:
> The bits we have to clear when disabling are different when the other
> stream is still active.

If this is a bug fix I'd have expected to see it at the start of the
series so we could merge it prior to the rest of the series (which is
new development) - what practical issues does this bug cause?

--hrQ5MIiBPpJXe8FT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPdycAAoJELSic+t+oim9kXkQAJYwEDF87Viq56AwMFh5Akmy
eNJx/V+SvH7wMszehNQwUWc0Z6lDz2dMIsJHUSdxri/iQWGGtk/jHbgX4KeeTw2j
Ux7uR39x6/3FJa2IC7CqNI+h3/4fvoHIApZKu91LaRaf9psw2h1qauGqR/O/86vb
kq2DzXCofHrOI4FZCe76rMl2DBQArmT4xPppVnfwdoVkY8gqlW4qWkGIp7zgEebv
eQGySqWKAw6FDPNRqxkGbbMdX1DVB4c0KXxXcIvqW391lK7KlE8ej6s3fwkdpSK7
qEsUhnShHpSmsh7FoyhFYLoLyffYunuFdHPPRc5DH3XqEylJSGER9+OJbACjctIc
yR9uNZw6tZAoIMpY4qYE2H73mVtpQZKg/ANf27qjci2fLeryNosfaDoGwkOV3nl9
BKOdFpPFrk9d9s7xBMahWcX5qWbBnVePCz3aeJskeCc/Ah1kGmupjbvuzM2XSwLW
Kl0fGAqRGKuoAJx1Ls4tAuOyPUO8SvJc0SE013jE7tVrDwhvoQ/p/44bjPrms6u6
bzP6jjQbpx19XrY+tNO9TwiW6QUTjhHDZdcy+obL949enx+ghqvsVhJzbwKuJVDP
+94bFehkhBEMH2N7JmBZqoEzCibQWiZR1IJkUIj9AyklHEY/O8k+rb6swCjCzyn9
PkRK695qfwIYP6ihFbxR
=GUjG
-----END PGP SIGNATURE-----

--hrQ5MIiBPpJXe8FT--

--===============4361608397606973703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4361608397606973703==--
