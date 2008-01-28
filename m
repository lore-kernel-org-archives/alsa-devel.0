From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my ALSA intel8x0
	sound card
Date: Mon, 28 Jan 2008 09:15:23 +0800
Message-ID: <1201482923.24645.1.camel@sli10-desk.sh.intel.com>
References: <3aa654a40801270640s59cfdcc4lfa3fb487e0d9b799@mail.gmail.com>
	 <alpine.LFD.1.00.0801280841440.4544@www.l.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757624AbYA1BPs@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.00.0801280841440.4544@www.l.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Avuton Olrich <avuton@gmail.com>, Zhao Yakui <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Thomas Renninger <trenn@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "Linux-Kernel," <linux-kernel@vger.kernel.org>, Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Mon, 2008-01-28 at 08:50 +1100, Linus Torvalds wrote:
> 
> On Sun, 27 Jan 2008, Avuton Olrich wrote:
> >
> > With v2.6.24 my second ALSA sound device stopped working.
> 
> Hmm. Why is PnP ACPI called before PCI probing? That seems to be the 
> problem here - we should *never* have any firmware allocation block known 
> hardware BARs, they should only be blocking new dynamic allocations.
> 
> Hmm. I wonder if the problem is that ACPIPnP marks the regions busy. That 
> would be wrong. They shouldn't be busy, they should just "exist".
> 
> A busy region will stop a "request_region()" (incorrect for this case - 
> thats' not what the PnP resurce allocation should be all about), but an 
> *existing* resource will just stop a new resource being dynamically 
> assigned to that address (not not stop a known resource from using it).
> 
> So maybe the ACPIPnP allocation is doen at the right moment, just doing 
> the wrong thing..
This is because the region is declaimed in motherboard device. That is
BIOS thinks the region is reserved for motherboard. Maybe we should
blacklist the system too.
