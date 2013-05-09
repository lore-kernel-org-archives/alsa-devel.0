From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix driver probe after
	reset
Date: Thu, 9 May 2013 10:30:46 +0100
Message-ID: <20130509093046.GY7478@sirena.org.uk>
References: <1368032653-19489-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1235415427895378522=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A39BC265146
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2013 11:30:51 +0200 (CEST)
In-Reply-To: <1368032653-19489-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, matt@genesi-usa.com, alsa-devel@alsa-project.org, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============1235415427895378522==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CQ3bIqlPgDWyQ28b"
Content-Disposition: inline


--CQ3bIqlPgDWyQ28b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2013 at 02:04:06PM -0300, Fabio Estevam wrote:

> As the sgtl5000 codec did not go through a real reset, we cannot rely on =
the=20
> reg_defaults array, since these are only valid after a clean power-on res=
et.

> To fix this issue, use 'reg_defaults_raw' which tells the regcache driver
> to actually read the codec registers and then fill the cache.

No, this isn't what raw defaults are for - they're for cases where the
power on defaults can be changed (eg, by setting pins on the board).
If we do this cases where we rely on defaults actually being chip
defaults can get broken.

--CQ3bIqlPgDWyQ28b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRi2zCAAoJELSic+t+oim90BAP/3Hwvm5qJkFSvu9SKnwxoir1
8Ob9clw1pkE+DPN3g4tYrwivjtH78yrgNc1Vf9UuGaSHwmZOi/Q2IBmkfYXEYlcn
8oni52z6skFnKk68XH6PD41xTADxa0wunp4qHmuOUQg8MdMmQ3uVSKKk81zD1e2v
PzEyIgNUa54Vu2wbW+8LrFhJk162K5Jsb2/32+i4yTZLCnDCz/pkTNMPZ0IZnWLM
aPw/B0HsghIgQqpG9/QTX5mSn2TifK/wmCxPHdbrINFUUCxjgxR8fL7vpUefzZ/u
TLiHNFCZURt23ex2XCED+TUytdMJOv4Yq7DIU4qvZAwkQpFCRsFOK0E0UA3GF1DF
FMKmhQJUV+yg+UDgn84AVqWVVHgoKuik8+UxEJqZqd3JL6BhLNVSF38tzQyezDaF
OFcTwAwFm0XDBJxQniRAciYW7So12dFnFio3ht2rdTqNzQSv2AbEyf8Um/Is/cx+
B8LKdu3lpVJUQ/djYI1K2BFeiD8KCrzqDkAhwBxaKkg74lyPAPFfsxsyUj5I0cV8
zaZOmERigm5I/iz3sQugP7jAvSh3Y1dxN/nGAPZ9hmx2lTIUNNrr2vCQDLuFszBq
u6B85t9Qfg2Z7GVwJcGX+DQtvrnsVgFW32m6W+qgwNqGXPyMAQLeXKwq4vqH7mF5
MuSmYrXAt1lLLY7jbzcX
=8+kh
-----END PGP SIGNATURE-----

--CQ3bIqlPgDWyQ28b--

--===============1235415427895378522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1235415427895378522==--
