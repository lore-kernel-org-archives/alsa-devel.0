From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH -next] slimbus: qcom: fix potential NULL dereference in
 qcom_slim_prg_slew()
Date: Wed, 23 May 2018 14:42:26 +0100
Message-ID: <5b5c4eb4-0d13-7fa4-c0b6-e9949af4e1e1@linaro.org>
References: <1526989582-139939-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526989582-139939-1-git-send-email-weiyongjun1@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>, Sagar Dharia <sdharia@codeaurora.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 22/05/18 12:46, Wei Yongjun wrote:
> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference
> a bit later in the code.
> 
> This is detected by Coccinelle semantic patch.
> 
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
> 
> res = platform_get_resource_byname(pdev, t, n);
> + if (!res)
> +   return -EINVAL;
> ... when != res == NULL
> e = devm_ioremap(e1, res->start, e2);
> 

> Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/slimbus/qcom-ctrl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
> index bb36a8f..caea3b9 100644
> --- a/drivers/slimbus/qcom-ctrl.c
> +++ b/drivers/slimbus/qcom-ctrl.c
> @@ -478,6 +478,8 @@ static void qcom_slim_prg_slew(struct platform_device *pdev,
>   		/* SLEW RATE register for this SLIMbus */
>   		slew_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>   				"slew");
> +		if (!slew_mem)
> +			return;

I think a better fix would be to do a devm_ioremap_resource() instead of 
  devm_ioremap, which already has this check. This will also be inline 
with other resource handled in this driver.

thanks,
srini
>   		ctrl->slew_reg = devm_ioremap(&pdev->dev, slew_mem->start,
>   				resource_size(slew_mem));
>   		if (!ctrl->slew_reg)
> 
