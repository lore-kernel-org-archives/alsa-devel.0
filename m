From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/2] ASoC: atmel: simplify Kconfig
Date: Tue, 26 May 2015 12:13:43 +0200
Message-ID: <55644757.7060602@atmel.com>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 17D96265019
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:14:41 +0200 (CEST)
In-Reply-To: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Le 26/05/2015 00:04, Alexandre Belloni a =E9crit :
> Enclose the options in if SND_ATMEL_SOC ... endif to remove the dependenc=
y.
> Also remove the useless description for SND_ATMEL_SOC_SSC.
> =

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

For the record:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  sound/soc/atmel/Kconfig | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> =

> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index e7d08806f3e9..93abe4e6d596 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -6,27 +6,22 @@ config SND_ATMEL_SOC
>  	  the ATMEL SSC interface. You will also need
>  	  to select the audio interfaces to support below.
>  =

> +if SND_ATMEL_SOC
> +
>  config SND_ATMEL_SOC_PDC
>  	tristate
> -	depends on SND_ATMEL_SOC
>  =

>  config SND_ATMEL_SOC_DMA
>  	tristate
> -	depends on SND_ATMEL_SOC
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  =

>  config SND_ATMEL_SOC_SSC
>  	tristate
> -	depends on SND_ATMEL_SOC
> -	help
> -	  Say Y or M if you want to add support for codecs the
> -	  ATMEL SSC interface. You will also needs to select the individual
> -	  machine drivers to support below.
>  =

>  config SND_AT91_SOC_SAM9G20_WM8731
>  	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation boa=
rd"
>  	depends on ARCH_AT91 || COMPILE_TEST
> -	depends on ATMEL_SSC && SND_ATMEL_SOC && SND_SOC_I2C_AND_SPI
> +	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
>  	select SND_ATMEL_SOC_PDC
>  	select SND_ATMEL_SOC_SSC
>  	select SND_SOC_WM8731
> @@ -37,7 +32,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
>  config SND_ATMEL_SOC_WM8904
>  	tristate "Atmel ASoC driver for boards using WM8904 codec"
>  	depends on ARCH_AT91 || COMPILE_TEST
> -	depends on ATMEL_SSC && SND_ATMEL_SOC && I2C
> +	depends on ATMEL_SSC && I2C
>  	select SND_ATMEL_SOC_SSC
>  	select SND_ATMEL_SOC_DMA
>  	select SND_SOC_WM8904
> @@ -48,10 +43,11 @@ config SND_ATMEL_SOC_WM8904
>  config SND_AT91_SOC_SAM9X5_WM8731
>  	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
>  	depends on ARCH_AT91 || COMPILE_TEST
> -	depends on ATMEL_SSC && SND_ATMEL_SOC && SND_SOC_I2C_AND_SPI
> +	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
>  	select SND_ATMEL_SOC_SSC
>  	select SND_ATMEL_SOC_DMA
>  	select SND_SOC_WM8731
>  	help
>  	  Say Y if you want to add support for audio SoC on an
>  	  at91sam9x5 based board that is using WM8731 codec.
> +endif
> =



-- =

Nicolas Ferre
