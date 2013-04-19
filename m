From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoc: spdif_transciever: Add DT
	support
Date: Fri, 19 Apr 2013 19:36:11 +0200
Message-ID: <5171808B.1010209@gmail.com>
References: <1366378725-14471-1-git-send-email-michal.bachraty@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 72F9B2615E6
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 19:36:03 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id ji2so229742bkc.6
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 10:36:03 -0700 (PDT)
In-Reply-To: <1366378725-14471-1-git-send-email-michal.bachraty@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, marek.belisko@streamunlimited.com
List-Id: alsa-devel@alsa-project.org

Hi Michal,

On 19.04.2013 15:38, Michal Bachraty wrote:
> Add devicetree support for this dummy audio soc driver.

I think Mark wants to see only "ASoC:" in the patch subjects now.

> 
> Signed-off-by: Michal Bachraty <michal.bachraty@streamunlimited.com>
> ---
>  sound/soc/codecs/spdif_transciever.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
> index 112a49d..4c8c295 100644
> --- a/sound/soc/codecs/spdif_transciever.c
> +++ b/sound/soc/codecs/spdif_transciever.c
> @@ -20,6 +20,7 @@
>  #include <sound/soc.h>
>  #include <sound/pcm.h>
>  #include <sound/initval.h>
> +#include <linux/of.h>
>  
>  #define DRV_NAME "spdif-dit"
>  
> @@ -52,12 +53,21 @@ static int spdif_dit_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id spdif_dit_dt_ids[] = {
> +	{ .compatible = DRV_NAME, },

I think this needs a "linux," prefix. Just put the whole string here.

Same goes for the patch against the spdif_receiver driver.


Thanks,
Daniel


> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, spdif_dits_dt_ids);
> +#endif
> +
>  static struct platform_driver spdif_dit_driver = {
>  	.probe		= spdif_dit_probe,
>  	.remove		= spdif_dit_remove,
>  	.driver		= {
>  		.name	= DRV_NAME,
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(spdif_dit_dt_ids),
>  	},
>  };
>  
> 
