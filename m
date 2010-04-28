From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/5] ASoC: twl4030 - AIF/APLL clock fix for
	all DAPM routes.
Date: Wed, 28 Apr 2010 09:11:08 +0300
Message-ID: <201004280911.08269.peter.ujfalusi@nokia.com>
References: <1272380060-12493-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E050F24343
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 08:11:09 +0200 (CEST)
In-Reply-To: <1272380060-12493-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

One comment

On Tuesday 27 April 2010 17:54:16 ext Liam Girdwood wrote:
> This allows the AIF and APLL clocks to continue running in
> loopback mode and when invalid DAPM routes are selected at
> stream runtime.
> =

> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  sound/soc/codecs/twl4030.c |  123
> +++++++++++++++++++++++++++++-------------- 1 files changed, 83
> insertions(+), 40 deletions(-)
> =

> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index dc26b71..1a3e7f6 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -123,7 +123,10 @@ struct twl4030_priv {
>  	struct snd_soc_codec codec;
> =

>  	unsigned int codec_powered;
> +
> +	/* reference counts of AIF/APLL users */
>  	unsigned int apll_enabled;
> +	unsigned int aif_enabled;
> =

>  	struct snd_pcm_substream *master_substream;
>  	struct snd_pcm_substream *slave_substream;
> @@ -259,22 +262,50 @@ static void twl4030_init_chip(struct snd_soc_codec
> *codec) static void twl4030_apll_enable(struct snd_soc_codec *codec, int
> enable) {
>  	struct twl4030_priv *twl4030 =3D snd_soc_codec_get_drvdata(codec);
> -	int status;
> -
> -	if (enable =3D=3D twl4030->apll_enabled)
> -		return;
> +	int status =3D -1;
> =

> +	/* update the user count */
>  	if (enable)
> +		twl4030->apll_enabled++;
> +	else
> +		twl4030->apll_enabled--;
> +
> +	if (enable && twl4030->apll_enabled =3D=3D 1)
>  		/* Enable PLL */
>  		status =3D twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
> -	else
> +	else if (!enable && twl4030->apll_enabled =3D=3D 0)
>  		/* Disable PLL */
>  		status =3D twl4030_codec_disable_resource(TWL4030_CODEC_RES_APLL);
> =

>  	if (status >=3D 0)
>  		twl4030_write_reg_cache(codec, TWL4030_REG_APLL_CTL, status);
> +}
> =

> -	twl4030->apll_enabled =3D enable;
> +static void  twl4030_aif_enable(struct snd_soc_codec *codec, int enable)
> +{
> +	struct twl4030_priv *twl4030 =3D codec->private_data;

Should be to due the API change:
struct twl4030_priv *twl4030 =3D snd_soc_codec_get_drvdata(codec);

> +
> +	/* update the user count */
> +	if (enable)
> +		twl4030->aif_enabled++;
> +	else
> +		twl4030->aif_enabled--;
> +
> +	if (enable && twl4030->aif_enabled =3D=3D 1) {
> +		/* Enable AIF */
> +		/* enable the PLL before we use it to clock the DAI */
> +		twl4030_apll_enable(codec, 1);
> +
> +		twl4030_write(codec, TWL4030_REG_AUDIO_IF,
> +							twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF)
> +							| TWL4030_AIF_EN);
> +	} else if (!enable && twl4030->aif_enabled =3D=3D 0) {
> +		/* disable the DAI before we stop it's source PLL */
> +		twl4030_write(codec, TWL4030_REG_AUDIO_IF,
> +							twl4030_read_reg_cache(codec, TWL4030_REG_AUDIO_IF)
> +							& ~TWL4030_AIF_EN);
> +		twl4030_apll_enable(codec, 0);
> +	}
>  }
> =

>  static void twl4030_power_up(struct snd_soc_codec *codec)
> @@ -672,6 +703,20 @@ static int apll_event(struct snd_soc_dapm_widget *w,
>  	return 0;
>  }
> =

> +static int aif_event(struct snd_soc_dapm_widget *w,
> +		struct snd_kcontrol *kcontrol, int event)
> +{
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		twl4030_aif_enable(w->codec, 1);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		twl4030_aif_enable(w->codec, 0);
> +		break;
> +	}
> +	return 0;
> +}
> +
>  static void headset_ramp(struct snd_soc_codec *codec, int ramp)
>  {
>  	struct snd_soc_device *socdev =3D codec->socdev;
> @@ -1178,6 +1223,11 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D { SND_SOC_DAPM_OUTPUT("HFR"),
>  	SND_SOC_DAPM_OUTPUT("VIBRA"),
> =

> +	/* AIF and APLL clocks for running DAIs (including loopback) */
> +	SND_SOC_DAPM_OUTPUT("AIF DAC"),
> +	SND_SOC_DAPM_INPUT("AIF ADC"),
> +	SND_SOC_DAPM_OUTPUT("APLL"),
> +
>  	/* DACs */
>  	SND_SOC_DAPM_DAC("DAC Right1", "Right Front HiFi Playback",
>  			SND_SOC_NOPM, 0, 0),
> @@ -1215,16 +1265,21 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D { &twl4030_dapm_dbypassv_control),
> =

>  	/* Digital mixers, power control for the physical DACs */
> -	SND_SOC_DAPM_MIXER("Digital R1 Playback Mixer",
> -			TWL4030_REG_AVDAC_CTL, 0, 0, NULL, 0),
> -	SND_SOC_DAPM_MIXER("Digital L1 Playback Mixer",
> -			TWL4030_REG_AVDAC_CTL, 1, 0, NULL, 0),
> -	SND_SOC_DAPM_MIXER("Digital R2 Playback Mixer",
> -			TWL4030_REG_AVDAC_CTL, 2, 0, NULL, 0),
> -	SND_SOC_DAPM_MIXER("Digital L2 Playback Mixer",
> -			TWL4030_REG_AVDAC_CTL, 3, 0, NULL, 0),
> -	SND_SOC_DAPM_MIXER("Digital Voice Playback Mixer",
> -			TWL4030_REG_AVDAC_CTL, 4, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER_E("Digital R1 Playback Mixer",
> +			TWL4030_REG_AVDAC_CTL, 0, 0, NULL, 0, aif_event,
> +			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_MIXER_E("Digital L1 Playback Mixer",
> +			TWL4030_REG_AVDAC_CTL, 1, 0, NULL, 0, aif_event,
> +			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_MIXER_E("Digital R2 Playback Mixer",
> +			TWL4030_REG_AVDAC_CTL, 2, 0, NULL, 0, aif_event,
> +			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_MIXER_E("Digital L2 Playback Mixer",
> +			TWL4030_REG_AVDAC_CTL, 3, 0, NULL, 0, aif_event,
> +			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
> +	SND_SOC_DAPM_MIXER_E("Digital Voice Playback Mixer",
> +			TWL4030_REG_AVDAC_CTL, 4, 0, NULL, 0, apll_event,
> +			SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
> =

>  	/* Analog mixers, power control for the physical PGAs */
>  	SND_SOC_DAPM_MIXER("Analog R1 Playback Mixer",
> @@ -1238,11 +1293,6 @@ static const struct snd_soc_dapm_widget
> twl4030_dapm_widgets[] =3D { SND_SOC_DAPM_MIXER("Analog Voice Playback
> Mixer",
>  			TWL4030_REG_VDL_APGA_CTL, 0, 0, NULL, 0),
> =

> -	SND_SOC_DAPM_SUPPLY("APLL Enable", SND_SOC_NOPM, 0, 0, apll_event,
> -			    SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
> -
> -	SND_SOC_DAPM_SUPPLY("AIF Enable", TWL4030_REG_AUDIO_IF, 0, 0, NULL, 0),
> -
>  	/* Output MIXER controls */
>  	/* Earpiece */
>  	SND_SOC_DAPM_MIXER("Earpiece Mixer", SND_SOC_NOPM, 0, 0,
> @@ -1370,17 +1420,14 @@ static const struct snd_soc_dapm_route intercon[]=
 =3D
> { {"Digital R2 Playback Mixer", NULL, "DAC Right2"},
>  	{"Digital Voice Playback Mixer", NULL, "DAC Voice"},
> =

> -	/* Supply for the digital part (APLL) */
> -	{"Digital R1 Playback Mixer", NULL, "APLL Enable"},
> -	{"Digital L1 Playback Mixer", NULL, "APLL Enable"},
> -	{"Digital R2 Playback Mixer", NULL, "APLL Enable"},
> -	{"Digital L2 Playback Mixer", NULL, "APLL Enable"},
> -	{"Digital Voice Playback Mixer", NULL, "APLL Enable"},
> +	/* Route for the digital part (APLL) */
> +	{"APLL", NULL, "Digital Voice Playback Mixer"},
> =

> -	{"Digital R1 Playback Mixer", NULL, "AIF Enable"},
> -	{"Digital L1 Playback Mixer", NULL, "AIF Enable"},
> -	{"Digital R2 Playback Mixer", NULL, "AIF Enable"},
> -	{"Digital L2 Playback Mixer", NULL, "AIF Enable"},
> +	/* Route for digital part (AIF) */
> +	{"AIF DAC", NULL, "Digital L1 Playback Mixer"},
> +	{"AIF DAC", NULL, "Digital R1 Playback Mixer"},
> +	{"AIF DAC", NULL, "Digital L2 Playback Mixer"},
> +	{"AIF DAC", NULL, "Digital R2 Playback Mixer"},
> =

>  	{"Analog L1 Playback Mixer", NULL, "Digital L1 Playback Mixer"},
>  	{"Analog R1 Playback Mixer", NULL, "Digital R1 Playback Mixer"},
> @@ -1493,15 +1540,11 @@ static const struct snd_soc_dapm_route intercon[]=
 =3D
> { {"ADC Virtual Left2", NULL, "TX2 Capture Route"},
>  	{"ADC Virtual Right2", NULL, "TX2 Capture Route"},
> =

> -	{"ADC Virtual Left1", NULL, "APLL Enable"},
> -	{"ADC Virtual Right1", NULL, "APLL Enable"},
> -	{"ADC Virtual Left2", NULL, "APLL Enable"},
> -	{"ADC Virtual Right2", NULL, "APLL Enable"},
> -
> -	{"ADC Virtual Left1", NULL, "AIF Enable"},
> -	{"ADC Virtual Right1", NULL, "AIF Enable"},
> -	{"ADC Virtual Left2", NULL, "AIF Enable"},
> -	{"ADC Virtual Right2", NULL, "AIF Enable"},
> +	/* Route for digital part AIF */
> +	{"ADC Virtual Left1", NULL, "AIF ADC"},
> +	{"ADC Virtual Right1", NULL, "AIF ADC"},
> +	{"ADC Virtual Left2", NULL, "AIF ADC"},
> +	{"ADC Virtual Right2", NULL, "AIF ADC"},
> =

>  	/* Analog bypass routes */
>  	{"Right1 Analog Loopback", "Switch", "Analog Right"},

-- =

P=E9ter
