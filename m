From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Clean up of PCM spinlocks
Date: Tue, 13 Mar 2012 16:16:36 +0100
Message-ID: <4F5F64D4.5080206@perex.cz>
References: <s5hboo03h01.wl%tiwai@suse.de> <4F5F588B.40107@perex.cz>
	<s5hpqcg1r6g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id EEC271043A8
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:16:33 +0100 (CET)
In-Reply-To: <s5hpqcg1r6g.wl%tiwai@suse.de>
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

Date 13.3.2012 16:00, Takashi Iwai wrote:
> At Tue, 13 Mar 2012 15:24:11 +0100,
> Jaroslav Kysela wrote:
>>
>> Date 13.3.2012 11:57, Takashi Iwai wrote:
>>> Hi,
>>>
>>> below is a patch I posted to LKML as the follow up for the lockdep
>>> report from Dave Jones.  It's a resurrected patch from what I worked
>>> on quite ago.  Although this fix is suboptimal, I see no better way.
>>>
>>> If this looks OK, I'm going to queue it as a 3.4 material.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>> ===
>>>
>>> From: Takashi Iwai <tiwai@suse.de>
>>> Subject: [PATCH] ALSA: pcm - Simplify linked PCM substream spinlocks
>>>
>>> The spinlocks held for PCM substreams have been always messy.  For the
>>> better concurrent accessibility, we took always the substream's lock
>>> first.  When substreams are linked, we need a group-wide lock, but
>>> this should be applied outside substream's lock.  So, we unlock the
>>> substream's lock first, then do locks twice.
>>>
>>> This scheme is known to be problematic with lockdep.  Maybe because
>>> the nested lock isn't marked properly, and partly because the lock and
>>> unlock sequences are different (A/B -> A/B).
>>>
>>> This patch tries to simplify the scheme.  Instead of holding the
>>> substream's lock, we take the group lock always at first.  A drawback
>>> of this is that the access to the individual substream in a same group
>>> won't be allowed any longer.  But, the code looks much easier, and
>>> likely less buggy.
>>
>> What do you mean by this? I noticed that you switched the behaviour for
>> the stream_lock():
>>
>> 1) self_group spinlock is used for single (non-linked) stream
>>    - same as before
>> 2) group.lock spinlock is used for the linked streams
>>    - the self_group spinlock is used only in the group action
>>      - the question is why? it seems useless, the
>>        stream_lock() functions use the allocated group.lock
> 
> Oh yeah, right, this is utterly useless!
> I just thought of the mutex case, but in this case, the lock is
> avoided anyway.
> 
>> I don't think that this patch will work in the way we expect.
>>
>> I believe we should use only group.lock spinlock for the linked streams
>> without using the self_group spinlock to make locking work like this:
>>
>> stream_lock(current)
>> group_action(current) {
>>   for s from all_group_substreams {
>>     if (s != current)
>>       stream_lock(s);
>>   }
>>   .... job ....
>>   .... group substreams unlock ....
>> }
>> stream_unlock(current)
> 
> Well, if we think of a single lock, the code would be much
> simplified than above.
> 
> The reviewsed patch is below.  I left the single-stream version as is
> since it's used explicitly in the drain() -- the drain action is
> applied to each substream although it's linked.

I meant use group->lock in the group_action, see patch bellow.

> Also, the changes in snd_pcm_link() to use GFP_KERNEL is splitted out
> of this patch.

Maybe, we can reuse the self_group container for the linked streams, too?
In this case, the dynamic allocation of new group structure can be removed.

					Jaroslav


diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1d58d79..301ed22 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -535,36 +535,36 @@ static inline int snd_pcm_stream_linked(struct
snd_pcm_substream *substream)
 static inline void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
 {
 	read_lock(&snd_pcm_link_rwlock);
-	spin_lock(&substream->self_group.lock);
+	spin_lock(&substream->group->lock);
 }

 static inline void snd_pcm_stream_unlock(struct snd_pcm_substream
*substream)
 {
-	spin_unlock(&substream->self_group.lock);
+	spin_unlock(&substream->group->lock);
 	read_unlock(&snd_pcm_link_rwlock);
 }

 static inline void snd_pcm_stream_lock_irq(struct snd_pcm_substream
*substream)
 {
 	read_lock_irq(&snd_pcm_link_rwlock);
-	spin_lock(&substream->self_group.lock);
+	spin_lock(&substream->group->lock);
 }

 static inline void snd_pcm_stream_unlock_irq(struct snd_pcm_substream
*substream)
 {
-	spin_unlock(&substream->self_group.lock);
+	spin_unlock(&substream->group->lock);
 	read_unlock_irq(&snd_pcm_link_rwlock);
 }

 #define snd_pcm_stream_lock_irqsave(substream, flags) \
 do { \
 	read_lock_irqsave(&snd_pcm_link_rwlock, (flags)); \
-	spin_lock(&substream->self_group.lock); \
+	spin_lock(&substream->group->lock); \
 } while (0)

 #define snd_pcm_stream_unlock_irqrestore(substream, flags) \
 do { \
-	spin_unlock(&substream->self_group.lock); \
+	spin_unlock(&substream->group->lock); \
 	read_unlock_irqrestore(&snd_pcm_link_rwlock, (flags)); \
 } while (0)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 25ed9fe..5096c83 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -713,7 +713,7 @@ static int snd_pcm_action_group(struct action_ops *ops,

 	snd_pcm_group_for_each_entry(s, substream) {
 		if (do_lock && s != substream)
-			spin_lock_nested(&s->self_group.lock,
+			spin_lock_nested(&s->group->lock,
 					 SINGLE_DEPTH_NESTING);
 		res = ops->pre_action(s, state);
 		if (res < 0)
@@ -741,7 +741,7 @@ static int snd_pcm_action_group(struct action_ops *ops,
 		/* unlock streams */
 		snd_pcm_group_for_each_entry(s1, substream) {
 			if (s1 != substream)
-				spin_unlock(&s1->self_group.lock);
+				spin_unlock(&s1->group->lock);
 			if (s1 == s)	/* end */
 				break;
 		}
@@ -779,13 +779,7 @@ static int snd_pcm_action(struct action_ops *ops,
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
@@ -801,19 +795,9 @@ static int snd_pcm_action_lock_irq(struct
action_ops *ops,
 {
 	int res;

-	read_lock_irq(&snd_pcm_link_rwlock);
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
-	read_unlock_irq(&snd_pcm_link_rwlock);
+	snd_pcm_stream_lock_irq(substream);
+	res = snd_pcm_action(ops, substream, state);
+	snd_pcm_stream_unlock_irq(substream);
 	return res;
 }


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
