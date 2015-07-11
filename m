From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [RFT PATCH 2/2] ASoC: zx: spdif: Fix
 devm_ioremap_resource return value check
Date: Sat, 11 Jul 2015 10:01:44 +0800
Message-ID: <CABymUCNbRG+9rscLseyS=_oH_yaNLcdes0E0j2CQjQGi9pi5Ow@mail.gmail.com>
References: <1436447969-24583-1-git-send-email-k.kozlowski.k@gmail.com>
 <1436447969-24583-2-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AD742604CA
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 04:01:44 +0200 (CEST)
Received: by lbbyj8 with SMTP id yj8so16179766lbb.0
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 19:01:44 -0700 (PDT)
In-Reply-To: <1436447969-24583-2-git-send-email-k.kozlowski.k@gmail.com>
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
> Fixes: 6fc3d24d4277 ("ASoC: zx: Add zx296702 SPDIF support")
>
> ---
>
> Patch only compile tested.
> ---
>  sound/soc/zte/zx296702-spdif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/zte/zx296702-spdif.c b/sound/soc/zte/zx296702-spdif.c
> index 11a0e46a1156..26265ce4caca 100644
> --- a/sound/soc/zte/zx296702-spdif.c
> +++ b/sound/soc/zte/zx296702-spdif.c
> @@ -322,9 +322,9 @@ static int zx_spdif_probe(struct platform_device *pdev)
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         zx_spdif->mapbase = res->start;
>         zx_spdif->reg_base = devm_ioremap_resource(&pdev->dev, res);
> -       if (!zx_spdif->reg_base) {
> +       if (IS_ERR(zx_spdif->reg_base)) {
>                 dev_err(&pdev->dev, "ioremap failed!\n");
> -               return -EIO;
> +               return PTR_ERR(zx_spdif->reg_base);
>         }
>
>         zx_spdif_dev_init(zx_spdif->reg_base);
> --
> 2.1.4
>
Reviewed-by: Jun Nie <jun.nie@linaro.org>
