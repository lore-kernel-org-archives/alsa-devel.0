From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [ACPI] Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416
	(1/2)
Date: Thu, 28 Jul 2005 16:48:06 +0800
Message-ID: <1122540486.2903.8.camel__33347.5220985294$1122540809$gmane$org@linux-hp.sh.intel.com>
References: <200507261247.05684.rjw@sisk.pl>
	 <20050727205249.GA708@openzaurus.ucw.cz> <s5hr7djtkvo.wl%tiwai@suse.de>
	 <200507281043.14697.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from orsfmr005.jf.intel.com (fmr20.intel.com [134.134.136.19])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CDA416D
	for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2005 10:52:40 +0200 (MEST)
In-Reply-To: <200507281043.14697.rjw@sisk.pl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Takashi Iwai <tiwai@suse.de>, Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-07-28 at 10:43 +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thursday, 28 of July 2005 10:06, Takashi Iwai wrote:
> > At Wed, 27 Jul 2005 22:52:49 +0200,
> > Pavel Machek wrote:
> > > 
> > > Hi!
> > > 
> > > > > The following patch adds free_irq() and request_irq() to the suspend and
> > > > > resume, respectively, routines in the snd_intel8x0 driver.
> > > > 
> > > > The patch looks OK to me although I have some concerns.
> > > > 
> > > > - The error in resume can't be handled properly.
> > > > 
> > > >   What should we do for the error of request_irq()?
> > > > 
> > > > - Adding this to all drivers seem too much.
> > > 
> > > There's probably no other way. Talk to Len Brown.
> > > 
> > > >   We just need to stop the irq processing until resume, so something
> > > >   like suspend_irq(irq, dev_id) and resume_irq(irq, dev_id) would be
> > > >   more uesful?
> > > 
> > > Its more complex than that. Irq numbers may change during resume.
> > 
> > Hmm, then the patch looks wrong.  It assumes that the irq number is
> > as same as before suspend.
> 
> Well, that''s the theory, but frankly I don't see a practical reason.  I have never
> seen this happening.  Practically, for this to happen, you'll have to reconfigure
> the BIOS accross suspend/resume which is dangerous anyway.
>From my understanding, we should not have such assumption. Say all
device drivers with the same ioapic pin have freed irq. We might mask
the ioapic pin and even free the vector. Then after you request_irq
again, the interrupt might get different vector. If you enable MSI, then
it's broken.
In IA64, we already have such staff (mask ioapic pin and free vector).

Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
