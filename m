From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: add missing dev_dbg() in
	rsnd_bset()
Date: Thu, 31 Jul 2014 20:37:12 +0100
Message-ID: <20140731193712.GS17528@sirena.org.uk>
References: <87d2cmuiin.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1447822095624023592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA71262631
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 21:37:21 +0200 (CEST)
In-Reply-To: <87d2cmuiin.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1447822095624023592==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dYsPnCVH0s/ug5Kd"
Content-Disposition: inline


--dYsPnCVH0s/ug5Kd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 11:52:50PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> b8c637864a6904a9ba8e0df556d5bdf9f26b2c54
> (ASoC: rsnd: use regmap_mmio instead of original regmap bus)
> used regmap_mmio and modified dev_dbg() for rsnd_read/write().
> But rsnd_bset() is missing it.

Applied, thanks.

--dYsPnCVH0s/ug5Kd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2prlAAoJELSic+t+oim9wkcQAI7uJcbp0BHqYYVHiPOARRyN
lFnQGn93v0zWMsbI0gXAvcX9jjXFeZUrDNp/dRPnQsUCKcQIeZ2Fn65K472na4fd
XxTwBJoQSN8lb0QfcC6XhSP3IkSAlymCLGFKoOk35NM0FwkA7bmrfZgMl1dZ5S3s
3p1BM56O3rL3XWYDqeEI18tb952+0215BtKnFlYw6CWMh22DYinM1/N7F0/2CcB2
kvYi5Eb107KfbshAWmQ2Ti5sqdk7k63djw0QbsLk+aUl4vdj382/jPo+uBoh4TaT
G36Zpn3JPeBpZwOFuqS9PYjxRCJi6WuaCtKhDw7a2TkrLASGgdYqraF1oIAojJ/e
WTHnluy7UI3AXmQ4MutpEKJkj31YRoz1jz28VWSbFX1z1pTIFNpsWS4gF9u1XG6j
G5/InrFZ4c6iPKCFSKRq6Qmq+uE1HWghQ40i5gDaDSEv74mcbD935HJgPXA0avOh
06al7XOyRR2ptKfgXPuJIke4HR+YVzcKyZpTkURwmaX7ZygqdktVHYnNjKETmFAD
91KQ8O9xrU6+VbVPcFj4AGwvPpr8Ii2rH66i2cEeLE6kF7Lm9TB3Sn13sjsZpEwG
4BwXa9yj0lXI8QnR8SqQ5qCBsoyIIIBiYul/o2XSRizjk/mz9084gmP0LYOaW9fW
y5lDoA5L+k05SzdgSfRJ
=qigM
-----END PGP SIGNATURE-----

--dYsPnCVH0s/ug5Kd--

--===============1447822095624023592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1447822095624023592==--
