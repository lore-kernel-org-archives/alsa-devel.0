From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsi: remove unsupported PAUSE flag
Date: Wed, 29 Oct 2014 11:03:06 +0000
Message-ID: <20141029110306.GC18557@sirena.org.uk>
References: <ebfba8c7cfed4909ad23e63899dce37c@SG2PR06MB0444.apcprd06.prod.outlook.com>
 <14c90bfeb435473dadc9e4d3251c9f65@HK2PR06MB0419.apcprd06.prod.outlook.com>
 <87lhnziubh.wl%kuninori.morimoto.gx@renesas.com>
 <b1b3c40db17d47f79355ba7f44d0f21f@SG2PR06MB0444.apcprd06.prod.outlook.com>
 <87egtrcymo.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4142671613180843093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6986A2604D6
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 12:03:32 +0100 (CET)
In-Reply-To: <87egtrcymo.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, JUN WATANABE <jun.watanabe.ue@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4142671613180843093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1U01N4NmGZxaG3tl"
Content-Disposition: inline


--1U01N4NmGZxaG3tl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2014 at 09:01:53PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> FSI doesn't support PAUSE.
> Remove SNDRV_PCM_INFO_PAUSE flags from snd_pcm_hardware info

Applied, thanks.

--1U01N4NmGZxaG3tl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUMlqAAoJECTWi3JdVIfQ+6IH/Re7CSy1Pg891AzniYGNs6f/
huWvNYa741aUyatqNtE/z9G0L8TnJJ9Q7DfQV6lk2Wfh0uk8C2sz3idUhKM3mMKF
17R/llD1PxAQ/ZzNyng5FUUo7bTYha6fgNLp50CtFm/Vxu/z2GNcc9DIxWjag9xR
WInCcBQ8hFRxj3x5u8XZXFlwScF2OdZTRLCkg1uUSWU8BuIfytrEWmGFRJCKerWy
rlVE9BwgtPdnEW5wG5dzPrOThcN9+9LeG5MWhVUynHoIJPPfixszCXGz4aUnshBC
nPAFvTWxt7Ja/TKAR/7qTOhjxyyvQ62/kA0kECVb5RaE3UXpxy+ygEr/tyiWUIQ=
=vtnn
-----END PGP SIGNATURE-----

--1U01N4NmGZxaG3tl--

--===============4142671613180843093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4142671613180843093==--
