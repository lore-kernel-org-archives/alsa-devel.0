From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 02/10] ASoC: imx-pcm-dma: DT support
Date: Thu, 18 Apr 2013 16:43:43 +0200
Message-ID: <5170069F.4030200@metafoo.de>
References: <1366288424-7660-1-git-send-email-mpa@pengutronix.de>
 <1366288424-7660-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-199.synserver.de
 [212.40.185.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 447A3264F00
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 16:44:31 +0200 (CEST)
In-Reply-To: <1366288424-7660-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 04/18/2013 02:33 PM, Markus Pargmann wrote:
> This patch adds the possibility to pass a of_node as platform_data which
> is used by generic-pcm-dma to request a DMA slave channel.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  sound/soc/fsl/imx-pcm-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
> index c246fb5..8945d22 100644
> --- a/sound/soc/fsl/imx-pcm-dma.c
> +++ b/sound/soc/fsl/imx-pcm-dma.c
> @@ -62,9 +62,11 @@ static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
>  
>  int imx_pcm_dma_init(struct platform_device *pdev)
>  {
> +	if (pdev->dev.platform_data)
> +		pdev->dev.of_node = pdev->dev.platform_data;

In my opinion it's better to use pdev->dev.parent->of_node here. In the ssi
driver you use platform_device_register_data, which will create a copy of
the of_node you pass in as platform data. I'm not quite sure how well this
will work. If you want to continue to use platform_data you should at least
change the code in the ssi driver to not make a copy of the of_node.

- Lars

> +
>  	return snd_dmaengine_pcm_register(&pdev->dev, &imx_dmaengine_pcm_config,
>  		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
> -		SND_DMAENGINE_PCM_FLAG_NO_DT |
>  		SND_DMAENGINE_PCM_FLAG_COMPAT);
>  }
>  
