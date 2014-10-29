From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: remove unsupported PAUSE flag
Date: Wed, 29 Oct 2014 11:03:13 +0000
Message-ID: <20141029110313.GD18557@sirena.org.uk>
References: <ebfba8c7cfed4909ad23e63899dce37c@SG2PR06MB0444.apcprd06.prod.outlook.com>
 <14c90bfeb435473dadc9e4d3251c9f65@HK2PR06MB0419.apcprd06.prod.outlook.com>
 <87lhnziubh.wl%kuninori.morimoto.gx@renesas.com>
 <b1b3c40db17d47f79355ba7f44d0f21f@SG2PR06MB0444.apcprd06.prod.outlook.com>
 <87d29bcymb.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0947614617326037991=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B8732604DF
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 12:03:38 +0100 (CET)
In-Reply-To: <87d29bcymb.wl%kuninori.morimoto.gx@gmail.com>
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


--===============0947614617326037991==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VRDXsl/NVT4k+glJ"
Content-Disposition: inline


--VRDXsl/NVT4k+glJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2014 at 09:02:03PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> R-Car sound doesn't support PAUSE.
> Remove SNDRV_PCM_INFO_PAUSE flags from snd_pcm_hardware info

Applied, thanks.

--VRDXsl/NVT4k+glJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUMlwAAoJECTWi3JdVIfQC6cH/2Vc53Mp4QhEjfavQ4vBNUFP
DyE9xHwn/WUc80hfc6NOXs9W9X1QINQNkL0lGjEFOCHQTtlY2iSUnDDQZTjaVlov
x0GHB9qyWawsoNHNkRrh3GXuU1aLwnWLNVVFhzzAaJjHIB02xmj93mCBNgWNGMGe
j9k1To3MK6o4DHvqmxOOFJOpdDkKls2wcWUxv3PQNOSjQdi2b6NewvADXD7DMVoo
oSZzu9ikNlJS7Fnz4DRZ7hUcIi3FZdGep1Z2VgNkSLEuU3dcThTQ0FAdl/FlBnPC
ntmxBUL+VJxnynRPAZE1yJlk1/AKfyAFVpeMFEVs2GkT4fhpv4SoCDhL5XCyrTc=
=iCfq
-----END PGP SIGNATURE-----

--VRDXsl/NVT4k+glJ--

--===============0947614617326037991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0947614617326037991==--
