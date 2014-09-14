From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH 0/9] Misc fixes related to rewinds
Date: Sun, 14 Sep 2014 17:19:22 +0600
Message-ID: <541579BA.3050007@gmail.com>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
 <CAN8cciY=sOrAyNHzqUo6tsuz0MOFj5aF=ieM4EmUGJVKt0XEhA@mail.gmail.com>
 <541569C4.1020702@gmail.com> <5415776B.4040807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E3BF4264F28
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 13:19:24 +0200 (CEST)
Received: by mail-la0-f43.google.com with SMTP id gi9so3189345lab.2
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 04:19:24 -0700 (PDT)
In-Reply-To: <5415776B.4040807@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

14.09.2014 17:09, Alexander E. Patrakov wrote:
> 14.09.2014 16:11, Alexander E. Patrakov wrote:
>> 14.09.2014 14:53, Raymond Yau wrote:
>>>
>>>  >
>>>  > Note: this series touches pcm_dmix.c, but does not make it
>>> rewindable. In
>>>  > other words, a variant of the test in [2] now produces a tone
>>> instead of
>>>  > failing due to snd_pcm_rewind() returning 0. But it should ideally
>>> produce
>>>  > silence. Obviously, there is some bug left that I have not pinpointed
>>> yet.
>>>  >
>>>
>>> It is better to let dmix not support rewind and force your rewind
>>> program to fail
>>>
>>> You rewind program should not affect the other application playing
>>> through dmix
>>
>> Sorry, you are not an author of a single line in dmix (although you do
>> understand how it works), so I cannot just blindly follow this request.
>> OTOH, I was about to ask the same "should it work" question.
>
> Well, after looking a bit more at this, I think that I know what's wrong
> with dmix. I can probably fix it, but I have tasks with higher priority
> right now.
>
> The real problem is that it tries to do some remixing work in its
> .rewind callback. It shouldn't do this - in fact, the whole callback
> should just move the application pointer. Look - on a hardware device,
> if you disable xrun detection, write something, rewind it, and then let
> it underrun, it will still be played in full. On dmix, it is actively
> attempted to be unmixed.
>
> The real rewind-support work should be done in the mmap_commit callback.
> It should:
>
> 0. Keep a shadow copy of the mmap areas, so that it can look at old
> samples.
>
> 1. Zero out the part of the sum buffer crossed by the hardware pointer
> since the last call (possibly in another client). Zero out the
> corresponding part of the mmap areas (both real and shadow). This should
> probably be done in snd_pcm_dmix_sync_ptr(), but I am not sure. There is
> already a hack based on ARCH_CMPXCHG that purports to do this in
> mix_areas_16().
>
> 2. Unmix the old contents of the mmap areas in mmap_commit callback
> (instead of the rewind callback). Most of the time, it will unmix the
> sequence of zeros.
>
> 3. Mix the new contents of mmap areas.
>
> 4. Update the shadow copy.

Well, scratch that. It obviously does not apply to dshare, where the 
problem also exists, although no real work is done in the rewind 
callback (correctly), and I still don't know why.

Sorry for the spam.

-- 
Alexander E. Patrakov
