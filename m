From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Wed, 07 Nov 2007 21:52:46 +0300
Message-ID: <4732097E.3040401@aknet.ru>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>
	<s5hode6xhgp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id F0C0F244C6
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 19:51:33 +0100 (CET)
In-Reply-To: <s5hode6xhgp.wl%tiwai@suse.de>
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
> Well, I'm using ogg123 with dmix but it works fine.
> That's why I'm wondering why you got so *many* problems.
Honestly, I don't want to search an answer
to this. :) Now, when I have located all,
or most of, the bugs I needed to locate,
this question concerns me not too much. :)

> And, to fix the problem, a test case is always helpful.
I don't think the (code) test-case will
do the trick. I have "anything" as a code
test-case, but for you that test-case doesn't
work.
The only remaining thing I can think of,
is asound.conf, which you now have of mine
and can try.

> Or, possibly wrapping with softvol is the problem?
No, it is not (tried before, tried now
once again).
I am quite sure in that I have located
the problem(s) correctly. So you may see
some reluctance, but frankly, I don't
know what kind of a test-case I can provide,
and why. Write some prog with libao?
But it won't be any better than ogg123...
