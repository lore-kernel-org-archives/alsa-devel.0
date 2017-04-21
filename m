From: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: add I2C dependency for
	CS42XX8
Date: Fri, 21 Apr 2017 10:10:38 +0800
Message-ID: <1492740638.23218.0.camel@mtkswgap22>
References: <20170420081541.658178-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id F241D267064
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 04:10:47 +0200 (CEST)
In-Reply-To: <20170420081541.658178-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Koro Chen <koro.chen@mediatek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-04-20 at 10:15 +0200, Arnd Bergmann wrote:
> We should not select drivers that depend on I2C when that is disabled,
> as it results in a build error:
> 
> warning: (SND_SOC_MT2701_WM8960) selects SND_SOC_WM8960 which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && I2C)
> sound/soc/codecs/wm8960.c:1469:1: error: data definition has no type or storage class [-Werror]
> sound/soc/codecs/wm8960.c:1469:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> 
> Fixes: 8625c1dbd876 ("ASoC: mediatek: Add mt2701-wm8960 machine driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/mediatek/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index c6f39040f71f..5c68797f36c4 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -24,7 +24,7 @@ config SND_SOC_MT2701_CS42448
>  
>  config SND_SOC_MT2701_WM8960
>  	tristate "ASoc Audio driver for MT2701 with WM8960 codec"
> -	depends on SND_SOC_MT2701
> +	depends on SND_SOC_MT2701 && I2C
>  	select SND_SOC_WM8960
>  	help
>  	  This adds ASoC driver for Mediatek MT2701 boards


Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Thanks
