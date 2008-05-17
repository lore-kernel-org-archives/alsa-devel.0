From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: pcsp weirdness/report (yes,
	even with libasound 1.0.16 revert)
Date: Sat, 17 May 2008 19:23:06 +0400
Message-ID: <482EF85A.5090309@aknet.ru>
References: <20080516210128.GA2210@rhlx01.hs-esslingen.de>
	<482E0235.5070609@aknet.ru>
	<20080517141816.GA15040@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B18D1037EA
	for <alsa-devel@alsa-project.org>;
	Sat, 17 May 2008 17:23:23 +0200 (CEST)
In-Reply-To: <20080517141816.GA15040@rhlx01.hs-esslingen.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andreas Mohr <andi@lisas.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

Andreas Mohr wrote:
> Hold on... well, of course I definitely had, but - I didn't have swvol
> configured (as done by your sample asound.conf.gz / .asoundrc).
Why? Do you have an updated the PC-Speaker.conf
from alsa-lib hg (same that I posted to LKML)?
That should be enough to get softvol working
"out of the box".
But there is a small caveat to that. After
you load the driver module, you won't get
softvol configured immediately. Running the
mixer doesn't help, too. You need to play
some sound, and then softvol gets configured
so you can start mixer and change volume.
I never investigated that, but its an alsa-lib
bug most certainly. Running alsamixer without
playing any sound first, should be sufficient
to get softvol running. If this is what got you
trapped into, then I'll appreciate if you report
that to the right place. :)

> Now sound is a lot better, but it's still a wee bit too silent
> (piezo...).
Of course you can adjust the softvol config
and increase an amplification, but...

> And of course I don't quite like the fact that I'm burning 50%
> user-space on my Athlon!!!
What Athlon?
Have you tried setting the sampling rate
to 18KHz in alsamixer? Does that change
anything?
I am pretty sure there are the unhappy
asound.conf configurations that look
innocent but burns up your whole CPU.
I had them myself while trying to create
a good config for the driver.
Could you please remove all the custom
/etc/asound.conf, .asoundrc etc, and
only use the PC-Speaker.conf of alsa-lib hg?
I was testing that driver since 486DX4 120
(not in alsa version but an OSS), and it
didn't lead to any significant CPU load.

> (probably caused by tasklet,
AFAIK tasklet is a very light-weight technique.
And hopefully it'll be nuked from the driver
soon. :) It is only used once per playback
btw, so shouldn't hurt the CPU load at all.

> and probably by excessive ALSA handling
> there as well).
I suspect the excessive _user-space_ alsa
handling. That's what happened to me a few
times too.

> Do we really have to do ALSA housekeeping during every timer cycle??
There is only a small housekeeping per
every cycle. Most of it is a... well...
a locking mess. :) The rest is to take
the next byte from DMA buffer, write a
timer counter and advance a playback
pointer. Shouldn't be anything more.

> Not a single standard soundcard does this, it only triggers a sound
> interrupt whenever a period elapsed and _then_ calls
> snd_pcm_period_elapsed().
snd_pcm_period_elapsed() should only be
called when the period(s) has elapsed. If
not - its a bug. snd-pcsp is not an exception.

> Thus I'm strongly suspecting that we're severely overhandling things
> here, but I didn't really look into it.
Its rather messy right now because of
the locking stuff. But I don't think it
really does something redundant by mistake.

> Thus it'd seem we have a lot of overhead in this handler which one
If it is really a callback problem, then
perhaps the hrtimer code itself can
generate an overhead. Maybe you can try
an empty callback to check that out.

> gamix doesn't seem to handle a whole lot of things right (that's not the
> first time that I'm hitting a problem there).
Undoubtedly, you have already reported
it to the right people. :)
And I have to report the same problem
about the gnome-volume-control prog...

> Code. It just seemed to me that treble is something entirely different
> than the thing used by the driver.
OK, I'll rename it soon then.
Or you can do that yourself. :)

>>> Oh, and why does the code order I/O sequence as
>>>                         outb_p(chip->val61, 0x61);
>>>                         outb_p(timer_cnt, 0x42);
>>>                         outb(chip->val61 ^ 1, 0x61);
>>> instead of
>>>                         outb_p(chip->val61, 0x61);
>>>                         outb(chip->val61 ^ 1, 0x61);
>>>                         outb_p(timer_cnt, 0x42);
>>> as mentioned at some other sites? Is there any reason or maybe it just
>>> doesn't matter?
>> I think it doesn't matter, and I did
>> it that way to increase the delays
>> between the port 0x61 writes. I have
>> no proof that it helps or hurts.
> But that doesn't happen to be the reason for the nforce breakage, right?
No, and that's exactly what I did when
first heard about an nforce problem.
This was very long ago. I was hoping
an extra delays could help, but they
reportedly did not. I left it though,
but the first _p is of course now redundant.
Now I have the nforces everywhere
(actually, I don't have the non-nforce
boards any more), and I wasn't able to
find the right fix. Also note that all
the old DOS players are broken on nforce
just as well.
