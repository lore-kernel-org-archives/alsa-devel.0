From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/6] ASoC: jz4740: Remove redundant
	platform_set_drvdata()
Date: Fri, 03 May 2013 11:24:37 +0200
Message-ID: <51838255.7040900@metafoo.de>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
 <1367572164-19523-6-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-050.synserver.de (smtp-out-053.synserver.de
 [212.40.185.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 86FE126166B
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:25:10 +0200 (CEST)
In-Reply-To: <1367572164-19523-6-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On 05/03/2013 11:09 AM, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Lars-Peter Clausen <lars@metatfoo.de>

Thanks

> ---
>  sound/soc/codecs/jz4740.c     |    2 --
>  sound/soc/jz4740/jz4740-i2s.c |    1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
> index 5f607b3..bcebd1a 100644
> --- a/sound/soc/codecs/jz4740.c
> +++ b/sound/soc/codecs/jz4740.c
> @@ -384,8 +384,6 @@ static int jz4740_codec_remove(struct platform_device *pdev)
>  {
>  	snd_soc_unregister_codec(&pdev->dev);
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }
>  
> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
> index 9a12644..cafc6ed 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -509,7 +509,6 @@ static int jz4740_i2s_dev_remove(struct platform_device *pdev)
>  	iounmap(i2s->base);
>  	release_mem_region(i2s->mem->start, resource_size(i2s->mem));
>  
> -	platform_set_drvdata(pdev, NULL);
>  	kfree(i2s);
>  
>  	return 0;
