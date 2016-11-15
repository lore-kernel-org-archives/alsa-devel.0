From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 05/19] ASoC: wm8510: Convert to
 module_i2c/spi_driver()
Date: Tue, 15 Nov 2016 09:33:11 +0100
Message-ID: <1132b3b4-4576-07e0-1fce-4a4ba255eb57@metafoo.de>
References: <871syd9vq9.wl%kuninori.morimoto.gx@renesas.com>
 <87twb98h2o.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id CF69726661C
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 09:33:18 +0100 (CET)
In-Reply-To: <87twb98h2o.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 11/15/2016 06:10 AM, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Let's use module_i2c/spi_driver()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/wm8510.c | 34 ++--------------------------------
>  1 file changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
> index 119ceac..2455606 100644
> --- a/sound/soc/codecs/wm8510.c
> +++ b/sound/soc/codecs/wm8510.c
> @@ -651,6 +651,7 @@ static int wm8510_spi_remove(struct spi_device *spi)
>  	.probe		= wm8510_spi_probe,
>  	.remove		= wm8510_spi_remove,
>  };
> +module_spi_driver(wm8510_spi_driver);
>  #endif /* CONFIG_SPI_MASTER */
>  
>  #if IS_ENABLED(CONFIG_I2C)
> @@ -698,40 +699,9 @@ static int wm8510_i2c_remove(struct i2c_client *client)
>  	.remove =   wm8510_i2c_remove,
>  	.id_table = wm8510_i2c_id,
>  };
> +module_i2c_driver(wm8510_i2c_driver);
>  #endif


This wont work when the driver is built as a module as this creates multiple
module init and exit entry points.

Ideally the driver would be split into submodules for i2c and spi, like
we've already done for a few drivers.
