From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
 ALSA intel8x0 sound card
Date: Thu, 14 Feb 2008 13:37:15 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802141323130.6110@woody.linux-foundation.org>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<200802141307.59120.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802141226010.6110@woody.linux-foundation.org>
	<200802141401.24723.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	by alsa0.perex.cz (Postfix) with ESMTP id ABC7224668
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 22:37:19 +0100 (CET)
In-Reply-To: <200802141401.24723.bjorn.helgaas@hp.com>
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
> 
> That means the PNP system driver has to be registered after the PCI
> driver.

After the PCI *subsystem*

Here's the actual problem:

[   31.133141] PCI: Unable to reserve mem region #1:4000@febf8000 for device 0000:00:1b.0

and here is what the resource tree *should* look like:

	febf8000-febfbfff : 0000:00:1b.0
	  febf8000-febfbfff : ICH HD audio

that's with a working sound driver.

Notice how there is *two* resources there: there's the PCI bus resource 
itself, the one called 0000:00:1b.0 (which was active at boot), and there 
is the "driver resource" that nests inside of it ("ICH HD audio").

The PCI bus resource is created and inserted into the resource when the 
PCI bus discovery happens - long before the driver comes along at all.

And the problem is this ABSOLUTE CRAP that happened much earlier:

[   22.906610] system 00:08: iomem range 0xfebfe000-0xfebfec00 has been reserved
[   22.906654] system 00:08: iomem range 0xfebfa000-0xfebfac00 has been reserved

which happens
 (a) before the PCI bus probing
 (b) despite the fact that the PCI bus probing already found something at 
     that address, and PnP shouldn't pollute the *correct* resources.

and the fix is to move that crap PnP to _after_ the PCI bus has been 
probed, and make sure that if the PnP resource clashes with the known good 
ones, then PnP gets the h*ll out and doesn't insert it at all.

See?

> We can't guarantee that, especially if the sound driver is
> a module.

This has *nothing* to do with the sound driver.

This has everything to do with the fact that the PnP layer is  a piece of 
crap and overrides/messes with the *correct* resources that we found 
during PCI bus probing.

Is that really so hard to understand?

So here is (for the *fifth* time) what PnP should do:

 - only try to insert its resources *after* the PCI bus probing has 
   happened
 - and if that fails, LET THE CRAP FAIL instead of making the *good* code 
   fail!

Ok?

			Linus
