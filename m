From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Thu, 29 May 2008 00:08:32 +0400
Message-ID: <483DBBC0.1080001@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>	<s5hve1ac05g.wl%tiwai@suse.de>	<4831B260.1060802@aknet.ru>	<s5hhccrx2ey.wl%tiwai@suse.de>	<4835D774.3070306@aknet.ru>	<s5hprrduwdk.wl%tiwai@suse.de>	<483C10E7.7070203@aknet.ru>	<s5h4p8jbvaj.wl%tiwai@suse.de>	<483C477D.2000207@aknet.ru>
	<s5hprr6u46f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp08.mtu.ru (smtp08.mtu.ru [62.5.255.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 21B2210383A
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 22:08:28 +0200 (CEST)
In-Reply-To: <s5hprr6u46f.wl%tiwai@suse.de>
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
> OTOH, the update of the whole PCM via snd_pcm_period_elapsed() is a
> slow path.  Especially in the case of hrtimer, it brings the lock
> mess, too.
Unless the entire callback is done in
a softirq, as it currently is, no?

> Issuing softirq at each hrtimer callback isn't optimal from
> performance perspective.  For RT-kernels, it doesn't matter, but for
> normal kernels, it does.
Oh. But in that case I guess it would
really be better if just snd_pcm_period_elapsed()
would raise a softirq. That's something
you proposed in the past IIRC.
Is this acceptable to have that change
not in the driver, or do you think it
is snd-pcsp-specific, and no other driver
will benefit?
Btw, could you please point me to where
to read about the softirq expense? I
thought they are very cheap, almost zero
overhead.
And yes, if the sotfirqs are expensive,
then indeed I see why you propose all
these tricks you do... But if they are
not and we can keep the entire callback
in a softirq as it currently is, then
there might be a simpler solutions.

>> the chip->substream_lock for that (why?),
> Because the pointer callback and the hrtimer callback can race about
I asked only why have you chosen
chip->substream_lock - IIRC it was
intended not for this.

>>> +	pcsp_stop_playing(chip);
>> This will set chip->timer_active to 0,
>> but who knows if the callback on another
>> CPU have already passed the check or not?
> If it passed, then we simply wait until the next hrtimer callback
> finished.  That's what hrtimer_cancel() does.  So, after that, it is
> guaranteed that neither hrtimer and tasklet remains.
Yes, but the state doesn't seem to be
guaranteed. Running the handler after
the pcsp_stop_playing(chip) called, looks
nasty. The timer will be in a different
mode. Nothing bad will likely to happen,
but... esp with the nforce workaround,
where the callback is supposed to be
called even amount of times. Doesn't
look very good to me, even if nothing
bad can happen...

> Because the substream lock isn't necessary!  It just makes things more
> complicated -- if we take substream lock, AB/BA deadlocks occur again.
Even if the callback is called within
the softirq?

>> And
>> if right now it is barely usefull, then
>> why it can't be improved to simply not
>> require a second lock that guards a
>> substream itself?
> Because it won't be simpler, as you already tried.
I haven't tried that. :)
I have tried the snd_pcm_stream_lock(),
and yes, its nasty. But to me its nastiness
is only because it needs another lock to
protect the substream itself. So it is
barely usefull. But it can be improved
(or an alternative provided), the way the
second lock is not needed. Then I will
need only that - a single lock, nothing
more. This might not be even difficult to
do at all.
