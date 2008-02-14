From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
 ALSA intel8x0 sound card
Date: Thu, 14 Feb 2008 15:14:45 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802141503470.6110@woody.linux-foundation.org>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<200802141401.24723.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802141323130.6110@woody.linux-foundation.org>
	<200802141528.53446.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802141456370.6110@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F86A245C6
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2008 00:14:49 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0802141456370.6110@woody.linux-foundation.org>
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



On Thu, 14 Feb 2008, Linus Torvalds wrote:
> 
> It should insert the resource to the root resource (or a bridge resource), 
> or not at all. If somebody else has already inserted a real device 
> resource, we already know about it, and the PnP information is going to be 
> just making things worse.

Hmm. The approach I'd take is to always insert the thing into the root 
resource. If we do want to let PnP insert it into some lower-level bus, 
we'd need to have some way to distinguish "bus" from "device", and we 
don't.

So right now, how about just making PnP/ACPI just use

	root = (flags & IORESOURCE_MEM) ? iomem_resource : ioport_resource;
	request_resource(root, newresource);

which is what we do for the e820 map and the other special resources we 
know about (ie the magic resources we make up ourselves like video ram and 
our standard PCI/ISA resource lists like the <0x100 DMA/PIC/FPU IO ports 
etc)

		Linus
