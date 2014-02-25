From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da732x: Use da732x->regmap instead
 of codec->control_data
Date: Tue, 25 Feb 2014 13:34:14 +0900
Message-ID: <20140225043414.GR25940@sirena.org.uk>
References: <1393090485-10894-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4170553026532034507=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6A0D265546
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 05:34:21 +0100 (CET)
In-Reply-To: <1393090485-10894-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Adam Thomson <Adam.Thomson@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============4170553026532034507==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VTgTzoOEg/vvPQeV"
Content-Disposition: inline


--VTgTzoOEg/vvPQeV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2014 at 06:34:45PM +0100, Lars-Peter Clausen wrote:
> With the ongoing component-ization of the ASoC framework and the continuing
> migration to using regmap for IO the control_data field of the snd_soc_codec
> struct will eventually be removed. Prepare the da732x driver for this by using
> da732x->regmap instead of accessing the CODEC's control_data field.

Applied, thanks.

--VTgTzoOEg/vvPQeV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDB0+AAoJELSic+t+oim9BHIP/1HCYVqU3h31+Qo5G/yEvWOj
BY14wAKHFqlcmgiNqeEMtFdfoWNd+PexbtQCPfvXqeuTCS5xVkpKTGacWTFTsEct
K4HBywVN7pAcKQnXLHQhM4HLxK5IhOaUTk2hHkzFrPfEm82OsQKjtVp+uex1rtZM
5oAN3UObN+TGN8RSbqBrHSyCcnwMJhVTNXgcUrKNFoIZf9+x5sAw8CSTymouE2/C
DRbCzxqs9l4J4WMj+2m+xSAYM/DH/fXvjhxh7bnUgd4taIXOCl0KfC2qXf0HZD5N
I8lrfaE40mR/hb7DCDBCvHCq8QCJhBmX8lwfsuyi7IF5eV82d6x/4eB4XQVCePIH
1uukx1MN7pxIoGqch2H03w8PkfUP9Gg+Krpuzf6jLba56xkHtfNJ14lXz8TPmGxq
7QXAkI4qhJH53nlcAsUMrKww00VeB6DUuik/ut6gcjfLamiHiOVF9dlfNg7II30R
IyxRtlkuyKmhH7Y/I6gEO3O4ovEV5jSSePmbtorJIKVt/6ISWHuXc0KuEordxANo
posW9r5jLpWVIZBdF7eF5l8JQ/7Hg+vPHtVo7rWFuqf5wW6Lhwg2lDo3A3zFxQ1H
4yf4lScyIlYhM/wkB3Osowo3qVWMsdemShXuCNjUJVAkGKNGziOwUyTU0DGdMRBR
9PM03INV3P/GhCfQ0vx2
=jvQ5
-----END PGP SIGNATURE-----

--VTgTzoOEg/vvPQeV--

--===============4170553026532034507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4170553026532034507==--
