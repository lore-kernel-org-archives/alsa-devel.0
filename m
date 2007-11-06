From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c (and
	patch)
Date: Tue, 06 Nov 2007 16:56:42 +0300
Message-ID: <4730729A.3020102@aknet.ru>
References: <472E5A64.6010705@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id F0E4524540
	for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2007 14:55:24 +0100 (CET)
Received: from ppp91-76-88-162.pppoe.mtu-net.ru ([91.76.88.162])
	by mail.aknet.ru with esmtpa (Exim 4.68 (FreeBSD))
	(envelope-from <stsp@aknet.ru>) id 1IpOtm-0000zD-2w
	for alsa-devel@alsa-project.org; Tue, 06 Nov 2007 16:55:22 +0300
In-Reply-To: <472E5A64.6010705@aknet.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Stas Sergeev wrote:
> The patch is attached, any comments?
I am actually a bit surprised
with the lack of the response
to this. Esp given the existance
of the threads like this:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg15494.html
(btw, can someone please e-mail
the address of Scott Waye, so that
I can ask him to test the patch?)
and the amount of entries google
gives on "alsa underrun" request.
I also have one private reply, which
says that my patch fixes also
portaudio+espeak, but that's all.

That patch may not be correct, but
at least I think it worth some attention.
Without the patch, I am (and many
other users apparently) getting a
constant stream of underruns and
a choppy sound from pretty much
anything. With the patch - its
almost perfect. Well, it is perfect,
but I can still get an underrun by
the rapid console switching between
X and text. And I think I see the
source of these underruns too:
snd_pcm_wait() checks for avail>=avail_min
in userspace, and then proceeds to
poll(). snd_pcm_playback_poll() (in
kernel) doesn't check for anything
and calls poll_wait(). If between
these events the fragment was completed
(by an irq handler), this poll_wait()
will miss the right time. I guess that
the fix is to use the wait_for_completion()
here, but I am not sure.

Anyway. If this work is ignored now,
then I can bet the problems will stay
for the next few years or more, until
someone else will expire to start fixing them.
Which would probably be a bit disappointing.
