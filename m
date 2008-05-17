From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [Bug #10679] 2.6.26-rc1
 regression:	e5e1d3cb20034a3cbcfff1f0bae12201aa2ce17e breaks artsd
Date: Sun, 18 May 2008 02:05:25 +0400
Message-ID: <482F56A5.7000008@aknet.ru>
References: <hPXlJLjt4XG.A._lF.Jv1JIB@chimera>
	<88YBFoyd1CN.A._sF.Ov1JIB@chimera>
	<s5hskwmeb1h.wl%tiwai@suse.de> <20080514212011.GH7054@mit.edu>
	<s5hhcd0azv1.wl%tiwai@suse.de> <20080515130654.GC18825@mit.edu>
	<s5h8wybr0c2.wl%tiwai@suse.de>
	<20080517204725.GA11460@codemonkey.org.uk>
	<482F47DC.60505@aknet.ru>
	<20080517213231.GA31440@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 08B9910381E
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 00:05:54 +0200 (CEST)
In-Reply-To: <20080517213231.GA31440@codemonkey.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello.

Dave Jones wrote:
> Unless someone has 10 sound cards :-)  (Sounds bizarre, but I never tire
> of seeing some of the creative situations our users get themselves into).
Yes, the hardcoded values sucks...

> Something like this is probably the only real supportable way to do it though.
> It would be great if alsa took something like -1 to mean 'never make this default'.
-1 seems to be already reserved for
"use first free slot", but maybe it
would be nice to reserve some value
for the "movable" index. For example,
the index -2 can mean "use the first
free slot, but move to the next one
when some other driver is registering
with -1 or explicitly to that slot".
Of course I have no idea whether this
is possible and acceptable, but maybe
the alsa guys can tell.

> But until that lands in a module-init-tools update, we're kind of stuck.
Well, they won't take 10 or any other
value I guess...
