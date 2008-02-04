From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my ALSA intel8x0 sound card
Date: Mon, 4 Feb 2008 10:39:35 -0700
Message-ID: <200802041039.36100.bjorn.helgaas@hp.com>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no> <47A2644B.4000905@shaw.ca> <alpine.LFD.1.00.0802011149160.3198@www.l.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756914AbYBDRig@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.00.0802011149160.3198@www.l.google.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, avuton@gmail.com, yakui.zhao@intel.com, shaohua.li@intel.com, trenn@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 31 January 2008 05:50:13 pm Linus Torvalds wrote:
> On Thu, 31 Jan 2008, Robert Hancock wrote:
> > 
> > I think so. There was one objection that it introduced a dependency on pnpacpi
> > loading after PCI bus enumeration, though.
> > 
> > Linus also suggested that pnpacpi could be marking the resources as "present
> > but unused" so that drivers can request those regions but we still prevent
> > dynamically assigning resources into them.
> 
> I _think_ that's what ACPI used to do before switching over to the PnPACPI 
> thing, so I do think that "present but not reserved" approach is not just 
> the right one, but also the (historically) tested one.

The reservation happens in drivers/pnp/system.c, and it does mark the
region as "not busy."

I think the problem here is that the PCI BAR is bigger and spans the
region reported by ACPI:

[   22.906654] system 00:08: iomem range 0xfebfa000-0xfebfac00 has been reserved
[   31.133141] PCI: Unable to reserve mem region #1:4000@febf8000 for device 0000:00:1b.0

We can easily add more BIOSes to the PNP quirk.

I really don't want to use the earlier quirk that scanned PCI devices
from a PNP quirk.  I think that's just wrong because PNP (which
conceptually includes ACPI) is what tells us about PCI root bridges.

Bjorn
