From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: call
 snd_soc_runtime_set_dai_fmt() before soc_new_pcm()
Date: Fri, 10 Apr 2015 16:09:37 +0100
Message-ID: <20150410150937.GK6023@sirena.org.uk>
References: <87sic871ut.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2051320785839336930=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5880226065A
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 17:09:47 +0200 (CEST)
In-Reply-To: <87sic871ut.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============2051320785839336930==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nQL6+q0ki3qA3u+D"
Content-Disposition: inline


--nQL6+q0ki3qA3u+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 09:47:00AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current snd_soc_runtime_set_dai_fmt() is called after
> soc_probe_link_dais(). this means snd_soc_dai_set_fmt() will be
> called after soc_new_pcm().

Applied, thaks.

--nQL6+q0ki3qA3u+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJ+ewAAoJECTWi3JdVIfQ5F8H/0ebaiGlLZLYRoV6MD+9JnD3
doTlEOpaMM4N5PUez9ICwSx1IfeOb/at0hsbJVYDo6Gt+UDSN4/cXJJ3XbPp0/Ms
wGzwkL1DHZHzeiPQYe3mHYxmzgxRAWQzXv/kNgNlEX8JQPflpy7bq0PdyBQ/frkt
YhxHAn9Xa0IP9rj2nojU6pA0e1YyPP28UJ2DnjmSa31kC1CbC7z/+yGYCGPRM3sE
oA/TCa6PWW3TRUBMeNFLuvAcHrFjs/XLz4+QgcsRvXIfHds6uewcG/nqw/msIlBd
mEIObjj7sEQ5gau+HSt35k5BXEXxbmdI3kYNUlPrPJHghs/JrervemLMbEFPcNI=
=jQCR
-----END PGP SIGNATURE-----

--nQL6+q0ki3qA3u+D--

--===============2051320785839336930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2051320785839336930==--
