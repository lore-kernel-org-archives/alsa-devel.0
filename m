From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] ASoC: au1x: psc-i2s: Convert to use
	devm_ioremap_resource
Date: Sun, 30 Aug 2015 08:22:35 +0200
Message-ID: <CAOLZvyGJpoDe0wM+4yyTjpsCF6S+nnSo0bO4WuNT-q+bWDr5TA@mail.gmail.com>
References: <1440904189.32046.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 50C82260709
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 08:23:15 +0200 (CEST)
Received: by lbcbn3 with SMTP id bn3so46497489lbc.2
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 23:23:14 -0700 (PDT)
In-Reply-To: <1440904189.32046.3.camel@ingics.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 30, 2015 at 5:09 AM, Axel Lin <axel.lin@ingics.com> wrote:
> Use devm_ioremap_resource() instead of open code.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/au1x/psc-i2s.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
> index e742ef6..38e853a 100644
> --- a/sound/soc/au1x/psc-i2s.c
> +++ b/sound/soc/au1x/psc-i2s.c
> @@ -305,19 +305,9 @@ static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!iores)
> -               return -ENODEV;
> -
> -       ret = -EBUSY;
> -       if (!devm_request_mem_region(&pdev->dev, iores->start,
> -                                    resource_size(iores),
> -                                    pdev->name))
> -               return -EBUSY;
> -
> -       wd->mmio = devm_ioremap(&pdev->dev, iores->start,
> -                               resource_size(iores));
> -       if (!wd->mmio)
> -               return -EBUSY;
> +       wd->mmio = devm_ioremap_resource(&pdev->dev, iores);
> +       if (IS_ERR(wd->mmio))
> +               return PTR_ERR(wd->mmio);
>
>         dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>         if (!dmares)
> --


Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
