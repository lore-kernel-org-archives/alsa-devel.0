From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: sparc: Fix invalid
 snd_free_pages() at error path
Date: Sat, 24 Nov 2018 23:47:08 +0900
Message-ID: <20181124144708.GB11722@sakamocchi.jp>
References: <20181123171956.9236-1-tiwai@suse.de>
 <20181123171956.9236-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123171956.9236-2-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 23, 2018 at 06:19:56PM +0100, Takashi Iwai wrote:
> Some spurious calls of snd_free_pages() have been overlooked and
> remain in the error paths of sparc cs4231 driver code.  Since
> runtime->dma_area is managed by the PCM core helper, we shouldn't
> release manually.
> 
> Drop the superfluous calls.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/sparc/cs4231.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
> index e73c962590eb..079063d8038d 100644
> --- a/sound/sparc/cs4231.c
> +++ b/sound/sparc/cs4231.c
> @@ -1146,10 +1146,8 @@ static int snd_cs4231_playback_open(struct snd_pcm_substream *substream)
>  	runtime->hw = snd_cs4231_playback;
>  
>  	err = snd_cs4231_open(chip, CS4231_MODE_PLAY);
> -	if (err < 0) {
> -		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
> +	if (err < 0)
>  		return err;
> -	}
>  	chip->playback_substream = substream;
>  	chip->p_periods_sent = 0;
>  	snd_pcm_set_sync(substream);
> @@ -1167,10 +1165,8 @@ static int snd_cs4231_capture_open(struct snd_pcm_substream *substream)
>  	runtime->hw = snd_cs4231_capture;
>  
>  	err = snd_cs4231_open(chip, CS4231_MODE_RECORD);
> -	if (err < 0) {
> -		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
> +	if (err < 0)
>  		return err;
> -	}
>  	chip->capture_substream = substream;
>  	chip->c_periods_sent = 0;
>  	snd_pcm_set_sync(substream);
> -- 
> 2.19.1

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Regards

Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
