From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/10] ASoC: SMDKV310: Add I2S support
Date: Mon, 20 Dec 2010 13:41:37 +0000
Message-ID: <20101220134136.GF26706@rakim.wolfsonmicro.main>
References: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
	<1292810757-30224-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A1A0245C1
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 14:41:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292810757-30224-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 11:05:57AM +0900, Jassi@opensource.wolfsonmicro.com wrote:

> +	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1, WM8994_FLL_SRC_MCLK1,
> +					SMDK_WM8994_FREQ, pll_out);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_FLL1,
> +					pll_out, SND_SOC_CLOCK_IN);
> +	if (ret < 0)
> +		return ret;

...

> +static struct snd_soc_ops smdk_ops = {
> +	.hw_params = smdk_hw_params,
> +};

This means that the FLL won't ever get powered off when it goes idle.
While it's not going to be such an issue on a board like this as it is a
reference design it's likely people will lift the code into places where
it does matter so it'd be good to get such support into the driver.

> +	/* HeadPhone */
> +	snd_soc_dapm_enable_pin(dapm, "HPOUT1R");
> +	snd_soc_dapm_enable_pin(dapm, "HPOUT1L");

There's no need to explicitly enable pins that aren't being actively
managed - the default is for all pins to be enabled.

> +	snd_soc_dapm_sync(dapm);
> +

Core should be doing this automatically for you these days, on the other
hand this does no harm.
