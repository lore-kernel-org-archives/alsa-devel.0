From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/2] slimbus: qcom-ctrl: Fix
 devm_ioremap_resource() error handling
Date: Tue, 9 Jan 2018 09:48:06 +0000
Message-ID: <b69e1b08-b23a-85b2-1c90-ef6b80a41a86@linaro.org>
References: <20180109092644.wa4ubwxkcvc3lyza@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C4692675FA
 for <alsa-devel@alsa-project.org>; Tue,  9 Jan 2018 10:48:15 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id y82so19445151wmg.1
 for <alsa-devel@alsa-project.org>; Tue, 09 Jan 2018 01:48:14 -0800 (PST)
In-Reply-To: <20180109092644.wa4ubwxkcvc3lyza@mwanda>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 09/01/18 09:26, Dan Carpenter wrote:
> devm_ioremap_resource() returns error pointers, not NULL so the check
> needs to be fixed.
> 
> Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
> index 3ab59209cbdc..6bf95bf33299 100644
> --- a/drivers/slimbus/qcom-ctrl.c
> +++ b/drivers/slimbus/qcom-ctrl.c
> @@ -528,9 +528,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
>   
>   	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
>   	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
> -	if (!ctrl->base) {
> +	if (IS_ERR(ctrl->base)) {
>   		dev_err(&pdev->dev, "IOremap failed\n");
> -		return -ENOMEM;
> +		return PTR_ERR(ctrl->base);
>   	}
>   
>   	sctrl->set_laddr = qcom_set_laddr;
> 

Already fixed at:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1575797.html
