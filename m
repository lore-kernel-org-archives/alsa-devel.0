From: Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 07 Apr 2010 17:55:27 -0600
Message-ID: <4BBD1B6F.3000205@gmail.com>
References: <20100407090623.GN30807@buzzloop.caiaq.de> <Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1004071036060.1779-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 04/07/2010 08:59 AM, Alan Stern wrote:
> On Wed, 7 Apr 2010, Daniel Mack wrote:
>
>> Hi,
>>
>> I was pointed to https://bugzilla.kernel.org/show_bug.cgi?id=15580 by
>> Pedro Ribeiro, and unfortunately I'm pretty late in the game. I wasn't
>> aware of that thread until yesterday.
>>
>> While the report is quite confusing, the reason seams pretty clear to me
>> as I've been thru quite some time-demanding debugging of a very similar
>> issue on Mac OS X. But I'm not totally sure whether we really hit the
>> same issue here, so I'd like to have your opinions first.
>>
>> The problem is appearantly the way the transfer buffer is allocated in
>> the drivers. In the snd-usb-caiaq driver, I used kzalloc() to get memory
>> which works fine on 32bit systems. On x86_64, however, it seems that
>> kzalloc() hands out memory beyond the 32bit addressable boundary, which
>> the DMA controller of the 32bit PCI-connected EHCI controller is unable
>> to write to or read from. Am I correct on this conclusion?
>
> That seems like the right answer.  You are correct that an EHCI
> controller capable only of 32-bit memory accesses would not be able to
> use a buffer above the 4 GB line.
>
>> Depending on the condition of the memory management, things might work
>> or not, and especially right after a reboot, there's a better chance to
>> get lower memory.
>>
>> The fix is to use usb_buffer_alloc() for that purpose which ensures
>> memory that is suitable for DMA. And on x86_64, this also means that the
>> upper 32 bits of the address returned are all 0's.
>
> That is not a good fix.  usb_buffer_alloc() provides coherent memory,
> which is not what we want.  I believe the correct fix is to specify the
> GFP_DMA32 flag in the kzalloc() call.
>
> Of course, some EHCI hardware _is_ capable of using 64-bit addresses.
> But not all, and other controller types aren't.  In principle we could
> create a new allocation routine, which would take a pointer to the USB
> bus as an additional argument and use it to decide whether the memory
> needs to lie below 4 GB.  I'm not sure adding this extra complexity
> would be worthwhile.

AFAIK, the driver shouldn't have to worry about this at all. When the 
buffer gets DMA-mapped for the controller, the DMA mapping code should 
see that the device has a 32-bit DMA mask and either bounce or IOMMU-map 
the memory so that it appears below 4GB.

Not to say that something might not be sabotaging this somehow, but this 
complexity really shouldn't be needed.

>
>> If what I've stated is true, there are quite some more drivers affected
>> by this issue.
>
> Practically every USB driver, I should think.  And maybe a lot of
> non-USB drivers too.
>
>> I collected a list of places where similar fixes are
>> needed, and I can send patches if I get a thumbs-up.
>>
>> Pedro is currently testing a patch I sent out yesterday.
>
> Good work -- it certainly would have taken me a long time to figure
> this out.
>
> Alan Stern
>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
