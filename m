From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: [PATCH] ASoC Platform Driver for AT32AP7000 (AVR32)
Date: Wed, 28 May 2008 10:28:59 -0500
Message-ID: <200805281028.59582.geoffrey@pager.net>
References: <200805271732.00086.geoffrey@pager.net>
	<20080528111854.GC12414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.26])
	by alsa0.perex.cz (Postfix) with ESMTP id C8D031037EE
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 17:28:33 +0200 (CEST)
Received: from [192.168.1.71] (localhost [127.0.0.1])
	by barracuda.pager.net (Spam Firewall) with ESMTP id 11A8DBAF94
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2008 10:28:32 -0500 (CDT)
Received: from [192.168.1.71] ([192.168.1.1]) by barracuda.pager.net with
	ESMTP id 8hWPacFcZ1INzV63 for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 10:28:32 -0500 (CDT)
In-Reply-To: <20080528111854.GC12414@sirena.org.uk>
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

On Wednesday 28 May 2008 06:18:55 am Mark Brown wrote:
> On Tue, May 27, 2008 at 05:32:00PM -0500, Geoffrey Wossum wrote:
> > Add ASoC platform driver for AT32AP7000 (AVR32).
> > This is basically a port of the at91 ASoC platform code to the
>
> Thanks - I've added this to the ASoC git tree.

Cool.

> The driver looks good but there are quite a few issues that should be
> fixed up before submission to mainline but these are coding style issues
> rather than anything substantial - most of them can be picked up by
> running the script scripts/checkpatch.pl in the kernel source against
> your patch (it also has a --file argument which can be used to run it on
> regular files rather than patches).

Argh!  When I perfect my time machine, first thing I'm doing is preventing the 
invention of tabs.  Second, I'm going to convince Kernigham and Ritchie that 
braces shouldn't be optional.  Only then will I go stop the rise of fascism 
in Europe.  :)

Do I need to submit patches to fix the style issues?


> One thing that's missing is the build system updates in sound/soc to
> hook this in.

Whoops, attached to the end of this email.

> > AVR32.  This is currently against the Linux 2.6.24.3.atmel.3 kernel,
> > the latest kernel Atmel has released for the AVR32.
>
> Will this driver work with a current mainline kernel or does it require
> other things from the Atmel kernel?

at32-pcm.c and at32-ssc.c will compile against a vanilla 2.6.24.3 kernel.  
playpaq_wm8510.c will not, since it references the WM8510 code that is not in 
the mainline kernel.  Not sure if it would really work.  Even though AVR32 is 
in the mainline kernel, Atmel still has a fairly extensive patch against the 
kernel.  Until you can use an unpatched and current kernel for the AVR32, 
this code probably isn't a candidate for inclusion the mainline.


> > playpaq_wm8510.c isn't necessarily intended for inclusion into the
> > mainline kernel or linux-2.6-asoc repository.  It's provided more as a
> > reference machine driver for an AT32AP7000 system.
>
> It's generally useful to have reference machine drivers - apart from
> anything else, it helps from the point of view of doing build tests even
> if you don't have the hardware to actually run them.

I'll have to correct the file to kernel coding standards at some point then.  
I also need to make it not depend on a patch I have to the kernel.
  

> > +#include <sound/driver.h>
>
> driver.h shouldn't be required with current ALSA versions, though I
> can't remember if it's needed on the older kernel you're running with.

In 2.6.24, I think you still need to include sound/driver.h.  This was part of 
what clued me into the fact that the linux-2.6-asoc HEAD was not going to 
work me.

> > +/*
> > + * SSC register values that Atmel left out of <linux/atmel-ssc.h>. 
> > These + * are expected to be used with SSC_BF
> > + */
> > +/* START bit field values */
> > +#define SSC_START_CONTINUOUS    0
> > +#define SSC_START_TX_RX         1
> > +#define SSC_START_LOW_RF        2
> > +#define SSC_START_HIGH_RF       3
> > +#define SSC_START_FALLING_RF    4
> > +#define SSC_START_RISING_RF     5
> > +#define SSC_START_LEVEL_RF      6
> > +#define SSC_START_EDGE_RF       7
> > +#define SSS_START_COMPARE_0     8

I'll see if I can get this kind of stuff merged into Atmel's patch set.

Thanks,
---
Geoffrey


Patch Makefile's and Kconfig's for ASoC with AT32
Patch is against linux-2.6-asoc repository when v.2.6.24 was tagged

Signed-off-by: Geoffrey Wossum <gwossum@acm.org>
Index: linux-2.6.24.3.atmel.3/sound/soc/Kconfig
===================================================================
--- linux-2.6.24.3.atmel.3.orig/sound/soc/Kconfig
+++ linux-2.6.24.3.atmel.3/sound/soc/Kconfig
@@ -25,6 +25,7 @@ config SND_SOC
 	  will be called snd-soc-core.
 
 # All the supported Soc's
+source "sound/soc/at32/Kconfig"
 source "sound/soc/at91/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
Index: linux-2.6.24.3.atmel.3/sound/soc/Makefile
===================================================================
--- linux-2.6.24.3.atmel.3.orig/sound/soc/Makefile
+++ linux-2.6.24.3.atmel.3/sound/soc/Makefile
@@ -1,4 +1,4 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/ imx/ au1x/ blackfin/ fsl/
+obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ imx/ au1x/ blackfin/ fsl/
