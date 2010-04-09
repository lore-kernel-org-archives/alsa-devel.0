From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 12:01:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004091155570.1852-100000@iolanthe.rowland.org>
References: <m2n74fd948d1004081613n90408827s7c51ef572848fb1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m2n74fd948d1004081613n90408827s7c51ef572848fb1d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Apr 2010, Pedro Ribeiro wrote:

> On 8 April 2010 17:57, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 8 Apr 2010, Daniel Mack wrote:
> >
> >> > > AFAIK, the driver shouldn't have to worry about this at all. W=
hen the
> >> > > buffer gets DMA-mapped for the controller, the DMA mapping cod=
e should
> >> > > see that the device has a 32-bit DMA mask and either bounce or=
 IOMMU-map
> >> > > the memory so that it appears below 4GB.
> >> >
> >> > That's true. =A0It would of course be more efficient for the buf=
fer to be
> >> > allocated below 4 GB, but it should work okay either way. =A0Dan=
iel, do
> >> > you have any idea why it fails?
> >>
> >> No, and I can't do real tests as I lack a 64bit machine. I'll do s=
ome
> >> more investigation later today, but for now the only explanation I=
 have
> >> is that not the remapped DMA buffer is used eventually by the EHCI=
 code
> >> but the physical address of the original buffer.
> >>
> >> It would of course be best to fix the whole problem at this level,=
 if
> >> possible.
> >
> > It definitely needs to be fixed at this level. =A0But I still think=
 it's
> > appropriate to have new USB core functions for allocating and
> > deallocating I/O memory. =A0The additional price is small compared =
to
> > constantly bouncing the buffers.
> >
> > Pedro, in the hope of tracking down the problem, can you apply this
> > patch and see what output it produces in the system log when the
> > "interference" happens? =A0(Warning: It will produce quite a lot of
> > output whenever you send data to the audio device -- between 500 an=
d
> > 1000 lines per second.)

> Hi Alan,
>=20
> here is the output of the patch you sent me when the interference is =
triggered.
>=20
> The log is long, 1.3mb in size.

I don't see anything suspicious.  The transfer_buffer addresses repeat=20
every 32 URBs, and the DMA addresses cycle almost entirely uniformly=20
from 0x20000000 to 0x23ffffff in units of 0x2000 (there are a few gaps=20
where the interval is a little bigger).

Alan Stern
