From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fixup pcm_new callback method
Date: Thu, 31 Jul 2014 20:37:26 +0100
Message-ID: <20140731193726.GT17528@sirena.org.uk>
References: <87bns6uiia.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6793431321986122572=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5D272619FF
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 21:37:34 +0200 (CEST)
In-Reply-To: <87bns6uiia.wl%kuninori.morimoto.gx@gmail.com>
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


--===============6793431321986122572==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nMMm0HmtHvBQBrqC"
Content-Disposition: inline


--nMMm0HmtHvBQBrqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 11:53:03PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> bff58ea4f43d9b4a9fd6fb05fabc8f50f68131f5
> (ASoC: rsnd: add DVC support) added DVC support,
> and it added pcm_new callback feature for it.
> Then it called all DAI's pcm_new callback, and it was wrong.
> This patch fixup it and call correct callback.

Applied, thanks.

--nMMm0HmtHvBQBrqC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2pryAAoJELSic+t+oim9UwkQAJry1H6ZCq5UwfK+gBGhPo88
9cGbrY/wulauzZe6ZZS7lvSk/zljAsK/36YVw45aZKj5Iy/MrrPmx1CbR2Qh0rAT
cvP73LxW8Z5YP8Ux0pIo10FLVYRVdAulAUSZ8N4B/5ZECMqA2tqY2pbvHRrtUYYz
r+atIqX1KlFc1FZnBliMf03GD/mjQ7sCKk6uOA0p+Mb6kFShci/UhTQGAo0U3g6G
6l+29vW4r6ZDHaSKZvEqt51I9citTlmSqOQ0/Mi+4afRYshFHXuNtZlO1orfmTy/
DXhT/wYZDP+DX0bkkmh0rubbFkwNU1jkdgKIEia635pkhxnX4gXltTaINNN3gpqi
QiSpmkwKNbAQmPHOSGjCJyp62bNHe14dlqzWvn4SsStdOwkTCggVOWDQk4K7WWa6
5tAfDrjW0wFTHmniFOnkbxfwjRF0ixjgERapvcMTRRLgtsj1WUOOUM+VYkHP681Z
JUL74hGGMjRsvTeMqA8Vwn6TJ1XyprIGso3P6WunmHrTGHBdG0D3o7/evOFrvV6s
s95moSNV5lO1tU6jT8gXOEKY47/vbxw9ggl2BRMoxzYFfT2pd4rzviDIIsl4GaP5
sWvPoFxIvimpvtwRP1gEhJZ/egP1uxWfesbKjHF6Fyes2D9ZYb748VqEBSsrEI5G
UoOYoGvkhfErlFcgClGV
=c2fQ
-----END PGP SIGNATURE-----

--nMMm0HmtHvBQBrqC--

--===============6793431321986122572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6793431321986122572==--
