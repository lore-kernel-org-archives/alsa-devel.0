From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH] media: Drop superfluous PCM preallocation
	error checks
Date: Tue, 12 Mar 2019 09:13:32 +0100
Message-ID: <7393e26f-621f-1855-2829-846e909e3475@xs4all.nl>
References: <20190206173239.18046-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net
 [194.109.24.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E791F80799
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2019 09:13:37 +0100 (CET)
In-Reply-To: <20190206173239.18046-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 2/6/19 6:32 PM, Takashi Iwai wrote:
> snd_pcm_lib_preallocate_pages() and co always succeed, so the error
> check is simply redundant.  Drop it.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

I can take it as for 5.2, but you can as well with my Ack. If you want me
to take it, let me know.

Regards,

	Hans

> ---
> 
> This is a piece I overlooked in the previous patchset:
>    https://www.spinics.net/lists/alsa-devel/msg87223.html
> 
> Media people, please give ACK if this is OK.  Then I'll merge it together
> with other relevant patches.  Thanks!
> 
>  drivers/media/pci/solo6x10/solo6x10-g723.c | 4 +---
>  drivers/media/pci/tw686x/tw686x-audio.c    | 3 ++-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/pci/solo6x10/solo6x10-g723.c b/drivers/media/pci/solo6x10/solo6x10-g723.c
> index 2cc05a9d57ac..a16242a9206f 100644
> --- a/drivers/media/pci/solo6x10/solo6x10-g723.c
> +++ b/drivers/media/pci/solo6x10/solo6x10-g723.c
> @@ -360,13 +360,11 @@ static int solo_snd_pcm_init(struct solo_dev *solo_dev)
>  	     ss; ss = ss->next, i++)
>  		sprintf(ss->name, "Camera #%d Audio", i);
>  
> -	ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
> +	snd_pcm_lib_preallocate_pages_for_all(pcm,
>  					SNDRV_DMA_TYPE_CONTINUOUS,
>  					snd_dma_continuous_data(GFP_KERNEL),
>  					G723_PERIOD_BYTES * PERIODS,
>  					G723_PERIOD_BYTES * PERIODS);
> -	if (ret < 0)
> -		return ret;
>  
>  	solo_dev->snd_pcm = pcm;
>  
> diff --git a/drivers/media/pci/tw686x/tw686x-audio.c b/drivers/media/pci/tw686x/tw686x-audio.c
> index a28329698e20..fb0e7573b5ae 100644
> --- a/drivers/media/pci/tw686x/tw686x-audio.c
> +++ b/drivers/media/pci/tw686x/tw686x-audio.c
> @@ -301,11 +301,12 @@ static int tw686x_snd_pcm_init(struct tw686x_dev *dev)
>  	     ss; ss = ss->next, i++)
>  		snprintf(ss->name, sizeof(ss->name), "vch%u audio", i);
>  
> -	return snd_pcm_lib_preallocate_pages_for_all(pcm,
> +	snd_pcm_lib_preallocate_pages_for_all(pcm,
>  				SNDRV_DMA_TYPE_DEV,
>  				snd_dma_pci_data(dev->pci_dev),
>  				TW686X_AUDIO_PAGE_MAX * AUDIO_DMA_SIZE_MAX,
>  				TW686X_AUDIO_PAGE_MAX * AUDIO_DMA_SIZE_MAX);
> +	return 0;
>  }
>  
>  static void tw686x_audio_dma_free(struct tw686x_dev *dev,
> 
