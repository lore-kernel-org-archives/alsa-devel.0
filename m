From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my
	ALSA intel8x0 sound card
Date: Thu, 14 Feb 2008 13:07:58 -0700
Message-ID: <200802141307.59120.bjorn.helgaas@hp.com>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
	<200802141151.40396.bjorn.helgaas@hp.com>
	<alpine.LFD.1.00.0802141141470.6110@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	by alsa0.perex.cz (Postfix) with ESMTP id D854424644
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 21:06:21 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0802141141470.6110@woody.linux-foundation.org>
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

On Thursday 14 February 2008 12:42:52 pm Linus Torvalds wrote:
> =

> On Thu, 14 Feb 2008, Bjorn Helgaas wrote:
> > =

> > Sorry for the delay.  I did work on this, but I don't see how this
> > can work.  pcibios_init() marks its reservations as not busy, so the
> > subsequent PNP request doesn't fail, even if it clashes.
> =

> It *shouldn't* fail.
> =

> Things should fail only when two different drivers have requested the sam=
e =

> region. NOT when something tells the system that a region _exists_.

The sound driver doesn't fail because two different drivers have
requested the same region; it fails because PNP told us a region
exists, and the sound region crosses the edge of the PNP region.

You wrote earlier that:

> On Tue, 5 Feb 2008, Bjorn Helgaas wrote:
> > > =A0- PnP/ACPI resource allocation *after* it, but before driver
> > > loading (which wll cause new resources to be allocated). This
> > > could be fs_initcall, or whatever (that's what things like
> > > "acpi_event_init" already do).
> >
> > If we put the PNP system driver here, we can easily do a quirk
> > that ignores PNP resources that overlap PCI resources.
>
> No, you don't need any quirks: you just do an "insert_resource()"
> and ignore the error return. If the (bogus) PnP resource clashes
> with the (correct) hardware PCI resource, the insert will simply
> fail. No quirks needed.

I thought you were suggesting here that the PNP system driver would
do an insert_resource(), and it would fail if it clashed with the
PCI resource.

Can you be more explicit about how you think I should fix this?

Bjorn
