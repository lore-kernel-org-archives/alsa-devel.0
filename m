From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: underruns and strange code in pcm_rate.c
	(and	patch)
Date: Tue, 06 Nov 2007 20:14:26 +0300
Message-ID: <4730A0F2.8070900@aknet.ru>
References: <472E5A64.6010705@aknet.ru> <s5hy7dbvcgf.wl%tiwai@suse.de>
	<47307E8A.9090700@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id DADCE24808
	for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2007 18:13:08 +0100 (CET)
In-Reply-To: <47307E8A.9090700@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi.

James Courtier-Dutton wrote:
> Are any steps being taken to change the design so that sample rate
> conversion works better?
Yes, you've seen it, its in my patch. :)
Seriously though, I think that attitude
is unfair. I dare to claim that it was
not some random hack that just happened
to work. But rather a correct and reliable
fix.

> 2) allow the user application to use different buffer/period sizes than
> the hardware itself.
That's what the rate plugin already
allows, it seems.

> 3) Try to encourage applications not to use the pcm_rate plugin at
> all!!!  Instead force each application to do its own sample rate
> conversion to match what the hardware can do.
The applications have nothing to do
with that plugin I think - it all in
an alsa config.
