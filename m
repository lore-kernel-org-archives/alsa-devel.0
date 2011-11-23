From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Tegra: Add support of tegra boards
 based on ALC5632 codec
Date: Wed, 23 Nov 2011 15:38:09 +0000
Message-ID: <20111123153809.GC30049@opensource.wolfsonmicro.com>
References: <1321906088-29964-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8DBA103B17
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 16:38:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321906088-29964-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 21, 2011 at 10:08:08PM +0200, Leon Romanovsky wrote:

Mostly OK, a few things below but they're very minor.

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

These should use the .dai_fmt member in the dai_link struct.

> +	ret = snd_soc_add_controls(codec, tegra_alc5632_controls,
> +				   ARRAY_SIZE(tegra_alc5632_controls));
> +	if (ret < 0)
> +		return ret;
> +
> +	snd_soc_dapm_new_controls(dapm, tegra_alc5632_dapm_widgets,
> +		ARRAY_SIZE(tegra_alc5632_dapm_widgets));
> +
> +	snd_soc_dapm_add_routes(dapm, tegra_alc5632_audio_map,
> +		ARRAY_SIZE(tegra_alc5632_audio_map));

These should use the controls, dapm_widgets and dapm_routes members of
the card structure.

> +
> +	snd_soc_dapm_sync(dapm);

No need for this, the core will sync for you.

> +	if (!machine_is_paz00()) {
> +		dev_err(&pdev->dev, "Not running on Toshiba AC100!\n");
> +		return -ENODEV;
> +	}

Should be no need to check for htis as you're using an explicit platform
device - if the device is registered you should be OK.

> +static int __init tegra_alc5632_init(void)
> +{
> +	return platform_driver_register(&tegra_alc5632_driver);
> +}
> +module_init(tegra_alc5632_init);
> +
> +static void __exit tegra_alc5632_exit(void)
> +{
> +	platform_driver_unregister(&tegra_alc5632_driver);
> +}
> +module_exit(tegra_alc5632_exit);

Use platform_module_driver for this.
