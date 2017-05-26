From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 06/14] ALSA: pcm: Shuffle codes
Date: Fri, 26 May 2017 22:06:29 +0900
Message-ID: <ccca946d-8b43-0398-12ac-1917b5f495a8@sakamocchi.jp>
References: <20170525191735.13787-1-tiwai@suse.de>
 <20170525191735.13787-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id D68872674DB
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 15:06:35 +0200 (CEST)
In-Reply-To: <20170525191735.13787-7-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 26 2017 04:17, Takashi Iwai wrote:
> Just shuffle the codes, without any change otherwise.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_lib.c | 210 +++++++++++++++++++++++++--------------------------
>   1 file changed, 105 insertions(+), 105 deletions(-)
> 
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index e4f5c43b6448..5db086748515 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c > ...
> @@ -2117,19 +2179,6 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
>   }
>   
>   /* sanity-check for read/write methods */
> -static int pcm_sanity_check(struct snd_pcm_substream *substream)
> -{
> -	struct snd_pcm_runtime *runtime;
> -	if (PCM_RUNTIME_CHECK(substream))
> -		return -ENXIO;
> -	runtime = substream->runtime;
> -	if (snd_BUG_ON(!substream->ops->copy_user && !runtime->dma_area))
> -		return -EINVAL;
> -	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
> -		return -EBADFD;
> -	return 0;
> -}
> -

The function comment should be involved to this move.


Regards

Takashi Sakamoto
