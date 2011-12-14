From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Complete initialisation before
 registering Samsung PCM DAI
Date: Wed, 14 Dec 2011 14:40:54 +0900
Message-ID: <03cc01ccba22$f23621b0$d6a26510$@com>
References: <1323688113-32580-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id BA147244DE
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 06:40:59 +0100 (CET)
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LW600GG2IG6RKL0@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 14 Dec 2011 14:40:54 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.120.118])
	by mmp2.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0LW600FF1IG67H40@mmp2.samsung.com>
	for alsa-devel@alsa-project.org; Wed, 14 Dec 2011 14:40:54 +0900 (KST)
In-reply-to: <1323688113-32580-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Monday, December 12, 2011 8:09 PM, Mark Brown wrote:
> Otherwise there's a race where the DAI might get used without everything
> having been set up.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/pcm.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
> index beef63f..3a29c26 100644
> --- a/sound/soc/samsung/pcm.c
> +++ b/sound/soc/samsung/pcm.c
> @@ -570,12 +570,6 @@ static __devinit int s3c_pcm_dev_probe(struct
> platform_device *pdev)
>  	}
>  	clk_enable(pcm->pclk);
> 
> -	ret = snd_soc_register_dai(&pdev->dev, &s3c_pcm_dai[pdev->id]);
> -	if (ret != 0) {
> -		dev_err(&pdev->dev, "failed to get pcm_clock\n");
> -		goto err5;
> -	}
> -
>  	s3c_pcm_stereo_in[pdev->id].dma_addr = mem_res->start
>  							+ S3C_PCM_RXFIFO;
>  	s3c_pcm_stereo_out[pdev->id].dma_addr = mem_res->start
> @@ -587,6 +581,12 @@ static __devinit int s3c_pcm_dev_probe(struct
> platform_device *pdev)
>  	pcm->dma_capture = &s3c_pcm_stereo_in[pdev->id];
>  	pcm->dma_playback = &s3c_pcm_stereo_out[pdev->id];
> 
> +	ret = snd_soc_register_dai(&pdev->dev, &s3c_pcm_dai[pdev->id]);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "failed to get register DAI: %d\n",
ret);
> +		goto err5;
> +	}
> +
>  	return 0;
> 
>  err5:

Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Thanks,
Sangbeom
