From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c (and
	patch)
Date: Thu, 08 Nov 2007 11:27:42 +0300
Message-ID: <4732C87E.8000706@aknet.ru>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<473206A7.1000305@aknet.ru>
	<s5hpryl9wl1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id CDF6324823
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 09:26:27 +0100 (CET)
In-Reply-To: <s5hpryl9wl1.wl%tiwai@suse.de>
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
>> OK then. The race will have to wait
>> till I get to it hard and (in case
>> there really is) produce a patch.
> Yeah, a testcase is required to reproduce the bug anyway.
No, the race doesn't have a test-case -
it gives underruns only when I rapidly
switch the consoles... Anyway, let's
wait till I get to it.

> Well, I object it - as far as I know (through hundreds of SUSE
> package I've been maintaining), most of them write the period_size
> data at once.  Writing arbitrary size is rather minor.
OK, thanks for info - I'll see about
enlarging my test-suit.

>> mpg123:
>> ogg123:
> Both are for libao.
Hmm, my mpg123 is not from libao, only
ogg123 is. And mpg123 doesn't suffer an
underruns therefore, but it is affected
by a few other problems I mentioned.

> The normal apps are more careful about the write timing and sync with
> GUI.  So they tend to write the data at the time poll permits, instead
> of dumb write sequence relying on blocking mode.  Maybe this is the
> key to get or avoid the bug.
OK, I'll try aplay later and post back.

> The difference seems to be whether you do simply writei() sequences
> without checks which causes partial writes and eventually triggers the
> hack.
No, its not that simple. Or at least in
my theory. :) The rounding error I was
pointing into, causes the following:
- the app writes a full period.
- the rate plugin converts it to the
slave period, which has a different
size.
- because of the rounding errors, that
slave period is not filled properly -
it is either slightly underfilled, or
overfilled (and the subsequent period is
started). That triggers the hack.
Does this look realistic or not?

> As mentioned, many apps do check the available spaces before
> write, so the partial write doesn't happen practically.
I don't think this will help, but I'll
check with aplay later.

> No, what I meant is that the app should check always the return value
> of the write properly.  Even in the blocking mode, write *may* return
> without writing the whole data.  Well, it's off-topic right now.
I know that, but I can't follow the
logic. If write returns earlier, then
the app will have to do the partial
write next time, so you loose the
alignment. So by saying that, you
basically say that the arbitrary writes
are unavoidable, and so I can't follow
the logic.

> I'm not satisfied because I have no testcase to reproduce the
> practical bug.  The patch looks fine, but I cannot test it because the
> serious bug doesn't occur to me.  OK?  That's why I claim a testcase.
I'll try to help with that, but I don't
think this will be successfull (and
you should try my asound.conf first).
But we always can ask someone else
with the problem to test the patch,
right? I don't think there is a shortage
of such people - google makes me to beleive
so.
