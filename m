From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Clean up of PCM spinlocks
Date: Tue, 13 Mar 2012 15:24:11 +0100
Message-ID: <4F5F588B.40107@perex.cz>
References: <s5hboo03h01.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 759991042F1
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 15:24:08 +0100 (CET)
In-Reply-To: <s5hboo03h01.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 13.3.2012 11:57, Takashi Iwai wrote:
> Hi,
> 
> below is a patch I posted to LKML as the follow up for the lockdep
> report from Dave Jones.  It's a resurrected patch from what I worked
> on quite ago.  Although this fix is suboptimal, I see no better way.
> 
> If this looks OK, I'm going to queue it as a 3.4 material.
> 
> 
> thanks,
> 
> Takashi
> 
> ===
> 
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: pcm - Simplify linked PCM substream spinlocks
> 
> The spinlocks held for PCM substreams have been always messy.  For the
> better concurrent accessibility, we took always the substream's lock
> first.  When substreams are linked, we need a group-wide lock, but
> this should be applied outside substream's lock.  So, we unlock the
> substream's lock first, then do locks twice.
> 
> This scheme is known to be problematic with lockdep.  Maybe because
> the nested lock isn't marked properly, and partly because the lock and
> unlock sequences are different (A/B -> A/B).
> 
> This patch tries to simplify the scheme.  Instead of holding the
> substream's lock, we take the group lock always at first.  A drawback
> of this is that the access to the individual substream in a same group
> won't be allowed any longer.  But, the code looks much easier, and
> likely less buggy.

What do you mean by this? I noticed that you switched the behaviour for
the stream_lock():

1) self_group spinlock is used for single (non-linked) stream
   - same as before
2) group.lock spinlock is used for the linked streams
   - the self_group spinlock is used only in the group action
     - the question is why? it seems useless, the
       stream_lock() functions use the allocated group.lock

I don't think that this patch will work in the way we expect.

I believe we should use only group.lock spinlock for the linked streams
without using the self_group spinlock to make locking work like this:

stream_lock(current)
group_action(current) {
  for s from all_group_substreams {
    if (s != current)
      stream_lock(s);
  }
  .... job ....
  .... group substreams unlock ....
}
stream_unlock(current)

So we use only one lock per stream.

					Jaroslav

> 
> Note that the group lock is identical with the substream's lock
> initially before the substream is linked with others.  So, in the case
> of non-linked PCM, the new code behaves exactly same as before.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/sound/pcm.h     |   12 ++++++------
>  sound/core/pcm_native.c |   36 ++++++++++++++----------------------
>  2 files changed, 20 insertions(+), 28 deletions(-)
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 0cf91b2..d634dcc 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -531,36 +531,36 @@ static inline int snd_pcm_stream_linked(struct snd_pcm_substream *substream)
>  static inline void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
>  {
>  	read_lock(&snd_pcm_link_rwlock);
> -	spin_lock(&substream->self_group.lock);
> +	spin_lock(&substream->group->lock);
>  }
>  
>  static inline void snd_pcm_stream_unlock(struct snd_pcm_substream *substream)
>  {
> -	spin_unlock(&substream->self_group.lock);
> +	spin_unlock(&substream->group->lock);
>  	read_unlock(&snd_pcm_link_rwlock);
>  }
>  
>  static inline void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
>  {
>  	read_lock_irq(&snd_pcm_link_rwlock);
> -	spin_lock(&substream->self_group.lock);
> +	spin_lock(&substream->group->lock);
>  }
>  
>  static inline void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream)
>  {
> -	spin_unlock(&substream->self_group.lock);
> +	spin_unlock(&substream->group->lock);
>  	read_unlock_irq(&snd_pcm_link_rwlock);
>  }
>  
>  #define snd_pcm_stream_lock_irqsave(substream, flags) \
>  do { \
>  	read_lock_irqsave(&snd_pcm_link_rwlock, (flags)); \
> -	spin_lock(&substream->self_group.lock); \
> +	spin_lock(&substream->group->lock); \
>  } while (0)
>  
>  #define snd_pcm_stream_unlock_irqrestore(substream, flags) \
>  do { \
> -	spin_unlock(&substream->self_group.lock); \
> +	spin_unlock(&substream->group->lock); \
>  	read_unlock_irqrestore(&snd_pcm_link_rwlock, (flags)); \
>  } while (0)
>  
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 25ed9fe..c5f28ed 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -712,7 +712,7 @@ static int snd_pcm_action_group(struct action_ops *ops,
>  	int res = 0;
>  
>  	snd_pcm_group_for_each_entry(s, substream) {
> -		if (do_lock && s != substream)
> +		if (do_lock)
>  			spin_lock_nested(&s->self_group.lock,
>  					 SINGLE_DEPTH_NESTING);
>  		res = ops->pre_action(s, state);
> @@ -740,8 +740,7 @@ static int snd_pcm_action_group(struct action_ops *ops,
>  	if (do_lock) {
>  		/* unlock streams */
>  		snd_pcm_group_for_each_entry(s1, substream) {
> -			if (s1 != substream)
> -				spin_unlock(&s1->self_group.lock);
> +			spin_unlock(&s1->self_group.lock);
>  			if (s1 == s)	/* end */
>  				break;
>  		}
> @@ -779,13 +778,7 @@ static int snd_pcm_action(struct action_ops *ops,
>  	int res;
>  
>  	if (snd_pcm_stream_linked(substream)) {
> -		if (!spin_trylock(&substream->group->lock)) {
> -			spin_unlock(&substream->self_group.lock);
> -			spin_lock(&substream->group->lock);
> -			spin_lock(&substream->self_group.lock);
> -		}
>  		res = snd_pcm_action_group(ops, substream, state, 1);
> -		spin_unlock(&substream->group->lock);
>  	} else {
>  		res = snd_pcm_action_single(ops, substream, state);
>  	}
> @@ -801,19 +794,13 @@ static int snd_pcm_action_lock_irq(struct action_ops *ops,
>  {
>  	int res;
>  
> -	read_lock_irq(&snd_pcm_link_rwlock);
> +	snd_pcm_stream_lock_irq(substream);
>  	if (snd_pcm_stream_linked(substream)) {
> -		spin_lock(&substream->group->lock);
> -		spin_lock(&substream->self_group.lock);
>  		res = snd_pcm_action_group(ops, substream, state, 1);
> -		spin_unlock(&substream->self_group.lock);
> -		spin_unlock(&substream->group->lock);
>  	} else {
> -		spin_lock(&substream->self_group.lock);
>  		res = snd_pcm_action_single(ops, substream, state);
> -		spin_unlock(&substream->self_group.lock);
>  	}
> -	read_unlock_irq(&snd_pcm_link_rwlock);
> +	snd_pcm_stream_unlock_irq(substream);
>  	return res;
>  }
>  
> @@ -1586,12 +1573,18 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
>  	struct file *file;
>  	struct snd_pcm_file *pcm_file;
>  	struct snd_pcm_substream *substream1;
> +	struct snd_pcm_group *group;
>  
>  	file = snd_pcm_file_fd(fd);
>  	if (!file)
>  		return -EBADFD;
>  	pcm_file = file->private_data;
>  	substream1 = pcm_file->substream;
> +	group = kmalloc(sizeof(*group), GFP_KERNEL);
> +	if (!group) {
> +		res = -ENOMEM;
> +		goto _nolock;
> +	}
>  	down_write(&snd_pcm_link_rwsem);
>  	write_lock_irq(&snd_pcm_link_rwlock);
>  	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
> @@ -1604,11 +1597,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
>  		goto _end;
>  	}
>  	if (!snd_pcm_stream_linked(substream)) {
> -		substream->group = kmalloc(sizeof(struct snd_pcm_group), GFP_ATOMIC);
> -		if (substream->group == NULL) {
> -			res = -ENOMEM;
> -			goto _end;
> -		}
> +		substream->group = group;
>  		spin_lock_init(&substream->group->lock);
>  		INIT_LIST_HEAD(&substream->group->substreams);
>  		list_add_tail(&substream->link_list, &substream->group->substreams);
> @@ -1620,7 +1609,10 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
>   _end:
>  	write_unlock_irq(&snd_pcm_link_rwlock);
>  	up_write(&snd_pcm_link_rwsem);
> + _nolock:
>  	fput(file);
> +	if (res < 0)
> +		kfree(group);
>  	return res;
>  }
>  


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
