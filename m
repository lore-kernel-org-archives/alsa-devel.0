From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
Date: Tue, 28 Mar 2017 10:21:03 +0100
Message-ID: <20170328092103.GQ6986@localhost.localdomain>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 115BB266703
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 11:20:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org, timur@tabi.org, nicoleotsuka@gmail.com, broonie@kernel.org, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 28, 2017 at 11:58:52AM +0300, Daniel Baluta wrote:
> Resource managed devm_clk_get only works with platform's device dev.
> 

I feel like this could use an explaination of why not using devm
is the correct fix, rather than just using the platform device
for the call. Its not obvious to me, that using the platform
device would be an issue.

Thanks,
Charles

> Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/imx-wm8962.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
> index 3d894d9..52659fa 100644
> --- a/sound/soc/fsl/imx-wm8962.c
> +++ b/sound/soc/fsl/imx-wm8962.c
> @@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> +	codec_clk = clk_get(&codec_dev->dev, NULL);
>  	if (IS_ERR(codec_clk)) {
>  		ret = PTR_ERR(codec_clk);
>  		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
> @@ -239,6 +239,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  	}
>  
>  	data->clk_frequency = clk_get_rate(codec_clk);
> +	clk_put(codec_clk);
>  
>  	data->dai.name = "HiFi";
>  	data->dai.stream_name = "HiFi";
> -- 
> 2.7.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
