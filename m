From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH 3/6] ASoC: mxs: mxs-pcm does not need to be
 a plaform_driver
Date: Thu, 10 May 2012 17:25:55 +0800
Message-ID: <20120510092554.GI6622@shlinux2.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
	<1336639333-11561-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe002.messaging.microsoft.com [213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 6799510BA1C
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 11:19:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1336639333-11561-4-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <dong.aisheng@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2012 at 04:42:10PM +0800, Shawn Guo wrote:
> Same as the commit 518de86 (ASoC: tegra: register 'platform' from DAIs,
> get rid of pdev), it makes mxs-pcm not a platform_driver but helper to
> register "platform", so that the platform_device for mxs-pcm can be
> saved completely.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/mxs/mxs-pcm.c      |   24 ++++++------------------
>  sound/soc/mxs/mxs-pcm.h      |    3 +++
>  sound/soc/mxs/mxs-saif.c     |   25 ++++---------------------
>  sound/soc/mxs/mxs-saif.h     |    1 -
>  sound/soc/mxs/mxs-sgtl5000.c |    4 ++--
>  5 files changed, 15 insertions(+), 42 deletions(-)
> 
...

> +int mxs_pcm_platform_register(struct device *dev);
> +void mxs_pcm_platform_unregister(struct device *dev);
> +
>  #endif
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index 5192db6..fa80ee6 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -713,35 +713,18 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	saif->soc_platform_pdev = platform_device_alloc(
> -					"mxs-pcm-audio", pdev->id);
> -	if (!saif->soc_platform_pdev) {
> -		ret = -ENOMEM;
> -		goto failed_pdev_alloc;
> -	}
> -
> -	platform_set_drvdata(saif->soc_platform_pdev, saif);
> -	ret = platform_device_add(saif->soc_platform_pdev);
> +	ret = mxs_pcm_platform_register(&pdev->dev);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to add soc platform device\n");
> -		goto failed_pdev_add;
> +		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -failed_pdev_add:
> -	platform_device_put(saif->soc_platform_pdev);
> -failed_pdev_alloc:
> -	snd_soc_unregister_dai(&pdev->dev);
Do not need to unregister_dai in case mxs_pcm_platform_register failed?

Regards
Dong Aisheng
