From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 5/9] dmaengine: sun6i: support V3s SoC
	variant
Date: Wed, 1 Mar 2017 10:32:52 +0100
Message-ID: <20170301093252.ukeurxvl55tfkymm@lukather>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
 <20170225123029.55939-5-icenowy@aosc.xyz>
 <20170227075021.e7e43o54s23jzfto@lukather>
 <1426971488192481@web6g.yandex.ru>
 <20170228175604.kdlmjjcncfljnbfp@lukather>
 <535111488304713@web26h.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1764454342210549958=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DC5B266EF3
 for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2017 10:32:53 +0100 (CET)
In-Reply-To: <535111488304713@web26h.yandex.ru>
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


--===============1764454342210549958==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fbh524dvpoozskrk"
Content-Disposition: inline


--fbh524dvpoozskrk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 01:58:33AM +0800, Icenowy Zheng wrote:
>=20
>=20
> 01.03.2017, 01:56, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Mon, Feb 27, 2017 at 06:48:01PM +0800, Icenowy Zheng wrote:
> >> =A027.02.2017, 15:50, "Maxime Ripard" <maxime.ripard@free-electrons.co=
m>:
> >> =A0> On Sat, Feb 25, 2017 at 08:30:25PM +0800, Icenowy Zheng wrote:
> >> =A0>> =A0Allwinner V3s has a DMA engine similar to the ones from A31, =
but with
> >> =A0>> =A0fewer channels and DRQs.
> >> =A0>>
> >> =A0>> =A0Add support for it.
> >> =A0>>
> >> =A0>> =A0As it also needs the special gate bit, make the gate bit gene=
ric.
> >> =A0>
> >> =A0> That should be part of a separate patch.
> >>
> >> =A0OK.
> >>
> >> =A0>
> >> =A0>> =A0According to BSP source code, SUN8IW6 (A83T) also needs the b=
it, so it
> >> =A0>> =A0have also been specified gate_needed property.
> >> =A0>>
> >> =A0>> =A0Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> =A0>> =A0---
> >> =A0>> =A0=A0Documentation/devicetree/bindings/dma/sun6i-dma.txt | 1 +
> >> =A0>> =A0=A0drivers/dma/sun6i-dma.c | 17 ++++++++++++++---
> >> =A0>> =A0=A02 files changed, 15 insertions(+), 3 deletions(-)
> >> =A0>>
> >> =A0>> =A0diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.=
txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> =A0>> =A0index 6b267045f522..98fbe1a5c6dd 100644
> >> =A0>> =A0--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> =A0>> =A0+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> >> =A0>> =A0@@ -9,6 +9,7 @@ Required properties:
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"all=
winner,sun8i-a23-dma"
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"all=
winner,sun8i-a83t-dma"
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"all=
winner,sun8i-h3-dma"
> >> =A0>> =A0+ "allwinner,sun8i-v3s-dma"
> >> =A0>> =A0=A0- reg: Should contain the registers base address and length
> >> =A0>> =A0=A0- interrupts: Should contain a reference to the interrupt =
used by this device
> >> =A0>> =A0=A0- clocks: Should contain a reference to the parent AHB clo=
ck
> >> =A0>> =A0diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> >> =A0>> =A0index a2358780ab2c..1f38424c1b14 100644
> >> =A0>> =A0--- a/drivers/dma/sun6i-dma.c
> >> =A0>> =A0+++ b/drivers/dma/sun6i-dma.c
> >> =A0>> =A0@@ -101,6 +101,7 @@ struct sun6i_dma_config {
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u32 nr_max_channels;
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u32 nr_max_requests;
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u32 nr_max_vchans;
> >> =A0>> =A0+ bool gate_needed;
> >> =A0>> =A0=A0};
> >> =A0>>
> >> =A0>> =A0=A0/*
> >> =A0>> =A0@@ -1009,12 +1010,14 @@ static struct sun6i_dma_config sun8i_=
a23_dma_cfg =3D {
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_channels =3D 8,
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_requests =3D 24,
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_vchans =3D 37,
> >> =A0>> =A0+ .gate_needed =3D true,
> >> =A0>> =A0=A0};
> >> =A0>>
> >> =A0>> =A0=A0static struct sun6i_dma_config sun8i_a83t_dma_cfg =3D {
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_channels =3D 8,
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_requests =3D 28,
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_vchans =3D 39,
> >> =A0>> =A0+ .gate_needed =3D true,
> >> =A0>> =A0=A0};
> >> =A0>>
> >> =A0>> =A0=A0/*
> >> =A0>> =A0@@ -1028,11 +1031,19 @@ static struct sun6i_dma_config sun8i_=
h3_dma_cfg =3D {
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.nr_max_vchans =3D 34,
> >> =A0>> =A0=A0};
> >> =A0>>
> >> =A0>> =A0+static struct sun6i_dma_config sun8i_v3s_dma_cfg =3D {
> >> =A0>> =A0+ .nr_max_channels =3D 8,
> >> =A0>> =A0+ .nr_max_requests =3D 23,
> >> =A0>> =A0+ .nr_max_vchans =3D 24,
> >> =A0>
> >> =A0> This one is suspicious. There's just a single endpoint that can be
> >> =A0> used in both directions?
> >>
> >> =A0nr_max_vchans is the endpoint number. nr_max_requests is the
> >> =A0maximum DRQ number, for V3s, according to the datasheet, it's
> >> =A023: SPI0_{R,T}X.
> >
> > There's not a lot of endpoints indeed, but you need 28 vchans (2 *
> > 14).
>=20
> Sorry but I counted only 12 pairs of vchans:
> Port 0. SRAM
> Port 1. SDRAM
> Port 6. UART0
> Port 7. UART1
> Port 8. UART2
> Port 15. Audio Codec
> Port 16. CE
> Port 17. OTG EP1
> Port 18. OTG EP2
> Port 19. OTG EP3
> Port 20. OTG EP4
> Port 23. SPI0

It seems like I can't count anymore... Yes, you're right, sorry.

Having a comment on top of the structure, just like all the other SoCs
would be nice though.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--fbh524dvpoozskrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYtpVAAAoJEBx+YmzsjxAghKoP/0dYwy6h7SA6CVpqTF/4v61z
XlfBHzQh2YgoNhUAjejb0rjNZPOT/xiNwjA/ryBlrr8sXA+kPYPsYtVc8OQr+FBR
PaSZEmJuohSUcRjyLVg75/QH+flqOrQmwrNAhfIQZffnexaBPEpAbPYp8pGhfUEM
e3g7X9Zt5ffl8ojo/5scSFMHDTbe8uAKLJvC/Dr7w8vngfjaGi0QujyMTR8WqwNJ
VF61jj9yxMor9zoXrocQF/W/qgNBSCxao0BYAqSVeRLNVCNMPQS2+wKzGHyzPwrL
lW5n+1jvgSc987z8aEcLafI2zLP91rYRAhcqRBvZ1gJna7PJtq7ESdADZgJhfVmM
MCz+nFFWYwtd4MFPvXp30pYWcOjGZtbtT6HFWx5YP4aGgMU0esE1AGz0zR8Qp/7O
0Tw+Wc6eqoYob3vcxVSPL+x3+WgtHQ7OO/wKVykgdDi/HFJvq0VpawJ540RI3CzZ
UGapBoTqy9IW0ejdogL7kMz8nvNZod8fi1pIgqTfxM5oRqq98kAcZPjjhwXrbZ+a
I4Hb/6jGM1U6oj88OIF1WtTbbFkrxkWfGIYqfbXtoLPWzGzzQfFfjTiZfUNN0l8q
uHeYPtKK7r3xTqTwoFMlofbcME4Xik/nfRbftrVxCf+tSREATfu+vcMuepaASc7P
uadbOwG5MF2hHbS40ZL2
=oMlw
-----END PGP SIGNATURE-----

--fbh524dvpoozskrk--

--===============1764454342210549958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1764454342210549958==--
