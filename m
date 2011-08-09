From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Fix SPI driver binding for WM8987
Date: Tue, 9 Aug 2011 13:17:02 +0100
Message-ID: <4E41253E.2040407@ti.com>
References: <1312362661-4544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id D3D3F103845
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 14:17:07 +0200 (CEST)
In-Reply-To: <1312362661-4544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/08/11 10:11, Mark Brown wrote:
> As we had no id_table only the driver name would be matched against
> meaning that WM8987 devices wouldn't be bound.
> 

Subject line is for wrong codec but otherwise (with new subject line)

Acked-by: Liam Girdwood <lrg@ti.com>

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8750.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
> index 6cbf51b..2bb7bea 100644
> --- a/sound/soc/codecs/wm8750.c
> +++ b/sound/soc/codecs/wm8750.c
> @@ -779,11 +779,18 @@ static int __devexit wm8750_spi_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct spi_device_id wm8750_spi_ids[] = {
> +	{ "wm8750", 0 },
> +	{ "wm8987", 0 },
> +};
> +MODULE_DEVICE_TABLE(spi, wm8750_spi_id);
> +
>  static struct spi_driver wm8750_spi_driver = {
>  	.driver = {
> -		.name	= "wm8750-codec",
> +		.name	= "wm8750",
>  		.owner	= THIS_MODULE,
>  	},
> +	.id_table	= wm8750_spi_ids,
>  	.probe		= wm8750_spi_probe,
>  	.remove		= __devexit_p(wm8750_spi_remove),
>  };
