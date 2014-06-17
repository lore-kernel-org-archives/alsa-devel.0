From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: MMP audio needs sram support
Date: Tue, 17 Jun 2014 15:31:12 +0100
Message-ID: <20140617143112.GQ5099@sirena.org.uk>
References: <4367111.vzeoBg4u5h@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8311851810962764489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1CA22654A7
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 16:31:30 +0200 (CEST)
In-Reply-To: <4367111.vzeoBg4u5h@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, lgirdwood@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8311851810962764489==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6pQrL3WnLTXWajL"
Content-Disposition: inline


--L6pQrL3WnLTXWajL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2014 at 12:40:04PM +0200, Arnd Bergmann wrote:
> From e7a94bb7fb871c73cc85712d89c1f48d0271c1be Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 5 Jun 2014 12:31:28 +0200
> Subject: [PATCH] ASoC: MMP audio needs sram support
>=20
> Building the pxa/mmp audio driver without support for the mmp
> sram driver enabled results in this link error:

One other thing here: please send patches in the format in
SubmittingPatches so that the tools can apply them cleanly.

--L6pQrL3WnLTXWajL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToFEtAAoJELSic+t+oim9Zh8P/2NXkpyGhNRWJKDG8VrJNkpw
5WjTMa1jWgk5hYssZEuQmU7ndk1tMx7G+CbDeM89Q/qNjYzz4Ypg/qn0DJULxHeF
w2QqymG8g5EodoxDbLQDIIeXq3G7Ayom09Dw9LGAKx83aWwe4YPU84pA6bqrbSNH
f1KAzzD7mQxpNoDTl7W2/bzJKd/4vhZ1HkKgz04dCPFkkFsWxjnV3ifJAXq7Al0a
vzsVIErXaKZ5cmzSG76Crc8cKkgnH+ay6lzEUMSAkxI7gRlKlQjE2q3G6sAZ5/6a
Dy46iGf0K7aXUCzdQHaMVTiQP6lXVcDWap9lVwPF7JAIR0SPxgi/XIG7c38NzQJY
a3tq0/6/+ZUQplrMFRqMQtb4/fsvguVbEHrgD9hNtLhECZskpqe7Qj1QBFB1TKq3
NRF9drZI5Mjos8QgxBZbG39yAUSePlsgnv8Hqf6fyNQ0D4Bu4MsqYJxkl3RMySZ8
oaTBTnqsjZt+HErr0fEyIpNs2ghT97HEV74aM3jLNM6+zdMidsc/8r1nPdX3YEVF
x6pBxBzWevZE8Gbp56BQT/vtEpllwGIiFk+z3MiPYYrTGE/pj9eDVVJP5Jcplmgr
jO7REANET9AGAu11Kq++iNk5TFt8WgcfJd/+9yo6qGLIWSzj5qVbGeEase8K0ZLv
t0zVTD0TMHz23f3otsna
=fHCG
-----END PGP SIGNATURE-----

--L6pQrL3WnLTXWajL--

--===============8311851810962764489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8311851810962764489==--
