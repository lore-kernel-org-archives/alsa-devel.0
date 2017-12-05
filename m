From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] [v2] ASoC: atmel-classd: improve Kconfig
	dependencies
Date: Tue, 5 Dec 2017 14:24:54 +0100
Message-ID: <20171205132454.GK21780@piout.net>
References: <20171205131022.2082003-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 55FC0266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 14:25:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171205131022.2082003-1-arnd@arndb.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 05/12/2017 at 14:10:11 +0100, Arnd Bergmann wrote:
> Commit 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
> changed the way that the dependencies are handled, but then the
> Class D amplifier support got merged, which used the old method.
> 
> This seems to have triggered a very rare randconfig condition for me
> now, leading to a link error:
> 
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> atmel_ssc_dai.c:(.text+0x79c): undefined reference to `atmel_pcm_dma_platform_register'
> atmel_ssc_dai.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_register'
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_put_audio':
> atmel_ssc_dai.c:(.text+0xf24): undefined reference to `atmel_pcm_dma_platform_unregister'
> atmel_ssc_dai.c:(.text+0xf24): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `atmel_pcm_dma_platform_unregister'
> 
> This changes the SND_ATMEL_SOC_DMA option so it gets built whenever
> one of the two users (SND_ATMEL_SOC_SSC_DMA and SND_ATMEL_SOC_CLASSD)
> is enabled, with the twist that we make it built-in when SND_ATMEL_SOC_SSC
> is built-in, even if one of the other two is a module.
> 
> I think this captures best what the real dependency in the hardware
> is, and it simplifies the logic a bit.
> 
> Fixes: e0a25b6d1862 ("ASoC: atmel-classd: add the Audio Class D Amplifier")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rewrite the change completely, after running into a new regression.
> 
> I'm putting it out on the list so we can review the change together,
> but I'm still doing more testing at the same time. If I don't reply
> by Dec 6, nothing new has come up.
> ---
>  sound/soc/atmel/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index 4a56f3dfba51..af9a9096d50b 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -20,8 +20,8 @@ config SND_ATMEL_SOC_SSC_PDC
>  config SND_ATMEL_SOC_DMA
>  	tristate
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
> -	default m if SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=m
> -	default y if SND_ATMEL_SOC_SSC_DMA=y || (SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=y)
> +	default y if SND_ATMEL_SOC_SSC=y && (SND_ATMEL_SOC_SSC_DMA=m || SND_ATMEL_SOC_CLASSD=m)
> +	default SND_ATMEL_SOC_CLASSD || SND_ATMEL_SOC_SSC_DMA
>  

I really think the only required dependency for SND_ATMEL_SOC_CLASSD is
SND_SOC_GENERIC_DMAENGINE_PCM. It comes with SND_ATMEL_SOC_DMA but it
doesn't actually use anything provided specifically by atmel-pcm-dma.c

Basically, it handles all of its DMA operations itself.

>  config SND_ATMEL_SOC_SSC_DMA
>  	tristate
> @@ -64,7 +64,6 @@ config SND_AT91_SOC_SAM9X5_WM8731
>  config SND_ATMEL_SOC_CLASSD
>  	tristate "Atmel ASoC driver for boards using CLASSD"
>  	depends on ARCH_AT91 || COMPILE_TEST
> -	select SND_ATMEL_SOC_DMA
>  	select REGMAP_MMIO
>  	help
>  	  Say Y if you want to add support for Atmel ASoC driver for boards using
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
