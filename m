From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Add of_node_put()
	before return
Date: Mon, 5 Aug 2019 15:49:32 -0700
Message-ID: <20190805224932.GB6470@builder>
References: <20190804162201.5838-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E489F800F4
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2019 00:49:37 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id r26so4510465pgl.10
 for <alsa-devel@alsa-project.org>; Mon, 05 Aug 2019 15:49:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190804162201.5838-1-nishkadg.linux@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, agross@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

On Sun 04 Aug 09:22 PDT 2019, Nishka Dasgupta wrote:

> Each iteration of for_each_available_child_of_node puts the previous
> node, but in the case of a return from the middle of the loop, there is
> no put, thus causing a memory leak. Hence add an of_node_put before the
> return in two places.
> Issue found with Coccinelle.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index f3585777324c..29fbab55c3b3 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1338,12 +1338,15 @@ static int of_qcom_slim_ngd_register(struct device *parent,
>  			continue;
>  
>  		ngd = kzalloc(sizeof(*ngd), GFP_KERNEL);
> -		if (!ngd)
> +		if (!ngd) {
> +			of_node_put(node);
>  			return -ENOMEM;
> +		}
>  
>  		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
>  		if (!ngd->pdev) {
>  			kfree(ngd);
> +			of_node_put(node);
>  			return -ENOMEM;
>  		}
>  		ngd->id = id;
> -- 
> 2.19.1
> 
