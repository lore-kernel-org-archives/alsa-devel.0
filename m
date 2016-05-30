From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/49] ASoC: add new simple-card-core.c
Date: Mon, 30 May 2016 17:22:08 +0100
Message-ID: <20160530162208.GT29837@sirena.org.uk>
References: <87lh35rs8w.wl%kuninori.morimoto.gx@renesas.com>
 <87eg8xrrzm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3T2jnoiI0lx9XXvh"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87eg8xrrzm.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--3T2jnoiI0lx9XXvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 20, 2016 at 09:42:25AM +0000, Kuninori Morimoto wrote:

> future. Maybe it want to use simple-card like feature / function.
> Because of these background, this patch tries to create
> new simple-card-core, and provides common function to each drivers.
> 1st is asoc_simple_card_parse_daifmt()

This isn't really a core but more helper functions so should probably be
called -utils or something.  In the past we've added helpers to the
core, though this particular one is obviously a bit different as most
machine drivers should be expected to have the formats hard coded into
them - it's not something we'd normally have in the DT since it
shouldn't be varying except in the case of very generic drivers like
simple-card.

--3T2jnoiI0lx9XXvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTGivAAoJECTWi3JdVIfQCSUH/0AQXK7oK2heaDtGAFmfSC+3
8BC6g3O11ZuR5HGswUz2LQXZX1AX5bkdjw/+gdJJjZduD6irfpYzVCsZs8b/DTJv
dugn/Xy0gJ2dQZU8kdKk6UC1W+QTqjVxKvcL6ARiLPr6ISAe4Ov35TAv75v/a4d8
b+zb7b0/Q92KlgDXDDkOcs/X6gwYkKbVOfj/WXAxz0lZvspfJ4CtdyphIg/h5uFN
G3X+Tgc+21tdUoy4DvYTBWh2lkulZYllgA7lDzLx7Al2PKc1emE7xWr2WG0VKIyN
VIT7VdFl5r98rZEv9GEYCeRD9H24RCKsmz9tcjUARMBVFtGISipik6zKGHqQ7ok=
=GEQg
-----END PGP SIGNATURE-----

--3T2jnoiI0lx9XXvh--
