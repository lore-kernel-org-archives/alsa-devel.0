From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: soc-core: indicate unregister
 debug message once
Date: Mon, 9 Feb 2015 16:27:28 +0800
Message-ID: <20150209082728.GG2593@finisterre.sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87iofj7qhc.wl%kuninori.morimoto.gx@renesas.com>
 <20150204205503.GM21293@sirena.org.uk>
 <87a90nwlur.wl%kuninori.morimoto.gx@renesas.com>
 <877fvrwlt0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2964690102020330455=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACF49260438
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 09:27:59 +0100 (CET)
In-Reply-To: <877fvrwlt0.wl%kuninori.morimoto.gx@renesas.com>
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


--===============2964690102020330455==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2015 at 08:05:45AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current snd_soc_unregister_card() indicates unregistered debug
> message when it was called. But, it should be called only when
> it was really unregistered.

This doesn't seem to apply against current code, can you please check?

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2G9vAAoJECTWi3JdVIfQNN4H/11yWD90xAOmYideaEMroLXK
ptILpQIXmKzN1liLDzoHG/FNIP57G04M4zgOK9Usgo1smkO/gAtDrWxVorFA3R6b
SACl5LarJNI5Qt1WD0gjZpKvUSb5S7IkG/dzxzOgY09ULbiNaQZHPsNO4Gr350zo
2oETVlSNT61XlRsU8FtAqJ7qW9a+Ib94eTeQ2akL8l9FX35XMv2li2SVXroURrge
BlJrb35pjpWEDjgm4/F3EMCScc3L7l77FD+1IHcrdwDYkaRv/dUM1VtgQz44hYvP
Ysi/ZoYHNbXztfJ2wvhSPjNfDOsyfBHuRZaH2itR50m++QVVNmmvdbLpov9TLWA=
=KP7z
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--

--===============2964690102020330455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2964690102020330455==--
