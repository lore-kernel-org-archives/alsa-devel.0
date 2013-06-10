From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adav80x: Select SND_SOC_ADAV80X if
	SND_SOC_I2C_AND_SPI
Date: Mon, 10 Jun 2013 15:24:30 +0200
Message-ID: <51B5D38E.1080706@metafoo.de>
References: <1370870444.14367.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-067.synserver.de (smtp-out-069.synserver.de
 [212.40.185.69])
 by alsa0.perex.cz (Postfix) with ESMTP id E376A2615EE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 15:24:27 +0200 (CEST)
In-Reply-To: <1370870444.14367.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Yi Li <yi.li@analog.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/10/2013 03:20 PM, Axel Lin wrote:
> This driver is useless if both SPI and I2C are not configured.
> Thus don't build this driver if both SPI and I2C are not configured.
> 
> This patch silences below build warning if both SPI and I2C are not configured.
> 
>   CC      sound/soc/codecs/adav80x.o
> sound/soc/codecs/adav80x.c:842:12: warning: 'adav80x_bus_probe' defined but not used [-Wunused-function]
> sound/soc/codecs/adav80x.c:863:12: warning: 'adav80x_bus_remove' defined but not used [-Wunused-function]
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Yep, wanted to send the same patch sometime in the next days, since this
actually also fixes a compile error in case of I2C=m and SPI=y.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/codecs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c90d298..6234900 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -19,7 +19,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
>  	select SND_SOC_AD73311
>  	select SND_SOC_ADAU1373 if I2C
> -	select SND_SOC_ADAV80X
> +	select SND_SOC_ADAV80X if SND_SOC_I2C_AND_SPI
>  	select SND_SOC_ADS117X
>  	select SND_SOC_AK4104 if SPI_MASTER
>  	select SND_SOC_AK4535 if I2C
