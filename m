From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set TDM when needed
Date: Thu, 13 Aug 2009 03:28:59 +0200
Message-ID: <20090813012858.GR13639@buzzloop.caiaq.de>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 53247247E5
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 03:29:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Daniel Ribeiro <drwyrm@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 06, 2009 at 03:55:18PM +0100, Mark Brown wrote:
> * Automatically sets TDM mode for frame_width larger than 32 bits, if
>   the user doesn't setup the TDM slots with set_tdm_slot().
> * Reset SSCR0_EDSS and SSCR0_DSS on pxa_ssp_set_dai_fmt.
> * Makes SSCR0_MOD optional.
> * Clears SSCR1_RWOT case SSCR0_MOD is set.
> 
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/pxa/pxa-ssp.c |   92 +++++++++++++++++++++++++++--------------------
>  1 files changed, 53 insertions(+), 39 deletions(-)
> 
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 5b9ed64..d60492e 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c

[...]

> @@ -532,48 +532,70 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
>  	struct ssp_priv *priv = cpu_dai->private_data;
>  	struct ssp_device *ssp = priv->dev.ssp;
>  	int chn = params_channels(params);
> -	u32 sscr0;
> -	u32 sspsp;
> +	u32 sscr0, sscr1, sspsp;
>  	int width = snd_pcm_format_physical_width(params_format(params));
> -	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
> +	int slot_width, frame_width = 0;
> +
> +	/* check if the user explicitly set a slot_width */
> +	sscr0 = ssp_read_reg(ssp, SSCR0);
> +
> +	if (sscr0 & (SSCR0_EDSS | SSCR0_DSS))
> +		slot_width = (sscr0 & SSCR0_DSS) +
> +			(sscr0 & SSCR0_EDSS ? 17 : 1);
> +	else
> +		frame_width = slot_width = width * chn;
>  
>  	/* generate correct DMA params */
>  	if (cpu_dai->dma_data)
>  		kfree(cpu_dai->dma_data);
>  
> -	/* Network mode with one active slot (ttsa == 1) can be used
> -	 * to force 16-bit frame width on the wire (for S16_LE), even
> -	 * with two channels. Use 16-bit DMA transfers for this case.
> -	 */
> -	cpu_dai->dma_data = ssp_get_dma_params(ssp,
> -			((chn == 2) && (ttsa != 1)) || (width == 32),
> +	cpu_dai->dma_data = ssp_get_dma_params(ssp, slot_width > 16,
>  			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
>  
>  	/* we can only change the settings if the port is not in use */
> -	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
> +	if (sscr0 & SSCR0_SSE)
>  		return 0;
>  
> -	/* clear selected SSP bits */
> -	sscr0 = ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
> -	ssp_write_reg(ssp, SSCR0, sscr0);
> -
> -	/* bit size */
> -	sscr0 = ssp_read_reg(ssp, SSCR0);
> -	switch (params_format(params)) {
> -	case SNDRV_PCM_FORMAT_S16_LE:
>  #ifdef CONFIG_PXA3xx
> -		if (cpu_is_pxa3xx())
> -			sscr0 |= SSCR0_FPCKE;
> +	if (slot_width == 16 && cpu_is_pxa3xx())

And I forgot to mention that this should read ">= 16".

Daniel
