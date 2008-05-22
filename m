From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Fri, 23 May 2008 00:28:36 +0400
Message-ID: <4835D774.3070306@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>	<s5hve1ac05g.wl%tiwai@suse.de>	<4831B260.1060802@aknet.ru>
	<s5hhccrx2ey.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 9541C1037F7
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 22:28:51 +0200 (CEST)
In-Reply-To: <s5hhccrx2ey.wl%tiwai@suse.de>
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
> The substream lock can be removed from hrtimer callback gracefully.
> So, you have no longer the issue with this lock/unlock procedure.
> In hrtimer callback, you just need to have the DMA-buffer.  That can
> be protected without the substream lock, too, I believe.
OK. But still, the substream have to
be protected against the close callback.
So I still need 2 locks. One for the
substream, another for the DMA buffer.
That makes things better but not much.
I don't want 2 locks in a softirq callback,
even if they are independant.
Or am I still missing your point?

> In this scenario, the trigger-stop could be asynchronous.  Thus, the
> prepare PCM callback should sync also with the hrtimer callback to
> assure that the pending callback is finished.
OK, so I need 3 locks after all - adding
one for the position pointers. Now that
may be not even better than using the
pcm_stream_lock() after all...
Can there be a more advanced version
of a pcm stream lock? The one that will
take something persistant as an argument
(chip->pcm perhaps), take some lock from
there, then check if the substream is
not freed, and then take the substream
lock. And if substream was freed - it
unlocks and returns an error. Effectively
similar to the current snd_pcm_stream_lock(),
but without a need for the second lock
to protect the substream itself.

>> code. And I remember the last time we
>> discussed this, you admitted (some of)
>> the other drivers do get this part wrong
>> too. So fixing it properly once and for
>> all might be a good idea as you are at
>> it again.
> I don't agree here unless any code is shown :)
OK, lets try. My assumption is that all
drivers do have the locking wrong because
of that policy, but please show me what
am I missing. :)
So lets see hda_intel.c.
What it does is to release some reg_lock
before calling snd_pcm_period_elapsed().
It takes that lock in azx_pcm_close().
If it spins on that lock in azx_pcm_close()
on one CPU and drops that lock in an IRQ
handler on another CPU, then, I beleive,
it will crash in snd_pcm_period_elapsed(),
as the substream is freed before it takes
the lock again.
What am I missing? (that can't happen with
a single CPU perhaps, as the lock is IRQ-safe,
but IIRC this doesn't help on SMP at all)
Or, what nm256.c does... hmm, it doesn't
even do "substream = NULL" in a close
callback - why?
