From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/5] ASoC: pxa: add DT bindings for
	pxa2xx-pcm
Date: Mon, 12 Aug 2013 11:00:20 +0200
Message-ID: <5208A424.70704@metafoo.de>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-6-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id C94F626030A
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 11:00:07 +0200 (CEST)
In-Reply-To: <1376296961-20564-6-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, broonie@kernel.org, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 08/12/2013 10:42 AM, Daniel Mack wrote:
> The bindings do not carry any resources, as the module only registers
> the ASoC platform driver.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>

As this is just a virtual device (and Linux specific) it shouldn't be in the 
devicetree. Usually when using devicetree you'd register the PCM device from 
the CPU DAI driver. Take a look at how other platforms (e.g. tegra) do this.

- Lars

> ---
>   .../devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt         | 15 +++++++++++++++
>   sound/soc/pxa/pxa2xx-pcm.c                                | 13 +++++++++++--
>   2 files changed, 26 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt b/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
> new file mode 100644
> index 0000000..551fbb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
> @@ -0,0 +1,15 @@
> +DT bindings for ARM PXA2xx PCM platform driver
> +
> +This is just a dummy driver that registers the PXA ASoC platform driver.
> +It does not have any resources assigned.
> +
> +Required properties:
> +
> +	- compatible		'mrvl,pxa-pcm-audio'
> +
> +Example:
> +
> +	pxa_pcm_audio: snd_soc_pxa_audio {
> +		compatible = "mrvl,pxa-pcm-audio";
> +	};
> +
> diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
> index 0aa2d69..806da27 100644
> --- a/sound/soc/pxa/pxa2xx-pcm.c
> +++ b/sound/soc/pxa/pxa2xx-pcm.c
> @@ -13,6 +13,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/module.h>
>   #include <linux/dmaengine.h>
> +#include <linux/of.h>
>
>   #include <sound/core.h>
>   #include <sound/soc.h>
> @@ -133,10 +134,18 @@ static int pxa2xx_soc_platform_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id snd_soc_pxa_audio_match[] = {
> +	{ .compatible   = "mrvl,pxa-pcm-audio" },
> +	{ }
> +};
> +#endif
> +
>   static struct platform_driver pxa_pcm_driver = {
>   	.driver = {
> -			.name = "pxa-pcm-audio",
> -			.owner = THIS_MODULE,
> +		.name = "pxa-pcm-audio",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(snd_soc_pxa_audio_match),
>   	},
>
>   	.probe = pxa2xx_soc_platform_probe,
>
