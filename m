From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Tegra: Add support of tegra boards
 based	on ALC5632 codec
Date: Wed, 23 Nov 2011 13:50:39 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C817@HQMAIL01.nvidia.com>
References: <1321906088-29964-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id BD4EB103B47
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 22:50:49 +0100 (CET)
In-Reply-To: <1321906088-29964-1-git-send-email-leon@leon.nu>
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
To: Leon Romanovsky <leon@leon.nu>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

Leon Romanovsky wrote at Monday, November 21, 2011 1:08 PM:
> At this stage only Toshiba AC100/Dynabook supported.
...
> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
...
> +config SND_SOC_TEGRA_ALC5632
> +	tristate "SoC Audio support for Tegra boards using an ALC5632 codec"
> +	depends on SND_SOC_TEGRA && I2C
> +	select SND_SOC_TEGRA_I2S
> +	select SND_SOC_ALC5632
> +	help
> +	  Say Y or M here if you want to add support for SoC audio on the
> +	  Toshiba AC100 netbook.

If this is going to be named tegra_acl5632 rather than something board-
specific such as tegra_paz00, then perhaps you should do Kconfig the
same way as the tegra_wm8903 driver; have a MACH_HAS_SND_SOC_TEGRA_ALC5632
variable that boards need to select, and make this depend on that?

> diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
...
> +static int tegra_alc5632_asoc_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
...
> +	srate = params_rate(params);
> +	switch (srate) {
> +	case 64000:
> +	case 88200:
> +	case 96000:
> +		mclk = 128 * srate;
> +		break;
> +	default:
> +		mclk = 512 * srate;
> +		break;
> +	}
> +	/* FIXME: Codec only requires >= 3MHz if OSR==0 */
> +	while (mclk < 6000000)
> +		mclk *= 2;

That is identical to the code in tegra_wm8903. Are you sure it's correct
for the ALC5632? At the very least, I think the comment is wrong; OSR is
a WM8903 register field, which I doubt exists on the ALC5632.

> +	err = snd_soc_dai_set_fmt(cpu_dai,
> +					SND_SOC_DAIFMT_I2S |
> +					SND_SOC_DAIFMT_NB_NF |
> +					SND_SOC_DAIFMT_CBS_CFS);
> +	if (err < 0) {
> +		dev_err(card->dev, "cpu_dai fmt not set\n");
> +		return err;
> +	}
> +
> +	err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
> +					SND_SOC_CLOCK_IN);
> +	if (err < 0) {
> +		dev_err(card->dev, "codec_dai clock not set\n");
> +		return err;
> +	}

Mark Brown wrote here:
> These should use the .dai_fmt member in the dai_link struct.

Mark, I guess you mean that we should remove those two snd_soc_dai_set_fmt
calls, and just set .dai_fmt to a constant value? If so, that should be
applied to the other two Tegra machine drivers too.

That said, while these values are constant right now, I think they won't
always be; I think we'll need to switch between DSP mode for mono and
I2S mode for stereo here; at least I /think/ that's what I remember our
downstream drivers doing...

> +static struct snd_soc_jack_gpio tegra_alc5632_hs_jack_gpios[] = {
> +	{
> +		.name = "Headset Detect",
> +		.report = SND_JACK_HEADSET,
> +		.debounce_time = 150,
> +	}
> +};

You probably don't want to make this an array, since that'll make the
code that fills in tegra_alc5632_hs_jack_gpio [0].gpio have to hard-code
the "0" array index; better to make this just:

static struct snd_soc_jack_gpio tegra_alc5632_hs_jack_gpio = {
	.name = "Headset Detect",
	.report = SND_JACK_HEADSET,
	.debounce_time = 150,
};

And then you can assign tegra_alc5632_hs_jack_gpio.gpio.

> +static const struct snd_soc_dapm_route tegra_alc5632_audio_map[] = {
> +	/* Internal Mic */
> +	{"MIC2", NULL, "Mic Bias 2"},
> +	{"Mic Bias 2", NULL, "Int Mic"},

Yay, a separate mic bias for each microphone:-)

> +static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
...
> +	snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
> +			 &tegra_alc5632_hs_jack);
> +	snd_soc_jack_add_pins(&tegra_alc5632_hs_jack,
> +			ARRAY_SIZE(tegra_alc5632_hs_jack_pins),
> +			tegra_alc5632_hs_jack_pins);
> +	snd_soc_jack_add_gpios(&tegra_alc5632_hs_jack,
> +			ARRAY_SIZE(tegra_alc5632_hs_jack_gpios),
> +			tegra_alc5632_hs_jack_gpios);

Do you need to call something in the ALC5632 codec driver here to start
mic detection? The tegra_wm8903 driver calls wm8903_mic_detect() here.

> +	snd_soc_dapm_nc_pin(dapm, "AUXOUT");
> +	snd_soc_dapm_nc_pin(dapm, "LINEINL");
> +	snd_soc_dapm_nc_pin(dapm, "LINEINR");
> +	snd_soc_dapm_nc_pin(dapm, "PHONEP");
> +	snd_soc_dapm_nc_pin(dapm, "PHONEN");
> +	snd_soc_dapm_nc_pin(dapm, "MIC2");

----------==========----------==========----------==========----------==========
You may be able to remove that if you set snd_soc_tegra_alc5632.fully_routed.
The patch for that was just merged into Mark's ASoC tree.

> +static __devinit int tegra_alc5632_probe(struct platform_device *pdev)
...
> +	alc5632 = kzalloc(sizeof(struct tegra_alc5632), GFP_KERNEL);

If you use devm_kzalloc there, it'll remove the need to manually free
it; see the very latest tegra_wm8903 driver.

> +err_clear_drvdata:
> +	snd_soc_card_set_drvdata(card, NULL);
> +	platform_set_drvdata(pdev, NULL);
> +	card->dev = NULL;

There's no need for those last 3 lines.

> +	tegra_asoc_utils_fini(&alc5632->util_data);
> +err_free_tegra_alc5632:
> +	kfree(alc5632);

That kfree is what you could get rid of using devm_kzalloc.

> +static int __devexit tegra_alc5632_remove(struct platform_device *pdev)
...
> +	snd_soc_card_set_drvdata(card, NULL);
> +	platform_set_drvdata(pdev, NULL);
> +	card->dev = NULL;

Same here; no need for those last 3 lines.

> +	tegra_asoc_utils_fini(&alc5632->util_data);
> +
> +	kfree(alc5632);

That's another thing you could remove if using devm_kzalloc.

...
> +MODULE_LICENSE("GPL");

The comment at the top would imply "GPL v2", since no "or later" is
mentioned there. Yes, the existing Tegra code is probably wrong here too.

-- 
nvpublic
