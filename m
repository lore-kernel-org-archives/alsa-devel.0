From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC Platform Driver for AT32AP7000 (AVR32)
Date: Wed, 28 May 2008 16:40:00 +0100
Message-ID: <20080528153958.GE12414@sirena.org.uk>
References: <200805271732.00086.geoffrey@pager.net>
	<20080528111854.GC12414@sirena.org.uk>
	<200805281028.59582.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C3761037F9
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 17:40:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200805281028.59582.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 28, 2008 at 10:28:59AM -0500, Geoffrey Wossum wrote:

> Do I need to submit patches to fix the style issues?

Ideally, yes; there are some not entirely mechanical things in there as
well so it'd be good to make sure that what goes in has been tested
as-is.

> > Will this driver work with a current mainline kernel or does it require
> > other things from the Atmel kernel?

> at32-pcm.c and at32-ssc.c will compile against a vanilla 2.6.24.3 kernel.  
> playpaq_wm8510.c will not, since it references the WM8510 code that is not in 
> the mainline kernel.  Not sure if it would really work.  Even though AVR32 is 

We should be able to submit the WM8510 driver so it shouldn't be a
blocker.

> in the mainline kernel, Atmel still has a fairly extensive patch against the 
> kernel.  Until you can use an unpatched and current kernel for the AVR32, 
> this code probably isn't a candidate for inclusion the mainline.

OTOH, if it will build with current mainline then that reduces the diff
that one needs to carry in order to use this support and means there's
one less thing in that diff that needs to be merged into mainline.  That
seems like a net win to me.

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
