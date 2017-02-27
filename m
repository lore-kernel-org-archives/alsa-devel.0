From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 5/9] dmaengine: sun6i: support V3s SoC
	variant
Date: Mon, 27 Feb 2017 08:50:21 +0100
Message-ID: <20170227075021.e7e43o54s23jzfto@lukather>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
 <20170225123029.55939-5-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7162917847184997259=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 78FAB2669AF
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 08:50:22 +0100 (CET)
In-Reply-To: <20170225123029.55939-5-icenowy@aosc.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7162917847184997259==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wqbdmu3xkno5eyt3"
Content-Disposition: inline


--wqbdmu3xkno5eyt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2017 at 08:30:25PM +0800, Icenowy Zheng wrote:
> Allwinner V3s has a DMA engine similar to the ones from A31, but with
> fewer channels and DRQs.
>=20
> Add support for it.
>=20
> As it also needs the special gate bit, make the gate bit generic.

That should be part of a separate patch.

>=20
> According to BSP source code, SUN8IW6 (A83T) also needs the bit, so it
> have also been specified gate_needed property.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  Documentation/devicetree/bindings/dma/sun6i-dma.txt |  1 +
>  drivers/dma/sun6i-dma.c                             | 17 ++++++++++++++-=
--
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Docume=
ntation/devicetree/bindings/dma/sun6i-dma.txt
> index 6b267045f522..98fbe1a5c6dd 100644
> --- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> @@ -9,6 +9,7 @@ Required properties:
>  		  "allwinner,sun8i-a23-dma"
>  		  "allwinner,sun8i-a83t-dma"
>  		  "allwinner,sun8i-h3-dma"
> +		  "allwinner,sun8i-v3s-dma"
>  - reg:		Should contain the registers base address and length
>  - interrupts:	Should contain a reference to the interrupt used by this d=
evice
>  - clocks:	Should contain a reference to the parent AHB clock
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index a2358780ab2c..1f38424c1b14 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -101,6 +101,7 @@ struct sun6i_dma_config {
>  	u32 nr_max_channels;
>  	u32 nr_max_requests;
>  	u32 nr_max_vchans;
> +	bool gate_needed;
>  };
> =20
>  /*
> @@ -1009,12 +1010,14 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg =
=3D {
>  	.nr_max_channels =3D 8,
>  	.nr_max_requests =3D 24,
>  	.nr_max_vchans   =3D 37,
> +	.gate_needed	 =3D true,
>  };
> =20
>  static struct sun6i_dma_config sun8i_a83t_dma_cfg =3D {
>  	.nr_max_channels =3D 8,
>  	.nr_max_requests =3D 28,
>  	.nr_max_vchans   =3D 39,
> +	.gate_needed	 =3D true,
>  };
> =20
>  /*
> @@ -1028,11 +1031,19 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg =
=3D {
>  	.nr_max_vchans   =3D 34,
>  };
> =20
> +static struct sun6i_dma_config sun8i_v3s_dma_cfg =3D {
> +	.nr_max_channels =3D 8,
> +	.nr_max_requests =3D 23,
> +	.nr_max_vchans   =3D 24,

This one is suspicious. There's just a single endpoint that can be
used in both directions?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--wqbdmu3xkno5eyt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYs9o9AAoJEBx+YmzsjxAgjSAP/1tCb0DdLiZwMU2l6peo0ah1
MIyBD1BpYzUTFlYd9BMbfdebyNx7LaFC2/khqqmrOYfatjjTvSOGz0oz44DgmyLe
YKx7k7EpQiHyOtAYrVoROT4nnW6C/MWBJ6H5wyo27RNY4QanyrKagEV4R2Qii0mb
Yl67gCFayWYuTUU1HoxB4HeR0axsB2MPfodlMWYKZAGRwLD5jjTA6kNaNPmoxGjO
CG7L/M+6skKvSFNoik0z04e5IuLPF7E9nJZl0F7BD+Er0k1xMOf+BqODNpBV2nAf
vAKDnl6k7o1DO1UX4PhWiGa64joXde6IR3dPv7ATOI0GrhRsQ5E/D1qkab/o2xd+
7ebAUJ4yWiUEYj1Cof5c5qM8reUVwfYYzb2s30lkBGXULEfwAKGR3DUYVhIwA10P
rFINFLkBnRZqZQ7DiCcnK+Fb0kOpVL/44iJvLD0e/1Icl0yNsX/nq86h0rmW06YR
4INgnUiB8h3FY5cad6O3SmorKVlaGOCkceAq0N/xXipDu5UCBelPkdRa2GBz0uy7
gEhHLxN/tcdhyUAZcWSFWSPCSYz12MWx0US29uRcrMdRYTCZBDTlwmf2CLEf9CPl
4rtsY/PtcbWJOeKobhCCnWveustrRkY7gV4/k+D2jAyzmASDl2oBroWySIZ46kEi
zncrCdc+6qHIltUr7Tqi
=ieMh
-----END PGP SIGNATURE-----

--wqbdmu3xkno5eyt3--

--===============7162917847184997259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7162917847184997259==--
