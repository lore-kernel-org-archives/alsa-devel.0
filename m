From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [patch] snd-pcsp fixes
Date: Fri, 30 Oct 2009 15:22:39 +0300
Message-ID: <4AEADA8F.8030408@aknet.ru>
References: <4ADF4827.8060608@aknet.ru> <s5heiolyvyx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 2075E103899
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 13:22:58 +0100 (CET)
In-Reply-To: <s5heiolyvyx.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.

Takashi Iwai wrote:
> I applied the patch now as is, as I suppose you tested it well :)
Well, no! :) I only tested it on 2
machines yet. Please give it more
testing if you can.

> I don't remember exactly the changes for pcsp driver right now,
> but the change of the initial delay was due to the change of start
> logic.  At least, at the time HRTIMER_CB_IRQSAFE was removed, starting
> with zero didn't work at all on my machine.  Maybe something got fixed
> in the core side.
OK, it would be nice if you can check
whether or not the problem is there on
that particular machine...

> But, I still don't understand why it has to be zero.  The first
> bit-flip is done inside the trigger-start, so the next wakeup should
> be after the calculated ns.  Isn't it?
That was the logic you invented, but
initially, and with my patch, there
is no bitflip on start trigger. Or,
at least, not supposed to be - there
was only a timer mode setup, or if not -
that was a bug. :)
Also, you added some caching variables:

+       unsigned int fmt_size;
+       unsigned int is_signed;

What was the intention? Is this a speed-up?
If not - reverting that too?
