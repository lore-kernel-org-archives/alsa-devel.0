From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/27]: ASoC: rsnd: add Renesas Gen2
	DMAEngine support
Date: Mon, 27 Jan 2014 19:49:02 +0000
Message-ID: <20140127194902.GU11841@sirena.org.uk>
References: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6505208206321739074=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B497261A80
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 20:49:08 +0100 (CET)
In-Reply-To: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
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


--===============6505208206321739074==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JcGvecxLhm+LytDG"
Content-Disposition: inline


--JcGvecxLhm+LytDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 06:36:56PM -0800, Kuninori Morimoto wrote:
>=20
> Hi Mark
>=20
> These are Renesas Gen2 DMAEngine support patches.
> #1 - #26 are cleanup/prepare patches.
> #27 adds Gen2 DMAEngine support.

I've applied all these but as discussed please do work towards using the
generic dmaengine code (with extensions to handle non-cyclic DMA) and
DPCM.

--JcGvecxLhm+LytDG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5rgrAAoJELSic+t+oim9dVIP/1MvYSjB4sa/yzudDwTECD8q
IYAjEGPbmFFOQ9dAI1CWxCV0hG/K9hoq8yjTYTDSzhj1FhdJVBcerHyr/sZ66aiY
axpWneWOjDIwNAgpPpQXW70BHwciL+qYDkCYDPoHKMa503lRnH87QTM4BoHDRabN
uk2YpU/27Ikm4eSZUtM4l/DpOCIevl5+CCsiWPPjyxKvdKBAPcXta3f3P/3VJIyo
+LGWKfZrzlpRN/9ImhEVvqu1SciD1cdiDNWwTqHlZNMgQpdHsSfY5HQ1rNu4Ctxi
QC5LXVN+xG9sCYh774xIcPhUOUk/Rr3j3HIpFg1ixy5sUGi54R6wxou/ldpqX1el
xhrYvyc8Vd80uxzXRTu+bMwTbXu00m2UeBahUsGn0Xgi/9TMomKwAhCxNT2AnAW0
FpU/V1aZUybXwjDAGqAayuwOT6c6961EHON97eWS4vWSi7qD/XldOYKGuFjTWhxU
NkvbGPJ1JxqmKCd36MgtrivXg8k0F9IYLE4+4aXkkYRi1jpLtqCw2IBGjfC/aMgn
QvIMmDs95yNQvmQDBkDiv5y6zgGbPJpFu/cv6ni8c7nhbrGzpKpk/0wSdAtrtY0W
XezlJ88uAJT2I2wPNDfl1/NTx3UXannqMkQBkLY2GdTSXPtPigp4CSr6AIoyoonq
nhqQFhQbvvOk02vcG/rl
=5bCJ
-----END PGP SIGNATURE-----

--JcGvecxLhm+LytDG--

--===============6505208206321739074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6505208206321739074==--
