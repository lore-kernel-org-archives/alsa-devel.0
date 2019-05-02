From: =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=
        <benoit.thebaudeau.dev@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: tlv320aic3x: Add support for high
 power analog output
Date: Fri, 3 May 2019 00:44:31 +0200
Message-ID: <CA+sos7-U49b7DyQ76h-RohhGqPSPqsV-u-r+oaZnB5=DAkbm6w@mail.gmail.com>
References: <20190502181332.5503-1-sravanhome@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502181332.5503-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravanan Sekar <sravanhome@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Dear Saravanan Sekar,

On Thu, May 2, 2019 at 8:14 PM Saravanan Sekar <sravanhome@gmail.com> wrote=
:
>
> Add support to output level control for the analog high power output
> drivers HPOUT and HPCOM.
>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>
> Notes:
>     Changes in V3:
>     -Fixed compilation error
>
>     Changes in V2:
>     - Removed power control as it is handled by DAPM
>     - Added level control for left channel
>
>  sound/soc/codecs/tlv320aic3x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3=
x.c
> index 516d17cb2182..489a6d89d63d 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
>   */
>  static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
>
> +/* HP/HPCOM volumes. From 0 to 9 dB in 1 dB steps */
> +static DECLARE_TLV_DB_SCALE(hp_tlv, 0, 100, 0);

This could be made "const" (as well as the other instances of
DECLARE_TLV_DB_SCALE()).

The hp_tlv naming is fine for the change here, but something not
HP-specific, such as out_tlv would be better if you consider the
further changes that could use this definition:
static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
+/* Output volumes. From 0 to 9 dB in 1 dB steps */
+static const DECLARE_TLV_DB_SCALE(out_tlv, 0, 100, 0);

E.g., the following control could be added to aic3x_snd_controls[]:
+SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, 4,
9, 0, out_tlv),

And this control could be added to aic3x_mono_controls[]:
+SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0, out_tlv),

The MONOLOPM_CTRL register exists for the 33 and 3106, but not for the
31, 32, 3007, and 3104 (it should not be written to for these CODECs).
However, the driver uses this register for the 31 and 32 too, which
should be fixed rather than disabling the corresponding pin as
suggested in the file top comment.

> +
>  static const struct snd_kcontrol_new aic3x_snd_controls[] =3D {
>         /* Output */
>         SOC_DOUBLE_R_TLV("PCM Playback Volume",
> @@ -419,6 +422,12 @@ static const struct snd_kcontrol_new aic3x_snd_contr=
ols[] =3D {
>         /* Pop reduction */
>         SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
>         SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
> +
> +       /* Analog HPOUT, HPCOM output level controls */
> +       SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL,
> +                       4, 9, 0, hp_tlv),

Correct for all the supported CODECs.

> +       SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTR=
L,
> +                       4, 9, 0, hp_tlv),

Correct for all the supported CODECs but the TLV320AIC3007. The latter
has no HPRCOM output, but only HPCOM (=3D HPLCOM). The HPRCOM_CTRL
register of this CODEC is reserved and should not be written to. All
the references to this register for this CODEC are actually broken in
this driver. You could still add this control, and the 3007 issue
could be fixed separately by you or someone else.

You could keep the volumes grouped with the corresponding switches,
just like all the AGC or PGA Capture controls are grouped together:
-/* Output pin mute controls */
+/* Output pin controls */
+SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, 4,
9, 0, out_tlv),
SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3, 0x01, 0),
+SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, 4,
9, 0, out_tlv),
SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3, 0x01, 0),
+SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL,
4, 9, 0, out_tlv),
SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3, 0x01, 0)=
,

And:
+SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0, out_tlv),
SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),

>  };
>
>  /* For other than tlv320aic3104 */

Best regards
Beno=C3=AEt
