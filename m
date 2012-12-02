From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ALSA: ASoC: cs4271: fix property check
Date: Sun, 2 Dec 2012 13:02:49 +0900
Message-ID: <20121202040248.GK17981@opensource.wolfsonmicro.com>
References: <1354271337-15113-1-git-send-email-zonque@gmail.com>
 <1354271337-15113-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5946303263831705758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7FB87264FE7
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:02:53 +0100 (CET)
In-Reply-To: <1354271337-15113-2-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5946303263831705758==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 30, 2012 at 11:28:56AM +0100, Daniel Mack wrote:
> The driver had the property check for 'cirrus,amutec_eq_bmutec' the
> wrong way around. That happens if you misspell the property in the
> bindings during tests.

Applied, thanks.

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutLeAAoJELSic+t+oim97ScQAJXq+cj1cfCpfYUiMc1eD2Zb
l6xOiOHQQYTOG0oN4hy5fVuz+hNqXUn90pa1zCiLxuUNShX7s9dzAhQax1Gt2q7l
CdEomSy7kbkmKeOa98DL1GCR25yFu9MB/g0zzAaVyj0cKe85VuJcU0rLZUKB+/xl
Mr4x/x3bm6Ss/0bwczZCVzc1zL6gvSLf32QVIjXXma4PMkL8QzMTCjqo02SPC5iN
n/skNVIO8DIlxSIahBdtDCORQLMdLYW/pg8t5ifCcWqY6ZflhoSvC4hGnmjuRX98
KKo9eh5TJ6ah7uStZFgU/lytsbcR/o0e/f2AVdY7OOR/lrkg0YZi+kkihqRXz4B3
KShSt6gnIT0WGc3qkaB1yAEhbq5TlACsmKnlPAyV5DIIWiBlqHWEA2G0aO/ivsd8
IAGER4CTi6K7dZTodzQh8ATXRuVI2cGkNHhG+w5Or59ndHYrNCTQfh8NsD+Mdj1U
f7AzZrvLVvMsjoIO9/WMguUcaUJ7eWOJNMR3ij1rTc2gFin6M5+pc3GygkjWBBt8
mQEhohGePOCwu4YS6V8cRYBgWqtm71QskML2B7FIuctRB19drhYK1B0Bcr3LDeD2
KTKXXh+Y7J0HEhwt6i7qc8wfcG+l9Yi9j1ESVB2YwY9lpJ222P6Qt04P4X8ebvKh
gWSL11D2IizHyhYu73ZP
=FS/9
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--

--===============5946303263831705758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5946303263831705758==--
