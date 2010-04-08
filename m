From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Thu, 8 Apr 2010 18:17:15 +0100
Message-ID: <h2m74fd948d1004081017p6fe8652cpee34d79edf65508b@mail.gmail.com>
References: <20100408073041.GO30801@buzzloop.caiaq.de>
	 <Pine.LNX.4.44L0.1004081245330.1720-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1004081245330.1720-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Mack <daniel@caiaq.de>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 8 April 2010 17:57, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 8 Apr 2010, Daniel Mack wrote:
>
>> > > AFAIK, the driver shouldn't have to worry about this at all. Whe=
n the
>> > > buffer gets DMA-mapped for the controller, the DMA mapping code =
should
>> > > see that the device has a 32-bit DMA mask and either bounce or I=
OMMU-map
>> > > the memory so that it appears below 4GB.
>> >
>> > That's true. =A0It would of course be more efficient for the buffe=
r to be
>> > allocated below 4 GB, but it should work okay either way. =A0Danie=
l, do
>> > you have any idea why it fails?
>>
>> No, and I can't do real tests as I lack a 64bit machine. I'll do som=
e
>> more investigation later today, but for now the only explanation I h=
ave
>> is that not the remapped DMA buffer is used eventually by the EHCI c=
ode
>> but the physical address of the original buffer.
>>
>> It would of course be best to fix the whole problem at this level, i=
f
>> possible.
>
> It definitely needs to be fixed at this level. =A0But I still think i=
t's
> appropriate to have new USB core functions for allocating and
> deallocating I/O memory. =A0The additional price is small compared to
> constantly bouncing the buffers.
>
> Pedro, in the hope of tracking down the problem, can you apply this
> patch and see what output it produces in the system log when the
> "interference" happens? =A0(Warning: It will produce quite a lot of
> output whenever you send data to the audio device -- between 500 and
> 1000 lines per second.)
>
> Alan Stern
>
>
>
> Index: 2.6.33/drivers/usb/core/hcd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- 2.6.33.orig/drivers/usb/core/hcd.c
> +++ 2.6.33/drivers/usb/core/hcd.c
> @@ -1395,6 +1395,10 @@ int usb_hcd_submit_urb (struct urb *urb,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usbmon_urb_submit_error(&hcd->self, ur=
b, status);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto error;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 if (usb_endpoint_is_isoc_out(&urb->ep->desc))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&urb->dev->dev, "Iso xfer %p d=
ma %llx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 urb->tr=
ansfer_buffer,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long) urb->transfer_dma);
>
> =A0 =A0 =A0 =A0if (is_root_hub(urb->dev))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D rh_urb_enqueue(hcd, urb);
>
>

I'll do it tonight and send you the results tomorrow morning. Do you
want CONFIG_USB_DEBUG enabled or disabled?

Pedro
