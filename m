From: Wolfgang Woehl <tito@rumford.de>
Subject: Re: position_fix issue / snd-hda-intel / alsa <-> jack
Date: Mon, 11 Feb 2008 22:22:27 +0100
Message-ID: <200802112222.27634.tito@rumford.de>
References: <26670.62.212.109.253.1202065817.squirrel@webmail.nerim.net>
	<20080207182521.7363c38a@hypofiz.lan>
	<200802072146.20691.tito@rumford.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id D6E262464B
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 22:22:30 +0100 (CET)
In-Reply-To: <200802072146.20691.tito@rumford.de>
Content-Disposition: inline
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

Hi,

I'm sorry I just kind of cc-dumped this in here without any why's and 
how's. It's the sum-up of a communication on jack-devel that left us 
irritated because our devices would perform so strangely.

Could someone confirm this or hint me towards anything?

Thanks, Wolfgang

Donnerstag, 7. Februar 2008 Wolfgang Woehl:

> For, at least, our two snd-hda-intel devices (ALC888 and 82801I
> (ICH9 Family)) both position_fix values (POSBUF and FIFO, 0 and 3
> respectively) produce ok sound, only that
>
> position_fix=0 makes alsa fine and jack crackle/sizzle
> position_fix=3 makes alsa crackle/sizzle and jack fine
>
> "alsa" meaning direct use of alsa and "jack" meaning (at least in
> my case) jack with the alsa backend.
>
> Here I have alsa-1.0.14-31.2 and jack-0.109.2-0.pm.1 (0.pm.1 stems
> from the packman repository, I guess)
>
> Wolfgang
