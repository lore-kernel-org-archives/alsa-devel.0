From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH] ASoC: zx296702-i2s: Fix resource leak when
	unload module
Date: Sun, 30 Aug 2015 21:35:09 +0800
Message-ID: <CABymUCNCRanrutcy-FsbKSEyr5aoufuo9a6nYtmWmOdDtaWpcA@mail.gmail.com>
References: <1440860970.28601.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id ADA4D260468
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 15:35:10 +0200 (CEST)
Received: by wicfv10 with SMTP id fv10so48569347wic.0
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 06:35:10 -0700 (PDT)
In-Reply-To: <1440860970.28601.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Reviewed-by: Jun Nie <jun.nie@linaro.org>

2015-08-29 23:09 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> Use devm_* API to fix leaks in current code.
> 1. Use devm_kzalloc to fix memory leak for zx_i2s when unload the module.
> 2. Use devm_snd_soc_register_component to ensure component is unregistered
>    when unload the module.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/zte/zx296702-i2s.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx296702-i2s.c
> index 1930c42..1cad93d 100644
> --- a/sound/soc/zte/zx296702-i2s.c
> +++ b/sound/soc/zte/zx296702-i2s.c
> @@ -380,7 +380,7 @@ static int zx_i2s_probe(struct platform_device *pdev)
>         struct zx_i2s_info *zx_i2s;
>         int ret;
>
> -       zx_i2s =  kzalloc(sizeof(*zx_i2s), GFP_KERNEL);
> +       zx_i2s = devm_kzalloc(&pdev->dev, sizeof(*zx_i2s), GFP_KERNEL);
>         if (!zx_i2s)
>                 return -ENOMEM;
>
> @@ -401,8 +401,8 @@ static int zx_i2s_probe(struct platform_device *pdev)
>         writel_relaxed(0, zx_i2s->reg_base + ZX_I2S_FIFO_CTRL);
>         platform_set_drvdata(pdev, zx_i2s);
>
> -       ret = snd_soc_register_component(&pdev->dev, &zx_i2s_component,
> -                                        &zx_i2s_dai, 1);
> +       ret = devm_snd_soc_register_component(&pdev->dev, &zx_i2s_component,
> +                                             &zx_i2s_dai, 1);
>         if (ret) {
>                 dev_err(&pdev->dev, "Register DAI failed: %d\n", ret);
>                 return ret;
> --
> 2.1.0
>
>
>
