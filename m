From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 5/5] ASoC: imx-sgtl5000: lower log level
 for potential probe deferral cases
Date: Thu, 17 Jan 2019 14:01:52 -0800
Message-ID: <20190117220152.GC16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
 <20190117090640.12972-5-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AF97266A89
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 23:01:56 +0100 (CET)
Received: by mail-pl1-f194.google.com with SMTP id p8so5366760plo.2
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 14:01:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-5-stefan@agner.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Agner <stefan@agner.ch>
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, fabio.estevam@nxp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 10:06:40AM +0100, Stefan Agner wrote:
> Not finding the codec/SSI instance can be due to probe deferral.
> Do not print error messages in those cases.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 45969e6dfad7..b6cb80480b60 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -104,13 +104,13 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  
>  	ssi_pdev = of_find_device_by_node(ssi_np);
>  	if (!ssi_pdev) {
> -		dev_err(&pdev->dev, "failed to find SSI platform device\n");
> +		dev_dbg(&pdev->dev, "failed to find SSI platform device\n");
>  		ret = -EPROBE_DEFER;
>  		goto fail;
>  	}
>  	codec_dev = of_find_i2c_device_by_node(codec_np);
>  	if (!codec_dev) {
> -		dev_err(&pdev->dev, "failed to find codec platform device\n");
> +		dev_dbg(&pdev->dev, "failed to find codec platform device\n");
>  		ret = -EPROBE_DEFER;
>  		goto fail;
>  	}
> -- 
> 2.20.1
> 
