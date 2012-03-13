From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Clean up of PCM spinlocks
Date: Tue, 13 Mar 2012 20:50:00 +0100
Message-ID: <4F5FA4E8.4040705@perex.cz>
References: <s5hboo03h01.wl%tiwai@suse.de> <4F5F588B.40107@perex.cz>
	<s5hpqcg1r6g.wl%tiwai@suse.de> <4F5F64D4.5080206@perex.cz>
	<s5hlin41q58.wl%tiwai@suse.de> <4F5F6BDF.5030601@perex.cz>
	<s5hhaxs1o7k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 449D72442D
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 20:49:58 +0100 (CET)
In-Reply-To: <s5hhaxs1o7k.wl%tiwai@suse.de>
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

Date 13.3.2012 17:05, Takashi Iwai wrote:
> At Tue, 13 Mar 2012 16:46:39 +0100,
> Jaroslav Kysela wrote:
>>
>> Date 13.3.2012 16:23, Takashi Iwai wrote:
>>> At Tue, 13 Mar 2012 16:16:36 +0100,
>>> Jaroslav Kysela wrote:
>>>>
>>>> Date 13.3.2012 16:00, Takashi Iwai wrote:
>>>>> At Tue, 13 Mar 2012 15:24:11 +0100,
>>>>> Jaroslav Kysela wrote:
>>>>>>
>>>>>> Date 13.3.2012 11:57, Takashi Iwai wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> below is a patch I posted to LKML as the follow up for the lockdep
>>>>>>> report from Dave Jones.  It's a resurrected patch from what I worked
>>>>>>> on quite ago.  Although this fix is suboptimal, I see no better way.
>>>>>>>
>>>>>>> If this looks OK, I'm going to queue it as a 3.4 material.
>>>>>>>
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> Takashi
>>>>>>>
>>>>>>> ===
>>>>>>>
>>>>>>> From: Takashi Iwai <tiwai@suse.de>
>>>>>>> Subject: [PATCH] ALSA: pcm - Simplify linked PCM substream spinlocks
>>>>>>>
>>>>>>> The spinlocks held for PCM substreams have been always messy.  For the
>>>>>>> better concurrent accessibility, we took always the substream's lock
>>>>>>> first.  When substreams are linked, we need a group-wide lock, but
>>>>>>> this should be applied outside substream's lock.  So, we unlock the
>>>>>>> substream's lock first, then do locks twice.
>>>>>>>
>>>>>>> This scheme is known to be problematic with lockdep.  Maybe because
>>>>>>> the nested lock isn't marked properly, and partly because the lock and
>>>>>>> unlock sequences are different (A/B -> A/B).
>>>>>>>
>>>>>>> This patch tries to simplify the scheme.  Instead of holding the
>>>>>>> substream's lock, we take the group lock always at first.  A drawback
>>>>>>> of this is that the access to the individual substream in a same group
>>>>>>> won't be allowed any longer.  But, the code looks much easier, and
>>>>>>> likely less buggy.
>>>>>>
>>>>>> What do you mean by this? I noticed that you switched the behaviour for
>>>>>> the stream_lock():
>>>>>>
>>>>>> 1) self_group spinlock is used for single (non-linked) stream
>>>>>>    - same as before
>>>>>> 2) group.lock spinlock is used for the linked streams
>>>>>>    - the self_group spinlock is used only in the group action
>>>>>>      - the question is why? it seems useless, the
>>>>>>        stream_lock() functions use the allocated group.lock
>>>>>
>>>>> Oh yeah, right, this is utterly useless!
>>>>> I just thought of the mutex case, but in this case, the lock is
>>>>> avoided anyway.
>>>>>
>>>>>> I don't think that this patch will work in the way we expect.
>>>>>>
>>>>>> I believe we should use only group.lock spinlock for the linked streams
>>>>>> without using the self_group spinlock to make locking work like this:
>>>>>>
>>>>>> stream_lock(current)
>>>>>> group_action(current) {
>>>>>>   for s from all_group_substreams {
>>>>>>     if (s != current)
>>>>>>       stream_lock(s);
>>>>>>   }
>>>>>>   .... job ....
>>>>>>   .... group substreams unlock ....
>>>>>> }
>>>>>> stream_unlock(current)
>>>>>
>>>>> Well, if we think of a single lock, the code would be much
>>>>> simplified than above.
>>>>>
>>>>> The reviewsed patch is below.  I left the single-stream version as is
>>>>> since it's used explicitly in the drain() -- the drain action is
>>>>> applied to each substream although it's linked.
>>>>
>>>> I meant use group->lock in the group_action, see patch bellow.
>>>
>>> Hmm, I don't think this works.  From linked stream members,
>>> group->lock points to the very same lock instance.  So,
>>> snd_pcm_action_group() would dead-lock the same lock with your code.
>>
>> I see. The problem is that the concurrent but linked streams can take
>> different first locks for the group locking:
>>
>> time 0		 time 1
>> --------------------------------
>> lock stream 0 -> group lock
>> lock stream 1 -> group lock
>>
>> In this case the condition current != s is not enough. I think that we
>> have to strictly separate situations when the group lock can be
>> activated and use different locking scheme there - for example using a
>> master lock per linked substreams.
> 
> In my revised patch, group->lock is actually the master lock of the
> group.  This is the only lock applied to the substream.
> 
> When a stream is linked, it's done in the global write_lock to
> guarantee that stream is unlocked.  Then group->lock is replaced with
> a real group lock from self_group.lock.  So, there is no race among
> this move.
> 
>> It seems to me that your proposed patch just removes the spinlocks for
>> linked substreams which can cause inconsistencies for these streams.
> 
> Not really.  It just uses a single lock for linked streams.  There are
> no longer stream locks once when the stream is linked.
> 
> This is of course a drawback -- it disallows the concurrent access to
> linked stream members in some operations.  How this is regarded as a
> serious drawback, is a question of operation styles.  If any apps are
> accessing many streams as a linked stream in realtime manner, and
> access to each without mmap, then the performance may be worsen.  But,
> this scenario is rather pretty rare, I guess.
> 
>> Or just a quick idea - what about to track the the group action
>> collisions? We can use a spinlock protected counter and serialize these
>> requests in another way (if counter is above one - the CPU should wait
>> until it becomes one).
> 
> Well...  this sounds way too complex, I'm afraid.

I tried to think about it more. I think that the spinlock reorder is at
the wrong code position. What about the code bellow. I believe, it
should guarantee the consistent locking scheme (although the first
substream lock will stay outside of the group->lock, but it should not
be an issue).

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 25ed9fe..758a7c0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -711,10 +711,12 @@ static int snd_pcm_action_group(struct action_ops
*ops,
 	struct snd_pcm_substream *s1;
 	int res = 0;

+	spin_lock(&substream->group->lock);
 	snd_pcm_group_for_each_entry(s, substream) {
-		if (do_lock && s != substream)
-			spin_lock_nested(&s->self_group.lock,
-					 SINGLE_DEPTH_NESTING);
+		if (do_lock && s != substream) {
+			while (!spin_trylock(&s->self_group.lock))
+				/* nothing */ ;
+		}
 		res = ops->pre_action(s, state);
 		if (res < 0)
 			goto _unlock;
@@ -746,6 +748,7 @@ static int snd_pcm_action_group(struct action_ops *ops,
 				break;
 		}
 	}
+	spin_unlock(&substream->group->lock);
 	return res;
 }

@@ -779,13 +782,7 @@ static int snd_pcm_action(struct action_ops *ops,
 	int res;

 	if (snd_pcm_stream_linked(substream)) {
-		if (!spin_trylock(&substream->group->lock)) {
-			spin_unlock(&substream->self_group.lock);
-			spin_lock(&substream->group->lock);
-			spin_lock(&substream->self_group.lock);
-		}
-		res = snd_pcm_action_group(ops, substream, state, 1);
-		spin_unlock(&substream->group->lock);
+		res = snd_pcm_action_group(ops, substream, state);
 	} else {
 		res = snd_pcm_action_single(ops, substream, state);
 	}
@@ -802,17 +799,7 @@ static int snd_pcm_action_lock_irq(struct
action_ops *ops,
 	int res;

 	read_lock_irq(&snd_pcm_link_rwlock);
-	if (snd_pcm_stream_linked(substream)) {
-		spin_lock(&substream->group->lock);
-		spin_lock(&substream->self_group.lock);
-		res = snd_pcm_action_group(ops, substream, state, 1);
-		spin_unlock(&substream->self_group.lock);
-		spin_unlock(&substream->group->lock);
-	} else {
-		spin_lock(&substream->self_group.lock);
-		res = snd_pcm_action_single(ops, substream, state);
-		spin_unlock(&substream->self_group.lock);
-	}
+	res = snd_pcm_action(ops, substream, state);
 	read_unlock_irq(&snd_pcm_link_rwlock);
 	return res;
 }


				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
