From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: wm8940: Fix setting PLL Output clock division ratio
Date: Mon, 24 Oct 2011 13:06:08 +0100
Message-ID: <CABS+qY1bfAneoVuHuKBpeGmPG_Knh_CDkf1xpaTFa+_oEZGdKA@mail.gmail.com>
References: <1319427161.5773.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319427161.5773.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 24 October 2011 04:32, Axel Lin <axel.lin@gmail.com> wrote:
> According to the datasheet:
> The PLL Output clock division ratio is controlled by BIT[5:4] of
> WM8940_GPIO register(08h).
> Current code read/write the WM8940_ADDCNTRL(07h) register which is wr=
ong.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =C2=A0sound/soc/codecs/wm8940.c | =C2=A0 =C2=A04 ++--
> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
> index a4abfdf..3cc3bce 100644
> --- a/sound/soc/codecs/wm8940.c
> +++ b/sound/soc/codecs/wm8940.c
> @@ -627,8 +627,8 @@ static int wm8940_set_dai_clkdiv(struct snd_soc_d=
ai *codec_dai,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D snd_so=
c_write(codec, WM8940_CLOCK, reg | (div << 5));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case WM8940_OPCLKDIV:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_re=
ad(codec, WM8940_ADDCNTRL) & 0xFFCF;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D snd_soc_wr=
ite(codec, WM8940_ADDCNTRL, reg | (div << 4));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_re=
ad(codec, WM8940_GPIO) & 0xFFCF;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D snd_soc_wr=
ite(codec, WM8940_GPIO, reg | (div << 4));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> --

Acked-by: Liam Girdwood <lrg@ti.com>
