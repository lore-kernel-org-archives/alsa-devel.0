From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH -next] ASoC: sprd: Fix return value check in sprd_mcdt_probe()
Date: Tue, 30 Apr 2019 10:54:51 +0800
Message-ID: <CAMz4kuJtMAyjbPR0Yf_FN1fhDwSi5=0WAgD_BNEuTB5GhcTYxQ@mail.gmail.com>
References: <20190429122512.59242-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429122512.59242-1-weiyongjun1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 29 Apr 2019 at 20:15, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>
> Fixes: d7bff893e04f ("ASoC: sprd: Add Spreadtrum multi-channel data transfer support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks for fixing my mistake.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  sound/soc/sprd/sprd-mcdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
> index 28f5e649733d..e9318d7a4810 100644
> --- a/sound/soc/sprd/sprd-mcdt.c
> +++ b/sound/soc/sprd/sprd-mcdt.c
> @@ -951,8 +951,8 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         mcdt->base = devm_ioremap_resource(&pdev->dev, res);
> -       if (!mcdt->base)
> -               return -ENOMEM;
> +       if (IS_ERR(mcdt->base))
> +               return PTR_ERR(mcdt->base);
>
>         mcdt->dev = &pdev->dev;
>         spin_lock_init(&mcdt->lock);
>
>
>


-- 
Baolin Wang
Best Regards
