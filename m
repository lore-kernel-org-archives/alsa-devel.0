From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Make register_card API available to
 drivers
Date: Thu, 13 Jan 2011 18:54:52 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010844671FD1@bgsmsx502.gar.corp.intel.com>
References: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
	<20110113112607.GA9936@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844671F9B@bgsmsx502.gar.corp.intel.com>
	<20110113114203.GA30351@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BE0610383A
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:25:57 +0100 (CET)
In-Reply-To: <20110113114203.GA30351@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> > Yes on both of these, but I didn't want to break current method.
> > So I kept these to ensure both methods work fine.
> 
> > One we have converted all driver to use register then we can remove these.
> > Would have made sense to put a comment for that
> 
> My plan for this when I originally wrote the comment had been to make
> the contents of the soc-audio device probe and removal look exactly like
> what you'd write directly in a machine driver so no code except for the
> code doing the soc-audio device had any idea it was there.  This would
> keep backwards compatiblity without special casing, making things more
> maintainable.
Hmmmm, I didn't want to change the current machine drivers yet, hence tried to
move the code of soc_probe into card_register.
So that works neatly (doesn't matter who is doing, machine or core)
Only thing which I kept is to check for card pointer and if valid then call
register (assuming someone is still using old method) which we should mark
deprecated

>  	card->dev = &pdev->dev;
This would be required only for current method hence kept it there. For anyone
who uses register, the machine should set this up properly

 
And I agree that these things should be done by machine. But wanted to split the
change to avoid any issues

So what I propose is keep it as is, I will resend the split patch series, and
then after machine drivers are changed we remove these.

Btw this make me wonder what will soc_probe be used (it is not doing anything)
Do we still need this and creating soc-audio device?

~Vinod
