From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
	ALSA intel8x0 sound card
Date: Thu, 14 Feb 2008 11:51:39 -0700
Message-ID: <200802141151.40396.bjorn.helgaas@hp.com>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<alpine.LFD.1.00.0802051013110.9374@woody.linux-foundation.org>
	<200802051312.47074.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g5t0008.atlanta.hp.com (g5t0008.atlanta.hp.com [15.192.0.45])
	by alsa0.perex.cz (Postfix) with ESMTP id CA2182451F
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 19:50:09 +0100 (CET)
In-Reply-To: <200802051312.47074.bjorn.helgaas@hp.com>
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

On Tuesday 05 February 2008 01:12:46 pm Bjorn Helgaas wrote:
> On Tuesday 05 February 2008 11:15:12 am Linus Torvalds wrote:
> > No, you don't need any quirks: you just do an "insert_resource()" and 
> > ignore the error return. If the (bogus) PnP resource clashes with the 
> > (correct) hardware PCI resource, the insert will simply fail. No quirks
> > needed.

> I'll play with your insert_resource() idea and see if I can figure
> something out.

Sorry for the delay.  I did work on this, but I don't see how this
can work.  pcibios_init() marks its reservations as not busy, so the
subsequent PNP request doesn't fail, even if it clashes.

The PNP system driver is an fs_initcall(), so it already happens after
pcibios_init():

  1) register ACPI PCI root bridge driver, which enumerates PCI
       devices behind the bridge
  2) pcibios_init() -> pcibios_resource_survey() -> request_resource()
  3) register PNP system driver -> request_region()
  4) register intel8x0 sound driver and reserve resources
       (conflict happens here)

We have reservations in this order:

  febf8000-febfbfff : 0000:00:1b.0 -- from pcibios_resource_survey (!busy)
  febfa000-febfac00 : pnp 00:08    -- from PNP system driver (!busy)
  febf8000-febfbfff : ICH HD audio -- fails because it spans the PNP region

The PNP reservation succeeds even though the PCI reservation has
already happened, so I don't see how we can do this without a
quirk that ignores the bogus PNP resources.

Bjorn
