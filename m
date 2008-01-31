From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
 ALSA intel8x0 sound card
Date: Thu, 31 Jan 2008 14:58:20 -0800
Message-ID: <20080131145820.44171af2.akpm@linux-foundation.org>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<479CCAAD.4080706@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	by alsa0.perex.cz (Postfix) with ESMTP id E51F6103904
	for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2008 23:58:27 +0100 (CET)
In-Reply-To: <479CCAAD.4080706@shaw.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: alsa-devel@alsa-project.org, avuton@gmail.com, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, shaohua.li@intel.com, torvalds@linux-foundation.org, trenn@suse.de, bjorn.helgaas@hp.com
List-Id: alsa-devel@alsa-project.org

On Sun, 27 Jan 2008 12:17:17 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> Avuton Olrich wrote:
> > With v2.6.24 my second ALSA sound device stopped working.
> > 
> > After bisection it says this was the offending commit.
> > 
> > a7839e960675b549f06209d18283d5cee2ce9261 is first bad commit
> > commit a7839e960675b549f06209d18283d5cee2ce9261
> > Author: Zhao Yakui <yakui.zhao@intel.com>
> > Date:   Wed Nov 28 16:21:21 2007 -0800
> > 
> >     PNP: increase the maximum number of resources
> > 
> >     On some systems the number of resources(IO,MEM) returnedy by PNP device is
> >     greater than the PNP constant, for example motherboard devices.  It brings
> >     that some resources can't be reserved and resource confilicts.  This will
> >     cause PCI resources are assigned wrongly in some systems, and cause hang.
> >     This is a regression since we deleted ACPI motherboard driver and use PNP
> >     system driver.
> > 
> >     [akpm@linux-foundation.org: fix text and coding-style a bit]
> >     Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> >     Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> >     Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> >     Cc: Thomas Renninger <trenn@suse.de>
> >     Cc: <stable@kernel.org>
> >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > 
> > The audio device is 00:1b.0 (see my lspci -vvv output), the other
> > audio device works fine.
> > 
> > http://avuton.googlepages.com/v2.6-before (dmesg revision before)
> > http://avuton.googlepages.com/v2.6-after (dmesg broken revision)
> > http://avuton.googlepages.com/lspci-vvv
> > http://avuton.googlepages.com/config (from the broken revision)
> > http://avuton.googlepages.com/iomem
> > http://avuton.googlepages.com/ioports

I don't think anything has happened yet on this?

> Here's why the driver fails to load:
> 
> [   31.133060] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, 
> low) -> IRQ 22
> [   31.133141] PCI: Unable to reserve mem region #1:4000@febf8000 for 
> device 0000:00:1b.0
> [   31.133197] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
> [   31.133244] HDA Intel: probe of 0000:00:1b.0 failed with error -16
> 
> The iomem location of the HDA controller conflicts with this reservation 
> by the BIOS:
> 
> [   22.906654] system 00:08: iomem range 0xfebfa000-0xfebfac00 has been 
> reserved
> 
> There was a patch floating around to ignore PnPACPI reservations which 
> conflict with PCI BARs, which appears to be what's happening in this 
> case. That patch originally worked for any board, but was later made 
> specific to a certain Supermicro motherboard which had the sata_nv 
> controller MMIO regions marked as reserved, preventing the driver from 
> loading. We may need a more general solution. See:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=313491

Thanks.  If we were to remove the supermicro-specificity, would this be a
sufficiently general solution?
