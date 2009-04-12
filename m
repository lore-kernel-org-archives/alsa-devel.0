From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: Question about pxa2xx-ac97-lib.c
Date: Sun, 12 Apr 2009 18:36:49 +0200
Message-ID: <87ocv1akwu.fsf@free.fr>
References: <200904121647.39464.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id DE5CC24457
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Apr 2009 18:36:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk, Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Marek Vasut <marek.vasut@gmail.com> writes:
> One more thing, I'd like to ask how to change the reset_gpio in the above 
> file. Will I have to make copy of pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI] in 
> palm27x.c and change the .probe pointer to my own function that sets the 
> proper platform data? That is, something like the following? Thanks

I'll add Mark to the discussion here, for the ASoC point of view. Mark, the
original mail is in [1].

I originaly thought we would change pxa_set_ac97_info(), to add a parameter
which will be the platform data for the gpio.

IOW, have something like :
void __init pxa_set_ac97_info(struct pxa2xx_ac97_platform_data *pdata)
{
        pxa_register_device(&pxa_device_ac97, ops);
}

The trouble is, I saw references to the platform data as pxa2xx_audio_ops_t*,
mostly to suspend and resume a card. I've seen them in pxa2xx_ac97_do_suspend(),
pxa2xx_ac97_do_resume().

Mark, could you please have a glance at it, and tell us the right approach to
have the struct pxa2xx_ac97_platform_data passed to pxa2xx-ac97 please ?

Cheers.

--
Robert

[1] :
> diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
> index 48a73f6..f134f95 100644
> --- a/sound/soc/pxa/palm27x.c
> +++ b/sound/soc/pxa/palm27x.c
> @@ -19,11 +19,13 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/platform_device.h>
>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
> +#include <sound/pxa2xx-lib.h>
>
>  #include <asm/mach-types.h>
>  #include <mach/audio.h>
> @@ -168,6 +170,21 @@ static int palm27x_ac97_init(struct snd_soc_codec *codec)
>         return 0;
>  }
> // this is the altered probe function
> +/* Palms use GPIO95 for AC97 reset */
> +static int palm_ac97_probe(struct platform_device *pdev,
> +                            struct snd_soc_dai *dai)
> +{
> +       struct platform_device *pd = to_platform_device(dai->dev);
> +       static struct pxa2xx_ac97_platform_data pdata = {
> +               .reset_gpio = 95,
> +       };
> +       printk("%s[%i]\n", __FUNCTION__, __LINE__);
> +       pd->dev.platform_data = &pdata;
> +       return pxa2xx_ac97_hw_probe(pd);
> +}
> +
> +static struct snd_soc_dai hifi_cpu_dai;
> +
>  static struct snd_soc_dai_link palm27x_dai[] = {
>  {
>         .name = "AC97 HiFi",
> @@ -204,6 +221,8 @@ static int __init palm27x_asoc_init(void)
>  {
>         int ret;
> // here it'll be copied 
> +       pxa_ac97_dai[PXA2XX_DAI_AC97_HIFI].probe = palm_ac97_probe;
> +
>         if (!(machine_is_palmtx() || machine_is_palmt5() ||
>                 machine_is_palmld()))
>                 return -ENODEV;
>
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
