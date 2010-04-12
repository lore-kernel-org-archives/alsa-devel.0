From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [alsa-devel] USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 13:58:37 -0700
Message-ID: <20100412205837.GA18665@xanatos>
References: <s5hhbnncflj.wl%tiwai@suse.de>
 <Pine.LNX.4.44L0.1004071452560.5760-100000@iolanthe.rowland.org>
 <20100408003313.GE4365@kroah.com>
 <4BBE6E57.6020600@gmail.com>
 <20100409165014.GC5184@xanatos>
 <g2u51f3faa71004091638nc383aa0ei899777c869273a22@mail.gmail.com>
 <20100410083453.GN30801@buzzloop.caiaq.de>
 <p2o51f3faa71004101002xef38c6e4z71f5a61eed7f899e@mail.gmail.com>
 <20100412185621.GA6101@xanatos>
 <x2t51f3faa71004121339j67558281mc71bfd35d929e060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <x2t51f3faa71004121339j67558281mc71bfd35d929e060@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, alsa-devel@alsa-project.org, Greg KH <gregkh@suse.de>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2010 at 02:39:04PM -0600, Robert Hancock wrote:
> On Mon, Apr 12, 2010 at 12:56 PM, Sarah Sharp
> <sarah.a.sharp@linux.intel.com> wrote:
> > On Sat, Apr 10, 2010 at 11:02:53AM -0600, Robert Hancock wrote:
> >> On Sat, Apr 10, 2010 at 2:34 AM, Daniel Mack <daniel@caiaq.de> wro=
te:
> >> > On Fri, Apr 09, 2010 at 05:38:13PM -0600, Robert Hancock wrote:
> >> >> On Fri, Apr 9, 2010 at 10:50 AM, Sarah Sharp
> >> >> <sarah.a.sharp@linux.intel.com> wrote:
> >> >> > What makes you think that? =A0I've seen URB buffers with 64-b=
it DMA
> >> >> > addresses. =A0I can tell when the debug polling loop runs and=
 I look at
> >> >> > the DMA addresses the xHCI driver is feeding to the hardware:
> >> >> >
> >> >> > Dev 1 endpoint ring 0:
> >> >> > xhci_hcd 0000:05:00.0: @71a49800 01000680 00080000 00000008 0=
0000841
> >> >> >
> >> >> > So the TRB at address 71a49800 is pointing to a buffer at add=
ress
> >> >> > 0x0008000001000680.
> >> >>
> >> >> I'm not sure why the address would be that huge, unless it's no=
t
> >> >> actually a physical address, or there's some kind of remapping =
going
> >> >> on?
> >> >>
> >> >> >
> >> >> > If I'm setting a DMA mask wrong somewhere, or doing something=
 else to
> >> >> > limit the DMA to 32-bit, then please let me know.
> >> >>
> >> >> The DMA mask for the controller isn't being set anywhere (in th=
e
> >> >> version that's in Linus' current git anyway). In that case it'l=
l
> >> >> default to 32-bit and any DMA mappings above 4GB will need to b=
e
> >> >> remapped. The controller driver doesn't do the mapping itself b=
ut the
> >> >> USB core does, passing in the controller device as the one doin=
g the
> >> >> DMA, so if the controller's DMA mask is set to 32-bit then the =
buffers
> >> >> passed in will get remapped/bounced accordingly.
> >> >
> >> > So if we're seeing physical addresses in the log above, and the =
xHCI
> >> > driver does not explicitly allow the USB core to use addresses a=
bove
> >> > 4GB, why shouldn't the same thing be true as well for EHCI?
> >> > (Which would then be exactly the case we're seeing)
> >>
> >> That is a bit suspicious, yes. With the DMA mask at default I don'=
t
> >> expect that should happen. Sarah, what kind of traffic was happeni=
ng
> >> when you saw that (bulk, isochronous, etc)?
> >
> > Ring 0 is the default control ring, so it must be control transfers=
=2E
> > That's the first control transfer on the ring (and it didn't fill),=
 so
> > it must have come from the USB core.
> >
> > I was running the USB mass storage driver, and the bulk endpoint ri=
ngs
> > don't have the high 32-bits of the address set. =A0It mostly uses t=
he
> > scatter-gather interface, which calls usb_buffer_map_sg(), so that'=
s not
> > surprising.
>=20
> Is this machine using an IOMMU or something which would be remapping
> physical addresses? That address 0x0008000001000680 seems huge, I
> don't see how it could even be a valid bus address otherwise..

Oh, shoot, nevermind.  That TRB has a slightly different format, where
the setup data for the control transfer is substituted for the DMA
buffer address.  I'll have to look through my logs to see if there's an=
y
real 64-bit DMA addresses in there, and fix xHCI's DMA mask.

Sarah Sharp
