From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: make module reloadable
Date: Mon, 05 Nov 2012 15:29:52 +0800
Message-ID: <50976AF0.90500@atmel.com>
References: <1351775882-15834-1-git-send-email-alexandre.belloni@piout.net>
 <5093D9CB.7000904@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 597742615B9
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2012 08:30:36 +0100 (CET)
In-Reply-To: <5093D9CB.7000904@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@piout.net>
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

Hi Alexandre Belloni,

On 11/1/2012 14:18, Alexandre Belloni wrote:
> As the platform_devices were never unregistered, it was not possible to
> unload/reload the module.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@piout.net>
> ---
>   sound/soc/atmel/atmel_ssc_dai.c |   11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)

NACK - Thanks for your work on atmel ssc dai component. Now, I am 
reworking the atmel ssc dai audio framework. So, some of them will be 
none exist any more.

Thanks again.

Best regards,
Bo Shen

> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 354341e..07ee57b 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -155,6 +155,8 @@ static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
>   #endif
>   };
>
> +static struct platform_device *dma_pdev;
> +static struct platform_device *ssc_pdevs[NUM_SSC_DEVICES];
>
>   /*
>    * SSC interrupt handler.  Passes PDC interrupts to the DMA
> @@ -796,6 +798,12 @@ static __devinit int asoc_ssc_probe(struct platform_device *pdev)
>
>   static int __devexit asoc_ssc_remove(struct platform_device *pdev)
>   {
> +	int i;
> +	platform_device_unregister(dma_pdev);
> +
> +	for(i = 0; i < NUM_SSC_DEVICES; i++)
> +		platform_device_unregister(ssc_pdevs[i]);
> +
>   	snd_soc_unregister_dai(&pdev->dev);
>   	return 0;
>   }
> @@ -816,7 +824,6 @@ static struct platform_driver asoc_ssc_driver = {
>   int atmel_ssc_set_audio(int ssc_id)
>   {
>   	struct ssc_device *ssc;
> -	static struct platform_device *dma_pdev;
>   	struct platform_device *ssc_pdev;
>   	int ret;
>
> @@ -855,6 +862,8 @@ int atmel_ssc_set_audio(int ssc_id)
>   	if (ret < 0)
>   		platform_device_put(ssc_pdev);
>
> +	ssc_pdevs[ssc_id] = ssc_pdev;
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
>
