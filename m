From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/5] ASoC: imx-spdif: don't print EPROBE_DEFER as error
Date: Thu, 17 Jan 2019 14:00:42 -0800
Message-ID: <20190117220041.GB16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
 <20190117090640.12972-2-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-2-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 10:06:37AM +0100, Stefan Agner wrote:

> Removing the goto would not be strictly necessary. However, if
> code gets added later, the cleanup in the EPROBE_DEFER case likely
> would get missed.

Considering there is no code being added between them over the
years, I am okay to remove it since it makes things clean. But
as you mentioned, we gotta be careful if code gets added later.

> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-spdif.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
> index fb896b2c9ba3..797d66e43d49 100644
> --- a/sound/soc/fsl/imx-spdif.c
> +++ b/sound/soc/fsl/imx-spdif.c
> @@ -67,10 +67,8 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
>  		goto end;
>  
>  	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
> -	if (ret) {
> +	if (ret && ret != -EPROBE_DEFER)
>  		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
> -		goto end;
> -	}
>  
>  end:
>  	of_node_put(spdif_np);
> -- 
> 2.20.1
> 
