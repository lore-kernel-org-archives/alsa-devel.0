From: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget driver
Date: Fri, 15 May 2009 11:36:52 +0200
Message-ID: <200905151136.52995.laurent.pinchart@skynet.be>
References: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net> <200905142325.24408.laurent.pinchart@skynet.be> <4A0D135C.7090806@ladisch.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A0D135C.7090806-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

thanks for your answer.

On Friday 15 May 2009 09:01:48 Clemens Ladisch wrote:
> Laurent Pinchart wrote:
> > To copy data from the ALSA ring buffer I need to know how much data is
> > available at that particular moment, in order to avoid buffer underruns.
>
> This is not how ALSA drivers are supposed to work.  The framework was
> designed for DMA devices that run asynchronously and just take data out
> of the ring buffer whenever they need them.  Your driver should work in
> the same way, i.e., you queue a packet of data when you need to queue
> it.

I know that ALSA is designed for asynchronous operation. This is fine for 
devices that provide an audio clock (all sound cards do), but leads to a few 
issues for devices that don't, like this one.

When streaming audio data from a file to USB, there is simply no audio clock 
in the system. When streaming audio data from a real audio device to USB, the 
audio clock comes from the real audio device and is beyond control of the USB 
Audio Class gadget driver.

I can see two ways around this.

1. Use an asynchronous isochronous endpoint to stream data. The USB Audio 
Class gadget driver will either have to be provided with a clock from 
userspace, or stream data as fast as it can, needing a way to check the amount 
of data present in the buffer (as explained in my previous e-mail).

2. Use a synchronous isochronous endpoint to stream data. The USB Audio Class 
gadget driver will derive its clock from the USB Start Of Frame clock and the 
sample rate, and send a fixed number of audio samples per packet. In this case 
the userspace application will have to resample audio data to match the source 
and sink rates. The issue with this solution is that I'm not sure if the USB 
stack provides the necessary information. I need to fill USB packets with 
audio data and queue them for transmission, but I don't know when they will be 
transmitted, making it difficult to adjust the amount of data per packet based 
on the sample rate.

As a side note, I'm not sure how difficult audio rate matching is, I suppose 
the userspace ALSA API provides enough information to match rates, but I'd 
appreciate if someone could confirm this (and possibly provide a few pointers 
to related documentation).

Best regards,

Laurent Pinchart


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
