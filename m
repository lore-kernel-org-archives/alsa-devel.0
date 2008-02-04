From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
	ALSA intel8x0 sound card
Date: Mon, 4 Feb 2008 13:41:36 -0700
Message-ID: <200802041341.37313.bjorn.helgaas@hp.com>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<200802041039.36100.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802041014410.3034@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 85E08243BD
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 21:40:27 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0802041014410.3034@hp.linux-foundation.org>
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
Cc: Robert Hancock <hancockr@shaw.ca>, alsa-devel@alsa-project.org, avuton@gmail.com, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, shaohua.li@intel.com, Andrew Morton <akpm@linux-foundation.org>, trenn@suse.de
List-Id: alsa-devel@alsa-project.org

On Monday 04 February 2008 11:18:09 am Linus Torvalds wrote:
> On Mon, 4 Feb 2008, Bjorn Helgaas wrote:
> > 
> > I think the problem here is that the PCI BAR is bigger and spans the
> > region reported by ACPI:
> 
> Ok, then it doesn't help that it's not busy.
> 
> In that case, the only real fix is to simply do the ACPI reservations 
> *after* PCI probing. Which is what it should have done to begin with.

I'm sure you're right, but I don't understand why yet.  Here's what
I think is happening; please correct me where I'm going wrong:

  1) enumerate PNP & ACPI devices
  2) initialize PNP & ACPI drivers
     2a) register ACPI PCI root bridge driver, which enumerates PCI
         devices behind the bridge
     2b) register PNP system driver and reserve resources (this is
         where the current quirk skips some reservations)
  3) initialize PCI drivers
     3a) register intel8x0 sound driver and reserve conflicting
         resources

> > I really don't want to use the earlier quirk that scanned PCI devices
> > from a PNP quirk.  I think that's just wrong because PNP (which
> > conceptually includes ACPI) is what tells us about PCI root bridges.
> 
> So? Do the bridge listing separately from resource marking. Why tie the 
> two together? They have absolutely *nothing* to do with each other.
> 
> The fact is, scanning devices should happen first. And AFTER the device 
> tree is scanned, we can then safely add all the special resources that 
> don't show up as normal devices.

I think you're suggesting that we should do 2a first, to enumerate all
PCI devices, and only later do 2b.  But I don't know how to accomplish
that cleanly.

It does happen in that order today, but only because the ACPI drivers
are registered before the PNP drivers.  I think that's an artificial
distinction, so I don't want to rely on it.  If the PCI bridge driver
became a PNP driver, we could use link ordering to make sure it still
came first, although that seems a little fragile to me.

Bjorn
