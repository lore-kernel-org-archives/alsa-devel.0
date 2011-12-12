From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v2] ASoC: Tegra machine ASoC driver for
 boards using ALC5332 codec
Date: Mon, 12 Dec 2011 12:20:46 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF175186086F@HQMAIL01.nvidia.com>
References: <1323719154-18344-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 0578A24378
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 21:21:00 +0100 (CET)
In-Reply-To: <1323719154-18344-1-git-send-email-leon@leon.nu>
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

Leon Romanovsky wrote at Monday, December 12, 2011 12:46 PM:
> At this stage only Toshiba AC100/Dynabook supported.

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

I think you should replace all that with:

mclk = 512 * srate;

The reason being:

* The codec only supports up to 48KHz as far as I can tell, thus making
the special-case in the switch statement never fire, and irrelevant.

* The codec wants 512Fs, not min(6MHz, 512Fs) as far as I can tell, so
the extra while loop at the end is going to set the wrong rate for 8KHz
and 11.025KHz.

> +static struct snd_soc_jack_gpio tegra_alc5632_hs_jack_gpio = {
> +	.name = "Headset Detect",
> +	.report = SND_JACK_HEADSET,
> +	.debounce_time = 150,
> +};
...
> +static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
> +{
...
> +	snd_soc_jack_add_gpios(&tegra_alc5632_hs_jack,
> +			1, &tegra_alc5632_hs_jack_gpio);

Since tegra_alc5632_hs_jack_gpio is never set, doesn't this end up using
GPIO 0 as the headset detect, which most likely is something completely
unrelated to audio.

Other than those two things, this looks fine to me.

-- 
nvpublic
