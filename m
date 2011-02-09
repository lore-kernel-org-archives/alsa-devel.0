From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 3/3] ASoC: Add support for AIF channel
	muxing on WM8903
Date: Wed, 9 Feb 2011 08:33:25 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F6015A@HQMAIL01.nvidia.com>
References: <1297259228-1891-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1297259228-1891-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 24BE5243BA
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 17:33:37 +0100 (CET)
In-Reply-To: <1297259228-1891-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Wednesday, February 09, 2011 6:47 AM:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8903.c |   66 ++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 62 insertions(+), 4 deletions(-)

Oh, thanks very much!

I was going to write this myself, and took a look at the wm8993(?) that you
mentioned over the weekend, but got side-tracked on other things. What you
wrote looks basically the same as what I was going to port over. I'll make
sure to test it within the next few days, once it's applied.

Thanks again.

> diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> index caf41ad..b20611b 100644
> --- a/sound/soc/codecs/wm8903.c
> +++ b/sound/soc/codecs/wm8903.c
> @@ -679,6 +679,22 @@ static const struct soc_enum lsidetone_enum =
>  static const struct soc_enum rsidetone_enum =
>  	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_0, 0, 3, sidetone_text);
> 
> +static const char *aif_text[] = {
> +	"Left", "Right"
> +};
> +
> +static const struct soc_enum lcapture_enum =
> +	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 7, 2, aif_text);
> +
> +static const struct soc_enum rcapture_enum =
> +	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 6, 2, aif_text);
> +
> +static const struct soc_enum lplay_enum =
> +	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 5, 2, aif_text);
> +
> +static const struct soc_enum rplay_enum =
> +	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 4, 2, aif_text);
> +
>  static const struct snd_kcontrol_new wm8903_snd_controls[] = {
> 
>  /* Input PGAs - No TLV since the scale depends on PGA mode */
> @@ -796,6 +812,18 @@ static const struct snd_kcontrol_new lsidetone_mux =
>  static const struct snd_kcontrol_new rsidetone_mux =
>  	SOC_DAPM_ENUM("DACR Sidetone Mux", rsidetone_enum);
> 
> +static const struct snd_kcontrol_new lcapture_mux =
> +	SOC_DAPM_ENUM("Left Capture Mux", lcapture_enum);
> +
> +static const struct snd_kcontrol_new rcapture_mux =
> +	SOC_DAPM_ENUM("Right Capture Mux", rcapture_enum);
> +
> +static const struct snd_kcontrol_new lplay_mux =
> +	SOC_DAPM_ENUM("Left Playback Mux", lplay_enum);
> +
> +static const struct snd_kcontrol_new rplay_mux =
> +	SOC_DAPM_ENUM("Right Playback Mux", rplay_enum);
> +
>  static const struct snd_kcontrol_new left_output_mixer[] = {
>  SOC_DAPM_SINGLE("DACL Switch", WM8903_ANALOGUE_LEFT_MIX_0, 3, 1, 0),
>  SOC_DAPM_SINGLE("DACR Switch", WM8903_ANALOGUE_LEFT_MIX_0, 2, 1, 0),
> @@ -859,14 +887,26 @@ SND_SOC_DAPM_MUX("Right Input Mode Mux",
> SND_SOC_NOPM, 0, 0, &rinput_mode_mux),
>  SND_SOC_DAPM_PGA("Left Input PGA", WM8903_POWER_MANAGEMENT_0, 1, 0, NULL,
> 0),
>  SND_SOC_DAPM_PGA("Right Input PGA", WM8903_POWER_MANAGEMENT_0, 0, 0,
> NULL, 0),
> 
> -SND_SOC_DAPM_ADC("ADCL", "Left HiFi Capture", WM8903_POWER_MANAGEMENT_6,
> 1, 0),
> -SND_SOC_DAPM_ADC("ADCR", "Right HiFi Capture", WM8903_POWER_MANAGEMENT_6,
> 0, 0),
> +SND_SOC_DAPM_ADC("ADCL", NULL, WM8903_POWER_MANAGEMENT_6, 1, 0),
> +SND_SOC_DAPM_ADC("ADCR", NULL, WM8903_POWER_MANAGEMENT_6, 0, 0),
> +
> +SND_SOC_DAPM_MUX("Left Capture Mux", SND_SOC_NOPM, 0, 0, &lcapture_mux),
> +SND_SOC_DAPM_MUX("Right Capture Mux", SND_SOC_NOPM, 0, 0, &rcapture_mux),
> +
> +SND_SOC_DAPM_AIF_OUT("AIFTXL", "Left HiFi Capture", 0, SND_SOC_NOPM, 0,
> 0),
> +SND_SOC_DAPM_AIF_OUT("AIFTXR", "Right HiFi Capture", 0, SND_SOC_NOPM, 0,
> 0),
> 
>  SND_SOC_DAPM_MUX("DACL Sidetone", SND_SOC_NOPM, 0, 0, &lsidetone_mux),
>  SND_SOC_DAPM_MUX("DACR Sidetone", SND_SOC_NOPM, 0, 0, &rsidetone_mux),
> 
> -SND_SOC_DAPM_DAC("DACL", "Left Playback", WM8903_POWER_MANAGEMENT_6, 3,
> 0),
> -SND_SOC_DAPM_DAC("DACR", "Right Playback", WM8903_POWER_MANAGEMENT_6, 2,
> 0),
> +SND_SOC_DAPM_AIF_IN("AIFRXL", "Left Playback", 0, SND_SOC_NOPM, 0, 0),
> +SND_SOC_DAPM_AIF_IN("AIFRXR", "Right Playback", 0, SND_SOC_NOPM, 0, 0),
> +
> +SND_SOC_DAPM_MUX("Left Playback Mux", SND_SOC_NOPM, 0, 0, &lplay_mux),
> +SND_SOC_DAPM_MUX("Right Playback Mux", SND_SOC_NOPM, 0, 0, &rplay_mux),
> +
> +SND_SOC_DAPM_DAC("DACL", NULL, WM8903_POWER_MANAGEMENT_6, 3, 0),
> +SND_SOC_DAPM_DAC("DACR", NULL, WM8903_POWER_MANAGEMENT_6, 2, 0),
> 
>  SND_SOC_DAPM_MIXER("Left Output Mixer", WM8903_POWER_MANAGEMENT_1, 1, 0,
>  		   left_output_mixer, ARRAY_SIZE(left_output_mixer)),
> @@ -948,18 +988,36 @@ static const struct snd_soc_dapm_route intercon[] =
> {
>  	{ "Left Input PGA", NULL, "Left Input Mode Mux" },
>  	{ "Right Input PGA", NULL, "Right Input Mode Mux" },
> 
> +	{ "Left Capture Mux", "Left", "ADCL" },
> +	{ "Left Capture Mux", "Right", "ADCR" },
> +
> +	{ "Right Capture Mux", "Left", "ADCL" },
> +	{ "Right Capture Mux", "Right", "ADCR" },
> +
> +	{ "AIFTXL", NULL, "Left Capture Mux" },
> +	{ "AIFTXR", NULL, "Right Capture Mux" },
> +
>  	{ "ADCL", NULL, "Left Input PGA" },
>  	{ "ADCL", NULL, "CLK_DSP" },
>  	{ "ADCR", NULL, "Right Input PGA" },
>  	{ "ADCR", NULL, "CLK_DSP" },
> 
> +	{ "Left Playback Mux", "Left", "AIFRXL" },
> +	{ "Left Playback Mux", "Right", "AIFRXR" },
> +
> +	{ "Right Playback Mux", "Left", "AIFRXL" },
> +	{ "Right Playback Mux", "Right", "AIFRXR" },
> +
>  	{ "DACL Sidetone", "Left", "ADCL" },
>  	{ "DACL Sidetone", "Right", "ADCR" },
>  	{ "DACR Sidetone", "Left", "ADCL" },
>  	{ "DACR Sidetone", "Right", "ADCR" },
> 
> +	{ "DACL", NULL, "Left Playback Mux" },
>  	{ "DACL", NULL, "DACL Sidetone" },
>  	{ "DACL", NULL, "CLK_DSP" },
> +
> +	{ "DACR", NULL, "Right Playback Mux" },
>  	{ "DACR", NULL, "DACR Sidetone" },
>  	{ "DACR", NULL, "CLK_DSP" },
> 
> --
> 1.7.2.3

-- 
nvpublic
