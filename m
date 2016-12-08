From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH V2 2/2] ASoC: samsung: add GPIOLIB dependency
Date: Thu, 8 Dec 2016 22:51:19 +0200
Message-ID: <20161208205119.GB17693@kozik-lap>
References: <1481229799-17532-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481229799-17532-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 08, 2016 at 09:43:19PM +0100, Fabian Frederick wrote:
> Both SND_SOC_SMARTQ and SND_SOC_SAMSUNG_TM2_WM5110
> use gpio/consumer.h
> This patch adds GPIOLIB || COMPILE_TEST to Kconfig entries
> to avoid any build errors.

I think that is not entirely correct. There won't be build errors here
because build dependency is satisfied by header (for both cases: GPIOLIB
and !GPIOLIB). However this fixes runtime dependency - the driver
requires GPIOLIB to work.

Beside the commit msg, it is okay:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> 
> See commit 638f958baeaf
> ("extcon: Allow compile test of GPIO consumers if !GPIOLIB")
> 
> for similar problem and explanations.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  sound/soc/samsung/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index 7c42315..f1f1d79 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -111,6 +111,7 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
>  config SND_SOC_SMARTQ
>  	tristate "SoC I2S Audio support for SmartQ board"
>  	depends on MACH_SMARTQ || COMPILE_TEST
> +	depends on GPIOLIB || COMPILE_TEST
>  	depends on I2C
>  	select SND_SAMSUNG_I2S
>  	select SND_SOC_WM8750
> @@ -193,6 +194,7 @@ config SND_SOC_ARNDALE_RT5631_ALC5631
>  config SND_SOC_SAMSUNG_TM2_WM5110
>  	tristate "SoC I2S Audio support for WM5110 on TM2 board"
>  	depends on SND_SOC_SAMSUNG && MFD_ARIZONA && I2C && SPI_MASTER
> +	depends on GPIOLIB || COMPILE_TEST
>  	select SND_SOC_MAX98504
>  	select SND_SOC_WM5110
>  	select SND_SAMSUNG_I2S
> -- 
> 2.7.4
> 
