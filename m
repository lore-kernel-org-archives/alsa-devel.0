From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Subject: Re: [alsa-devel] [PATCH v4] ASoC: tlv320aic3x: Add support for high
 power analog output
Date: Sat, 11 May 2019 21:10:32 +0200
Message-ID: <CA+sos7-KyuCmfuxby4ta46ypK6H-DmEA7RgoL3cyrghQa8i+zA@mail.gmail.com>
References: <20190511151149.28823-1-sravanhome@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190511151149.28823-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravanan Sekar <sravanhome@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Dear Saravanan Sekar,

On Sat, May 11, 2019 at 5:13 PM Saravanan Sekar <sravanhome@gmail.com> wrot=
e:
>
> Add support to output level control for the analog high power output
> drivers HPOUT and HPCOM.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>
> Notes:
>     Notes:
>         Changes in V4:
>         -Added separate mono playback volume control
>         -grouped volume controls with corresponding switch
>
>         Changes in V3:
>         -Fixed compilation error
>
>         Changes in V2:
>         - Removed power control as it is handled by DAPM
>         - Added level control for left channel
>
>  sound/soc/codecs/tlv320aic3x.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3=
x.c
> index 516d17cb2182..599e4ed3850b 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
>   */
>  static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
>
> +/* Output volumes. From 0 to 9 dB in 1 dB steps */
> +static const DECLARE_TLV_DB_SCALE(out_tlv, 0, 100, 0);
> +
>  static const struct snd_kcontrol_new aic3x_snd_controls[] =3D {
>         /* Output */
>         SOC_DOUBLE_R_TLV("PCM Playback Volume",
> @@ -386,11 +389,17 @@ static const struct snd_kcontrol_new aic3x_snd_cont=
rols[] =3D {
>                          DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
>                          0, 118, 1, output_stage_tlv),
>
> -       /* Output pin mute controls */
> +       /* Output pin controls */
> +       SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, =
4,
> +                        9, 0, out_tlv),
>         SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3,
>                      0x01, 0),
> +       SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, =
4,
> +                        9, 0, out_tlv),
>         SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
>                      0x01, 0),
> +       SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTR=
L,
> +                        4, 9, 0, out_tlv),
>         SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3=
,
>                      0x01, 0),
>
> @@ -472,6 +481,9 @@ static const struct snd_kcontrol_new aic3x_mono_contr=
ols[] =3D {
>                          0, 118, 1, output_stage_tlv),
>
>         SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
> +       SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0,
> +                       out_tlv),
> +
>  };
>
>  /*
> --
> 2.17.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Reviewed-by: Beno=C3=AEt Th=C3=A9baudeau <benoit.thebaudeau.dev@gmail.com>

Best regards,
Beno=C3=AEt
