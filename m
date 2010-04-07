From: Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 07 Apr 2010 17:59:26 -0600
Message-ID: <4BBD1C5E.4050906@gmail.com>
References: <s5hhbnncflj.wl%tiwai@suse.de> <Pine.LNX.4.44L0.1004071452560.5760-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1004071452560.5760-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 04/07/2010 01:13 PM, Alan Stern wrote:
> On Wed, 7 Apr 2010, Takashi Iwai wrote:
>
>>> Ok, I'll write some dummies for usb_malloc() and usb_zalloc() which
>>> will just call kmalloc() with GFP_DMA32 for now.
>>
>> Can't we provide only zalloc() variant?  Zero'ing doesn't cost much,
>> and the buffer allocation shouldn't be called too often.
>
> Linus specifically requested us to avoid using kzalloc in usbfs.  I
> can't find the message in the email archives, but Greg KH should be
> able to confirm it.
>
> As long as we're imitating kmalloc for one use, we might as well make
> it available to all.
>
>>> And while at it,
>>> usb_alloc_buffer() will be renamed to usb_alloc_consistent().
>>
>> Most of recent functions are named with "coherent".
>
> Yes, the terminology got a little confused between the PCI and DMA
> realms.  I agree, "coherent" is better.
>
> BTW, although some EHCI controllers may support 64-bit DMA, the driver
> contains this:
>
> 	if (HCC_64BIT_ADDR(hcc_params)) {
> 		ehci_writel(ehci, 0,&ehci->regs->segment);
> #if 0
> // this is deeply broken on almost all architectures
> 		if (!dma_set_mask(hcd->self.controller, DMA_BIT_MASK(64)))
> 			ehci_info(ehci, "enabled 64bit DMA\n");
> #endif
> 	}
>
> I don't know if the comment is still true, but until the "#if 0" is
> removed, ehci-hcd won't make use of 64-bit DMA.

The comment is wrong (or at least outdated or based on an incorrect 
assumption), but you're right, currently 64-bit DMA is not used on any 
EHCI controllers. It could be, but it sounded like the consensus was it 
wasn't worth the risk. Apparently Windows 7 started using it, and then 
had to put out a patch because some NVidia EHCI controllers indicated 
64-bit support but it didn't work properly. So you'd have to blacklist 
those controllers, at least.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
