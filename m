From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 04/12] ASoC: qdsp6: q6adm: use
 of_platform_populate/depopulate()
Date: Tue, 26 Jun 2018 11:30:03 +0200
Message-ID: <20180626093003.GB25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEAF22675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:30:06 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id i125-v6so8246941lji.2
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:30:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-5-srinivas.kandagatla@linaro.org>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:08AM +0100, Srinivas Kandagatla wrote:
> Now that the child nodes have there own compatible strings,
> Use of_platform_populate/depopulate() instead of less common
> of_platform_device_create()/destroy().
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6adm.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
> index 9983c665a941..932c3ebfd252 100644
> --- a/sound/soc/qcom/qdsp6/q6adm.c
> +++ b/sound/soc/qcom/qdsp6/q6adm.c
> @@ -64,7 +64,6 @@ struct q6adm {
>  	struct aprv2_ibasic_rsp_result_t result;
>  	struct mutex lock;
>  	wait_queue_head_t matrix_map_wait;
> -	struct platform_device *pdev_routing;
>  };
>  
>  struct q6adm_cmd_device_open_v5 {
> @@ -588,7 +587,6 @@ EXPORT_SYMBOL_GPL(q6adm_close);
>  static int q6adm_probe(struct apr_device *adev)
>  {
>  	struct device *dev = &adev->dev;
> -	struct device_node *dais_np;
>  	struct q6adm *adm;
>  
>  	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
> @@ -605,22 +603,12 @@ static int q6adm_probe(struct apr_device *adev)
>  	INIT_LIST_HEAD(&adm->copps_list);
>  	spin_lock_init(&adm->copps_list_lock);
>  
> -	dais_np = of_get_child_by_name(dev->of_node, "routing");
> -	if (dais_np) {
> -		adm->pdev_routing = of_platform_device_create(dais_np,
> -							   "q6routing", dev);
> -		of_node_put(dais_np);
> -	}
> -
> -	return 0;
> +	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>  }
>  
>  static int q6adm_remove(struct apr_device *adev)
>  {
> -	struct q6adm *adm = dev_get_drvdata(&adev->dev);
> -
> -	if (adm->pdev_routing)
> -		of_platform_device_destroy(&adm->pdev_routing->dev, NULL);
> +	of_platform_depopulate(&adev->dev);
>  
>  	return 0;
>  }
> -- 
> 2.16.2
> 
