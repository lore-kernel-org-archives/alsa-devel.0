From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Thu, 08 Nov 2007 12:05:21 +0300
Message-ID: <4732D151.20109@aknet.ru>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>	<s5hode6xhgp.wl%tiwai@suse.de>	<4732097E.3040401@aknet.ru>	<s5htznx9znk.wl%tiwai@suse.de>	<4732C455.7040503@aknet.ru>
	<s5hd4ulthy3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 43A3A24835
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 10:04:09 +0100 (CET)
In-Reply-To: <s5hd4ulthy3.wl%tiwai@suse.de>
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
> Yeah I've seen the problem,
Grrr... so you reproduced the
problem already, right?

> but as I wrote, it's basically because you
> use periods=2 and unaligned sample rates.
I do not - maybe libao does, but in
fact I am sure also the sound servers
have the same problem.

> So, of course, it doesn't work.
It does - have you tried my patch?

> 	slave.periods 3
> 	slave.period_size 4096
> then you'll hear the improvement, I guess.
So you already tried everything - then
why asking me for the test-case?
Anyway. There is a bug. And not the
only one. You knew the workaround
while I was searching for the fix.
Now you decide what is better - fix
it or apply to workarounds.
Btw, I can still reproduce the underrun
by rapidly switching the consoles, even
though now it is harder to reproduce.
