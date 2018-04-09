From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v6,
 2/2] ASoC: AMD: Enable/Disable auxiliary clock via common
 clock	framework
Date: Mon, 9 Apr 2018 12:28:02 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E5221@SW-EX-MBX01.diasemi.com>
References: <1523265596-8837-1-git-send-email-akshu.agrawal@amd.com>
 <1523265596-8837-2-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.143])
 by alsa0.perex.cz (Postfix) with ESMTP id E816F266C99
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 14:28:05 +0200 (CEST)
In-Reply-To: <1523265596-8837-2-git-send-email-akshu.agrawal@amd.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Akshu Agrawal <akshu.agrawal@amd.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 09 April 2018 10:20, Akshu Agrawal wrote:

> This enables/disables and sets auxiliary clock at 25Mhz. It uses
> common clock framework for proper ref counting. This approach will
> save power in comparison to keeping it always On in firmware.
> 
> TEST= aplay -vv <file>
> check register to see clock enabled
> kill aplay
> check register to see clock disabled
> 
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> V2: Correcting the pin to OSCOUT1 from OSCOUT2
> V3: Fix error/warnings from kbuild test
> V4: Fix build errors for platform which do not support CONFIG_COMMON_CLK
> V5: Review comments by Dan and Sriram
> V6: Adding COMMON_CLK to Kconfig, moving clk_get to register, var name changes
> 
>  sound/soc/amd/Kconfig                |   2 +-
>  sound/soc/amd/acp-da7219-max98357a.c | 150
> +++++++++++++++++++++++++++++++++--
>  2 files changed, 146 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
> index 6cbf9cf..8104f8f 100644
> --- a/sound/soc/amd/Kconfig
> +++ b/sound/soc/amd/Kconfig
> @@ -8,7 +8,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
>  	select SND_SOC_DA7219
>  	select SND_SOC_MAX98357A
>  	select SND_SOC_ADAU7002
> -	depends on SND_SOC_AMD_ACP && I2C
> +	depends on SND_SOC_AMD_ACP && I2C && COMMON_CLK
>  	help
>  	 This option enables machine driver for DA7219 and MAX9835.
> 
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-
> da7219-max98357a.c
> index 1012a80..29847f7 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -30,21 +30,42 @@
>  #include <sound/soc-dapm.h>
>  #include <sound/jack.h>
>  #include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <linux/acpi.h>
> +#include <linux/types.h>
> 
>  #include "../codecs/da7219.h"
>  #include "../codecs/da7219-aad.h"
> 
> -#define CZ_PLAT_CLK 24000000
> -#define MCLK_RATE 24576000
> +#define CZ_PLAT_CLK 25000000
> +#define DA7219_PLL_OUT 24576000
>  #define DUAL_CHANNEL		2
> 
> +/* Clock Driving Strength 2 register */
> +#define CLKDRVSTR2	0x28
> +/* Clock Control 1 register */
> +#define MISCCLKCNTL1	0x40
> +/* Auxiliary clock1 enable bit */
> +#define OSCCLKENB	2
> +/* 25Mhz auxiliary output clock freq bit */
> +#define OSCOUT1CLK25MHZ	16
> +
> +struct cz_clock {
> +	const char* acp_clk_name;
> +	struct clk_hw acp_clk_hw;
> +	struct clk_lookup *acp_clk_lookup;
> +	struct clk *acp_clk;
> +	void __iomem *res_base;
> +};
> +
>  static struct snd_soc_jack cz_jack;
> -struct clk *da7219_dai_clk;
> +static struct clk *da7219_dai_clk;
> +static struct clk *acpd7219_clk;
> 
>  static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>  {
> @@ -64,13 +85,18 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
>  	}
> 
>  	ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
> -				  CZ_PLAT_CLK, MCLK_RATE);
> +				  CZ_PLAT_CLK, DA7219_PLL_OUT);

For the PLL_OUT value you should use one of the following:

 - For 48KHz family of SRs:	'DA7219_PLL_FREQ_OUT_98304'
 - For 44.1KHz family of SRs:	'DA7219_PLL_FREQ_OUT_90316'

These will ensure correct calculations in the codec's set_pll() function for the
sampling rate family you require.
