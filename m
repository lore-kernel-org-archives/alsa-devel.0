From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 14/49] ASoC: simple-card-core: add
 asoc_simple_card_parse_dpcm()
Date: Mon, 30 May 2016 17:47:15 +0100
Message-ID: <20160530164715.GW29837@sirena.org.uk>
References: <87lh35rs8w.wl%kuninori.morimoto.gx@renesas.com>
 <871t4xrrq4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kjzasy1UhXmRStS5"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871t4xrrq4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--kjzasy1UhXmRStS5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 20, 2016 at 09:48:07AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> simple-card like driver is supporting DPCM FE/BE.
> This patch makes this method simple style standard.

DPCM is very much an implementation detail of the current stack,
providing helpers that promote its use doesn't seem like the best idea -
we want to change it for in kernel use going forwards and that's going
to be harder with DPCM.  We should be encouraging bindings that make
DSPs look more like CODECs.

--kjzasy1UhXmRStS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTG6SAAoJECTWi3JdVIfQxyIH/iEBerA7cmRJkGh/YbyGSlV/
7EEMUbV314xHQR0x6yqOQqzaTp9YDxEGCdU8BZJ964iO5XJKiNfM+4IaQTKFprHf
xa9ri0rmLCPSCVU6DXLx6y8l49YAvTXxAwqfHCpmZJutkleC/bu8R0iFDGEqR8eT
3Wx8TVLsfR2t2yl2W2PxBQmZ/yrOdN/ua8DpAhvTozH5EuXZSJoGFpNxw73KX3vK
dSc0mYkS56jS6eNZfYfteeG/JG4Q3p7mlEd6zsG7/Yo6bmtoseV5LhmXBctc+ht1
5t1EwxxW0OPQpY5vBvYkDQ1X2za/TRtji18YqWbrCoAlQhE2Iia3WyvJEMG8Log=
=1fLv
-----END PGP SIGNATURE-----

--kjzasy1UhXmRStS5--
