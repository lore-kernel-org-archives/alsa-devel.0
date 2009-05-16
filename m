From: Alexey Bazhin <baz@irc.msk.ru>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Sun, 17 May 2009 01:20:02 +0400
Message-ID: <20090517012002.203d2309.baz@irc.msk.ru>
References: <s5h4ovovtwe.wl%tiwai@suse.de>
	<20090517005251.9ade4602.baz@irc.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mosuzedu.ru (mail.mosuzedu.ru [217.112.17.3])
	by alsa0.perex.cz (Postfix) with ESMTP id E801024422
	for <alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 23:20:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.mosuzedu.ru (Postfix) with ESMTP id AA608ADFB
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 01:20:03 +0400 (MSD)
Received: from mail.mosuzedu.ru ([127.0.0.1])
	by localhost (sakura.mosuzedu.ru [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yZION3eBhca0 for <alsa-devel@alsa-project.org>;
	Sun, 17 May 2009 01:20:02 +0400 (MSD)
Received: from firefly.flat.yume.ru (cicada.yume.ru [217.172.19.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: baz@yume.ru)
	by mail.mosuzedu.ru (Postfix) with ESMTPSA
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 01:20:02 +0400 (MSD)
In-Reply-To: <20090517005251.9ade4602.baz@irc.msk.ru>
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

On Sun, 17 May 2009 00:52:51 +0400
Alexey Bazhin <baz@irc.msk.ru> wrote:

> On Thu, 14 May 2009 12:52:17 +0200
> Takashi Iwai <tiwai@suse.de> wrote:
> 
> > Once after I get positive feedbacks (or fix after negative ones),
> > I'm going to merge it to the main tree so that it'll be in the next
> > kernel.  So, a quick test report would be greatly appreciated.
> As for me:
> 
One more thing - using digital output (with maximum volume in mixer)
resulting volume of sound is much higher than with my other cards, so
some additional processing added so even playing sound sample with
native card rate is not bit accurate. Is it how it's supposed to be?

-- 
 Alexey Bazhin
  mailto:baz@irc.msk.ru
  ICQ 125125882
