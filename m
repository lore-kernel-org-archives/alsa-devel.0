From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH,
	RFC 3/3] pxa/magician: add I2C board info	and platform data for
	UDA1380
Date: Sun, 14 Jun 2009 16:00:23 +0100
Message-ID: <20090614150023.GC4482@sirena.org.uk>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-5-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 43A68243D3
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Jun 2009 17:00:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1244976692-5189-5-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 14, 2009 at 12:51:32PM +0200, Philipp Zabel wrote:
> Configures I2C address, power/reset GPIOs and DAC clock from WSPLL.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Eric, I don't know how you want to deal with the cross tree issues for
this patch?  It's part of a conversion of the UDA1380 driver to the
standard device model so it'll depend on ASoC changes to the UDA1380
driver but obviously there's arch/arm/mach-pxa changes too.

One way of making sure there aren't any problem would be for one of us
to apply both patches to a branch which can then be pulled in to both
the ASoC and PXA trees.  Does that sound sane?

> ---
>  arch/arm/mach-pxa/magician.c |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
> index 869f083..3da8284 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -43,6 +43,8 @@
>  #include <mach/irda.h>
>  #include <mach/ohci.h>
>  
> +#include <sound/uda1380.h>
> +
>  #include "devices.h"
>  #include "generic.h"
>  
> @@ -862,9 +864,22 @@ static struct platform_device calypso = {
>  };
>  
>  /*
> - * I2C
> + * Philips UDA1380 on I2C
>   */
>  
> +static struct uda1380_platform_data uda1380_info = {
> +	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
> +	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
> +	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
> +};
> +
> +static struct i2c_board_info i2c_board_info[] = {
> +	{
> +		I2C_BOARD_INFO("uda1380", 0x18),
> +		.platform_data = &uda1380_info,
> +	},
> +};
> +
>  static struct i2c_pxa_platform_data i2c_info = {
>  	.fast_mode = 1,
>  };
> @@ -906,6 +921,7 @@ static void __init magician_init(void)
>  	}
>  	pxa27x_set_i2c_power_info(NULL);
>  	pxa_set_i2c_info(&i2c_info);
> +	i2c_register_board_info(0, ARRAY_AND_SIZE(i2c_board_info));
>  	i2c_register_board_info(1, ARRAY_AND_SIZE(pi2c_board_info));
>  	pxa_set_mci_info(&magician_mci_info);
>  	pxa_set_ohci_info(&magician_ohci_info);
> -- 
> 1.6.3.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
