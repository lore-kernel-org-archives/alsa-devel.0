From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: alsa-driver 1.0.18 doesn't built on PPC 2.6.27	and
	2.6.28
Date: Tue, 4 Nov 2008 23:40:01 +0100
Message-ID: <20081104224001.GC4122@bilbo.home.lxtec.de>
References: <20081104134434.GA4122@bilbo.home.lxtec.de>
	<s5hr65rqwu6.wl%tiwai@suse.de>
	<20081104172711.GB8872@bilbo.home.lxtec.de>
	<s5hhc6nz8fh.wl%tiwai@suse.de>
	<20081104195114.GC8872@bilbo.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EDD72415F
	for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2008 23:40:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081104195114.GC8872@bilbo.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org

* Elimar Riesebieter [081104 21:00 +0100]
> * Takashi Iwai [081104 19:00 +0100]
> [...] 
> > Does sound-2.6.git tree work with 2.6.28-rc3?
> >     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > 
> > Pull master branch on 2.6.28-rc3 git.
> > If so, possibly it's a missing include path for asm/*.h or so...
> 
> Building 2.6.28-rc3 inline drivers works.
> 
> > Or, just try to add #include <linux/kernel.h> before the inclusion of
> > linux/module.h in alsa-driver/include/adriver.h.
> 
> That doesn't work either.
> 
> In 2.6.27, 2.6.28-rc? and sound-2.6.git we are missing
> include/asm-powerpc which configure is looking for:
> 
> checking for kernel linux/devfs_fs_kernel.h... no
> Creating a dummy <linux/devfs_fs_kernel.h>...
> --
> checking for kernel asm/hw_irq.h... no
> Creating a dummy <asm/hw_irq.h>...
> --
> checking for kernel asm/irq_regs.h... no
> Creating a dummy <asm/irq_regs.h>...
> 
> configure links include/asm-arch to asm, though.
> hw_irq.h and irq_regs.h, where local_irq_save and local_irq_restore
> is defined, I found in /arch/powerpc/include/asm.

My temporaire solution:

1. put #include <linux/mm.h> in alsa-driver/include/adriver.h
2. copy arch/powerpc/include/asm/* into include asm-powerpc
3. build suceeded

At this moment I need an idea how to patch configure script to do
that.

> But devfs_fs_kernel.h I found in none of 2.6.2[6-8]?
We don't use devfs anymore ;)

Thanks
Elimar

-- 
  Planung:
  Ersatz des Zufalls durch den Irrtum.
                                -unknown-
