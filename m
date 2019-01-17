From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: fsl_spdif: don't print EPROBE_DEFER as error
Date: Thu, 17 Jan 2019 13:52:41 -0800
Message-ID: <20190117215240.GA16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 10:06:36AM +0100, Stefan Agner wrote:
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 740b90df44bb..a26686e7281c 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1320,7 +1320,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = imx_pcm_dma_init(pdev, IMX_SPDIF_DMABUF_SIZE);
> -	if (ret)
> +	if (ret && ret != -EPROBE_DEFER)
>  		dev_err(&pdev->dev, "imx_pcm_dma_init failed: %d\n", ret);
>  
>  	return ret;
> -- 
> 2.20.1
> 
