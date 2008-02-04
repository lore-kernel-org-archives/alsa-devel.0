From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
 ALSA intel8x0 sound card
Date: Mon, 4 Feb 2008 10:18:09 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802041014410.3034@hp.linux-foundation.org>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<47A2644B.4000905@shaw.ca>
	<alpine.LFD.1.00.0802011149160.3198@www.l.google.com>
	<200802041039.36100.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EE712448A
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 19:18:23 +0100 (CET)
In-Reply-To: <200802041039.36100.bjorn.helgaas@hp.com>
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
Cc: Robert Hancock <hancockr@shaw.ca>, alsa-devel@alsa-project.org, avuton@gmail.com, linux-kernel@vger.kernel.org, yakui.zhao@intel.com, shaohua.li@intel.com, Andrew Morton <akpm@linux-foundation.org>, trenn@suse.de
List-Id: alsa-devel@alsa-project.org



On Mon, 4 Feb 2008, Bjorn Helgaas wrote:
> 
> I think the problem here is that the PCI BAR is bigger and spans the
> region reported by ACPI:

Ok, then it doesn't help that it's not busy.

In that case, the only real fix is to simply do the ACPI reservations 
*after* PCI probing. Which is what it should have done to begin with.

> We can easily add more BIOSes to the PNP quirk.

No. Don't add quirks just because the basic ordering is shit.

> I really don't want to use the earlier quirk that scanned PCI devices
> from a PNP quirk.  I think that's just wrong because PNP (which
> conceptually includes ACPI) is what tells us about PCI root bridges.

So? Do the bridge listing separately from resource marking. Why tie the 
two together? They have absolutely *nothing* to do with each other.

The fact is, scanning devices should happen first. And AFTER the device 
tree is scanned, we can then safely add all the special resources that 
don't show up as normal devices.

			Linus
