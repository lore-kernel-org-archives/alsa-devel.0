From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: twl4030 - Add VDL path support
Date: Tue, 17 Mar 2009 11:22:21 +0200
Message-ID: <200903171122.22136.peter.ujfalusi@nokia.com>
References: <49BF5F40.3020000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 584A0103833
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2009 10:22:29 +0100 (CET)
In-Reply-To: <49BF5F40.3020000@samsung.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: =?utf-8?q?=27=EB=B0=95=EA=B2=BD=EB=AF=BC=27?= <kyungmin.park@samsung.com>, ext Joonyoung Shim <jy0922.shim@samsung.com>, =?utf-8?q?=EB=AF=BC=EB=B3=91=ED=98=B8?= <bhmin@samsung.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 March 2009 10:28:48 ext Joonyoung Shim wrote:
> Adds DAPMs for VDL(voice down link) path.
> To support VDL path, we have to change DAPM of outputs(Earpiece,
> PreDrive Left/Right, Headset Left/Right, Carkit Left/Right) from mux to
> mixer.
>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  sound/soc/codecs/twl4030.c |  226
> ++++++++++++++++++++------------------------ 1 files changed, 103
> insertions(+), 123 deletions(-)
>
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 5ed5f1b..317d710 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -313,104 +313,60 @@ static void twl4030_power_down(struct snd_soc_codec
> *codec) }
>
>  /* Earpiece */
> -static const char *twl4030_earpiece_texts[] =3D
> -               {"Off", "DACL1", "DACL2", "DACR1"};
> -
> -static const unsigned int twl4030_earpiece_values[] =3D
> -               {0x0, 0x1, 0x2, 0x4};
> -
> -static const struct soc_enum twl4030_earpiece_enum =3D
> -       SOC_VALUE_ENUM_SINGLE(TWL4030_REG_EAR_CTL, 1, 0x7,
> -                       ARRAY_SIZE(twl4030_earpiece_texts),
> -                       twl4030_earpiece_texts,
> -                       twl4030_earpiece_values);
> -
> -static const struct snd_kcontrol_new twl4030_dapm_earpiece_control =3D
> -SOC_DAPM_VALUE_ENUM("Route", twl4030_earpiece_enum);
> +static const struct snd_kcontrol_new twl4030_dapm_earpiece_controls[] =
=3D {
> +       SOC_DAPM_SINGLE("Voice", TWL4030_REG_EAR_CTL, 0, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL1", TWL4030_REG_EAR_CTL, 1, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_EAR_CTL, 2, 1, 0),
> +       SOC_DAPM_SINGLE("AudioR1", TWL4030_REG_EAR_CTL, 3, 1, 0),
> +};

The reason to have the VALUE_ENUM for the audio path selection is that =

according to the TRM only one of the paths can be enabled at the time.
While the voice path can be mixed with one of the audio paths (at least tha=
t =

is my understanding).
So:
AudioL*/AudioR* (DACL*/DACR*) =3D Mux
Voice, AudioL/R* (DACL/R*) =3D Mix

I think it would be better to leave the current VALUE_ENUMS for the audio p=
ath =

and add a switch for the Voice enable/disable for the outputs and route the=
m =

through a mixer to the output.
Probably than it makes sense to rename the "Earpice Mux" and friends to =

something like "Earpiece aduio Mux"...
So we would have two controls per outputs:
"Earpiece aduio Mux" (Off, DACL1, DACL2, DACR1)
"Earpiece voice Switch" (on, off)
and internally we can have "Earpiece output mixer", which mixes them togeth=
er.

>
>  /* PreDrive Left */
> -static const char *twl4030_predrivel_texts[] =3D
> -               {"Off", "DACL1", "DACL2", "DACR2"};
> -
> -static const unsigned int twl4030_predrivel_values[] =3D
> -               {0x0, 0x1, 0x2, 0x4};
> -
> -static const struct soc_enum twl4030_predrivel_enum =3D
> -       SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 1, 0x7,
> -                       ARRAY_SIZE(twl4030_predrivel_texts),
> -                       twl4030_predrivel_texts,
> -                       twl4030_predrivel_values);
> -
> -static const struct snd_kcontrol_new twl4030_dapm_predrivel_control =3D
> -SOC_DAPM_VALUE_ENUM("Route", twl4030_predrivel_enum);
> +static const struct snd_kcontrol_new twl4030_dapm_predrivel_controls[] =
=3D {
> +       SOC_DAPM_SINGLE("Voice", TWL4030_REG_PREDL_CTL, 0, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL1", TWL4030_REG_PREDL_CTL, 1, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_PREDL_CTL, 2, 1, 0),
> +       SOC_DAPM_SINGLE("AudioR2", TWL4030_REG_PREDL_CTL, 3, 1, 0),
> +};
>
>  /* PreDrive Right */
> -static const char *twl4030_predriver_texts[] =3D
> -               {"Off", "DACR1", "DACR2", "DACL2"};
> -
> -static const unsigned int twl4030_predriver_values[] =3D
> -               {0x0, 0x1, 0x2, 0x4};
> -
> -static const struct soc_enum twl4030_predriver_enum =3D
> -       SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1, 0x7,
> -                       ARRAY_SIZE(twl4030_predriver_texts),
> -                       twl4030_predriver_texts,
> -                       twl4030_predriver_values);
> -
> -static const struct snd_kcontrol_new twl4030_dapm_predriver_control =3D
> -SOC_DAPM_VALUE_ENUM("Route", twl4030_predriver_enum);
> +static const struct snd_kcontrol_new twl4030_dapm_predriver_controls[] =
=3D {
> +       SOC_DAPM_SINGLE("Voice", TWL4030_REG_PREDR_CTL, 0, 1, 0),
> +       SOC_DAPM_SINGLE("AudioR1", TWL4030_REG_PREDR_CTL, 1, 1, 0),
> +       SOC_DAPM_SINGLE("AudioR2", TWL4030_REG_PREDR_CTL, 2, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_PREDR_CTL, 3, 1, 0),
> +};
>
>  /* Headset Left */
> -static const char *twl4030_hsol_texts[] =3D
> -               {"Off", "DACL1", "DACL2"};
> -
> -static const struct soc_enum twl4030_hsol_enum =3D
> -       SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 1,
> -                       ARRAY_SIZE(twl4030_hsol_texts),
> -                       twl4030_hsol_texts);
> -
> -static const struct snd_kcontrol_new twl4030_dapm_hsol_control =3D
> -SOC_DAPM_ENUM("Route", twl4030_hsol_enum);
> +static const struct snd_kcontrol_new twl4030_dapm_hsol_controls[] =3D {
> +       SOC_DAPM_SINGLE("Voice", TWL4030_REG_HS_SEL, 0, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL1", TWL4030_REG_HS_SEL, 1, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_HS_SEL, 2, 1, 0),
> +};
>
>  /* Headset Right */
> -static const char *twl4030_hsor_texts[] =3D
> -               {"Off", "DACR1", "DACR2"};
> -
> -static const struct soc_enum twl4030_hsor_enum =3D
> -       SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 4,
> -                       ARRAY_SIZE(twl4030_hsor_texts),
> -                       twl4030_hsor_texts);
> -
> -static const struct snd_kcontrol_new twl4030_dapm_hsor_control =3D
> -SOC_DAPM_ENUM("Route", twl4030_hsor_enum);
> +static const struct snd_kcontrol_new twl4030_dapm_hsor_controls[] =3D {
> +       SOC_DAPM_SINGLE("Voice", TWL4030_REG_HS_SEL, 3, 1, 0),
> +       SOC_DAPM_SINGLE("AudioR1", TWL4030_REG_HS_SEL, 4, 1, 0),
> +       SOC_DAPM_SINGLE("AudioR2", TWL4030_REG_HS_SEL, 5, 1, 0),
> +};
>
>  /* Carkit Left */
> -static const char *twl4030_carkitl_texts[] =3D
> -               {"Off", "DACL1", "DACL2"};
> -
> -static const struct soc_enum twl4030_carkitl_enum =3D
> -       SOC_ENUM_SINGLE(TWL4030_REG_PRECKL_CTL, 1,
> -                       ARRAY_SIZE(twl4030_carkitl_texts),
> -                       twl4030_carkitl_texts);
> -
> -static const struct snd_kcontrol_new twl4030_dapm_carkitl_control =3D
> -SOC_DAPM_ENUM("Route", twl4030_carkitl_enum);
> +static const struct snd_kcontrol_new twl4030_dapm_carkitl_controls[] =3D=
 {
> +       SOC_DAPM_SINGLE("Voice", TWL4030_REG_PRECKL_CTL, 0, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL1", TWL4030_REG_PRECKL_CTL, 1, 1, 0),
> +       SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_PRECKL_CTL, 2, 1, 0),
> +};
>
>  /* Carkit Right */
> -static const char *twl4030_carkitr_texts[] =3D
> -               {"Off", "DACR1", "DACR2"};
> -
> -static const struct soc_enum twl4030_carkitr_enum =3D
> -       SOC_ENUM_SINGLE(TWL4030_REG_PRECKR_CTL, 1,
> -                       ARRAY_SIZE(twl4030_carkitr_texts),
> -                       twl4030_carkitr_texts);
> -
> -static const struct snd_kcontrol_new twl4030_dapm_carkitr_control =3D
> -SOC_DAPM_ENUM("Route", twl4030_carkitr_enum);
> +static const struct snd_kcontrol_new twl4030_dapm_carkitr_controls[] =3D=
 {
> +       SOC_DAPM_SINGLE("Voice", TWL4030_REG_PRECKR_CTL, 0, 1, 0),
> +       SOC_DAPM_SINGLE("AudioR1", TWL4030_REG_PRECKR_CTL, 1, 1, 0),
> +       SOC_DAPM_SINGLE("AudioR2", TWL4030_REG_PRECKR_CTL, 2, 1, 0),
> +};
>
>  /* Handsfree Left */
>  static const char *twl4030_handsfreel_texts[] =3D
> -               {"Voice", "DACL1", "DACL2", "DACR2"};
> +               {"Voice", "AudioL1", "AudioL2", "AudioR2"};
>
>  static const struct soc_enum twl4030_handsfreel_enum =3D
>         SOC_ENUM_SINGLE(TWL4030_REG_HFL_CTL, 0,
> @@ -422,7 +378,7 @@ SOC_DAPM_ENUM("Route", twl4030_handsfreel_enum);
>
>  /* Handsfree Right */
>  static const char *twl4030_handsfreer_texts[] =3D
> -               {"Voice", "DACR1", "DACR2", "DACL2"};
> +               {"Voice", "AudioR1", "AudioR2", "AudioL2"};
>
>  static const struct soc_enum twl4030_handsfreer_enum =3D
>         SOC_ENUM_SINGLE(TWL4030_REG_HFR_CTL, 0,
> @@ -940,6 +896,8 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D { SND_SOC_DAPM_OUTPUT("HFR"),
>
>         /* DACs */
> +       SND_SOC_DAPM_DAC("DAC Voice", "Voice Down Link",
> +                       TWL4030_REG_AVDAC_CTL, 4, 0),
>         SND_SOC_DAPM_DAC("DAC Right1", "Right Front Playback",
>                         SND_SOC_NOPM, 0, 0),
>         SND_SOC_DAPM_DAC("DAC Left1", "Left Front Playback",
> @@ -950,6 +908,8 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D { SND_SOC_NOPM, 0, 0),
>
>         /* Analog PGAs */
> +       SND_SOC_DAPM_PGA("VDL_APGA", TWL4030_REG_VDL_APGA_CTL,
> +                       0, 0, NULL, 0),
>         SND_SOC_DAPM_PGA("ARXR1_APGA", TWL4030_REG_ARXR1_APGA_CTL,
>                         0, 0, NULL, 0),
>         SND_SOC_DAPM_PGA("ARXL1_APGA", TWL4030_REG_ARXL1_APGA_CTL,
> @@ -990,26 +950,35 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D { SND_SOC_DAPM_MIXER("Analog L2 Playback Mixer=
",
> TWL4030_REG_AVDAC_CTL, 3, 0, NULL, 0),
>
> -       /* Output MUX controls */
> +       /* Output MIXER controls */
>         /* Earpiece */
> -       SND_SOC_DAPM_VALUE_MUX("Earpiece Mux", SND_SOC_NOPM, 0, 0,
> -               &twl4030_dapm_earpiece_control),
> +       SND_SOC_DAPM_MIXER("Earpiece Mixer", SND_SOC_NOPM, 0, 0,
> +                       &twl4030_dapm_earpiece_controls[0],
> +                       ARRAY_SIZE(twl4030_dapm_earpiece_controls)),
>         /* PreDrivL/R */
> -       SND_SOC_DAPM_VALUE_MUX("PredriveL Mux", SND_SOC_NOPM, 0, 0,
> -               &twl4030_dapm_predrivel_control),
> -       SND_SOC_DAPM_VALUE_MUX("PredriveR Mux", SND_SOC_NOPM, 0, 0,
> -               &twl4030_dapm_predriver_control),
> +       SND_SOC_DAPM_MIXER("PredriveL Mixer", SND_SOC_NOPM, 0, 0,
> +                       &twl4030_dapm_predrivel_controls[0],
> +                       ARRAY_SIZE(twl4030_dapm_predrivel_controls)),
> +       SND_SOC_DAPM_MIXER("PredriveR Mixer", SND_SOC_NOPM, 0, 0,
> +                       &twl4030_dapm_predriver_controls[0],
> +                       ARRAY_SIZE(twl4030_dapm_predriver_controls)),
>         /* HeadsetL/R */
> -       SND_SOC_DAPM_MUX_E("HeadsetL Mux", SND_SOC_NOPM, 0, 0,
> -               &twl4030_dapm_hsol_control, headsetl_event,
> -               SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
> -       SND_SOC_DAPM_MUX("HeadsetR Mux", SND_SOC_NOPM, 0, 0,
> -               &twl4030_dapm_hsor_control),
> +       SND_SOC_DAPM_MIXER_E("HeadsetL Mixer", SND_SOC_NOPM, 0, 0,
> +                       &twl4030_dapm_hsol_controls[0],
> +                       ARRAY_SIZE(twl4030_dapm_hsol_controls),
> headsetl_event, +                      =

> SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD), +      =

> SND_SOC_DAPM_MIXER("HeadsetR Mixer", SND_SOC_NOPM, 0, 0,
> +                       &twl4030_dapm_hsor_controls[0],
> +                       ARRAY_SIZE(twl4030_dapm_hsor_controls)),
>         /* CarkitL/R */
> -       SND_SOC_DAPM_MUX("CarkitL Mux", SND_SOC_NOPM, 0, 0,
> -               &twl4030_dapm_carkitl_control),
> -       SND_SOC_DAPM_MUX("CarkitR Mux", SND_SOC_NOPM, 0, 0,
> -               &twl4030_dapm_carkitr_control),
> +       SND_SOC_DAPM_MIXER("CarkitL Mixer", SND_SOC_NOPM, 0, 0,
> +                       &twl4030_dapm_carkitl_controls[0],
> +                       ARRAY_SIZE(twl4030_dapm_carkitl_controls)),
> +       SND_SOC_DAPM_MIXER("CarkitR Mixer", SND_SOC_NOPM, 0, 0,
> +                       &twl4030_dapm_carkitr_controls[0],
> +                       ARRAY_SIZE(twl4030_dapm_carkitr_controls)),
> +
> +       /* Output MUX controls */
>         /* HandsfreeL/R */
>         SND_SOC_DAPM_MUX_E("HandsfreeL Mux", TWL4030_REG_HFL_CTL, 5, 0,
>                 &twl4030_dapm_handsfreel_control, handsfree_event,
> @@ -1064,6 +1033,8 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D { };
>
>  static const struct snd_soc_dapm_route intercon[] =3D {
> +       {"VDL_APGA", NULL, "DAC Voice"},
> +
>         {"Analog L1 Playback Mixer", NULL, "DAC Left1"},
>         {"Analog R1 Playback Mixer", NULL, "DAC Right1"},
>         {"Analog L2 Playback Mixer", NULL, "DAC Left2"},
> @@ -1076,37 +1047,46 @@ static const struct snd_soc_dapm_route intercon[]=
 =3D
> {
>
>         /* Internal playback routings */
>         /* Earpiece */
> -       {"Earpiece Mux", "DACL1", "ARXL1_APGA"},
> -       {"Earpiece Mux", "DACL2", "ARXL2_APGA"},
> -       {"Earpiece Mux", "DACR1", "ARXR1_APGA"},
> +       {"Earpiece Mixer", "Voice", "VDL_APGA"},
> +       {"Earpiece Mixer", "AudioL1", "ARXL1_APGA"},
> +       {"Earpiece Mixer", "AudioL2", "ARXL2_APGA"},
> +       {"Earpiece Mixer", "AudioR1", "ARXR1_APGA"},
>         /* PreDrivL */
> -       {"PredriveL Mux", "DACL1", "ARXL1_APGA"},
> -       {"PredriveL Mux", "DACL2", "ARXL2_APGA"},
> -       {"PredriveL Mux", "DACR2", "ARXR2_APGA"},
> +       {"PredriveL Mixer", "Voice", "VDL_APGA"},
> +       {"PredriveL Mixer", "AudioL1", "ARXL1_APGA"},
> +       {"PredriveL Mixer", "AudioL2", "ARXL2_APGA"},
> +       {"PredriveL Mixer", "AudioR2", "ARXR2_APGA"},
>         /* PreDrivR */
> -       {"PredriveR Mux", "DACR1", "ARXR1_APGA"},
> -       {"PredriveR Mux", "DACR2", "ARXR2_APGA"},
> -       {"PredriveR Mux", "DACL2", "ARXL2_APGA"},
> +       {"PredriveR Mixer", "Voice", "VDL_APGA"},
> +       {"PredriveR Mixer", "AudioR1", "ARXR1_APGA"},
> +       {"PredriveR Mixer", "AudioR2", "ARXR2_APGA"},
> +       {"PredriveR Mixer", "AudioL2", "ARXL2_APGA"},
>         /* HeadsetL */
> -       {"HeadsetL Mux", "DACL1", "ARXL1_APGA"},
> -       {"HeadsetL Mux", "DACL2", "ARXL2_APGA"},
> +       {"HeadsetL Mixer", "Voice", "VDL_APGA"},
> +       {"HeadsetL Mixer", "AudioL1", "ARXL1_APGA"},
> +       {"HeadsetL Mixer", "AudioL2", "ARXL2_APGA"},
>         /* HeadsetR */
> -       {"HeadsetR Mux", "DACR1", "ARXR1_APGA"},
> -       {"HeadsetR Mux", "DACR2", "ARXR2_APGA"},
> +       {"HeadsetR Mixer", "Voice", "VDL_APGA"},
> +       {"HeadsetR Mixer", "AudioR1", "ARXR1_APGA"},
> +       {"HeadsetR Mixer", "AudioR2", "ARXR2_APGA"},
>         /* CarkitL */
> -       {"CarkitL Mux", "DACL1", "ARXL1_APGA"},
> -       {"CarkitL Mux", "DACL2", "ARXL2_APGA"},
> +       {"CarkitL Mixer", "Voice", "VDL_APGA"},
> +       {"CarkitL Mixer", "AudioL1", "ARXL1_APGA"},
> +       {"CarkitL Mixer", "AudioL2", "ARXL2_APGA"},
>         /* CarkitR */
> -       {"CarkitR Mux", "DACR1", "ARXR1_APGA"},
> -       {"CarkitR Mux", "DACR2", "ARXR2_APGA"},
> +       {"CarkitR Mixer", "Voice", "VDL_APGA"},
> +       {"CarkitR Mixer", "AudioR1", "ARXR1_APGA"},
> +       {"CarkitR Mixer", "AudioR2", "ARXR2_APGA"},
>         /* HandsfreeL */
> -       {"HandsfreeL Mux", "DACL1", "ARXL1_APGA"},
> -       {"HandsfreeL Mux", "DACL2", "ARXL2_APGA"},
> -       {"HandsfreeL Mux", "DACR2", "ARXR2_APGA"},
> +       {"HandsfreeL Mux", "Voice", "VDL_APGA"},
> +       {"HandsfreeL Mux", "AudioL1", "ARXL1_APGA"},
> +       {"HandsfreeL Mux", "AudioL2", "ARXL2_APGA"},
> +       {"HandsfreeL Mux", "AudioR2", "ARXR2_APGA"},
>         /* HandsfreeR */
> -       {"HandsfreeR Mux", "DACR1", "ARXR1_APGA"},
> -       {"HandsfreeR Mux", "DACR2", "ARXR2_APGA"},
> -       {"HandsfreeR Mux", "DACL2", "ARXL2_APGA"},
> +       {"HandsfreeR Mux", "Voice", "VDL_APGA"},
> +       {"HandsfreeR Mux", "AudioR1", "ARXR1_APGA"},
> +       {"HandsfreeR Mux", "AudioR2", "ARXR2_APGA"},
> +       {"HandsfreeR Mux", "AudioL2", "ARXL2_APGA"},
>
>         /* outputs */
>         {"OUTL", NULL, "ARXL2_APGA"},
> --
> 1.5.6.3
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

P=E9ter
