From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/9] Misc fixes related to rewinds
Date: Sun, 14 Sep 2014 18:34:55 +0200
Message-ID: <5415C3AF.2040607@perex.cz>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
 <54149789.2060102@perex.cz> <54149B7F.6000002@gmail.com>
 <5414A00D.3030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 79D1F265099
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 18:34:56 +0200 (CEST)
In-Reply-To: <5414A00D.3030600@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Date 13.9.2014 21:50, Alexander E. Patrakov wrote:
> 14.09.2014 01:31, Alexander E. Patrakov wrote:
>> 14.09.2014 01:14, Jaroslav Kysela wrote:
>>> Date 13.9.2014 20:30, Alexander E. Patrakov wrote:
>>>> The idea of the series is to fix the two issues that I found [1] for the
>>>
>>> I applied all your patches to alsa-lib's repo, but...
>>>
>>>> hw plugin. snd_pcm_rewindable() sometimes returned negative values that
>>>> are actually negative amounts of samples and not error codes. Also, it
>>>> bases its calculations on stale hardware position pointer, which is not
>>>> what PulseAudio wants (alternatively, we can document the need to call
>>>> snd_pcm_avail() before snd_pcm_rewindable(), but I don't like it).
>>>
>>> The hw sync is expensive and the application might do this sync multiple
>>> times when woken up. I think that it must be clear that:
>>>
>>> 1) only snd_pcm_avail(), snd_pcm_delay(), snd_pcm_avail_delay()
>>>     does the real hw sync
>>> 2) snd_pcm_avail(), snd_pcm_delay(), snd_pcm_avail_delay(),
>>>     snd_pcm_rewindable() and snd_pcm_forwardable() does
>>>     hw sync (and change all plugins to respect this)
>>>
>>> I don't like the situation "be somewhere between because it's good for
>>> one purpose"...
>>
>> I understand the concern. I have specifically not added the call to
>> hwsync directly to snd_pcm_rewindable implementation (although it would
>> have resulted in a smaller patch), because that would indeed cause
>> double-hwsync and the resulting inefficiency. I made sure that all
>> plugins either make the hwsync thing themselves or rely on the slave to
>> do that for them, but not both. If you find an error and/or spot a case
>> of a double-hwsync in a plugin chain, please complain.
>>
>> One known case of double-hwsync is the following pattern: an application
>> calls snd_pcm_rewindable(), thinks about it, and then calls
>> snd_pcm_rewind(). Which, due to PATCH 2/9, calls the rewindable callback
>> again, resulting in the second hwsync. I don't know which way out is
>> best: either ignore, or revert the intention of PATCH 2/9, or revert the
>> whole PATCH 8/9 and replace it with a documentation change.
> 
> Well, after looking again, I see that the multi plugin became especially 
> problematic. Previously, it did not forward hwsync requests to slaves 
> other than master_slave. Now it does.
> 
> Please revert PATCH 8/9. It needs more discussion.

Reverted.

> 
>>
>> OTOH, I made a mistake of not adding David Henningsson to the CC list
>> during the initial submission. If PulseAudio would need to synchronize
>> hardware pointers even after conversion to snd_pcm_rewindable() for some
>> other reason, then the need for PATCH 8/9 is not that obvious, and maybe
>> it should be reverted and replaced with a documentation fix.
>>
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
