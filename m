From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v2 1/1] ALSA: SOC: DMA: access buffer pointer
 atomically
Date: Thu, 1 Dec 2016 13:49:26 +0100
Message-ID: <d8dbe0cb-ca98-6030-5977-181f09b8e1c1@metafoo.de>
References: <20161201052422.18775-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161201052422.18775-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, apape@de.adit-jv.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/01/2016 06:24 AM, Jiada Wang wrote:
> From: Andreas Pape <apape@de.adit-jv.com>
> 
> Setting pointer and afterwards check for wrap around leads
> to the possibility of returning the inconsistent pointer position.
> 
> This patch accesses buffer pointer atomically to avoid this issue.
> 
> v2: use READ_ONCE and WRITE_ONCE to ensure read/write of buffer pointer in
>     only one access
>     also updates snd_dmaengine_pcm_pointer_no_residue to ensure atomic
>     access
> 
> Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Thanks for the patch. Looks good to me.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/core/pcm_dmaengine.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index 8eb58c7..b6255fd 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -139,12 +139,14 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
>  
>  static void dmaengine_pcm_dma_complete(void *arg)
>  {
> +	unsigned int new_pos;
>  	struct snd_pcm_substream *substream = arg;
>  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
>  
> -	prtd->pos += snd_pcm_lib_period_bytes(substream);
> -	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
> -		prtd->pos = 0;
> +	new_pos = prtd->pos + snd_pcm_lib_period_bytes(substream);
> +	if (new_pos >= snd_pcm_lib_buffer_bytes(substream))
> +		new_pos = 0;
> +	WRITE_ONCE(prtd->pos, new_pos);
>  
>  	snd_pcm_period_elapsed(substream);
>  }
> @@ -235,7 +237,7 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_trigger);
>  snd_pcm_uframes_t snd_dmaengine_pcm_pointer_no_residue(struct snd_pcm_substream *substream)
>  {
>  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> -	return bytes_to_frames(substream->runtime, prtd->pos);
> +	return bytes_to_frames(substream->runtime, READ_ONCE(prtd->pos));
>  }
>  EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer_no_residue);
>  
> 
