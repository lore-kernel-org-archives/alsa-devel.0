From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 5/9] dmaengine: sun6i: support V3s SoC
	variant
Date: Tue, 28 Feb 2017 18:56:04 +0100
Message-ID: <20170228175604.kdlmjjcncfljnbfp@lukather>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
 <20170225123029.55939-5-icenowy@aosc.xyz>
 <20170227075021.e7e43o54s23jzfto@lukather>
 <1426971488192481@web6g.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8228053245081889857=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id AA353266718
 for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2017 18:56:05 +0100 (CET)
In-Reply-To: <1426971488192481@web6g.yandex.ru>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8228053245081889857==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x2rus7yuyqbzeq22"
Content-Disposition: inline


--x2rus7yuyqbzeq22
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 06:48:01PM +0800, Icenowy Zheng wrote:
>=20
>=20
> 27.02.2017, 15:50, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Sat, Feb 25, 2017 at 08:30:25PM +0800, Icenowy Zheng wrote:
> >> =A0Allwinner V3s has a DMA engine similar to the ones from A31, but wi=
th
> >> =A0fewer channels and DRQs.
> >>
> >> =A0Add support for it.
> >>
> >> =A0As it also needs the special gate bit, make the gate bit generic.
> >
> > That should be part of a separate patch.
>=20
> OK.
>=20
> >
> >> =A0According to BSP source code, SUN8IW6 (A83T) also needs the bit, so=
 it
> >> =A0have also been specified gate_needed property.
> >>
> >> =A0Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> =A0---
> >> =A0=A0Documentation/devicetree/bindings/dma/sun6i-dma.txt | 1 +
> >> =A0=A0drivers/dma/sun6i-dma.c | 17 ++++++++++++++---
> >> =A0=A02 files changed, 15 insertions(+), 3 deletions(-)
> >>
> >> =A0diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/=
Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> =A0index 6b267045f522..98fbe1a5c6dd 100644
> >> =A0--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> =A0+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> =A0@@ -9,6 +9,7 @@ Required properties:
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"allwinner=
,sun8i-a23-dma"
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"allwinner=
,sun8i-a83t-dma"
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"allwinner=
,sun8i-h3-dma"
> >> =A0+ "allwinner,sun8i-v3s-dma"
> >> =A0=A0- reg: Should contain the registers base address and length
> >> =A0=A0- interrupts: Should contain a reference to the interrupt used b=
y this device
> >> =A0=A0- clocks: Should contain a reference to the parent AHB clock
> >> =A0diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> >> =A0index a2358780ab2c..1f38424c1b14 100644
> >> =A0--- a/drivers/dma/sun6i-dma.c
> >> =A0+++ b/drivers/dma/sun6i-dma.c
> >> =A0@@ -101,6 +101,7 @@ struct sun6i_dma_config {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u32 nr_max_channels;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u32 nr_max_requests;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u32 nr_max_vchans;
> >> =A0+ bool gate_needed;
> >> =A0=A0};
> >>
> >> =A0=A0/*
> >> =A0@@ -1009,12 +1010,14 @@ static struct sun6i_dma_config sun8i_a23_dm=
a_cfg =3D {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_channels =3D 8,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_requests =3D 24,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_vchans =3D 37,
> >> =A0+ .gate_needed =3D true,
> >> =A0=A0};
> >>
> >> =A0=A0static struct sun6i_dma_config sun8i_a83t_dma_cfg =3D {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_channels =3D 8,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_requests =3D 28,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_vchans =3D 39,
> >> =A0+ .gate_needed =3D true,
> >> =A0=A0};
> >>
> >> =A0=A0/*
> >> =A0@@ -1028,11 +1031,19 @@ static struct sun6i_dma_config sun8i_h3_dma=
_cfg =3D {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_vchans =3D 34,
> >> =A0=A0};
> >>
> >> =A0+static struct sun6i_dma_config sun8i_v3s_dma_cfg =3D {
> >> =A0+ .nr_max_channels =3D 8,
> >> =A0+ .nr_max_requests =3D 23,
> >> =A0+ .nr_max_vchans =3D 24,
> >
> > This one is suspicious. There's just a single endpoint that can be
> > used in both directions?
>=20
> nr_max_vchans is the endpoint number. nr_max_requests is the
> maximum DRQ number, for V3s, according to the datasheet, it's
> 23: SPI0_{R,T}X.

There's not a lot of endpoints indeed, but you need 28 vchans (2 *
14).

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--x2rus7yuyqbzeq22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYtbmwAAoJEBx+YmzsjxAgeccP/0UxEr4x4xFKW5akT/NFg7zk
wd5pE6xnCGmZv12SQ2R63bnbB0uNLUqsQaaNA44wJFLAaim6Pz99tM6O9dThhYmx
S3qWcIx4GMiqma1Pmcw7ReZOL1bL/qvtOzCqgLHKuUICE6lMk1b1iAYJ1jyfm4hn
2hexl1bT0tZt4wem8S6LnUJ21aSdA55JyKjOyU/1ufsuitKYY1QurEQEb3seeGwN
md1IfFar1rvAr3KrufOdQNdhlaGcJ+Zb4GJ1X+oInEhs5DiynYrsFclJXmHqL71s
tml6ZlttVGlZ2vFls45XQ+nNrLVgsJb+lLUnp+3lIL1jAaxtLrQlYLbUqf4UGRo2
mp6UVeFjkxu3/nc2gx19oI5LhRtHeQR3y5H4rLpdWUSVb0QbJOqmdhE0AgDSEE0u
P7pCujUD/Axs5JcTx9Iw6oOhLabapzWtu7InhveRrFaj1XsMSE1TkayxTshzMbK/
BoCxDBSrDtlcOzpL1huX/qI4GrPzGrmAtVGcpK8oOvK1p0LDxG2Rtic/ftamYG8G
5QLzsj8jMJ5+xWrdadImTIJ22c7znCFIMgl6oizyajOHQiagIco4F7gfc3j+w08T
9xMAARSD16pLHtCa/lKpVoXTb6aaXCVoEx7zulMIFUXAs2FJ1vQ4yl8c9wvLq0XE
8peD9glZPF+mBf3G/Pbu
=xvy2
-----END PGP SIGNATURE-----

--x2rus7yuyqbzeq22--

--===============8228053245081889857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8228053245081889857==--
