From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [alsa-devel] [PATCH v5 2/2] ASoC: da7210: Add support for ALC and
 Noise suppression
Date: Wed, 19 Oct 2011 08:57:57 +0100
Message-ID: <CABS+qY3qw7YpeNwK2JJav4tR23uPCp19BPeE2E2KL3FnZ8zJ=g@mail.gmail.com>
References: <1318945431.13721.52.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318945431.13721.52.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 18 October 2011 14:43, Ashish Chavan <ashish.chavan@kpitcummins.com>=
 wrote:
> This patch adds controls to set following ALC parameters,
> =C2=A0- Max gain, Min gain, Noise gain, Attack rate, Release rate and=
 delay
>
> It also adds a switch to enable/disable noise suppression.
>
> As per DA7210 data sheet, ALC and noise suppression can be enabled
> only if certain conditions are met. This condition checks are handled
> by simply using "_EXT" version of controls to capture change events.
>
> Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
> Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> ---
> Changes since v1:
> - Reading from register instead of cache
> - Made debug message more specific about error
> - Changed "Gain" to "Volume" in names of ALC controls
> ---
> =C2=A0sound/soc/codecs/da7210.c | =C2=A0109 +++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 109 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
> index a31be70..edcfc36 100644
> --- a/sound/soc/codecs/da7210.c
> +++ b/sound/soc/codecs/da7210.c
> @@ -26,11 +26,15 @@
> =C2=A0#include <sound/tlv.h>
>
> =C2=A0/* DA7210 register space */
> +#define DA7210_CONTROL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x01
> =C2=A0#define DA7210_STATUS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x02
> =C2=A0#define DA7210_STARTUP1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x03
> =C2=A0#define DA7210_MIC_L =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x07
> =C2=A0#define DA7210_MIC_R =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x08
> +#define DA7210_AUX1_L =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00x09
> +#define DA7210_AUX1_R =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00x0A
> =C2=A0#define DA7210_AUX2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x0B
> +#define DA7210_IN_GAIN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x0C
> =C2=A0#define DA7210_INMIX_L =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x0D
> =C2=A0#define DA7210_INMIX_R =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x0E
> =C2=A0#define DA7210_ADC_HPF =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x0F
> @@ -59,6 +63,12 @@
> =C2=A0#define DA7210_PLL_DIV2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2A
> =C2=A0#define DA7210_PLL_DIV3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2B
> =C2=A0#define DA7210_PLL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x2C
> +#define DA7210_ALC_MAX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x83
> +#define DA7210_ALC_MIN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x84
> +#define DA7210_ALC_NOIS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x85
> +#define DA7210_ALC_ATT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x86
> +#define DA7210_ALC_REL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x87
> +#define DA7210_ALC_DEL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x88
> =C2=A0#define DA7210_A_HID_UNLOCK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x8A
> =C2=A0#define DA7210_A_TEST_UNLOCK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x8B
> =C2=A0#define DA7210_A_PLL1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x90
> @@ -81,6 +91,7 @@
> =C2=A0#define DA7210_IN_R_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (1 << 7)
>
> =C2=A0/* ADC bit fields */
> +#define DA7210_ADC_ALC_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 << 0)
> =C2=A0#define DA7210_ADC_L_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 3)
> =C2=A0#define DA7210_ADC_R_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 << 7)
>
> @@ -150,6 +161,29 @@
> =C2=A0/* SOFTMUTE bit fields */
> =C2=A0#define DA7210_RAMP_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (1 << 6)
>
> +/* CONTROL bit fields */
> +#define DA7210_NOISE_SUP_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(1 << 3)
> +
> +/* IN_GAIN bit fields */
> +#define DA7210_INPGA_L_VOL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (0x0F << 0)
> +#define DA7210_INPGA_R_VOL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (0xF0 << 0)
> +
> +/* ZERO_CROSS bit fields */
> +#define DA7210_AUX1_L_ZC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 << 0)
> +#define DA7210_AUX1_R_ZC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 << 1)
> +#define DA7210_HP_L_ZC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 << 6)
> +#define DA7210_HP_R_ZC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 << 7)
> +
> +/* AUX1_L bit fields */
> +#define DA7210_AUX1_L_VOL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(0x3F << 0)
> +
> +/* AUX1_R bit fields */
> +#define DA7210_AUX1_R_VOL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(0x3F << 0)
> +
> +/* Minimum INPGA and AUX1 volume to enable noise suppression */
> +#define DA7210_INPGA_MIN_VOL_NS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0A =C2=A0/* 10.5dB */
> +#define DA7210_AUX1_MIN_VOL_NS =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x35 =C2=A0=
/* 6dB */
> +
> =C2=A0#define DA7210_VERSION "0.0.1"
>
> =C2=A0/*
> @@ -202,6 +236,68 @@ static const char *da7210_hp_mode_txt[] =3D {
> =C2=A0static const struct soc_enum da7210_hp_mode_sel =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_ENUM_SINGLE(DA7210_HP_CFG, 0, 2, da721=
0_hp_mode_txt);
>
> +/* ALC can be enabled only if noise suppression is disabled */
> +static int da7210_put_alc_sw(struct snd_kcontrol *kcontrol,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct snd_ctl_elem_value *ucontrol)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct snd_soc_codec *codec =3D snd_kcontrol_c=
hip(kcontrol);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ucontrol->value.integer.value[0]) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if noise =
suppression is enabled */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (snd_soc_read(c=
odec, DA7210_CONTROL) & DA7210_NOISE_SUP_EN) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_dbg(codec->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Disable noise suppression to enabl=
e ALC\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EPERM;

-EINVAL


> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 /* If all conditions are met or we are actuall=
y disabling ALC */
> + =C2=A0 =C2=A0 =C2=A0 return snd_soc_put_volsw(kcontrol, ucontrol);
> +}
> +
> +/* Noise suppression can be enabled only if following conditions are=
 met
> + * =C2=A0ALC disabled
> + * =C2=A0ZC enabled for HP and AUX1 PGA
> + * =C2=A0INPGA_L_VOL and INPGA_R_VOL >=3D 10.5 dB
> + * =C2=A0AUX1_L_VOL and AUX1_R_VOL >=3D 6 dB
> + */
> +static int da7210_put_noise_sup_sw(struct snd_kcontrol *kcontrol,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct snd_ctl_elem_va=
lue *ucontrol)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct snd_soc_codec *codec =3D snd_kcontrol_c=
hip(kcontrol);
> + =C2=A0 =C2=A0 =C2=A0 u8 val;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (ucontrol->value.integer.value[0]) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if ALC is=
 enabled */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (snd_soc_read(c=
odec, DA7210_ADC) & DA7210_ADC_ALC_EN)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check ZC for HP=
 and AUX1 PGA */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((snd_soc_read(=
codec, DA7210_ZERO_CROSS) &
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (DA7210_AUX1_L_ZC | DA7210_AUX1_R_ZC | DA7210_HP_L_ZC |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 DA7210_HP_R_ZC)) !=3D 0xc3)

It may be clearer if you don't use the magic number here and specify
the bits you are checking.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check INPGA_L_V=
OL and INPGA_R_VOL */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D snd_soc_re=
ad(codec, DA7210_IN_GAIN);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((val & DA7210=
_INPGA_L_VOL) < DA7210_INPGA_MIN_VOL_NS) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (((val & DA7210_INPGA_R_VOL) >> 4) <
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 DA7210_INPGA_MIN_VOL_NS))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check AUX1_L_VO=
L and AUX1_R_VOL */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((snd_soc_read=
(codec, DA7210_AUX1_L) & DA7210_AUX1_L_VOL) <
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DA72=
10_AUX1_MIN_VOL_NS) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((sn=
d_soc_read(codec, DA7210_AUX1_R) & DA7210_AUX1_R_VOL) <
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DA72=
10_AUX1_MIN_VOL_NS))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 goto err;
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 /* If all conditions are met or we are actuall=
y disabling Noise sup */
> + =C2=A0 =C2=A0 =C2=A0 return snd_soc_put_volsw(kcontrol, ucontrol);
> +
> +err:
> + =C2=A0 =C2=A0 =C2=A0 return -EPERM;

-EINVAL

> +}
> +
> =C2=A0static const struct snd_kcontrol_new da7210_snd_controls[] =3D =
{
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DOUBLE_R_TLV("HeadPhone Playback Volum=
e",
> @@ -260,6 +356,19 @@ static const struct snd_kcontrol_new da7210_snd_=
controls[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_DOUBLE("Headphone ZC Switch", DA7210_Z=
ERO_CROSS, 6, 7, 1, 0),
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SOC_ENUM("Headphone Class", da7210_hp_mode=
_sel),
> +
> + =C2=A0 =C2=A0 =C2=A0 /* ALC controls */
> + =C2=A0 =C2=A0 =C2=A0 SOC_SINGLE_EXT("ALC Enable Switch", DA7210_ADC=
, 0, 1, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0snd_soc_get_volsw, da7210_put_alc_sw),
> + =C2=A0 =C2=A0 =C2=A0 SOC_SINGLE("ALC Capture Max Volume", DA7210_AL=
C_MAX, 0, 0x3F, 0),
> + =C2=A0 =C2=A0 =C2=A0 SOC_SINGLE("ALC Capture Min Volume", DA7210_AL=
C_MIN, 0, 0x3F, 0),
> + =C2=A0 =C2=A0 =C2=A0 SOC_SINGLE("ALC Capture Noise Volume", DA7210_=
ALC_NOIS, 0, 0x3F, 0),
> + =C2=A0 =C2=A0 =C2=A0 SOC_SINGLE("ALC Capture Attack Rate", DA7210_A=
LC_ATT, 0, 0xFF, 0),
> + =C2=A0 =C2=A0 =C2=A0 SOC_SINGLE("ALC Capture Release Rate", DA7210_=
ALC_REL, 0, 0xFF, 0),
> + =C2=A0 =C2=A0 =C2=A0 SOC_SINGLE("ALC Capture Release Delay", DA7210=
_ALC_DEL, 0, 0xFF, 0),
> +
> + =C2=A0 =C2=A0 =C2=A0 SOC_SINGLE_EXT("Noise Suppression Enable Switc=
h", DA7210_CONTROL, 3, 1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00, snd_soc_get_volsw, da7210_put_noise_sup_sw),
> =C2=A0};
>
> =C2=A0/* Codec private data */
> --
> 1.7.1
>
>
>
