From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: pcsp weirdness/report (yes,
	even with libasound 1.0.16 revert)
Date: Sat, 17 May 2008 01:52:53 +0400
Message-ID: <482E0235.5070609@aknet.ru>
References: <20080516210128.GA2210@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 9762A24712
	for <alsa-devel@alsa-project.org>;
	Fri, 16 May 2008 23:52:59 +0200 (CEST)
In-Reply-To: <20080516210128.GA2210@rhlx01.hs-esslingen.de>
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
Cc: alsa-devel@alsa-project.org, Theodore Tso <tytso@mit.edu>
List-Id: alsa-devel@alsa-project.org

Hi.

Andreas Mohr wrote:
> Immediately tried playback, and nothing worked properly.
> Sound is __EXTREMELY__ silent, about 15 times more silent than the
> normal terminal beep.
Sorry for the silly question but...
do you have the Master volume at
maximum?

> insmod with nforce_wa=1, no success either.
nforce_wa is only needed if your
speaker is completely silent otherwise.
So you don't need it.

> Debug output is (val has astonishingly uniform values):
> input: PC Speaker as /class/input/input12
> PCSP: lpj=4012338, min_div=32, res=1
> PCSP: open called
> PCSP: prepare called, size=32768 psize=2048 f=16 f1=16
> PCSP: trigger called
> PCSP: start_playing called
> timer_cnt 32 val 128 CUR_DIV 64 chip->treble 0 chip->max_treble 1
> timer_cnt 27 val 111 CUR_DIV 64 chip->treble 0 chip->max_treble 1
> timer_cnt 35 val 141 CUR_DIV 64 chip->treble 0 chip->max_treble 1
> timer_cnt 28 val 115 CUR_DIV 64 chip->treble 0 chip->max_treble 1
> timer_cnt 27 val 111 CUR_DIV 64 chip->treble 0 chip->max_treble 1
> timer_cnt 32 val 128 CUR_DIV 64 chip->treble 0 chip->max_treble 1
> timer_cnt 36 val 145 CUR_DIV 64 chip->treble 0 chip->max_treble 1
> timer_cnt 32 val 130 CUR_DIV 64 chip->treble 0 chip->max_treble 1
> timer_cnt 30 val 123 CUR_DIV 64 chip->treble 0 chip->max_treble 1
Only timer_cnt and val may change.
Others are from the mixer controls.
Well, whatever should change, seems
changing. :)

> BTW, since it has been frequently mentioned that sound device reordering is
> an issue:
> why not make that hard-coded in the driver itself??
I was thinking about that too - I don't
know an answer. Added alsa-devel to CC
because of that question.

> If this is safe to do (setting it to a "max" value or to e.g. 10,
> and all/most ALSA users still evaluate things properly), then one should
> probably do it.
Hopefully someone else can comment on that.

> And mixer controls in gamix are very confusing, too.
> E.g. when clicking on the BaseFRQ enum box, I get _two_ 18643 entries listed.
I've seen this too, but I think this is
a bug in that mixer gui. It doesn't seem
to handle the ENUMERATED values right,
IIRC. alsamixer works right.

> And I'm still not sure (haven't investigated fully)
> why that other setting is called "treble".
Where? In the GUI or in the code?
It shouldn't be called as such in
the GUI, and for the code... well, I
don't know, that was too long ago. :)

> All in all very confusing.
> All I'd want is enable playback, enable standard beep, master playback
> volume and having the base frequency displayed(/changeable).
Could you please see if there are any
problems with alsamixer first? If not,
then the problems are likely in the
mixer you use.

> Oh, and maybe oversampling configuration (how many samples to average,
> for reduced timer load, see e.g.
> http://kerneltrap.org/mailarchive/linux-activists/1993/4/13/29718 ).
They seem to be talking about a simple
downsampling to reduce the data transfer.
I beleive they talk about downsampling in
the player, not in the driver.
You can't reduce the PWM freq. Making it
below 18KHz would just whistle.

> Oh, and why does the code order I/O sequence as
>                         outb_p(chip->val61, 0x61);
>                         outb_p(timer_cnt, 0x42);
>                         outb(chip->val61 ^ 1, 0x61);
> instead of
>                         outb_p(chip->val61, 0x61);
>                         outb(chip->val61 ^ 1, 0x61);
>                         outb_p(timer_cnt, 0x42);
> as mentioned at some other sites? Is there any reason or maybe it just
> doesn't matter?
I think it doesn't matter, and I did
it that way to increase the delays
between the port 0x61 writes. I have
no proof that it helps or hurts.

> Kconfig description should perhaps also be updated to prominently but
> shortly display the fact that this driver provides full playback,
> not just simple beeps (e.g. mention "digital sound driver" or so).
It says something about a "primitive
sound card", but I see no problems
improving the text.

> Thanks a lot for providing a rather important puzzle piece for
> Linux usability!
:)
Ok, the problems should be solved, the
texts should be improved, the users should
upgrade, etc. And in a mean time, the
warning I put there, is hopefully strong
enough. :)
If not, we can always depend that driver
on CONFIG_BROKEN... but I'd like to hear
more opinions about that option.
Hmm, actually, why not? We can always
un-depend it later. Thoughts?
