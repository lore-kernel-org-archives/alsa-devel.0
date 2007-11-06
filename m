From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: underruns and strange code in pcm_rate.c
	(and	patch)
Date: Tue, 06 Nov 2007 14:47:38 +0000
Message-ID: <47307E8A.9090700@superbug.co.uk>
References: <472E5A64.6010705@aknet.ru> <s5hy7dbvcgf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net
	[194.217.242.90])
	by alsa0.perex.cz (Postfix) with ESMTP id B401424818
	for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2007 15:47:44 +0100 (CET)
In-Reply-To: <s5hy7dbvcgf.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Stas Sergeev <stsp@aknet.ru>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> removing the hack there.  Maybe not.  But, I feel it's a barren
> discussion.  It's really a design problem.  Sigh.
> 

Are any steps being taken to change the design so that sample rate
conversion works better?
The options are:
1) get the sound card hardware to produce time based interrupts for the
rate plugin to use as it's period trigger. This is how the old OSS
drivers did it.
2) allow the user application to use different buffer/period sizes than
the hardware itself.
3) Try to encourage applications not to use the pcm_rate plugin at
all!!!  Instead force each application to do its own sample rate
conversion to match what the hardware can do.

I favor option (3) myself.

James
