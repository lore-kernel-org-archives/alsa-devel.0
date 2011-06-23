From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Add ADAV80x codec driver
Date: Thu, 23 Jun 2011 13:34:13 +0100
Message-ID: <4E0332C5.7010608@ti.com>
References: <1308808818-26775-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A2E6103ADF
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 14:34:20 +0200 (CEST)
In-Reply-To: <1308808818-26775-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Frysinger <vapier.adi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 23/06/11 07:00, Lars-Peter Clausen wrote:
> This patch adds support for the Analog Devices ADAV801 and ADAV803 audio codec.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> Changes since v1:
> * Sync register on resume
> * Don't use arrays for the mux enums and controls
> * Rework PLL handling. Use DAPM for powering the PLL and OSC down and use
>   set_sysclk to select the system clock instead of doing this implicitly in
>   set_pll.
> ---
>  MAINTAINERS                |    1 +
>  sound/soc/codecs/Kconfig   |    4 +
>  sound/soc/codecs/Makefile  |    2 +
>  sound/soc/codecs/adav80x.c |  908 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/adav80x.h |   31 ++
>  5 files changed, 946 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/adav80x.c
>  create mode 100644 sound/soc/codecs/adav80x.h
> 

snip

> +
> +static int adav80x_probe(struct snd_soc_codec *codec)
> +{
> +       int ret;
> +       struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
> +
> +       ret = snd_soc_codec_set_cache_io(codec, 7, 9, adav80x->control_type);
> +       if (ret) {
> +               dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* Power down SYSCLK output, power down S/PDIF receiver */
> +       snd_soc_write(codec, ADAV80X_PLL_OUTE, 0x27);
> +       /* Disable DAC zero flag */
> +       snd_soc_write(codec, ADAV80X_DAC_CTRL3, 0x6);
> +
> +       return adav80x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +}
> +

It's usually better disable things like sysclk output in your machine driver as others may depend on it for probing.

Liam
