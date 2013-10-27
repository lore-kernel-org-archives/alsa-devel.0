From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ALSA: pcm_dmaengine: Remove hardcoded PCM
 formats
Date: Sun, 27 Oct 2013 16:53:56 +0100
Message-ID: <526D3714.7000002@metafoo.de>
References: <s5hhac5l4m8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-129.synserver.de
 [212.40.185.129])
 by alsa0.perex.cz (Postfix) with ESMTP id A2E4226169D
 for <alsa-devel@alsa-project.org>; Sun, 27 Oct 2013 16:53:57 +0100 (CET)
In-Reply-To: <s5hhac5l4m8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/25/2013 06:03 PM, Takashi Iwai wrote:
> Use the standard PCM helper function to figure out the sample bytes
> instead of hardcodec PCM format checks in
> snd_hwparams_to_dma_slave_config().
> 
> The patch also extends the format check for 8 bytes formats although
> no one should match so far.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> I stumbled upon this, but am not 100% sure whether the current
> hardcoded formats are the designed limitation...

Looks good. I'm not sure if we ever need to handle the 24 bits per word case
and if the current code handles the case correctly. But since the patch
keeps the existing behavior for that case it should be fine.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> 
>  sound/core/pcm_dmaengine.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index aa924d9..94d0873 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -63,23 +63,19 @@ int snd_hwparams_to_dma_slave_config(const struct snd_pcm_substream *substream,
>  	struct dma_slave_config *slave_config)
>  {
>  	enum dma_slave_buswidth buswidth;
> +	int bits;
>  
> -	switch (params_format(params)) {
> -	case SNDRV_PCM_FORMAT_S8:
> +	bits = snd_pcm_format_physical_width(params_format(params));
> +	if (bits < 8 || bits > 64)
> +		return -EINVAL;
> +	else if (bits == 8)
>  		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
> -		break;
> -	case SNDRV_PCM_FORMAT_S16_LE:
> +	else if (bits == 16)
>  		buswidth = DMA_SLAVE_BUSWIDTH_2_BYTES;
> -		break;
> -	case SNDRV_PCM_FORMAT_S18_3LE:
> -	case SNDRV_PCM_FORMAT_S20_3LE:
> -	case SNDRV_PCM_FORMAT_S24_LE:
> -	case SNDRV_PCM_FORMAT_S32_LE:
> +	else if (bits <= 32)
>  		buswidth = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	else
> +		buswidth = DMA_SLAVE_BUSWIDTH_8_BYTES;
>  
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  		slave_config->direction = DMA_MEM_TO_DEV;
> 
