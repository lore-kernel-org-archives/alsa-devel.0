From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: soc.h: tidyup struct
 snd_soc_dai_link definition order
Date: Mon, 27 Apr 2015 21:13:27 +0100
Message-ID: <20150427201327.GI22845@sirena.org.uk>
References: <87mw22ufs3.wl%kuninori.morimoto.gx@renesas.com>
 <87lhhmufqy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2626007522516733336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DCD926041C
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 22:13:33 +0200 (CEST)
In-Reply-To: <87lhhmufqy.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2626007522516733336==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6h+O0esyKQq61JWK"
Content-Disposition: inline


--6h+O0esyKQq61JWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2015 at 07:02:34AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current struct snd_soc_dai_link has many members, but definition order
> was random. Especially, bool / bit field are defined randomly.
> This patch tidyups these definition order to calculate data alignment
> easy.

Applied, thanks.

--6h+O0esyKQq61JWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPphmAAoJECTWi3JdVIfQEFYH/2FNUl62W2L2rCdTTiP/j5Lk
1yWx/GTIXyDCKzdUeUAGJFIONHDcSTzsKQmtrsFI+j+uWKgsZRPt6kZwf8x+zpsH
WUH6R4HQxGPt+IEvrRIoCd4kkFr4bRNFf+Z1lniakp+fK5mJ/XKlFFQYQPQtXV9o
M4ANfuTLHzyZC8EKFnBZ7MOtPprYfT9eIDpC3+/YA7ycLRK0XspsRTOCEzsWvfaT
I6EQBIVTFCO5xwHAgMSje++tbF3/Ak5Yb1huBtukjl6s0QbUwcKDJP89DWPyvCUA
Gbe9wlfm0NTm7eMp+LRJPWZy/0YIFsejNpAtVM+eIV4Qyx7grBAkDdd98TwwceM=
=qVDJ
-----END PGP SIGNATURE-----

--6h+O0esyKQq61JWK--

--===============2626007522516733336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2626007522516733336==--
