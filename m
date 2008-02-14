From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
 ALSA intel8x0 sound card
Date: Thu, 14 Feb 2008 14:57:15 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802141456370.6110@woody.linux-foundation.org>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<200802141401.24723.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802141323130.6110@woody.linux-foundation.org>
	<200802141528.53446.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 573EC24668
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 23:57:50 +0100 (CET)
In-Reply-To: <200802141528.53446.bjorn.helgaas@hp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Robert Hancock <hancockr@shaw.ca>, alsa-devel@alsa-project.org, avuton@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yakui.zhao@intel.com, shaohua.li@intel.com, Andrew Morton <akpm@linux-foundation.org>, trenn@suse.de
List-Id: alsa-devel@alsa-project.org



On Thu, 14 Feb 2008, Bjorn Helgaas wrote:
> > 
> > [   22.906610] system 00:08: iomem range 0xfebfe000-0xfebfec00 has been reserved
> > [   22.906654] system 00:08: iomem range 0xfebfa000-0xfebfac00 has been reserved
> 
> The PNP resource fits entirely inside the PCI bus resource, so the PNP
> insertion will only fail if the sound driver has already been loaded.

Ok, it does indeed fit entirely in (and the discussion about "clashing" 
misled me - the PCI resource doesn't actually clash, it's just a subset). 
And the problem then ends up that the PnP thing adds resources to inside 
the PCI resource. It shouldn't. It's crap.

It should insert the resource to the root resource (or a bridge resource), 
or not at all. If somebody else has already inserted a real device 
resource, we already know about it, and the PnP information is going to be 
just making things worse.

The *really* basic issue is that PnP and ACPI generally report utter crap. 
We should always totally ignore them EXCEPT AS A WAY TO AVOID _NEW_ 
ALLOCATIONS.

That's the only valid reason to believe in ACPI: we don't know what the 
hell it's talking about, but we _do_ know that we shouldn't be allocating 
new resources over it (because if it actually happens to be correct, it is 
some random scary stuff that we obviously didn't find out about).

But the moment we have better information (where "we actually scanned the 
hardware" is the very definition of better information), we should always 
totally discard any ACPI crud. It's guaranteed to be worse than what we 
already know about.

That's all I ever wanted. To have ACPI realize that it should never ever 
mess with something we know better about.

			Linus
