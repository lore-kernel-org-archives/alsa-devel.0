From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c
Date: Thu, 08 Nov 2007 11:09:57 +0300
Message-ID: <4732C455.7040503@aknet.ru>
References: <472E5A64.6010705@aknet.ru>	<s5hy7dbvcgf.wl%tiwai@suse.de>	<473091F4.80105@aknet.ru>	<s5h8x5auxz3.wl%tiwai@suse.de>	<4731F2F4.2080704@aknet.ru>	<s5hode6xhgp.wl%tiwai@suse.de>	<4732097E.3040401@aknet.ru>
	<s5htznx9znk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id D96132481A
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 09:08:42 +0100 (CET)
In-Reply-To: <s5htznx9znk.wl%tiwai@suse.de>
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
> I'm concerned much because I cannot reproduce the bug here (underrun)
> in the practical use even with the same application and driver.
Have you already tried my asound.conf?
Also, I use the 22050Hz ogg file for
testing - maybe that makes some difference,
so please try the 22050Hz ogg file.
And I explicitly tell "ogg123 -d alsa09",
or it will apply to some sound server.

> cannot reproduce the bug practically but only you do.
No, its not only me. As I already
said, I've got a positive reply from
the guy saying that it fixes
portaudio+espeak. I can also try
mailing the guy that raised that
problem here before. But unfortunately
people prefer to mail privately,
so you'll have to beleive me on
the other's feedback.

> With a test
> case, we both will be able to check in detail.  OK?
OK, but first please try my asound.conf
with 22050Hz ogg, and maybe that will
rescue me from writing a test-case which
won't work on your system most probably
anyway...
