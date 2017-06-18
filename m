From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: pcm: Fix possible inconsistent
 appl_ptr update via mmap
Date: Sun, 18 Jun 2017 19:49:24 +0900
Message-ID: <f101e9f3-b243-51d0-400c-907bbcb90367@sakamocchi.jp>
References: <20170616204055.31036-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 4A619266AE2
 for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2017 12:49:30 +0200 (CEST)
In-Reply-To: <20170616204055.31036-1-tiwai@suse.de>
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

Hi,

On Jun 17 2017 05:40, Takashi Iwai wrote:
> The ALSA PCM core refers to the appl_ptr value stored on the mmapped
> page that is shared between kernel and user-space.  Although the
> reference is performed in the PCM stream lock, it doesn't guarantee
> the atomic access when the value gets updated concurrently from the
> user-space on another CPU.
> 
> In most of codes, this is no big problem, but still there are a few
> places that may result in slight inconsistencies because they access
> runtime->control->appl_ptr multiple times; that is, the second read
> might be a different value from the first value.  It can be even
> backward or jumping, as we have no control for it.  Hence, the
> calculation may give an unexpected value.  Luckily, there is no
> security vulnerability by that, as far as I've checked.  But still we
> should address it.
> 
> This patch tries to reduce such possible cases.  The fix is simple --
> we just read once, store it to a local variable and use it for the
> rest calculations.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_lib.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

This looks good to me by itself.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

This function, 'snd_pcm_playback_silence()' can be called without 
acquiring stream lock by 'snd_pcm_reset()' when runtime of PCM substream 
is configured to have a larger value than zero to its 'silence_size' 
member. When a task or any IRQ handler operates the runtime and another 
task operates the reset in the same time, both of them got expected result.

I'll post a patch to take 'snd_pcm_reset()' to use 
'snd_pcm_action_lock_irq()' instead of 'snd_pcm_action_nonatomic()'. How 
do you think about it?

> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index 631cd598ba6c..cda258d91490 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -65,15 +65,16 @@ void snd_pcm_playback_silence(struct snd_pcm_substream *substream, snd_pcm_ufram
>   
>   	if (runtime->silence_size < runtime->boundary) {
>   		snd_pcm_sframes_t noise_dist, n;
> -		if (runtime->silence_start != runtime->control->appl_ptr) {
> -			n = runtime->control->appl_ptr - runtime->silence_start;
> +		snd_pcm_uframes_t appl_ptr = runtime->control->appl_ptr;
> +		if (runtime->silence_start != appl_ptr) {
> +			n = appl_ptr - runtime->silence_start;
>   			if (n < 0)
>   				n += runtime->boundary;
>   			if ((snd_pcm_uframes_t)n < runtime->silence_filled)
>   				runtime->silence_filled -= n;
>   			else
>   				runtime->silence_filled = 0;
> -			runtime->silence_start = runtime->control->appl_ptr;
> +			runtime->silence_start = appl_ptr;
>   		}
>   		if (runtime->silence_filled >= runtime->buffer_size)
>   			return;
> @@ -2224,7 +2225,9 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
>   				continue; /* draining */
>   		}
>   		frames = size > avail ? avail : size;
> -		cont = runtime->buffer_size - runtime->control->appl_ptr % runtime->buffer_size;
> +		appl_ptr = runtime->control->appl_ptr;
> +		appl_ofs = appl_ptr % runtime->buffer_size;
> +		cont = runtime->buffer_size - appl_ofs;
>   		if (frames > cont)
>   			frames = cont;
>   		if (snd_BUG_ON(!frames)) {
> @@ -2232,8 +2235,6 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
>   			snd_pcm_stream_unlock_irq(substream);
>   			return -EINVAL;
>   		}
> -		appl_ptr = runtime->control->appl_ptr;
> -		appl_ofs = appl_ptr % runtime->buffer_size;
>   		snd_pcm_stream_unlock_irq(substream);
>   		err = writer(substream, appl_ofs, data, offset, frames,
>   			     transfer);

Regards

Takashi Sakamoto
