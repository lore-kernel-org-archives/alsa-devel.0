From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: wss: Fix invalid
 snd_free_pages() at error path
Date: Sat, 24 Nov 2018 23:40:34 +0900
Message-ID: <20181124144034.GA11722@sakamocchi.jp>
References: <20181123171956.9236-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17B9E26786E
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 15:40:43 +0100 (CET)
Received: by mail-pf1-f193.google.com with SMTP id i12so4531603pfo.7
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 06:40:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181123171956.9236-1-tiwai@suse.de>
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

Hi,

On Fri, Nov 23, 2018 at 06:19:55PM +0100, Takashi Iwai wrote:
> Some spurious calls of snd_free_pages() have been overlooked and
> remain in the error paths of wss driver code.  Since runtime->dma_area
> is managed by the PCM core helper, we shouldn't release manually.
> 
> Drop the superfluous calls.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/isa/wss/wss_lib.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
> index 32453f81b95a..3a5008837576 100644
> --- a/sound/isa/wss/wss_lib.c
> +++ b/sound/isa/wss/wss_lib.c
> @@ -1531,7 +1531,6 @@ static int snd_wss_playback_open(struct snd_pcm_substream *substream)
>  	if (err < 0) {
>  		if (chip->release_dma)
>  			chip->release_dma(chip, chip->dma_private_data, chip->dma1);
> -		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
>  		return err;
>  	}
>  	chip->playback_substream = substream;
> @@ -1572,7 +1571,6 @@ static int snd_wss_capture_open(struct snd_pcm_substream *substream)
>  	if (err < 0) {
>  		if (chip->release_dma)
>  			chip->release_dma(chip, chip->dma_private_data, chip->dma2);
> -		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
>  		return err;
>  	}
>  	chip->capture_substream = substream;

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

As in commit message, in this case, the 'struct snd_pcm_runtime.dma_area'
is assigned by a call of 'snd_pcm_lib_malloc_pages()', thus it's
allocated in 'snd_wss_[capture|playback]_hw_params()', and released in
'snd_wss_[capture|playback]_hw_free()'. No need to care it in
'snd_wss_[capture|playback_open()]'.

> -- 
> 2.19.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
