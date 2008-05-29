From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Thu, 29 May 2008 21:07:55 +0400
Message-ID: <483EE2EB.8040905@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>	<s5hve1ac05g.wl%tiwai@suse.de>	<4831B260.1060802@aknet.ru>	<s5hhccrx2ey.wl%tiwai@suse.de>	<4835D774.3070306@aknet.ru>	<s5hprrduwdk.wl%tiwai@suse.de>	<483C10E7.7070203@aknet.ru>	<s5h4p8jbvaj.wl%tiwai@suse.de>	<483C477D.2000207@aknet.ru>	<s5hprr6u46f.wl%tiwai@suse.de>	<483DBBC0.1080001@aknet.ru>
	<s5h63sxd4up.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp09.mtu.ru (smtp09.mtu.ru [62.5.255.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EDFC248DA
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 19:07:50 +0200 (CEST)
In-Reply-To: <s5h63sxd4up.wl%tiwai@suse.de>
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

Hello.

Takashi Iwai wrote:
>> really be better if just snd_pcm_period_elapsed()
>> would raise a softirq. That's something
>> you proposed in the past IIRC.
>> Is this acceptable to have that change
>> not in the driver, or do you think it
>> is snd-pcsp-specific, and no other driver
>> will benefit?
> It would be good in general.
> However, better to be the next step after changing pcsp.
But why do you need both changes?
If you are going to change snd_pcm_period_elapsed()
itself, then how would the snd-pcsp
change be justified?

> One big disadvantage of the softirq is its (possible) timing
> inaccuracy.  (Note that this is about the normal non-preempt kernel.)
> The thing like pcsp driver does, flipping the bits at a high rate,
> isn't for softirq per se.
OK, I see.

> Well, it can be done in another away if you are so nervous about it.
> Simply add chip->timer_running atomic_t and reset it when the callback
> finished with HRTIMER_NORESTART.  In another side, wait until
> chip->timer_running becomes zero.
> But, it's just an uneeded addition of the code.
But for some reasons it looks safer
to me...

>>> Because the substream lock isn't necessary!  It just makes things more
>>> complicated -- if we take substream lock, AB/BA deadlocks occur again.
>> Even if the callback is called within
>> the softirq?
> The runtime callbacks, pointer and trigger, are called already inside they
> substream lock held by the PCM core.  Thus it doesn't matter whether
> it's in a hard or a softirq.
The difference is that in a softirq,
the hrtimer code doesn't take a lock.
The AB/BA problem was because of the
hrtimer' lock, which is not there
with the softirq callback. So what
exactly A and B do you mean here?

>> and yes, its nasty. But to me its nastiness
>> is only because it needs another lock to
>> protect the substream itself.
> No, you don't need to protect the substream at all.
But that was suggested by you in the
past. :) But adding a syncronization
point should be better I agree.
I'll see if some minimal change is
possible that will look sane to you
and wont make me ask 100 questions
about its safety at the same time. :)
