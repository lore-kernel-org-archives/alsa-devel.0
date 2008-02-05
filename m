From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
	ALSA intel8x0 sound card
Date: Tue, 5 Feb 2008 13:12:46 -0700
Message-ID: <200802051312.47074.bjorn.helgaas@hp.com>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<200802050003.32591.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802051013110.9374@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 66F8524471
	for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2008 21:17:08 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0802051013110.9374@woody.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robert Hancock <hancockr@shaw.ca>, alsa-devel@alsa-project.org, avuton@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yakui.zhao@intel.com, shaohua.li@intel.com, Andrew Morton <akpm@linux-foundation.org>, trenn@suse.de
List-Id: alsa-devel@alsa-project.org

On Tuesday 05 February 2008 11:15:12 am Linus Torvalds wrote:
> 
> On Tue, 5 Feb 2008, Bjorn Helgaas wrote:
> > > 
> > >  - PnP/ACPI resource allocation *after* it, but before driver loading 
> > >    (which wll cause new resources to be allocated). This could be 
> > >    fs_initcall, or whatever (that's what things like "acpi_event_init" 
> > >    already do).
> > 
> > If we put the PNP system driver here, we can easily do a quirk that
> > ignores PNP resources that overlap PCI resources.
> 
> No, you don't need any quirks: you just do an "insert_resource()" and 
> ignore the error return. If the (bogus) PnP resource clashes with the 
> (correct) hardware PCI resource, the insert will simply fail. No quirks 
> needed.
> 
> >						  But it's kind of
> > ugly to have the ACPI PCI root driver early and other PNP drivers
> > later because they're basically similar animals.
> 
> No they are not.
> 
> If one does just device enumeration, and the other does resource 
> registrations, then they ARE NOT similar animals at all. Don't claim that 
> they are.

Whoa, easy :-)  I just meant they're similar in that we discover PCI
root bridges and other PNP devices by traversing the ACPI namespace,
so unless we make special arrangements, we bind drivers to them at
roughly the same time.

I'll play with your insert_resource() idea and see if I can figure
something out.

Bjorn
