From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: 3.18.0-rc1 pulseaudio possible recursive locking
Date: Wed, 22 Oct 2014 02:38:55 +1030
Message-ID: <54468517.5030701@internode.on.net>
References: <5445159B.6050507@internode.on.net>	<s5h7fzu3sc9.wl-tiwai@suse.de>
 <s5htx2xzgnx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by alsa0.perex.cz (Postfix) with ESMTP id AF3A52606B7
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 18:09:15 +0200 (CEST)
In-Reply-To: <s5htx2xzgnx.wl-tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Takashi Iwai wrote, on 22/10/14 00:08:
> At Tue, 21 Oct 2014 07:27:34 +0200,
> Takashi Iwai wrote:
>>
>> At Tue, 21 Oct 2014 00:30:59 +1030,
>> Arthur Marsh wrote:
>>>
>>> Hi, I have been seeing this a few times lately, and noticed that it was
>>> still present
>>>
>>> Is this the right place to report it or should I be reporting a bug
>>> against pulseaudio?
>>
>> This is likely a false-positive report, so ignore it unless you really
>> encounter the deadlock by this.
>
> Or try the patch below.  This seems hitting more often, so it's maybe
> worth to put into 3.18-rc2.  Let me know if this solves the problem.
>
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: pcm: Fix false lockdep warnings
>
> As PCM core handles the multiple linked streams in parallel, lockdep
> gets confused (partly because of weak annotations) and spews the
> false-positive warnings.  This hasn't been a problem for long time but
> the latest PCM lock path update seems to have woken up a sleeping
> dog.
>
> Here is an attempt to paper over this issue: pass the lock subclass
> just calculated from the depth in snd_pcm_action_group().  Also, a
> (possibly) wrong lock subclass set in snd_pcm_action_lock_mutex() is
> dropped, too.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_native.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 815396d8427f..166d59cdc86b 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -781,16 +781,15 @@ static int snd_pcm_action_group(struct action_ops *ops,
>   {
>   	struct snd_pcm_substream *s = NULL;
>   	struct snd_pcm_substream *s1;
> -	int res = 0;
> +	int res = 0, depth = 1;
>
>   	snd_pcm_group_for_each_entry(s, substream) {
>   		if (do_lock && s != substream) {
>   			if (s->pcm->nonatomic)
> -				mutex_lock_nested(&s->self_group.mutex,
> -						  SINGLE_DEPTH_NESTING);
> +				mutex_lock_nested(&s->self_group.mutex, depth);
>   			else
> -				spin_lock_nested(&s->self_group.lock,
> -						 SINGLE_DEPTH_NESTING);
> +				spin_lock_nested(&s->self_group.lock, depth);
> +			depth++;
>   		}
>   		res = ops->pre_action(s, state);
>   		if (res < 0)
> @@ -906,8 +905,7 @@ static int snd_pcm_action_lock_mutex(struct action_ops *ops,
>   	down_read(&snd_pcm_link_rwsem);
>   	if (snd_pcm_stream_linked(substream)) {
>   		mutex_lock(&substream->group->mutex);
> -		mutex_lock_nested(&substream->self_group.mutex,
> -				  SINGLE_DEPTH_NESTING);
> +		mutex_lock(&substream->self_group.mutex);
>   		res = snd_pcm_action_group(ops, substream, state, 1);
>   		mutex_unlock(&substream->self_group.mutex);
>   		mutex_unlock(&substream->group->mutex);
>

Hi, I applied this patch, rebuilt the kernel and am running it now and 
have not seen the "pulseaudio possible recursive locking" message yet.

For the previous 4 reboots with earlier kernels 3.17.0+ / 3.18.0-rc1 I 
saw the "pulseaudio possible recursive locking" message appear about 5 
minutes after boot-up.

Thanks for your help!

Arthur.
