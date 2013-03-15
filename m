From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ALSA: ASoC: cs4271: convert to direct
	regmap API usage
Date: Fri, 15 Mar 2013 01:09:29 +0000
Message-ID: <20130315010928.GA4931@opensource.wolfsonmicro.com>
References: <1362696792-11681-1-git-send-email-zonque@gmail.com>
 <5141EECD.1000607@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1034694947587924845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E1D7C261639
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 02:09:35 +0100 (CET)
In-Reply-To: <5141EECD.1000607@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1034694947587924845==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2013 at 04:37:49PM +0100, Daniel Mack wrote:

> Ok, so nobody cared for a week now. Mark, do you think it's ok to apply
> it anyway, given the regmap usage? The driver works well on I2C, I'm
> just concerned about SPI.

Yeah, I tend to leave it for about a week (usually rounded up) if I
expect that someone might do some review.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQnS7AAoJELSic+t+oim9H+UP/0HcOdIzCcyOO++C2ZuYlxPy
QBRnxmfHVcvrGXAHPNJHRK9/WfZCf7LFCHzuBSlDsBA7ll/KXExeLa81SNs0sDbw
Xv7tghI8gqOrX9Hj2aVyg4iD43PnzdCvriwPTfxGymY/cLlDesyjKgOXtALjr8Jm
7FNrlp22883evQH2fvtUog1UJesChwAtYjiDDTzwt1MtuCVeAEh5ZA6p3XuxjVSt
zJGbgxSSYOkS8b1wJV0v3wFlRLKSvdzL1lHxXxDik/yOD342e6GjDLaa1L03m6NK
jZTXjmt27FAHzQu+JBhjxWtDaVG+ddH+WVh4/xDZ72ddKo1Wd0P1OYgW8VlLlWdm
CRYAdDo9WeWNAZxTEr2L28KhAaWUL1eUMXE2X6JumE4paUIDy3CC8KR/QnyszU1b
uwc6b7PEaj1Bi9o7jPbjmdvZd5F0uq1dSJhXZ25JStxW0Llqm05pezg32fBilfMS
ORyiXohLO2Pb9hwQZzOj5yHYYBhoElqwMg+R+ZCm2jFq9TzJ2Jxwc47PD1aEhU39
V8wxLhkgalHEaVCR3P1oxH3epUhWv7ivC+d/peXyeWPrc3JKtBELVEtAUA9d8BbF
5Lr+bqMihKonQWPW/DxzATC/olknMKqGSznwy32AHnjkXwsOIt9GnSc/9sUstnQi
Z3D32KETnVIw71kW0u0c
=Xi0u
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

--===============1034694947587924845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1034694947587924845==--
