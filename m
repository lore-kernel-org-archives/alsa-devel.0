From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Fix define for SGTL5000_BIAS_R_MASK
Date: Wed, 19 Oct 2011 09:06:57 +0100
Message-ID: <CABS+qY2n2xXVvK=CqOPXfH2YOYijPwSAc7tH=CYL1AJXGPxBNQ@mail.gmail.com>
References: <1318992896.7128.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318992896.7128.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Zeng Zhaoming <zhaoming.zeng@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19 October 2011 03:54, Axel Lin <axel.lin@gmail.com> wrote:
> According to the datasheet:
> CHIP_MIC_CTRL 0x002A
>
> BITS[9:8] BIAS_RESISTOR
> =C2=A0 =C2=A0 =C2=A0 =C2=A00x0 =3D Powerd off
> =C2=A0 =C2=A0 =C2=A0 =C2=A00x1 =3D 2.0 kohm
> =C2=A0 =C2=A0 =C2=A0 =C2=A00x2 =3D 4.0 kohm
> =C2=A0 =C2=A0 =C2=A0 =C2=A00x3 =3D 8.0 kohm
>
> Thus SGTL5000_BIAS_R_MASK should be defined as 0x0300 instead of 0x02=
00.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =C2=A0sound/soc/codecs/sgtl5000.h | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.=
h
> index eec3ab3..8a9f435 100644
> --- a/sound/soc/codecs/sgtl5000.h
> +++ b/sound/soc/codecs/sgtl5000.h
> @@ -280,7 +280,7 @@
> =C2=A0/*
> =C2=A0* SGTL5000_CHIP_MIC_CTRL
> =C2=A0*/
> -#define SGTL5000_BIAS_R_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 0x0200
> +#define SGTL5000_BIAS_R_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 0x0300
> =C2=A0#define SGTL5000_BIAS_R_SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A08
> =C2=A0#define SGTL5000_BIAS_R_WIDTH =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A02
> =C2=A0#define SGTL5000_BIAS_R_off =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0
> --
> 1.7.5.4
>
>
>
>

Both

Acked-by: Liam Girdwood <lrg@ti.com>
