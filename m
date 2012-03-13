From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Clean up of PCM spinlocks
Date: Tue, 13 Mar 2012 16:46:39 +0100
Message-ID: <4F5F6BDF.5030601@perex.cz>
References: <s5hboo03h01.wl%tiwai@suse.de> <4F5F588B.40107@perex.cz>
	<s5hpqcg1r6g.wl%tiwai@suse.de> <4F5F64D4.5080206@perex.cz>
	<s5hlin41q58.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B91C104384
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:46:36 +0100 (CET)
In-Reply-To: <s5hlin41q58.wl%tiwai@suse.de>
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

Date 13.3.2012 16:23, Takashi Iwai wrote:
> At Tue, 13 Mar 2012 16:16:36 +0100,
> Jaroslav Kysela wrote:
>>
>> Date 13.3.2012 16:00, Takashi Iwai wrote:
>>> At Tue, 13 Mar 2012 15:24:11 +0100,
>>> Jaroslav Kysela wrote:
>>>>
>>>> Date 13.3.2012 11:57, Takashi Iwai wrote:
>>>>> Hi,
>>>>>
>>>>> below is a patch I posted to LKML as the follow up for the lockdep
>>>>> report from Dave Jones.  It's a resurrected patch from what I worked
>>>>> on quite ago.  Although this fix is suboptimal, I see no better way.
>>>>>
>>>>> If this looks OK, I'm going to queue it as a 3.4 material.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>>> ===
>>>>>
>>>>> From: Takashi Iwai <tiwai@suse.de>
>>>>> Subject: [PATCH] ALSA: pcm - Simplify linked PCM substream spinlocks
>>>>>
>>>>> The spinlocks held for PCM substreams have been always messy.  For the
>>>>> better concurrent accessibility, we took always the substream's lock
>>>>> first.  When substreams are linked, we need a group-wide lock, but
>>>>> this should be applied outside substream's lock.  So, we unlock the
>>>>> substream's lock first, then do locks twice.
>>>>>
>>>>> This scheme is known to be problematic with lockdep.  Maybe because
>>>>> the nested lock isn't marked properly, and partly because the lock and
>>>>> unlock sequences are different (A/B -> A/B).
>>>>>
>>>>> This patch tries to simplify the scheme.  Instead of holding the
>>>>> substream's lock, we take the group lock always at first.  A drawback
>>>>> of this is that the access to the individual substream in a same group
>>>>> won't be allowed any longer.  But, the code looks much easier, and
>>>>> likely less buggy.
>>>>
>>>> What do you mean by this? I noticed that you switched the behaviour for
>>>> the stream_lock():
>>>>
>>>> 1) self_group spinlock is used for single (non-linked) stream
>>>>    - same as before
>>>> 2) group.lock spinlock is used for the linked streams
>>>>    - the self_group spinlock is used only in the group action
>>>>      - the question is why? it seems useless, the
>>>>        stream_lock() functions use the allocated group.lock
>>>
>>> Oh yeah, right, this is utterly useless!
>>> I just thought of the mutex case, but in this case, the lock is
>>> avoided anyway.
>>>
>>>> I don't think that this patch will work in the way we expect.
>>>>
>>>> I believe we should use only group.lock spinlock for the linked streams
>>>> without using the self_group spinlock to make locking work like this:
>>>>
>>>> stream_lock(current)
>>>> group_action(current) {
>>>>   for s from all_group_substreams {
>>>>     if (s != current)
>>>>       stream_lock(s);
>>>>   }
>>>>   .... job ....
>>>>   .... group substreams unlock ....
>>>> }
>>>> stream_unlock(current)
>>>
>>> Well, if we think of a single lock, the code would be much
>>> simplified than above.
>>>
>>> The reviewsed patch is below.  I left the single-stream version as is
>>> since it's used explicitly in the drain() -- the drain action is
>>> applied to each substream although it's linked.
>>
>> I meant use group->lock in the group_action, see patch bellow.
> 
> Hmm, I don't think this works.  From linked stream members,
> group->lock points to the very same lock instance.  So,
> snd_pcm_action_group() would dead-lock the same lock with your code.

I see. The problem is that the concurrent but linked streams can take
different first locks for the group locking:

time 0		 time 1
--------------------------------
lock stream 0 -> group lock
lock stream 1 -> group lock

In this case the condition current != s is not enough. I think that we
have to strictly separate situations when the group lock can be
activated and use different locking scheme there - for example using a
master lock per linked substreams.

It seems to me that your proposed patch just removes the spinlocks for
linked substreams which can cause inconsistencies for these streams.

Or just a quick idea - what about to track the the group action
collisions? We can use a spinlock protected counter and serialize these
requests in another way (if counter is above one - the CPU should wait
until it becomes one).

>>> Also, the changes in snd_pcm_link() to use GFP_KERNEL is splitted out
>>> of this patch.
>>
>> Maybe, we can reuse the self_group container for the linked streams, too?
>> In this case, the dynamic allocation of new group structure can be removed.
> 
> A substream can be unlinked at any time, thus it can't belong to
> the substream instance.  The point of substream->group is to detach
> the instance from the substream.  self_group is just an optimization
> for unlinked streams.

I see.

> The GFP_KERNEL thing is a thing of optimization, too: whether to call
> kmalloc() superfluously in the case of errors or not.  As seen in the
> patch below, it's no big matter...

I agree.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
