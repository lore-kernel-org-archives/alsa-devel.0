From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH 06/11] ASoC: qdsp6: q6afe: use
 of_platform_populate/depopulate()
Date: Mon, 25 Jun 2018 20:02:14 +0200
Message-ID: <20180625180214.GE10876@centauri.lan>
References: <20180625143115.8346-1-srinivas.kandagatla@linaro.org>
 <20180625143115.8346-7-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 755622673F5
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 20:02:17 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id v25-v6so5359555lji.4
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 11:02:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180625143115.8346-7-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: rohkumar@qti.qualcomm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Mon, Jun 25, 2018 at 03:31:10PM +0100, Srinivas Kandagatla wrote:
> Now that the child nodes have there own compatible strings,
> Use of_platform_populate/depopulate() instead of less common
> of_platform_device_create()/destroy().
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6afe.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index 01f43218984b..621b67b34db9 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -316,7 +316,6 @@ struct q6afe {
>  	struct mutex lock;
>  	struct list_head port_list;
>  	spinlock_t port_list_lock;
> -	struct platform_device *pdev_dais;
>  };
>  
>  struct afe_port_cmd_device_start {
> @@ -1438,7 +1437,6 @@ static int q6afe_probe(struct apr_device *adev)
>  {
>  	struct q6afe *afe;
>  	struct device *dev = &adev->dev;
> -	struct device_node *dais_np;
>  
>  	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
>  	if (!afe)
> @@ -1453,22 +1451,12 @@ static int q6afe_probe(struct apr_device *adev)
>  
>  	dev_set_drvdata(dev, afe);
>  
> -	dais_np = of_get_child_by_name(dev->of_node, "dais");
> -	if (dais_np) {
> -		afe->pdev_dais = of_platform_device_create(dais_np,
> -							   "q6afe-dai", dev);
> -		of_node_put(dais_np);
> -	}
> -
> -	return 0;
> +	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
>  static int q6afe_remove(struct apr_device *adev)
>  {
> -	struct q6afe *afe = dev_get_drvdata(&adev->dev);
> -
> -	if (afe->pdev_dais)
> -		of_platform_device_destroy(&afe->pdev_dais->dev, NULL);
> +	of_platform_depopulate(&adev->dev);
>  
>  	return 0;
>  }
> -- 
> 2.16.2
> 
