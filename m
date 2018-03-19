From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: twl6040: remove duplicated remove
	callback
Date: Mon, 19 Mar 2018 16:43:28 +0800
Message-ID: <20180319084328.GJ2186@sirena.org.uk>
References: <87d100tsjh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6181503835225812631=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0120F2672C0
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 09:43:35 +0100 (CET)
In-Reply-To: <87d100tsjh.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Julia Lawall <julia.lawall@lip6.fr>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6181503835225812631==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="94Ornb/7sD1MvElF"
Content-Disposition: inline


--94Ornb/7sD1MvElF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2018 at 07:50:48AM +0000, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> We don't need 2 .remove callback

Copying in Peter.

>=20
> Fixes: 7480389fb0d8 ("ASoC: twl6040: replace codec to component")
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/twl6040.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
> index b56a647..bfd1abd 100644
> --- a/sound/soc/codecs/twl6040.c
> +++ b/sound/soc/codecs/twl6040.c
> @@ -1158,7 +1158,6 @@ static void twl6040_remove(struct snd_soc_component=
 *component)
>  	.remove			=3D twl6040_remove,
>  	.read			=3D twl6040_read,
>  	.write			=3D twl6040_write,
> -	.remove			=3D twl6040_remove,
>  	.set_bias_level		=3D twl6040_set_bias_level,
>  	.controls		=3D twl6040_snd_controls,
>  	.num_controls		=3D ARRAY_SIZE(twl6040_snd_controls),
> --=20
> 1.9.1
>=20

--94Ornb/7sD1MvElF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqveC8ACgkQJNaLcl1U
h9AcFAf8C1YgpTHmeex26vSQc5VvgvwbYeeRK6I+nX8Laj6jRZJ5Bswd/X1SmGCQ
z37/BOEpFwWkUZqqq86nGjiSuBY1sGzeboSSVlGZYP0jt/ddnixaC395uVqe1wD2
n9sxuxsnF6ZyF/+vNXpei4H1/osYoHrplGwDX3dg0mhcy9NxVmYWofhP8wty+RnB
QdT5Oh5tzJ+xLQo3FuvFAoDF2ILX051y5M0SnK7Gc1ZddH8LgZKB2cprwQA/99Xe
qoNcp+YkS0WxoJnjp7aoVwKHGSvhth0pvDdRoefO5PpJK6m/4qfTpnLTKZ8DqPIo
8qJpABo8gMr71LSQ57ZbVZzhUWmmdw==
=ScA3
-----END PGP SIGNATURE-----

--94Ornb/7sD1MvElF--

--===============6181503835225812631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6181503835225812631==--
