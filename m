From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: use snd_soc_dai_init_dma_data()
Date: Tue, 21 Jan 2014 13:52:02 +0800
Message-ID: <20140121055201.GA335@MrMyself>
References: <1390202846-31670-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 537E9261B19
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2014 07:11:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1390202846-31670-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 20, 2014 at 03:27:26PM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>

> ---
>  sound/soc/fsl/fsl_spdif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 4d075f1..8f36f49 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -911,8 +911,8 @@ static int fsl_spdif_dai_probe(struct snd_soc_dai *dai)
>  {
>  	struct fsl_spdif_priv *spdif_private = snd_soc_dai_get_drvdata(dai);
>  
> -	dai->playback_dma_data = &spdif_private->dma_params_tx;
> -	dai->capture_dma_data = &spdif_private->dma_params_rx;
> +	snd_soc_dai_init_dma_data(dai, &spdif_private->dma_params_tx,
> +				  &spdif_private->dma_params_rx);
>  
>  	snd_soc_add_dai_controls(dai, fsl_spdif_ctrls, ARRAY_SIZE(fsl_spdif_ctrls));
>  
> -- 
> 1.8.4
> 
> 
