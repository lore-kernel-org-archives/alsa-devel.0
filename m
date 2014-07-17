From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Fix SOC_DOUBLE_R_SX_TLV volume
	mixer arguments
Date: Thu, 17 Jul 2014 19:59:34 +0100
Message-ID: <20140717185934.GG17528@sirena.org.uk>
References: <1405621015-29017-1-git-send-email-brian.austin@cirrus.com>
 <1405621015-29017-2-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6668378630542028744=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A357B2655A6
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 20:59:39 +0200 (CEST)
In-Reply-To: <1405621015-29017-2-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com, ryan.harvey@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============6668378630542028744==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j6Ejlva3tMw3xXYi"
Content-Disposition: inline


--j6Ejlva3tMw3xXYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 01:16:55PM -0500, Brian Austin wrote:
> Remove unnecessary bit shifts.
> Correct min value to match datasheet.
> Num steps = number of steps between min and max.

Applied, thanks.

--j6Ejlva3tMw3xXYi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyB0SAAoJELSic+t+oim9bLsP/09e1qr04I2pm8HDkrEX8cLo
5U8t2j/HhO+IvSb2GrY77Q0uTpmImas/aoSfoXBXi+riETK75uBQrj+6roNDiomN
rmVzMDZJijMs1I78NzQZrpBTUkFs0D9eOwpArKZ5Ojp7be9P9u6j8uoOyqhO25NO
E1qjKkFJqlZ+/5lPYWb+djGoB0a8sxnuZiUXGn6bP3Jycmeu44PbAH/7ZhN0PoR7
+/69QQ57H/VMbQHc1rP7JWYUKDR/7oByw4ixGNbmGcVkmcJ0ymdEDYbKxQYF+4ZP
Zo+WsmCoXaNXbhAQwPYPVCPSJ1wn5q7MZZxUpNbFsizke66ZenOfpbuJatElSRmg
1lIZNzSmrXJV8xh5ixDlgVDoSDVjQT+K+GOuJrKrDh6o3quaY43D7u8cUrR0r1XD
6FjZWm4X4uuYVIMZ7Zz2vSu9FYM00kvj4zHU1HvRAiio4v1wHi9w49AoCyw/pRqn
H4ckBXImQMdiJXJaGUTqMYTR0CAFxi4YyxQxlk6bigPLhvEIxkXj7tgmv3uE84hl
KSceZCneHG7z5sqoW0o0syaHT2n7PyzD+DSOFRronMQ7pKxNbzOEkasweCqo3H6N
05YUNmZfTWiA4qYZqX/Ndgqw/RMZ76ERYBP1xvuGU5KYNT0GNqTRs1X4Z8D7wBPm
Y8pvM3PBSPiXhqd/NXBq
=Wxhx
-----END PGP SIGNATURE-----

--j6Ejlva3tMw3xXYi--

--===============6668378630542028744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6668378630542028744==--
