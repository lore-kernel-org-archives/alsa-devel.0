From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 1/4] ASoC: esai: fix buggy of 'ret' type
	definition.
Date: Thu, 3 Apr 2014 18:50:59 +0800
Message-ID: <20140403105057.GA32081@MrMyself>
References: <1396516257-25354-1-git-send-email-Li.Xiubo@freescale.com>
 <1396516257-25354-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A919265671
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 13:00:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1396516257-25354-2-git-send-email-Li.Xiubo@freescale.com>
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

Hi Xiubo,

Could you please add some comments to describe where the bug is? If these
cause function break on Vybrid or LS1, you should tell people what the
root cause exactly is.

On Thu, Apr 03, 2014 at 05:10:54PM +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/fsl/fsl_esai.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 912104f..8efc89e 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -209,8 +209,9 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  	struct clk *clksrc = esai_priv->extalclk;
>  	bool tx = clk_id <= ESAI_HCKT_EXTAL;
>  	bool in = dir == SND_SOC_CLOCK_IN;
> -	u32 ret, ratio, ecr = 0;
> +	u32 ratio, ecr = 0;
>  	unsigned long clk_rate;
> +	int ret;

Using 'u32' instead of 'int' is just an expediency but not a crucial one.
This doesn't make a lot of sense to me.

>  
>  	/* sck_div can be only bypassed if ETO/ERO=0 and SNC_SOC_CLOCK_OUT */
>  	esai_priv->sck_div[tx] = true;
> @@ -432,8 +433,8 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  static int fsl_esai_startup(struct snd_pcm_substream *substream,
>  			    struct snd_soc_dai *dai)
>  {
> -	int ret;
>  	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
> +	int ret;

This looks fine.

Nicolin

>  
>  	/*
>  	 * Some platforms might use the same bit to gate all three or two of
> @@ -491,7 +492,8 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>  	u32 width = snd_pcm_format_width(params_format(params));
>  	u32 channels = params_channels(params);
> -	u32 bclk, mask, val, ret;
> +	u32 bclk, mask, val;
> +	int ret;
>  
>  	bclk = params_rate(params) * esai_priv->slot_width * 2;
>  
> -- 
> 1.8.4
> 
> 
