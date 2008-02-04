From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
 ALSA intel8x0 sound card
Date: Mon, 4 Feb 2008 13:16:52 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802041300170.3034@hp.linux-foundation.org>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<200802041039.36100.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802041014410.3034@hp.linux-foundation.org>
	<200802041341.37313.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	by alsa0.perex.cz (Postfix) with ESMTP id CC321244C1
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 22:16:58 +0100 (CET)
In-Reply-To: <200802041341.37313.bjorn.helgaas@hp.com>
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



On Mon, 4 Feb 2008, Bjorn Helgaas wrote:
> 
> I'm sure you're right, but I don't understand why yet.  Here's what
> I think is happening; please correct me where I'm going wrong:
> 
>   1) enumerate PNP & ACPI devices
>   2) initialize PNP & ACPI drivers
>      2a) register ACPI PCI root bridge driver, which enumerates PCI
>          devices behind the bridge
>      2b) register PNP system driver and reserve resources (this is
>          where the current quirk skips some reservations)
>   3) initialize PCI drivers
>      3a) register intel8x0 sound driver and reserve conflicting
>          resources

So where in this would you put the

	pcibios_init() -> pcibios_resource_survey()

call (it's a subsys_initcall)?

THAT is the thing that actually registers the PCI resurces we've found 
into the resource tree!

It's very inconveniently placed as-is, since it literally depends on the 
whole initcall ordering (and the link order within that subsys_initcall 
thing), and all of this is architecture-driven rather than driven from 
some central place.

So this is the thing that I think should happen before any PnP or ACPI 
drivers actually start registerign themselves (but obviously needs to 
happen after the PCI buses have been enumerated).

The ACPI/PnP tables shouldn't be able to break the enumeration of the 
actual hardware devices, now should it?

> I think you're suggesting that we should do 2a first, to enumerate all
> PCI devices, and only later do 2b.  But I don't know how to accomplish
> that cleanly.

We should enumerate the PCI devices, then register their resources (and 
no, I'm not at *all* convinced it should happen as a separate 
subsys_initcall), and then register the PnP resources. 

So I think we should have roughly something like:

 - arch_initcall: this could enumerate the ACPI/PnP devices (but not 
   register anything). Alternatively, do it as subsys_initcall, and just
   make sure it happens early with link-order.

 - subsys_initcall: this should do that pcibios_init() thing that surveys 
   the resources (and the PCI enumeration needs to have happened before, 
   probably in the same initcall thanks to link order)

 - PnP/ACPI resource allocation *after* it, but before driver loading 
   (which wll cause new resources to be allocated). This could be 
   fs_initcall, or whatever (that's what things like "acpi_event_init" 
   already do).

 - regular drivers will come along much later, as part of 
   driver_initcall, and by the time this happens, we've now reserved all 
   resources we know about.

Basically, we just want to register the most trust-worthy resources before 
we register anything less trust-worthy. And actual device probing simply 
tends to be more trust-worthy than any randomly broken ACPI/PnP tables.

		Linus
