From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: Bug in alsa-lib causes high CPU with rate plugin
Date: Fri, 9 Nov 2012 17:19:32 -0800
Message-ID: <CA+7tXihYX-hr7ai6KYWxzTeJEjtPjgGaeyqz+ife1=ehcHywCw@mail.gmail.com>
References: <CA+7tXii+Oc8utgBA=mqa3BA+9BYUv0cqd3pC=DQcAKrDTkyXxQ@mail.gmail.com>
 <s5htxsyiuji.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f50.google.com (mail-vb0-f50.google.com
 [209.85.212.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 37BDE260799
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 02:19:33 +0100 (CET)
Received: by mail-vb0-f50.google.com with SMTP id fa15so4349762vbb.9
 for <alsa-devel@alsa-project.org>; Fri, 09 Nov 2012 17:19:32 -0800 (PST)
In-Reply-To: <s5htxsyiuji.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 9, 2012 at 8:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 8 Nov 2012 13:47:52 -0800,
> Trent Piepho wrote:
>> snd_pcm_wait() doesn't sleep, because it's based on the status of the
>> hw buffer and that buffer does have free space.  snd_pcm_write_areas()
>> would write to the hw buffer and not try to sleep.  But it's not
>> looking at the hw buffer when it decides to sleep or write, it's
>> looking at the rate buffer.  And the rate buffer's fill level says to
>> sleep, not write.  And if snd_pcm_wait() was looking at the rate
>> buffer, it would sleep.
>>
>
> Yeah, this is a known longtime PITA in the rate plugin.
>
> Tweaking avail_min is also an option, but I'm afraid it's too
> hackish.
>
> The primary problem is the discrepancy of the state "I have to wait
> until period size becomes available" between the rate plugin and the
> underlying PCM.  Since the poll is performed only on the slave PCM,
> checking the rate plugin's avail is bogus in such a state.  In other
> words, if the rate plugin puts the decision for the sleep simply
> depending on the slave state, there will be no inconsistency between
> them.
>
> Below is a quick fix.  Does it work for you?

It adds an extra call to the kernel to get the HW pointer position yet
again.  snd_pcm_avail_update() is called initially by
snd_pcm_write_areas.  The avail_update method for the rate plugin
calls snd_pcm_avail_update on the slave.  It's worth noting at this
point that we know that avail(rate) + unresampled_data = avail(slave).
  Then check_for_wait() is called right after, which calls the rate
plugin's check_for_wait method, which calls snd_pcm_avail_update() on
the slave a second time.

It seems like you have a race if a period elapses between the two
checks of the slave's avail.  Suppose upon entering
snd_pcm_write_areas both buffers are 100% full.  avail =
snd_pcm_update_avail(pcm /*rate*/) returns zero, which is up to date
and correct.  We get to the code for check_for_wait() and it calls
snd_pcm_avail_update(slave) and a period has elapsed since "avail" was
found. So check_for_wait() returns not to wait, which is correct based
on the current state of the slave.  Now the rest of the
snd_pcm_write_areas() code runs, but avail=0 still and it's not going
to work, it just blows up if avail = 0.

If you think about it, tweaking avail_min does the same thing as using
the slave's avail and avail_min.

We had a wait check of "rate->avail < rate->avail_min".  What we want
is "slave->avail < slave->avail_min".  Ignoring the resampling factor,
we know that:
rate->avail + rate->unresampled_data = slave->avail
rate->avail_min = slave->avail_min

So if we do a little algebra:
slave->avail < slave->avail_min
rate->avail + rate->unresampled_data < slave->avail_min
rate->avail + rate->unresampled_data < rate->avail_min
rate->avail < rate->avail_min - rate->unresampled_data

In other words, subtracting the unresampled data from the avail_min
for the rate pcm produces the exact same comparison as looking at the
slave's avail and avail_min, which is what we actually wanted.
