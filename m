From: Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 14:39:04 -0600
Message-ID: <x2t51f3faa71004121339j67558281mc71bfd35d929e060@mail.gmail.com>
References: <s5hhbnncflj.wl%tiwai@suse.de>
	 <Pine.LNX.4.44L0.1004071452560.5760-100000@iolanthe.rowland.org>
	 <20100408003313.GE4365@kroah.com> <4BBE6E57.6020600@gmail.com>
	 <20100409165014.GC5184@xanatos>
	 <g2u51f3faa71004091638nc383aa0ei899777c869273a22@mail.gmail.com>
	 <20100410083453.GN30801@buzzloop.caiaq.de>
	 <p2o51f3faa71004101002xef38c6e4z71f5a61eed7f899e@mail.gmail.com>
	 <20100412185621.GA6101@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100412185621.GA6101@xanatos>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2010 at 12:56 PM, Sarah Sharp
<sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Sat, Apr 10, 2010 at 11:02:53AM -0600, Robert Hancock wrote:
>> On Sat, Apr 10, 2010 at 2:34 AM, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote=
:
>> > On Fri, Apr 09, 2010 at 05:38:13PM -0600, Robert Hancock wrote:
>> >> On Fri, Apr 9, 2010 at 10:50 AM, Sarah Sharp
>> >> <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> >> > What makes you think that? =A0I've seen URB buffers with 64-bit=
 DMA
>> >> > addresses. =A0I can tell when the debug polling loop runs and I=
 look at
>> >> > the DMA addresses the xHCI driver is feeding to the hardware:
>> >> >
>> >> > Dev 1 endpoint ring 0:
>> >> > xhci_hcd 0000:05:00.0: @71a49800 01000680 00080000 00000008 000=
00841
>> >> >
>> >> > So the TRB at address 71a49800 is pointing to a buffer at addre=
ss
>> >> > 0x0008000001000680.
>> >>
>> >> I'm not sure why the address would be that huge, unless it's not
>> >> actually a physical address, or there's some kind of remapping go=
ing
>> >> on?
>> >>
>> >> >
>> >> > If I'm setting a DMA mask wrong somewhere, or doing something e=
lse to
>> >> > limit the DMA to 32-bit, then please let me know.
>> >>
>> >> The DMA mask for the controller isn't being set anywhere (in the
>> >> version that's in Linus' current git anyway). In that case it'll
>> >> default to 32-bit and any DMA mappings above 4GB will need to be
>> >> remapped. The controller driver doesn't do the mapping itself but=
 the
>> >> USB core does, passing in the controller device as the one doing =
the
>> >> DMA, so if the controller's DMA mask is set to 32-bit then the bu=
ffers
>> >> passed in will get remapped/bounced accordingly.
>> >
>> > So if we're seeing physical addresses in the log above, and the xH=
CI
>> > driver does not explicitly allow the USB core to use addresses abo=
ve
>> > 4GB, why shouldn't the same thing be true as well for EHCI?
>> > (Which would then be exactly the case we're seeing)
>>
>> That is a bit suspicious, yes. With the DMA mask at default I don't
>> expect that should happen. Sarah, what kind of traffic was happening
>> when you saw that (bulk, isochronous, etc)?
>
> Ring 0 is the default control ring, so it must be control transfers.
> That's the first control transfer on the ring (and it didn't fill), s=
o
> it must have come from the USB core.
>
> I was running the USB mass storage driver, and the bulk endpoint ring=
s
> don't have the high 32-bits of the address set. =A0It mostly uses the
> scatter-gather interface, which calls usb_buffer_map_sg(), so that's =
not
> surprising.

Is this machine using an IOMMU or something which would be remapping
physical addresses? That address 0x0008000001000680 seems huge, I
don't see how it could even be a valid bus address otherwise..
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
