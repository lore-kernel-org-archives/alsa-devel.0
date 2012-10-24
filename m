From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: ux500_msp_i2s: Fix devm_* and return code merge error
Date: Wed, 24 Oct 2012 11:34:00 +0200
Message-ID: <CAPDyKFqrS0QT+UO0L3B29UcnjX0bSv3XvWTmC6E_ubgr8NTDiQ@mail.gmail.com>
References: <1350306806-5688-1-git-send-email-lee.jones@linaro.org>
	<1350306806-5688-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350306806-5688-2-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

I assume this shall go into 3.7, right?

Kind regards
Ulf Hansson

On 15 October 2012 15:13, Lee Jones <lee.jones@linaro.org> wrote:
> Some ux500_msp_i2s patches clashed with:
>
> b18e93a493626c1446f9788ebd5844d008bbf71c
> ASoC: ux500_msp_i2s: better use devm functions and fix error return code
>
> ... leaving the driver uncompilable. This patch fixes the
> issues encountered.
>
> Cc: alsa-devel@alsa-project.org
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  sound/soc/ux500/ux500_msp_i2s.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
> index b7c996e..a26c6bf 100644
> --- a/sound/soc/ux500/ux500_msp_i2s.c
> +++ b/sound/soc/ux500/ux500_msp_i2s.c
> @@ -18,6 +18,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> +#include <linux/io.h>
>  #include <linux/of.h>
>
>  #include <mach/hardware.h>
> @@ -697,14 +698,11 @@ int ux500_msp_i2s_init_msp(struct platform_device *pdev,
>                         platform_data = devm_kzalloc(&pdev->dev,
>                                 sizeof(struct msp_i2s_platform_data), GFP_KERNEL);
>                         if (!platform_data)
> -                               ret = -ENOMEM;
> +                               return -ENOMEM;
>                 }
>         } else
>                 if (!platform_data)
> -                       ret = -EINVAL;
> -
> -       if (ret)
> -               goto err_res;
> +                       return -EINVAL;
>
>         dev_dbg(&pdev->dev, "%s: Enter (name: %s, id: %d).\n", __func__,
>                 pdev->name, platform_data->id);
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
