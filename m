From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Mon, 19 May 2008 21:01:20 +0400
Message-ID: <4831B260.1060802@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>
	<s5hve1ac05g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 28FC224666
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 19:01:39 +0200 (CEST)
In-Reply-To: <s5hve1ac05g.wl%tiwai@suse.de>
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
>>> Anyway, what I meant is that the part touching I/O ports could be a faster path
>>> than softirq.  And the hrtimer code can use a bit simpler locks.  The hrtimer
>>> callback needs just one thing about DMA buffer - the buffer is allocated and
>>> the address doesn't change during the callback.  So, we'd need the lock for the
>>> hr callback and for the PCM prepare, hwparams and free callbacks, i.e. to
>>> assure that the hrtimer callback is finished when these PCM callbacks may
>>> change the DMA buffer.  Thus this lock doesn't have to be PCM substream lock.
>> I wonder if it would be better to introduce
>> such a lock in an alsa core rather than in a
>> driver. The same way as snd_pcm_stream_lock().
> I don't think it's good to introduce yet another lock in the PCM
> core.  More lock, more complex.  Even now the lock handling is too
> complex (and might be buggy in some cases) in ALSA PCM core.
Then I might be missing something.
Right now I touch runtime->dma_area[]
in a callback. You say it have to be
protected, but not with alsa lock, but
with my own lock. But I do not touch
it ever in any other place. Everything
else happens in an alsa core. So how
would I possibly protect it with some
lock private to snd-pcsp?

> I think, however, it'd be worth to consider snd_pcm_period_elapsed()
> to be softirq in PCM core so that the driver doesn't need
> initializations.  This will also reduce the spin unlock/re-lock
> procedure in IRQ handler around snd_pcm_perild_elapsed().
I guess it will help, but such a solution
has a tendency of being classified as a
"stupid hack", which you've already seen
recently. :)
There really must be other ways, that do
not carry such a risk.

>> Wouldn't it be better to just make
>> snd_pcm_period_elapsed() to not take
>> the stream lock? There is a requirement
>> right now to drop the stream lock before
>> calling this. I still beleive this is
>> the root of all the headache.
> No.  The work done by snd_pcm_period_elapsed() touches critical
> sections and is delicated enough to protect by a lock.
I didn't mean it should run without a lock.
But it shouldn't take it itself, allowing
the caller to _not drop_ it before calling.
Is this acceptable?

> The root of all the headache is the order of the spinlock.  It's just
> one lock in the PCM; and you must take it somewhere to protect.
Certainly, I take it. But the unfortunate
policy is that I have to drop it before
calling snd_pcm_period_elapsed(). Can we
change that?
Of course, that will mean more changes
than just to not take the lock in
snd_pcm_period_elapsed(). Most likely
the snd_pcm_stream_lock() and all its
users will have to be slightly adjusted,
but I think its pretty much a trivial
changes, which will lead to a much cleaner
code. And I remember the last time we
discussed this, you admitted (some of)
the other drivers do get this part wrong
too. So fixing it properly once and for
all might be a good idea as you are at
it again.
