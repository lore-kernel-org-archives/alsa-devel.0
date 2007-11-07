From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c (and
	patch)
Date: Wed, 07 Nov 2007 21:40:39 +0300
Message-ID: <473206A7.1000305@aknet.ru>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>
	<s5h8x5auxz3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DFBA243F3
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 19:39:24 +0100 (CET)
In-Reply-To: <s5h8x5auxz3.wl%tiwai@suse.de>
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
> I don't think it's a race.  It appears to be just the matter of
> configuration mismatch (or misconception) to me.
OK then. The race will have to wait
till I get to it hard and (in case
there really is) produce a patch.

> Possibly.  Changing avail_min isn't a good idea, I believe, too.
Well, what I was trying to say is
that there are a few serious bugs
that were hidden by the hack...
Never mind, I'll post the patches
when the time will come. One step
at a time.

>>> size.  Thus only for apps that fills arbitrary amount of data via
>>> snd_pcm_writei() triggers this hack.
>> I don't think so.
> It is.
Firstly, it seems all or most apps
write the arbitrary amounts.

mpg123:
---
#7  0x00002aaaaad34afa in snd_pcm_mmap_writei (pcm=0x565dd0, buffer=0x5660b0, 
    size=4096) at pcm_mmap.c:186
186             return snd_pcm_write_areas(pcm, areas, 0, size,
(gdb) p pcm->period_size
$1 = 5512
---
writes 4096, while period_size is 5512.

ogg123:
---
#9  0x00002aaab2c48a69 in snd_pcm_writei (pcm=0x673430, buffer=0x2aaab4215108, 
    size=11340) at pcm.c:1186
1186            return _snd_pcm_writei(pcm, buffer, size);
(gdb) p pcm->period_size
$2 = 2756
---
writes 11340 with period_size 2756.

But I don't agree with you even if
some app does not. It will still be
affected. Let me demonstrate. I added
the following:
---
+if (size > pcm->period_size && size % pcm->period_size)
+size -= size % pcm->period_size;
---
to snd_pcm_writei() and snd_pcm_mmap_writei()
to simulate the condition when an app
transfers by periods. Here we go:
---
#5  0x00002aaab2c5dbc1 in snd_pcm_mmap_writei (pcm=0x672e30, 
    buffer=0x2aaab4215108, size=11024) at pcm_mmap.c:188
188             return snd_pcm_write_areas(pcm, areas, 0, size,
(gdb) p pcm->period_size
$1 = 2756
(gdb) p pcm->period_size*4
$2 = 11024
(gdb) p pcm->period_size*4==size
$3 = 1
---
OK, it is trying to write 4 periods.

---
Breakpoint 2, snd_pcm_rate_poll_descriptors (pcm=0x672e30, pfds=0x409ffdd0, 
    space=1) at pcm_rate.c:720
720             snd_pcm_rate_t *rate = pcm->private_data;
(gdb) n
724             ret = snd_pcm_generic_poll_descriptors(pcm, pfds, space);
(gdb) n
725             if (ret < 0)
(gdb) n
728             avail_min = rate->appl_ptr % pcm->period_size;
(gdb) n
729             if (avail_min > 0) {
(gdb) n
730                     recalc(pcm, &avail_min);
(gdb) p avail_min
$4 = 4
---
See a small reminder?
Why you ask? Here:
(the ogg has the rate 22050, the
driver has 48000)
---
(gdb) p rate->gen.slave->period_size
$10 = 6000
(gdb) p 6000/2756.0
$11 = 2.1770682148040637
(gdb) p 48000/22050.0
$12 = 2.1768707482993195
---
See a slight difference? I think this
is exactly why _any_ app is affected,
not only those that write arbitrary
amounts (even though they are a majority,
it seems to me).
So let me challenge you on that. :)


> The app must not think that the whole fragment can be written at a
> single call.  That's the bug of the app!
Hmm, I don't think it does, but I don't
understand what you mean here. So you
say the app should write an arbitrary
amounts? Well, then the above examples
of mine makes no sense, but I don't see
how it helps.

> The problem is that two periods with the current rate plugin cannot
> work.  Suppose the case of client period size 940, slave period size
Thanks for the example, I now understand
what fundamental problem you have in mind.

> So, without another wake-up source, the problem cannot be solved.
OK, it appears we are talking about two
completely different problems.
Yes, I now see the fundamental one and
I admit my patch doesn't solve it. Neither
it was intended to.

So what we have:
1. A fundamental problem with the different
fragment sizes. This may (or may not, if the
HW period is adjustable) give you underruns.
2. A bug in snd_pcm_rate_poll_descriptors(),
which prevents an app from filling the second
fragment before the first one is played.
This _does_ give an underruns, constantly,
unavoidably and badly. I have a patch, it needs
to be discussed.
3. A bug in snd_pcm_write_areas() I mentioned
earlier. I have a patch, will post it when the
time will come.
4. A (possible) race in snd_pcm_playback_poll()
which is harmless most of the times, but I can
get underruns out of it by rapidly switching
consoles.
5. Some other bug related to that problem,
which makes me a headache, but is still to be
located.

And you basically say: "if we have 1, then we
are not interested in fixing 2,3 and investigating 4,5".
That point of view may exist, but given that
2 gives some 90% of underruns with 1 being
only theoretically harmfull, I am not satisfied. :)

Sorry for the lengthy posting, I tried to
strip it as much as I could.
