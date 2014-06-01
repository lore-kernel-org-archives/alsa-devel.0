From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: dapm: Add a helper to get the
 platform for DAPM kcontrol
Date: Sun, 1 Jun 2014 20:28:06 +0100
Message-ID: <20140601192806.GR5099@sirena.org.uk>
References: <1401357817-17942-1-git-send-email-vinod.koul@intel.com>
 <1401357817-17942-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2856846695628659729=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6800265475
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 21:28:15 +0200 (CEST)
In-Reply-To: <1401357817-17942-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2856846695628659729==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y08JZfPv7c5uulCx"
Content-Disposition: inline


--y08JZfPv7c5uulCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2014 at 03:33:37PM +0530, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>=20
> commit eee5d7f9 - "ASoC: dapm: Add a helper to get the CODEC for DAPM kco=
ntrol"
> introduced helper for getting codec for DAPM kcontrol. For DSPs we need s=
imilar
> method to get the platform pointer while handling the widgets.

This is fine if we need it but hopefully soon we'll be able to just use
a component for everything instead of a platform and so it won't be
needed at all so I'd rather wait until there's a user.

--y08JZfPv7c5uulCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTi37DAAoJELSic+t+oim9odMP/RiZfgKtm2WqGNXdFXXVLq+N
3rlnmrH9UJK7xrfDytnoJWwyIh8JKisrWYXbyAJi3iN/ztixltI5OugLJlzIZdQZ
xGiwM3aaANWQOSgLi3iO7+IAuwSHnz8ynHVfYEpnTsjZ5J1wIYCMg/R9+ft5e4/d
UcdM3ye+Y/TwZ/qlkr9J2VZWoBCV/HVJrcz92swKcFhtekoyqOhJU5w8WxG5v9no
wmFSaw4/N334SXzV1Pz+HuEmzq1fw1HCKItnmRx7hYu5qJeRM2pA2ohZLmmi4X6h
cHw7/UkIKbMVNbUuhR9Isc2lyfP53hnAZOELXpznitOyiJ319K7niY7L//KJSDY9
OrQarcGOxZkLTQPJ5zimSGgni3kzjy2oqDvBUE6j9p+ZU7a7ZF9ayoXv2hTIiV2L
s/CsRSH7ntv3OajE2R0NPslBIacp2V7dGuXQP0crGsvsGNG2OABlEHGEHV7SLDx5
KZ9TjFi6v2bD08wQ1TnuU3SjIY9gLNkCAURuxJA0/mmBF/qMTkS2z7LpY/UwAoq/
lwbnNZa8smoZMrZp4pmTJ2memf9QmfJMXqfcPCFYdFNiBjw96U1nY4zXHf7D8jjv
NTGDeIfrssQdYwZyf+YOJcR0dfRq7oDFkajpRye9x3512laN+RV6EPZPL4sR3Adx
IMOBZEpsaW3oaF0pLj2I
=knuA
-----END PGP SIGNATURE-----

--y08JZfPv7c5uulCx--

--===============2856846695628659729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2856846695628659729==--
