From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: add dialog da9034 (aka micco)
	audio codec	support
Date: Wed, 3 Jun 2009 14:26:31 +0100
Message-ID: <20090603132631.GG11507@sirena.org.uk>
References: <f17812d70906030534r4a0fe811n71cba5a13334c504@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D11B1037F2
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 15:26:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906030534r4a0fe811n71cba5a13334c504@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 08:34:36PM +0800, Eric Miao wrote:

This looks good overall - some comments below, mostly at the style
level.

> index 0000000..159a883
> --- /dev/null
> +++ b/sound/soc/codecs/da9034-audio.c
> @@ -0,0 +1,696 @@
> +/*
> + * linux/sound/soc/codecs/micco.c

Make your mind up :)

> +#include <asm/mach-types.h>

This shouldn't be needed and doesn't appear to be used so should be
removed.

> +/* NOTE: the ES1 revision of the chip has the following two issues
> + * regarding audio:
> + * 1. The MONO and BEAR are incorrectly exchanged
> + * 2. The Stereo DAC has to be enabled for Voice Codec
> + */
> +#define DA9034_ERRATA_ES1	1

This should be moved into platform data in order to allow it to be
selected based on board type - if this has been fixed in subsequent
silicon the workaround won't be appropriate for a lot of systems.
Probably a module option would also be good in case a board may have
either revision.

> +static const struct snd_kcontrol_new da9034_mixer_mono_out_controls[] = {
> +       SOC_DAPM_SINGLE("AUX1", DA9034_MUX_MONO, 0, 1, 0),
> +       SOC_DAPM_SINGLE("AUX2", DA9034_MUX_MONO, 1, 1, 0),

These should all be in the form "Foo Switch" - ths applies to most of
the controls.  Ideally the relevant PGAs should be named in the form
"Foo Volume" so that ALSA can present them to the user as a single
volume/PGA control.

> +static const struct soc_enum da9034_mux_enum[] = {
> +	SOC_VALUE_ENUM_SINGLE(DA9034_TX_PGA_MUX, 0, 0xff, 7,
> +		mux_tx_pga_texts, mux_tx_pga_values),
> +	SOC_ENUM_SINGLE(DA9034_MIC_PGA, 4, 2, mux_mic_texts),
> +};

Please move these out of arrays since...

> +	/* DACs and ADCs */
> +#ifdef DA9034_ERRATA_ES1
> +	SND_SOC_DAPM_DAC("DAC1", "HiFi Playback CH1", -1, 0, 0),
> +	SND_SOC_DAPM_DAC("DAC2", "HiFi Playback CH2", -1, 0, 0),

This should use SND_SOC_NOPM for the invalid register.

> +	SND_SOC_DAPM_PGA("LINE_OUT PGA", DA9034_AUDIO_LINE_AMP, 4, 0,
> +			&pga_ctrls[7], 1),

...these numerical references into the arrays from further down the
driver get confusing.  I know many of the older drivers do this but
I'm trying to avoid adding any new code using this scheme due to the
legibility and maintainability issues that result.

> +#ifdef DA9034_ERRATA_ES1
> +	{ "BEAR PGA", NULL, "MONO Mixer" },
> +#endif

The description of the erratum at the top said this was exchanged with
something else, not absent?  I'd expect an #else if so...

> +#define DA9034_HIFI_RATES	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> +				SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> +				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> +				SNDRV_PCM_RATE_48000)

This could be SNDRV_PCM_RATE_8000_48000 unless I misread.

> +struct snd_soc_dai da9034_dais[] = {
> +	[0] = {
> +		.name		= "I2S HiFi",
> +		.playback	= {
> +			.stream_name	= "HiFi Playback",
> +			.channels_min	= 2,
> +			.channels_max	= 2,
> +			.rates		= DA9034_HIFI_RATES,
> +			.formats	= DA9034_PCM_FORMATS,
> +		},
> +		.ops = &da9034_dai_ops_hifi,
> +	},

Your hw_params function above sets the rate unconditionally without
seperate configuration for playback and capture.  This suggests that you
should be defining symmetric_rates here in order to stop applications
trying to reconfigure the rates with a record while a playback is active
(or vice versa).

> +	[1] = {
> +		.name		= "PCM Voice",
> +		.playback	= {
> +			.stream_name	= "Voice Playback",
> +			.channels_min = 1,
> +			.channels_max = 1,
> +			.rates = DA9034_VOICE_RATES,
> +			.formats = DA9034_PCM_FORMATS,
> +		},
> +		.capture = {
> +			.stream_name = "Voice Capture",
> +			.channels_min = 1,
> +			.channels_max = 1,
> +			.rates = DA9034_VOICE_RATES,
> +			.formats = DA9034_PCM_FORMATS,
> +		},
> +		.ops = &da9034_dai_ops_voice,
> +	},

Same comment looks like it applies to the voice DAI.

> +#ifdef CONFIG_DEBUG_FS

Please remove all this code - ASoC already has register dump support via
both debugfs and sysfs.  It currently uses register numbers rather than
names but I wouldn't be averse to patches adding name support.

> +static struct snd_soc_codec *da9034_codec;
> +
> +static int da9034_soc_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	int ret = 0;
> +
> +	BUG_ON(!da9034_codec);

Seems harsh but OK.

> +	dev_info(&pdev->dev, "da9034 (aka micco) audio codec registered\n");

dev_dbg() if you're going to have this.  Might be better to use
codec->dev rather than the platform device since other things will use
that and it's a bit more friendly.
