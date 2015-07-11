From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [RFT PATCH 1/2] ASoC: zx: i2s: Fix
 devm_ioremap_resource return value check
Date: Sat, 11 Jul 2015 10:02:28 +0800
Message-ID: <CABymUCOj=yHAbdK5=uMtNiHjgSPKx7z-=Vc1JRy_nkE9rB1jAw@mail.gmail.com>
References: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AD07266682
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 04:02:29 +0200 (CEST)
Received: by lbnk3 with SMTP id k3so101063552lbn.1
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 19:02:28 -0700 (PDT)
In-Reply-To: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

2015-07-09 21:19 GMT+08:00 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>:
> Value returned by devm_ioremap_resource() was checked for non-NULL but
> devm_ioremap_resource() returns IOMEM_ERR_PTR, not NULL. In case of
> error this could lead to dereference of ERR_PTR.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> Cc: <stable@vger.kernel.org>
> Fixes: e5d4cd87800c ("ASoC: zx: Add ZTE zx296702 I2S DAI driver")
>
> ---
>
> Patch only compile tested.
> ---
>  sound/soc/zte/zx296702-i2s.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/zte/zx296702-i2s.c b/sound/soc/zte/zx296702-i2s.c
> index 98d96e1b17e0..1930c42e1f55 100644
> --- a/sound/soc/zte/zx296702-i2s.c
> +++ b/sound/soc/zte/zx296702-i2s.c
> @@ -393,9 +393,9 @@ static int zx_i2s_probe(struct platform_device *pdev)
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         zx_i2s->mapbase = res->start;
>         zx_i2s->reg_base = devm_ioremap_resource(&pdev->dev, res);
> -       if (!zx_i2s->reg_base) {
> +       if (IS_ERR(zx_i2s->reg_base)) {
>                 dev_err(&pdev->dev, "ioremap failed!\n");
> -               return -EIO;
> +               return PTR_ERR(zx_i2s->reg_base);
>         }
>
>         writel_relaxed(0, zx_i2s->reg_base + ZX_I2S_FIFO_CTRL);
> --
> 2.1.4
>
Reviewed-by: Jun Nie <jun.nie@linaro.org>
