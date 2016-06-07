From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: adg :: AUDIO-CLKOUTn can synchronizes with
 L/R clock.
Date: Tue, 7 Jun 2016 11:54:18 +0100
Message-ID: <20160607105418.GS7510@sirena.org.uk>
References: <87oa7dtti3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dQ2XShfnd5GHxhN7"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87oa7dtti3.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--dQ2XShfnd5GHxhN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 06:21:33AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> AUDIO-CLKOUTn can synchronizes with L/R clock, and Salvator board
> needs it. Otherwise, specific frequency sound will be noisy.

Why would a user not want these clocks to be synchronous?  A lot of
CODECs will at least have better performance if their master clock is
synchronous to the audio clocks so it'd be a better default, is there an
advantage to not doing it?

--dQ2XShfnd5GHxhN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVqfZAAoJECTWi3JdVIfQ9+UH/AtRat4T1p40EOeIbRog5Uta
xxm9vf67ONbc7epr5eLRLcyVp06sy/X5cuRVw1wQwNg1nPKcn83JiAId073TnSQD
sFCd0DOy3t75+7GgLCg2USnEXPADfTRLdwraacJR+YgSSNVyiVPJFIbRbnYRU8wn
zOhT3lY7ab6R3CkYfI7MpBf4072eirPoUgCccahIQsyVLS1okV3/310mmdovn6HQ
lL1Mu8yJsgUgP5oadZZt/eh2kqLXLxqM5jrjagWoU785dpSRcRekO4Fbk+0hbkkZ
hS/4DIX5pzITUA3J7jFfRRp8cGuEIv4MiN37o5G3kSAzlE8tqcjoltZJH8Bogt8=
=6wW0
-----END PGP SIGNATURE-----

--dQ2XShfnd5GHxhN7--
