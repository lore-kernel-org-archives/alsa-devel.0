From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Thu, 08 Nov 2007 21:34:09 +0300
Message-ID: <473356A1.4050701@aknet.ru>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>	<s5hode6xhgp.wl%tiwai@suse.de>	<4732097E.3040401@aknet.ru>	<s5htznx9znk.wl%tiwai@suse.de>	<4732C455.7040503@aknet.ru>	<s5hd4ulthy3.wl%tiwai@suse.de>	<4732D151.20109@aknet.ru>
	<s5habpptg5o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (unknown [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 911E02492F
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 19:33:09 +0100 (CET)
In-Reply-To: <s5habpptg5o.wl%tiwai@suse.de>
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
> But still not exactly sure whether it's the same as you've got.
> It's no good testcase after all, you see?
OK, I'll see what can be done about
a test-case. But it can't be made
immediately. Maybe this week-end.

> You didn't set the slave period_size and periods properly in your
> configuration.  This defines periods=2 eventually.
That's what the program did, I
simply have not made an override.

> It works casually until a certain point.  But XRUN shall happen, as I
> explained.  So, the patch helps well but not cures completely as long
> as you use that configuration.
Well, do we agree that at least on
the hardware that allows an arbitrary
fragment sizes, it fixes the problem
completely? If so, then IMHO this is
already very good.

> Sigh.  A bug is a bug.  I know.  But, the problem is that the
> configuration still doesn't work.
It will likely to work with most cards,
right?
But I don't have Ye Olde SB16 to test...

> This is utterly another problem, rather than the real-time response
> issue.  Because the realtime responsiveness is important for two
> period case, slight difference of period/buffer size or its wakeup
> condition influences greatly on the behavior.
As I said, I can reproduce the underrun
even after setting 3 periods. This is
very suspicious. I need to check for
a race.

> Yeah, but it's the case of partial writes again, i.e. when apps cannot
> write a full period size.  When apps check its availability via poll,
> the hack isn't triggered.
But how then it happens that it fixes
the portaudio problems?
By the way, I still don't see what's
the difference. When the poll returns,
there is usually a period_size free on
slave. But does it mean that the app
can write the full period? What if the
rate plugin converts the full period
of app to the full period of HW + 4
extra bytes? In this case, even after
poll, the write may block because of
these 4 extra bytes, and then the partial
write will happen. Or what am I missing?
