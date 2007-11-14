From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: rate plugin issue
Date: Wed, 14 Nov 2007 23:10:02 +0300
Message-ID: <473B561A.1050203@aknet.ru>
References: <s5hwssnx58j.wl%tiwai@suse.de>	<4738A89D.9060601@aknet.ru>
	<s5hmytihlvo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id E04B8243AA
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 21:08:57 +0100 (CET)
In-Reply-To: <s5hmytihlvo.wl%tiwai@suse.de>
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

Hi.

Takashi Iwai wrote:
> The problem is that the condition of poll() is indeed broken without
> the hack.  That is, it's no problem of snd_pcm_write_areas().
> snd_pcm_write_areas() just calls snd_pcm_wait(), which calls nothing
> but poll().  If your program calls poll() by itself, you would see the
> similar problem.
Yes. But I am not sure how should
it behave. For example, if the prog
sets avail_min=1, then it should
expect the snd_pcm_wait() to no longer
work. But I think the write() should
not be affected. Yes, snd_pcm_write_areas()
just calls snd_pcm_wait(), but should it?
Should write() depend on avail_min, or
only snd_pcm_wait() should?
If write() should depend on avail_min
(which doesn't look logical to me), then
this does imply mpg123 is doing the wrong
thing by setting avail_min=1? And so,
what would be the fix?

> True, it should be fixed in a better way.
Unfortunately, I have no idea how's the
better fix should look like.
My patch implements exactly the logic
I had in mind: leave snd_pcm_wait() to
depend on avail_min, but make writei()
to not depend on it (use period_size
instead). Since you don't agree with that
logic, please let me know what logic you
prefer.
Furthermore, as you said earlier, avail_min
doesn't really work as expected. It gets
"rounded" to period_size anyway, because
that's where the interrupt arrives. Taking
that into account, I can propose the following:
deprecate avail_min and always set it to
period_size, no matter what the program
thinks. That will pretty much return the
old behaveour (the hack), although this
time - without the underruns.
But I don't suppose you are going to like
also this approach. :)

> BTW, could you provide a bit more information how to reproduce the
> bug?
Simply play some mp3 with mpg123, run "top".

> (Or, a test-case code would be best, as you know  ;) 
Well, stripping down the mpg123 code is
not a rocket science, I can do that. But
I am a bit busy at the moment, this will
have to wait a few days. But I think there
are really no problems reproducing it. :)
