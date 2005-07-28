From: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (1/2)
Date: Thu, 28 Jul 2005 10:31:58 +0200
Message-ID: <20050728083157.GI6529__8024.86830293692$1122539615$gmane$org@elf.ucw.cz>
References: <200507261247.05684.rjw@sisk.pl> <200507261251.48291.rjw@sisk.pl> <s5hmzo8ljf6.wl%tiwai@suse.de> <20050727205249.GA708@openzaurus.ucw.cz> <s5hr7djtkvo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1DB717B
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2005 10:31:58 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hr7djtkvo.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Len Brown <len.brown@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi!

> > > > The following patch adds free_irq() and request_irq() to the suspend and
> > > > resume, respectively, routines in the snd_intel8x0 driver.
> > > 
> > > The patch looks OK to me although I have some concerns.
> > > 
> > > - The error in resume can't be handled properly.
> > > 
> > >   What should we do for the error of request_irq()?
> > > 
> > > - Adding this to all drivers seem too much.
> > 
> > There's probably no other way. Talk to Len Brown.
> > 
> > >   We just need to stop the irq processing until resume, so something
> > >   like suspend_irq(irq, dev_id) and resume_irq(irq, dev_id) would be
> > >   more uesful?
> > 
> > Its more complex than that. Irq numbers may change during resume.
> 
> Hmm, then the patch looks wrong.  It assumes that the irq number is
> as same as before suspend.

> Sorry for ignorance, but, is only irq affected?  Are the other
> resources like ioport consistent after resume?

I think it is only irq, but Len, please take correct me if I'm
wrong. Irq number can change during suspend/resume cycle, right?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
