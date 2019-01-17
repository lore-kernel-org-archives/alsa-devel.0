From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 3/5] ASoC: imx-sgtl5000: don't print EPROBE_DEFER as error
Date: Thu, 17 Jan 2019 14:03:43 -0800
Message-ID: <20190117220342.GD16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
 <20190117090640.12972-3-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-3-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 10:06:38AM +0100, Stefan Agner wrote:
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index c29200cf755a..e1e20499b2f1 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -156,7 +156,9 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  
>  	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
>  	if (ret) {
> -		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
> +				ret);
>  		goto fail;
>  	}
>  
> -- 
> 2.20.1
> 
