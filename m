From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Use snd_soc_update_bits for read-modify-write
Date: Thu, 27 Oct 2011 10:18:17 +0100
Message-ID: <CABS+qY37N5dm+aZj3Q436J1SDTveOi5KvkWXGhaPeoOpB_8xeQ@mail.gmail.com>
References: <1319638397.6637.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319638397.6637.2.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jhnikula@gmail.com>, Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 26 October 2011 15:13, Axel Lin <axel.lin@gmail.com> wrote:
> Use snd_soc_update_bits for read-modify-write register access instead=
 of
> open-coding it using snd_soc_read and snd_soc_write
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =C2=A0sound/soc/codecs/tlv320aic3x.c | =C2=A0 41 +++++++++++++-------=
-------------------
> =C2=A01 files changed, 14 insertions(+), 27 deletions(-)
>
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320=
aic3x.c
> index 7a49390..a77f6ea 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -833,7 +833,6 @@ static int aic3x_hw_params(struct snd_pcm_substre=
am *substream,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int codec_clk =3D 0, bypass_pll =3D 0, fsr=
ef, last_clk =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 data, j, r, p, pll_q, pll_p =3D 1, pll_=
r =3D 1, pll_j =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 d, pll_d =3D 1;
> - =C2=A0 =C2=A0 =C2=A0 u8 reg;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int clk;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* select data word length */
> @@ -869,14 +868,13 @@ static int aic3x_hw_params(struct snd_pcm_subst=
ream *substream,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_soc_write(=
codec, AIC3X_PLL_PROGA_REG, pll_q << PLLQ_SHIFT);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_soc_write(=
codec, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* disable PLL=
 if it is bypassed */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_re=
ad(codec, AIC3X_PLL_PROGA_REG);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_soc_write(code=
c, AIC3X_PLL_PROGA_REG, reg & ~PLL_ENABLE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bit=
s(codec, AIC3X_PLL_PROGA_REG, PLL_ENABLE, 0);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_soc_write(=
codec, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* enable PLL =
when it is used */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_re=
ad(codec, AIC3X_PLL_PROGA_REG);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_soc_write(code=
c, AIC3X_PLL_PROGA_REG, reg | PLL_ENABLE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bit=
s(codec, AIC3X_PLL_PROGA_REG,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PLL_ENABLE, PLL_ENABL=
E);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Route Left DAC to left channel input an=
d
> @@ -1155,7 +1153,6 @@ static int aic3x_set_bias_level(struct snd_soc_=
codec *codec,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum snd_soc_bias_level level=
)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct aic3x_priv *aic3x =3D snd_soc_codec=
_get_drvdata(codec);
> - =C2=A0 =C2=A0 =C2=A0 u8 reg;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (level) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case SND_SOC_BIAS_ON:
> @@ -1164,9 +1161,8 @@ static int aic3x_set_bias_level(struct snd_soc_=
codec *codec,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (codec->dap=
m.bias_level =3D=3D SND_SOC_BIAS_STANDBY &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
aic3x->master) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* enable pll */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reg =3D snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg | PLL_ENAB=
LE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 snd_soc_update_bits(codec, AIC3X_PLL_PROGA_REG,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PLL_ENABLE, PLL_ENABLE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case SND_SOC_BIAS_STANDBY:
> @@ -1175,9 +1171,8 @@ static int aic3x_set_bias_level(struct snd_soc_=
codec *codec,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (codec->dap=
m.bias_level =3D=3D SND_SOC_BIAS_PREPARE &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
aic3x->master) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0/* disable pll */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reg =3D snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg & ~PLL_ENA=
BLE);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 snd_soc_update_bits(codec, AIC3X_PLL_PROGA_REG,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 PLL_ENABLE, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case SND_SOC_BIAS_OFF:
> @@ -1294,7 +1289,6 @@ static int aic3x_resume(struct snd_soc_codec *c=
odec)
> =C2=A0static int aic3x_init(struct snd_soc_codec *codec)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct aic3x_priv *aic3x =3D snd_soc_codec=
_get_drvdata(codec);
> - =C2=A0 =C2=A0 =C2=A0 int reg;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_soc_write(codec, AIC3X_PAGE_SELECT, PA=
GE0_SELECT);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_soc_write(codec, AIC3X_RESET, SOFT_RES=
ET);
> @@ -1316,20 +1310,13 @@ static int aic3x_init(struct snd_soc_codec *c=
odec)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_soc_write(codec, DACR1_2_MONOLOPM_VOL,=
 DEFAULT_VOL | ROUTE_ON);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* unmute all outputs */
> - =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_read(codec, LLOPM_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, LLOPM_CTRL, reg | UNMUTE)=
;
> - =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_read(codec, RLOPM_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, RLOPM_CTRL, reg | UNMUTE)=
;
> - =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_read(codec, MONOLOPM_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, MONOLOPM_CTRL, reg | UNMU=
TE);
> - =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_read(codec, HPLOUT_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, HPLOUT_CTRL, reg | UNMUTE=
);
> - =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_read(codec, HPROUT_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, HPROUT_CTRL, reg | UNMUTE=
);
> - =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_read(codec, HPLCOM_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, HPLCOM_CTRL, reg | UNMUTE=
);
> - =C2=A0 =C2=A0 =C2=A0 reg =3D snd_soc_read(codec, HPRCOM_CTRL);
> - =C2=A0 =C2=A0 =C2=A0 snd_soc_write(codec, HPRCOM_CTRL, reg | UNMUTE=
);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bits(codec, LLOPM_CTRL, UNMUTE,=
 UNMUTE);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bits(codec, RLOPM_CTRL, UNMUTE,=
 UNMUTE);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bits(codec, MONOLOPM_CTRL, UNMU=
TE, UNMUTE);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bits(codec, HPLOUT_CTRL, UNMUTE=
, UNMUTE);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bits(codec, HPROUT_CTRL, UNMUTE=
, UNMUTE);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bits(codec, HPLCOM_CTRL, UNMUTE=
, UNMUTE);
> + =C2=A0 =C2=A0 =C2=A0 snd_soc_update_bits(codec, HPRCOM_CTRL, UNMUTE=
, UNMUTE);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ADC default volume and unmute */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0snd_soc_write(codec, LADC_VOL, DEFAULT_GAI=
N);
> --
> 1.7.5.4
>
>
>
>

Acked-by: Liam Girdwood <lrg@ti.com>
