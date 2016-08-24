From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH -next] sound: rockchip: fix build when SPI is not enabled
Date: Wed, 24 Aug 2016 10:55:08 -0700
Message-ID: <52b8a769-e582-d9d7-403a-e49a59067786@infradead.org>
References: <14691987-ab74-96c4-de5d-8caa06e94d3f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14691987-ab74-96c4-de5d-8caa06e94d3f@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 08/22/16 11:32, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors found in rt5514 drivers when SPI is not enabled.
> 
> Fixes these build errors:
> ERROR: "__spi_register_driver" [sound/soc/codecs/snd-soc-rt5514-spi.ko] undefined!
> ERROR: "spi_sync" [sound/soc/codecs/snd-soc-rt5514-spi.ko] undefined!
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	Bard Liao <bardliao@realtek.com>
> Cc:	Oder Chiou <oder_chiou@realtek.com>
> ---
>  sound/soc/rockchip/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This builds without errors, but if you always want to have the SPI
> interface available in this driver, change the first "depends" to
> include "&& SPI_MASTER".

Please drop this patch.  The comment above is the correct thing to do
and I am sending a patch with that change.


> --- linux-next-20160822.orig/sound/soc/rockchip/Kconfig
> +++ linux-next-20160822/sound/soc/rockchip/Kconfig
> @@ -49,7 +49,7 @@ config SND_SOC_RK3399_GRU_SOUND
>  	select SND_SOC_MAX98357A
>  	select SND_SOC_RT5514
>  	select SND_SOC_DA7219
> -	select SND_SOC_RT5514_SPI
> +	select SND_SOC_RT5514_SPI if SPI_MASTER
>  	help
>  	  Say Y or M here if you want to add support multiple codecs for SoC
>  	  audio on Rockchip RK3399 GRU boards.
> 


-- 
~Randy
