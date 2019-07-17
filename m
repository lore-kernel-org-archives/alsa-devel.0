From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [PATCH v3 6/6] ASoC: sgtl5000: Improve VAG power and mute control
Date: Wed, 17 Jul 2019 14:24:12 +0000
Message-ID: <AM6PR05MB6535E442AF37B7B079761DB2F9C90@AM6PR05MB6535.eurprd05.prod.outlook.com>
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
 <20190712145550.27500-7-oleksandr.suvorov@toradex.com>,<e9f0f7c7-4c11-36ad-679c-503f6160b83f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e9f0f7c7-4c11-36ad-679c-503f6160b83f@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Fabio Estevam <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Thank you, Cezary!

This is a good idea, I'll rework my patch accordingly.

R&D Engineer
Oleksandr Suvorov

Toradex AG

________________________________________
From: Cezary Rojewski <cezary.rojewski@intel.com>
Sent: Sunday, July 14, 2019 8:17:43 PM
To: Oleksandr Suvorov
Cc: Fabio Estevam; linux-kernel@vger.kernel.org; alsa-devel@alsa-project.or=
g; Marcel Ziswiler; Igor Opaniuk; Jaroslav Kysela; Mark Brown; Takashi Iwai=
; Liam Girdwood
Subject: Re: [PATCH v3 6/6] ASoC: sgtl5000: Improve VAG power and mute cont=
rol

On 2019-07-12 16:56, Oleksandr Suvorov wrote:
>
> +enum {
> +     HP_POWER_EVENT,
> +     DAC_POWER_EVENT,
> +     ADC_POWER_EVENT
> +};
> +
> +struct sgtl5000_mute_state {
> +     u16 hp_event;
> +     u16 dac_event;
> +     u16 adc_event;
> +};
> +
>   /* sgtl5000 private structure in codec */
>   struct sgtl5000_priv {
>       int sysclk;     /* sysclk rate */
> @@ -137,8 +156,109 @@ struct sgtl5000_priv {
>       u8 micbias_voltage;
>       u8 lrclk_strength;
>       u8 sclk_strength;
> +     struct sgtl5000_mute_state mute_state;

Why not array instead?
u16 mute_state[ADC_POWER_EVENT+1];
-or-
u16 mute_state[LAST_POWER_EVENT+1]; (if you choose to add explicit LAST
enum constant).

Enables simplification, see below.

> @@ -170,40 +290,79 @@ static int mic_bias_event(struct snd_soc_dapm_widge=
t *w,
>       return 0;
>   }
>
> -/*
> - * As manual described, ADC/DAC only works when VAG powerup,
> - * So enabled VAG before ADC/DAC up.
> - * In power down case, we need wait 400ms when vag fully ramped down.
> - */
> -static int power_vag_event(struct snd_soc_dapm_widget *w,
> -     struct snd_kcontrol *kcontrol, int event)
> +static void vag_and_mute_control(struct snd_soc_component *component,
> +                              int event, int event_source,
> +                              u16 mute_mask, u16 *mute_reg)
>   {
> -     struct snd_soc_component *component =3D snd_soc_dapm_to_component(w=
->dapm);
> -     const u32 mask =3D SGTL5000_DAC_POWERUP | SGTL5000_ADC_POWERUP;
> -
>       switch (event) {
> -     case SND_SOC_DAPM_POST_PMU:
> -             snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_=
POWER,
> -                     SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
> -             msleep(400);
> +     case SND_SOC_DAPM_PRE_PMU:
> +             *mute_reg =3D mute_output(component, mute_mask);
> +             break;
> +     case SND_SOC_DAPM_POST_PMU:
> +             vag_power_on(component, event_source);
> +             restore_output(component, mute_mask, *mute_reg);
>               break;
> -
>       case SND_SOC_DAPM_PRE_PMD:
> -             /*
> -              * Don't clear VAG_POWERUP, when both DAC and ADC are
> -              * operational to prevent inadvertently starving the
> -              * other one of them.
> -              */
> -             if ((snd_soc_component_read32(component, SGTL5000_CHIP_ANA_=
POWER) &
> -                             mask) !=3D mask) {
> -                     snd_soc_component_update_bits(component, SGTL5000_C=
HIP_ANA_POWER,
> -                             SGTL5000_VAG_POWERUP, 0);
> -                     msleep(400);
> -             }
> +             *mute_reg =3D mute_output(component, mute_mask);
> +             vag_power_off(component, event_source);
> +             break;
> +     case SND_SOC_DAPM_POST_PMD:
> +             restore_output(component, mute_mask, *mute_reg);
>               break;
>       default:
>               break;
>       }
> +}
> +
> +/*
> + * Mute Headphone when power it up/down.
> + * Control VAG power on HP power path.
> + */
> +static int headphone_pga_event(struct snd_soc_dapm_widget *w,
> +     struct snd_kcontrol *kcontrol, int event)
> +{
> +     struct snd_soc_component *component =3D
> +             snd_soc_dapm_to_component(w->dapm);
> +     struct sgtl5000_priv *sgtl5000 =3D
> +             snd_soc_component_get_drvdata(component);
> +
> +     vag_and_mute_control(component, event, HP_POWER_EVENT,
> +                          SGTL5000_HP_MUTE,
> +                          &sgtl5000->mute_state.hp_event);
> +
> +     return 0;
> +}
> +
> +/* As manual describes, ADC/DAC powering up/down requires
> + * to mute outputs to avoid pops.
> + * Control VAG power on ADC/DAC power path.
> + */
> +static int adc_updown_depop(struct snd_soc_dapm_widget *w,
> +     struct snd_kcontrol *kcontrol, int event)
> +{
> +     struct snd_soc_component *component =3D
> +             snd_soc_dapm_to_component(w->dapm);
> +     struct sgtl5000_priv *sgtl5000 =3D
> +             snd_soc_component_get_drvdata(component);
> +
> +     vag_and_mute_control(component, event, ADC_POWER_EVENT,
> +                          SGTL5000_OUTPUTS_MUTE,
> +                          &sgtl5000->mute_state.adc_event);
> +
> +     return 0;
> +}
> +
> +static int dac_updown_depop(struct snd_soc_dapm_widget *w,
> +     struct snd_kcontrol *kcontrol, int event)
> +{
> +     struct snd_soc_component *component =3D
> +             snd_soc_dapm_to_component(w->dapm);
> +     struct sgtl5000_priv *sgtl5000 =3D
> +             snd_soc_component_get_drvdata(component);
> +
> +     vag_and_mute_control(component, event, DAC_POWER_EVENT,
> +                          SGTL5000_OUTPUTS_MUTE,
> +                          &sgtl5000->mute_state.dac_event);
>
>       return 0;
>   }

With array approach you can simplify these 3 callbacks:
- remove local declaration of sgtl5000
- remove the need for "u16 *mute_reg" param for vag_and_mute_control
(you always provide the xxx_event field of mute_state corresponding to
given XXX_POWER_EVENT anyway)

The sgtl5000 local ptr would be declared within common handler, which
vag_and_mute_control clearly is. Said handler declaration could be
updated to again require widget rather than component.

Cherry on top: relocation of "return 0;" directly to
vag_and_mute_control. Leaving it void (as it is), however, might also be
appropriate (explicit).

Czarek
