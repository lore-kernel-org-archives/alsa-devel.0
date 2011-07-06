From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/5] input: twl6040-vibra: Do not use
 wrapper for irq request
Date: Wed, 6 Jul 2011 13:03:02 -0700
Message-ID: <20110706200302.GC6086@core.coreip.homeip.net>
References: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
	<1309895376-17446-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 43F7024456
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 22:03:11 +0200 (CEST)
Received: by pzk26 with SMTP id 26so289947pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 06 Jul 2011 13:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309895376-17446-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 05, 2011 at 10:49:33PM +0300, Peter Ujfalusi wrote:
> The twl6040_request_irq/free_irq inline functions are going
> to be removed, so replace them with direct calls.
> The irq number is provided by the core driver via resource.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Dmitry Torokhov <dtormail.ru>

> ---
>  drivers/input/misc/twl6040-vibra.c |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
> index dbf745d..c43002e 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -47,6 +47,7 @@ struct vibra_info {
>  	struct workqueue_struct *workqueue;
>  	struct work_struct play_work;
>  	struct mutex mutex;
> +	int irq;
>  
>  	bool enabled;
>  	int weak_speed;
> @@ -277,6 +278,13 @@ static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
>  		goto err_kzalloc;
>  	}
>  
> +	info->irq = platform_get_irq(pdev, 0);
> +	if (info->irq < 0) {
> +		dev_err(info->dev, "invalid irq\n");
> +		ret = -EINVAL;
> +		goto err_kzalloc;
> +	}
> +
>  	mutex_init(&info->mutex);
>  
>  	info->input_dev = input_allocate_device();
> @@ -308,9 +316,8 @@ static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, info);
>  
> -	ret = twl6040_request_irq(info->twl6040, TWL6040_IRQ_VIB,
> -				  twl6040_vib_irq_handler, 0,
> -				  "twl6040_irq_vib", info);
> +	ret = request_threaded_irq(info->irq, NULL, twl6040_vib_irq_handler, 0,
> +				   "twl6040_irq_vib", info);
>  	if (ret) {
>  		dev_err(info->dev, "VIB IRQ request failed: %d\n", ret);
>  		goto err_irq;
> @@ -360,7 +367,7 @@ static int __devinit twl6040_vibra_probe(struct platform_device *pdev)
>  err_voltage:
>  	regulator_bulk_free(ARRAY_SIZE(info->supplies), info->supplies);
>  err_regulator:
> -	twl6040_free_irq(info->twl6040, TWL6040_IRQ_VIB, info);
> +	free_irq(info->irq, info);
>  err_irq:
>  	input_unregister_device(info->input_dev);
>  	info->input_dev = NULL;
> @@ -379,7 +386,7 @@ static int __devexit twl6040_vibra_remove(struct platform_device *pdev)
>  	struct vibra_info *info = platform_get_drvdata(pdev);
>  
>  	input_unregister_device(info->input_dev);
> -	twl6040_free_irq(info->twl6040, TWL6040_IRQ_VIB, info);
> +	free_irq(info->irq, info);
>  	regulator_bulk_free(ARRAY_SIZE(info->supplies), info->supplies);
>  	destroy_workqueue(info->workqueue);
>  	kfree(info);
> -- 
> 1.7.6
> 

-- 
Dmitry
