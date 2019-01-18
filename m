From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: soc-core: add .num_platforms for
	dai_link
Date: Fri, 18 Jan 2019 19:15:21 +0000
Message-ID: <20190118191521.GH6260@sirena.org.uk>
References: <87munyu343.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1962724396742954589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A3046266AA9
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 20:15:22 +0100 (CET)
In-Reply-To: <87munyu343.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============1962724396742954589==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 11:22:00AM +0900, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current snd_soc_dai_link is starting to use snd_soc_dai_link_component
> style for Platform, but it is assuming single Platform so far.
> But We will need to have multi Platform support in the not far future.

This doesn't seem to apply against current code, perhaps it depends on
some of your other in flight patches (sorry, I'm a bit behind on review
there)?

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxCJcgACgkQJNaLcl1U
h9AUCwf+Pc8UkuxBgWkD//6t8Oa4DcXzfgJkwESK0StbfSMBcRUpgZO6hU3Iu+SJ
QZl67UNfE5RlaZi65hmcxp/1/Ypw59ekI1E9TvaCkB2WDyJGTtAfiNnWXNn4Xx8b
bILZWJfOFIaTlVQe/DDxKVkkNz6//e3f6UGeM4CIvjlDYR3biklEUmkWE5E1ccGf
sVaLtJKqQXEOLwInQkRAsVCfYPboNAnMyry72dJOCFeKq+a4+yGEpHFFQGXW7KRb
Gm9dpqzlX3GXBFnIpa+nlM5EYaPMqoM4bzt1WaxTbxagU3Ij90zu3D2jGgNtfaAB
TnQfHn6C6GqnL3nyN0brdm2uT3ymig==
=Ek6x
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--

--===============1962724396742954589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1962724396742954589==--
