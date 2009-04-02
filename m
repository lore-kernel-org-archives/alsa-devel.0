From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Thu, 2 Apr 2009 16:09:22 +0100
Message-ID: <20090402150922.GK9522@n2100.arm.linux.org.uk>
References: <20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
	<20090401192710.GH21294@sirena.org.uk>
	<20090402121348.GC9522@n2100.arm.linux.org.uk>
	<20090402121803.GD4527@sirena.org.uk>
	<20090402123844.GD9522@n2100.arm.linux.org.uk>
	<20090402133124.GE9522@n2100.arm.linux.org.uk>
	<20090402141200.GH4527@sirena.org.uk>
	<20090402144017.GI9522@n2100.arm.linux.org.uk>
	<20090402145330.GA21646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 7FF3F243F3
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 17:09:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090402145330.GA21646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 03:53:30PM +0100, Mark Brown wrote:
> On Thu, Apr 02, 2009 at 03:40:17PM +0100, Russell King - ARM Linux wrote:
> 
> > It's actually worse though - using my devmem2 hack no longer restores
> > things to a functional state.  devmem2 says the control register is
> > now set as:
> 
> Gah, I see one problem with the patch I sent.  The one below *might* do
> better if you have time to test it.  In any case, thanks a lot for your
> help here - I'm fairly confident that the remaining problems you're
> seeing are due to the lack of suspend and resume operations in the
> WM9705 driver.
> 
> >From eeec4f57eb9d8f5f45d9536319e0eb130cc3ba28 Mon Sep 17 00:00:00 2001
> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Date: Thu, 2 Apr 2009 15:49:41 +0100
> Subject: [PATCH] ASoC: Implement suspend and resume operations for WM9705
> 
> Compile tested only.

I beg to disagree with that statement...

sound/soc/codecs/wm9705.c: In function `wm9705_soc_suspend':
sound/soc/codecs/wm9705.c:326: error: `AC97_POWERDONW' undeclared (first use in this function)
sound/soc/codecs/wm9705.c:326: error: (Each undeclared identifier is reported only once
sound/soc/codecs/wm9705.c:326: error: for each function it appears in.)
sound/soc/codecs/wm9705.c: At top level:
sound/soc/codecs/wm9705.c:445: warning: initialization from incompatible pointer type

Fixing these results in something which can be built, and along with
your other two for the soc-core resume and the ac97 device parent,
the complaints from the touchscreen driver no longer appear.

Thanks.
