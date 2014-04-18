From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5651 CODEC driver
Date: Fri, 18 Apr 2014 18:55:11 +0100
Message-ID: <20140418175511.GY12304@sirena.org.uk>
References: <1397647246-9389-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3065337343057149639=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9207265189
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 19:55:23 +0200 (CEST)
In-Reply-To: <1397647246-9389-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3065337343057149639==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8FlLWydl2jPUybRo"
Content-Disposition: inline


--8FlLWydl2jPUybRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2014 at 07:20:46PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> This patch adds the Realtek ALC5651 codec driver.

I've applied this but please look into opportunities for code sharing
with rt5640 - there's not quite so many overlaps as with rt5639 but
there are some.  Can you do something like the Wolfson arizona code and
factor out things like the hw_params() into a shared bit of code for
example?

--8FlLWydl2jPUybRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUWb7AAoJELSic+t+oim9prsP/1ywicQwZlVv15PUCF+ZR5fK
byjTOpnQv1LRb1YtoXjxOX1a99HaP1hRiU/rSyu0pPAb+YqSymVUuNR8uFq2DjS/
TSSQ+IOoCowIoh76zffykSDHZQfgpEZQIz1+aIndQ9T3cqtrTk8xBksiC6MqVFRf
hbxjSDQI2+8Qu12Z4XbXrMRuNa4yHgktP0skx2cLSLozjeYAcWBuf8AQqzoTPDBC
vEnKkUIFcDXgIlunnVHbkox3kKzHe5MLJMsN5FV/CcHsWTCZGd3CTG2DlGF1XZZ4
nLh8CU5qqWsaYdbWIreM/YwXEgU8iVrVZK1hjeiilE+sB3aCVomXNVjyWqOwFuBJ
QhJ5mHD8RprCDwhOep+L9e+08NWtYSnwOPS6grGnxWscvNiMVgLBwMXj8vksOjpD
YsKoZLDcw9E1l+Jbm4srpc8+iZkWzczhYaNmrlfUrXu913iJQvxX5i8ZjZF73wa2
IPztSVKaDkgJ1LK3BK1nsg4PZZk0wxF+wKKX044sBT0E/FN348UEkQAyXEEaJ8D7
hj1o6n6GNhS0GKj7Q3EsJ/sqWgBerXV6aO46DkXWymM6ebe/whwIcHGftHfKS6p1
PB7eriJIBBjLSci4a25aTmbaRaVjTmmQ3++SclA1vyWCOO+IKbJS2Aps/vWeimAv
on2r22WY5+ifBBBCylKP
=1CU7
-----END PGP SIGNATURE-----

--8FlLWydl2jPUybRo--

--===============3065337343057149639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3065337343057149639==--
