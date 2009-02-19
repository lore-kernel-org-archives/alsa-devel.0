From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Thu, 19 Feb 2009 21:21:59 +0000
Message-ID: <4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk>
References: <87iqn6f97x.fsf@free.fr> (sfid-20090219_204415_285057_2FE278FF)
Mime-Version: 1.0 (iPhone Mail 5H11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B767A243B4
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2009 22:21:58 +0100 (CET)
In-Reply-To: <87iqn6f97x.fsf@free.fr> (sfid-20090219_204415_285057_2FE278FF)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 19 Feb 2009, at 20:44, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> Hi Mark,
>
> I can't find out if somebody had submitted that kind of patch  
> before. This is a
> starting point of discussion. I'm not fully convinced by my own  
> code, and so I
> post it here for advice.
>
> What I'd really like is to be able to choose the PXA AC97 gpio reset  
> (GPIO95 or
> GPIO113) through platform_data, but I couldn't find a way of doing  
> it. I hope
> you'll have some kind of idea.

This is a sensible idea in principle but should be done via platform  
data for the AC97 driver rather than via Kconfig - it'll need an  
update to use the platform in ASoC but I'll need to do those anyway.

>
>
> Cheers.
>
> --
> Robert
>
> From 8d4a0c602b85528af2a35fd3f1f1bd8ddca22985 Mon Sep 17 00:00:00 2001
> From: Robert Jarzmik <robert.jarzmik@free.fr>
> Date: Thu, 19 Feb 2009 21:35:42 +0100
> Subject: [PATCH] Allow choice in ac97 gpio reset line
>
> As the PXA series allow 2 gpios to reset the ac97 bus, allow
> through configuration the definition of the correct gpio
> which will reset the AC97 bus.
>
> This comes from a silicon defect on the PXA series, where
> the gpio must be manually controlled in warm reset cases.
>
> Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
> ---
> sound/arm/Kconfig           |   17 +++++++++++
> sound/arm/pxa2xx-ac97-lib.c |   68 ++++++++++++++++++++++++++++++++++ 
> +++++---
> 2 files changed, 80 insertions(+), 5 deletions(-)
>
> diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
> index f8e6de4..2749274 100644
> --- a/sound/arm/Kconfig
> +++ b/sound/arm/Kconfig
> @@ -39,6 +39,23 @@ config SND_PXA2XX_LIB
> config SND_PXA2XX_LIB_AC97
>    bool
>
> +choice
> +    prompt "PXA GPIO line used to reset AC97 bus"
> +    depends on SND_PXA2XX_LIB_AC97
> +    help
> +      Choose which GPIO is assigned the AC97 reset function.
> +
> +      Usually board designers use GPIO 113, but GPIO 95 can be used
> +      as well.
> +
> +config    SND_PXA2XX_LIB_AC97_RESET113
> +    bool "GPIO113"
> +
> +config    SND_PXA2XX_LIB_AC97_RESET95
> +    bool "GPIO95"
> +
> +endchoice
> +
> config SND_PXA2XX_AC97
>    tristate "AC97 driver for the Intel PXA2xx chip"
>    depends on ARCH_PXA
> diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
> index 35afd0c..aa522d2 100644
> --- a/sound/arm/pxa2xx-ac97-lib.c
> +++ b/sound/arm/pxa2xx-ac97-lib.c
> @@ -31,6 +31,8 @@ static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
> static volatile long gsr_bits;
> static struct clk *ac97_clk;
> static struct clk *ac97conf_clk;
> +static int is_ac97_resetgpio_95;
> +static int is_ac97_resetgpio_113;
>
> /*
>  * Beware PXA27x bugs:
> @@ -42,6 +44,55 @@ static struct clk *ac97conf_clk;
>  * 1 jiffy timeout if interrupt never comes).
>  */
>
> +enum {
> +    RESETGPIO_FORCE_HIGH,
> +    RESETGPIO_FORCE_LOW,
> +    RESETGPIO_NORMAL_ALTFUNC
> +};
> +
> +/**
> + * set_resetgpio_mode - computes and sets the AC97_RESET gpio mode  
> on PXA
> + * @mode: chosen action
> + *
> + * As the PXA CPUs suffer from a AC97 bug, a manual control of the  
> reset
> + * line must be done to insure proper work of AC97 reset line.
> + * This function computes the correct gpio_mode for further use by  
> reset
> + * functions, and applied the change through pxa_gpio_mode.
> + */
> +static void set_resetgpio_mode(int resetgpio_action)
> +{
> +    int mode = 0;
> +
> +    if (is_ac97_resetgpio_113)
> +        switch (resetgpio_action) {
> +        case RESETGPIO_FORCE_LOW:
> +            mode = 113 | GPIO_OUT | GPIO_DFLT_LOW;
> +            break;
> +        case RESETGPIO_FORCE_HIGH:
> +            mode = 113 | GPIO_OUT | GPIO_DFLT_HIGH;
> +            break;
> +        case RESETGPIO_NORMAL_ALTFUNC:
> +            mode = 113 | GPIO_ALT_FN_2_OUT;
> +            break;
> +        };
> +
> +    if (is_ac97_resetgpio_95)
> +        switch (resetgpio_action) {
> +        case RESETGPIO_FORCE_LOW:
> +            mode = 95 | GPIO_OUT | GPIO_DFLT_LOW;
> +            break;
> +        case RESETGPIO_FORCE_HIGH:
> +            mode = 95 | GPIO_OUT | GPIO_DFLT_HIGH;
> +            break;
> +        case RESETGPIO_NORMAL_ALTFUNC:
> +            mode = 95 | GPIO_ALT_FN_1_OUT;
> +            break;
> +        };
> +
> +    if (mode)
> +        pxa_gpio_mode(mode);
> +}
> +
> unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned  
> short reg)
> {
>    unsigned short val = -1;
> @@ -137,10 +188,10 @@ static inline void pxa_ac97_warm_pxa27x(void)
>
>    /* warm reset broken on Bulverde,
>       so manually keep AC97 reset high */
> -    pxa_gpio_mode(113 | GPIO_OUT | GPIO_DFLT_HIGH);
> +    set_resetgpio_mode(RESETGPIO_FORCE_HIGH);
>    udelay(10);
>    GCR |= GCR_WARM_RST;
> -    pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
> +    set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
>    udelay(500);
> }
>
> @@ -308,8 +359,8 @@ int pxa2xx_ac97_hw_resume(void)
>        pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
>    }
>    if (cpu_is_pxa27x()) {
> -        /* Use GPIO 113 as AC97 Reset on Bulverde */
> -        pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
> +        /* Use GPIO 113 or 95 as AC97 Reset on Bulverde */
> +        set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
>    }
>    clk_enable(ac97_clk);
>    return 0;
> @@ -321,6 +372,13 @@ int __devinit pxa2xx_ac97_hw_probe(struct  
> platform_device *dev)
> {
>    int ret;
>
> +#ifdef CONFIG_SND_PXA2XX_LIB_AC97_RESET113
> +    is_ac97_resetgpio_113 = 1;
> +#endif
> +#ifdef CONFIG_SND_PXA2XX_LIB_AC97_RESET95
> +    is_ac97_resetgpio_95 = 1;
> +#endif
> +
>    if (cpu_is_pxa25x() || cpu_is_pxa27x()) {
>        pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
>        pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
> @@ -330,7 +388,7 @@ int __devinit pxa2xx_ac97_hw_probe(struct  
> platform_device *dev)
>
>    if (cpu_is_pxa27x()) {
>        /* Use GPIO 113 as AC97 Reset on Bulverde */
> -        pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
> +        set_resetgpio_mode(RESETGPIO_NORMAL_ALTFUNC);
>        ac97conf_clk = clk_get(&dev->dev, "AC97CONFCLK");
>        if (IS_ERR(ac97conf_clk)) {
>            ret = PTR_ERR(ac97conf_clk);
> -- 
> 1.5.6.5
>
>
