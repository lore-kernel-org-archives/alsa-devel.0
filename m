From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] sound/soc/fsl: remove leftover
	release_mem_region
Date: Sun, 13 Oct 2013 20:36:59 +0200
Message-ID: <525AE84B.8080703@metafoo.de>
References: <1381685916-7401-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 23348261ADC
 for <alsa-devel@alsa-project.org>; Sun, 13 Oct 2013 20:36:10 +0200 (CEST)
In-Reply-To: <1381685916-7401-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/13/2013 07:38 PM, Wolfram Sang wrote:
> When converting this driver to devm_ioremap_resource, the removal of this now
> unneeded function has been forgotten.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>   sound/soc/fsl/imx-ssi.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
> index f58bcd8..b2cc743 100644
> --- a/sound/soc/fsl/imx-ssi.c
> +++ b/sound/soc/fsl/imx-ssi.c
> @@ -615,7 +615,6 @@ failed_pcm_dma:
>   failed_pcm_fiq:
>   	snd_soc_unregister_component(&pdev->dev);
>   failed_register:
> -	release_mem_region(res->start, resource_size(res));
>   	clk_disable_unprepare(ssi->clk);
>   failed_clk:
>   	snd_soc_set_ac97_ops(NULL);
> @@ -636,7 +635,6 @@ static int imx_ssi_remove(struct platform_device *pdev)
>   	if (ssi->flags & IMX_SSI_USE_AC97)
>   		ac97_ssi = NULL;
>
> -	release_mem_region(res->start, resource_size(res));

This should trigger a warning about res being unused now.

>   	clk_disable_unprepare(ssi->clk);
>   	snd_soc_set_ac97_ops(NULL);
>
>
