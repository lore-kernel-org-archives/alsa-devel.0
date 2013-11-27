From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: kirkwood: Fix erroneous double
	output while playing
Date: Wed, 27 Nov 2013 17:16:48 +0000
Message-ID: <20131127171648.GN14725@sirena.org.uk>
References: <20131125201905.0d009921@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0449941531621486175=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C32D82619E1
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 18:16:50 +0100 (CET)
In-Reply-To: <20131125201905.0d009921@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: alsa-devel@alsa-project.org


--===============0449941531621486175==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AS/cuf48TUvH8DlA"
Content-Disposition: inline


--AS/cuf48TUvH8DlA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2013 at 08:19:05PM +0100, Jean-Francois Moine wrote:
> This patch fixes the setting of the register KIRKWOOD_PLAYCTL which did
> always streaming on both I2S and SPDIF, ignoring the DAI ID.

Applied, thanks.

> The bug was introduced by the commit 75b9b65ee5a
>  "ASoC: kirkwood: add S/PDIF support"

There's the "Fixes:" tag for that now.

--AS/cuf48TUvH8DlA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlij9AAoJELSic+t+oim9IWIP/0vgOw+w+Ac9rt+zQM8Xm4Bn
TOgZJS8pXc7TFbsdLFKkOrzuQlS3Z+OTPR63J6UlnhLTLtBRICXslbLhENY7Ng9m
SWTADpU+D/KsuyTmzCYsebREnF1ca5MQSl/nZO+bolkpGHaz/908+1ClSk0RAsI/
68UKUH9hRvDq7S6U8yhM4k8IU+dAsA/f0B0T+evhm+n2wv7mMmVSheO0yx3qjkFF
72OIfLCIO3Cqiyf700RfZtCFmwz2sBgjP+KHUp4bNuwuVokkZluP4Ik8WIwHMg/w
QdCeat1wbNl8FpnGcWlWcsLmN66Sr09BwcszeLZvfFWkRXXAZ2wv99ZOlR5eVdkm
ihtwvl/k0I9EaG/uOSsCxUk1yFqXQCeZIp1vFJH//xVm8ZjaAzGsi2fR39gMZLXW
Dun53Ha+mZMW7/jtoyPqx8JFTKeMiq7g3g97IgWv5oV4ZsZA1iasAlX8ZIZYJV2E
kitEICEd+EkJeYLyGSWjNcEfrGUkGxGSNkJRmnhhj0F+xdiq7EP28Sdl+uO693l2
Qpd6K+q2nHQM7XLuR7Wmr37nmlLzU72HgOlAwK+0lcVgYJEP5wvxrzc6R33RvBX1
ZAZl8QFeX/bkOI9VB94IK37vOz0NlVGET0uq3UTddj8ALKH3zeKRLpUaQjHVws+o
nApygoesnmYh7HG5g30y
=spff
-----END PGP SIGNATURE-----

--AS/cuf48TUvH8DlA--

--===============0449941531621486175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0449941531621486175==--
