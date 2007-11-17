From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: rate plugin issue
Date: Sat, 17 Nov 2007 17:59:53 +0300
Message-ID: <473F01E9.8070907@aknet.ru>
References: <s5hwssnx58j.wl%tiwai@suse.de>	<4738A89D.9060601@aknet.ru>	<s5hmytihlvo.wl%tiwai@suse.de>	<473B561A.1050203@aknet.ru>
	<s5h6404dmsi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id AFE0C24582
	for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2007 15:58:48 +0100 (CET)
In-Reply-To: <s5h6404dmsi.wl%tiwai@suse.de>
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
> What I don't like is the place you fix it.  This is not much better
> than the old hack, or it's even worse because it adds a hack in the
> common function not in the plugin.
That depends on what logic does the
fix imply. My logic was that the writei()
should not depend on avail_min, and just
always use period_size. Your logic is that
they both should respect avail_min when it
is >period_size, and from that point of view,
my fix is of course wrong and at the wrong
place.

> And above all, the fix would be really easy like the patch below.
Your patch works very well.
Actually, much better than mine, for
the reasons I can't explain (there is
probably another similar loop somewhere,
otherwise they would work in the similar
way).
Just a few questions:
1. Do you want to "round" avail_min only
when it is < period_size, or maybe you
want something like this instead:
---
avail_min += period_size - 1;
avail_min -= avail_min % period_size;
---
so that it is always rounded up?
2. What is it really good for? Why would
the one want avail_min != period_size?
Now, after you disallow avail_min<period_size,
it makes even less sense - why would
someone set avail_min>period_size, instead
of increasing the period_size itself?
So maybe something like this is also
possible:
---
/* there seem to be no reason to set avail_min,
 * period_size is enough */
avail_min = period_size;
---

> Then which version of mpg123 with which configuration?
But I am not sure if you tried _any_
mpg123 with any configuration. :)
Well, mine is mpg123-0.60-1.fc5.rf,
running on top of Fedora8.
---
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layers 1, 2 and 3
        version 0.60; written and copyright by Michael Hipp and others
        free software (LGPL/GPL) without any warranty but with best wishes
---
But your patch works very well, so
perhaps you don't even need to test
it with mpg123 any more. :)

Thanks!
