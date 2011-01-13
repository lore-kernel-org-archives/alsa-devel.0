From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin: fix DAI/SPORT config
	dependency issues
Date: Thu, 13 Jan 2011 13:55:05 +0000
Message-ID: <20110113135505.GC11840@opensource.wolfsonmicro.com>
References: <1294794268-18416-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 185B8103B06
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:54:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294794268-18416-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 08:04:28PM -0500, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>
> 
> While I2S/TDM/AC97 DAI is built-in, others are compiled as modules,
> SND_BF5XX_SOC_SPORT will be module, then DAI can't get some symbols.
> Except that, SND_BF5XX_AC97 depends on SND_BF5XX_SOC_AC97 too.
> 
> Signed-off-by: Barry Song <barry.song@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Ccing in Liam - Mike, please remember to CC maintainers on patches.

> ---
>  sound/soc/blackfin/Kconfig |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
> index 3abeedd..ae40359 100644
> --- a/sound/soc/blackfin/Kconfig
> +++ b/sound/soc/blackfin/Kconfig
> @@ -1,6 +1,7 @@
>  config SND_BF5XX_I2S
>  	tristate "SoC I2S Audio for the ADI BF5xx chip"
>  	depends on BLACKFIN
> +	select SND_BF5XX_SOC_SPORT
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the Blackfin SPORT (synchronous serial ports) interface in I2S
> @@ -35,6 +36,7 @@ config SND_BFIN_AD73311_SE
>  config SND_BF5XX_TDM
>  	tristate "SoC I2S(TDM mode) Audio for the ADI BF5xx chip"
>  	depends on (BLACKFIN && SND_SOC)
> +	select SND_BF5XX_SOC_SPORT
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the Blackfin SPORT (synchronous serial ports) interface in TDM
> @@ -61,6 +63,10 @@ config SND_BF5XX_SOC_AD193X
>  config SND_BF5XX_AC97
>  	tristate "SoC AC97 Audio for the ADI BF5xx chip"
>  	depends on BLACKFIN
> +	select AC97_BUS
> +	select SND_SOC_AC97_BUS
> +	select SND_BF5XX_SOC_SPORT
> +	select SND_BF5XX_SOC_AC97
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the Blackfin SPORT (synchronous serial ports) interface in slot 16
> @@ -122,17 +128,12 @@ config SND_BF5XX_SOC_SPORT
>  
>  config SND_BF5XX_SOC_I2S
>  	tristate
> -	select SND_BF5XX_SOC_SPORT
>  
>  config SND_BF5XX_SOC_TDM
>  	tristate
> -	select SND_BF5XX_SOC_SPORT
>  
>  config SND_BF5XX_SOC_AC97
>  	tristate
> -	select AC97_BUS
> -	select SND_SOC_AC97_BUS
> -	select SND_BF5XX_SOC_SPORT
>  
>  config SND_BF5XX_SPORT_NUM
>  	int "Set a SPORT for Sound chip"
> -- 
> 1.7.4.rc1
> 
