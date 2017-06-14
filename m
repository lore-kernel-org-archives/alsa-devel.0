From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/6] ALSA: pcm: Preprocess PAUSED or
 SUSPENDED stream before PREPARE
Date: Wed, 14 Jun 2017 10:55:38 +0900
Message-ID: <8fe86243-e47d-bd59-f3e6-5c3359fff950@sakamocchi.jp>
References: <20170613141812.21220-1-tiwai@suse.de>
 <20170613141812.21220-5-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B02982668BF
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 03:55:41 +0200 (CEST)
In-Reply-To: <20170613141812.21220-5-tiwai@suse.de>
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

On Jun 13 2017 23:18, Takashi Iwai wrote:
> Calling PREPARE ioctl to the stream in either PAUSED or SUSPENDED
> state may confuse some drivers that don't handle the state properly.
> Instead of fixing each driver, PCM core should take care of the proper
> state change before actually trying to (re-)prepare the stream.
> Namely, when the stream is in PAUSED state, it triggers PAUSH_RELEASE,

s/PAUSH_RELEASE/PAUSE_RELEASE/

> and when in SUSPENDED state, it triggers STOP, before calling prepare
> callbacks.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_native.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 69cf9b02ac70..0941b9c92b3f 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1684,6 +1684,17 @@ static int snd_pcm_prepare(struct snd_pcm_substream *substream,
>   	else
>   		f_flags = substream->f_flags;
>   
> +	snd_pcm_stream_lock_irq(substream);
> +	switch (substream->runtime->status->state) {
> +	case SNDRV_PCM_STATE_PAUSED:
> +		snd_pcm_pause(substream, 0);
> +		/* fallthru */
> +	case SNDRV_PCM_STATE_SUSPENDED:
> +		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
> +		break;
> +	}
> +	snd_pcm_stream_unlock_irq(substream);
> +
>   	return snd_pcm_action_nonatomic(&snd_pcm_action_prepare,
>   					substream, f_flags);
>   }


Regards

Takashi Sakamoto
