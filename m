From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 4/5] ASoC: imx-sgtl5000: put of nodes if finding codec
 fails
Date: Thu, 17 Jan 2019 14:04:48 -0800
Message-ID: <20190117220448.GE16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
 <20190117090640.12972-4-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-4-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 10:06:39AM +0100, Stefan Agner wrote:
> Make sure to properly put the of node in case finding the codec
> fails.
> 
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index e1e20499b2f1..45969e6dfad7 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -111,7 +111,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  	codec_dev = of_find_i2c_device_by_node(codec_np);
>  	if (!codec_dev) {
>  		dev_err(&pdev->dev, "failed to find codec platform device\n");
> -		return -EPROBE_DEFER;
> +		ret = -EPROBE_DEFER;
> +		goto fail;
>  	}
>  
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> -- 
> 2.20.1
> 
