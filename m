From: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget driver
Date: Thu, 14 May 2009 23:25:24 +0200
Message-ID: <200905142325.24408.laurent.pinchart@skynet.be>
References: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net> <200905142258.42935.laurent.pinchart@skynet.be> <4a5ff6bc0905141412t5ab4f0f5x6c50b4e38af0790f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4a5ff6bc0905141412t5ab4f0f5x6c50b4e38af0790f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Steve,

On Thursday 14 May 2009 23:12:41 Steve Calfee wrote:
> On Thu, May 14, 2009 at 1:58 PM, Laurent Pinchart
> > Hi Hal,
> >
> > first of all, thanks for your answer.
> >
> > On Thursday 14 May 2009 20:18:07 Hal Murray wrote:
> > > > I need an API to transfer audio data from userspace to kernelspace. I
> > > > initially thought about ALSA, but it turns out some assumptions made
> > > > by ALSA  are not fulfilled by my system. One of the most serious
> > > > problems is that the  UAC gadget driver doesn't have any audio clock.
> > > > The only hardware clock  available is the USB device controller
> > > > interrupts generated at the USB  transfer rate, and those are much
> > > > faster than the audio sample rate. This will  cause buffer underruns
> > > > that I need to handle.
> > >
> > > You don't need a clock.  The data will come to you at the right rate.
> > >  All you need to do is pass it on when you have enough to fill up a
> > > buffer.  The buffer size is fixed.  It's part of the spec for the device
> > > you are emulating.
> >
> > I'm not emulating any device. The buffer size is up to me, and I actually
> > have a fixed number of small buffers, but that shouldn't make a
> > difference.
>
> Hi Laurent,
>
> The problems might be clearer to you if you do the output side first.
> You have to define one or more alt/interfaces with isoc OUT sizes to
> match the sample rate. Some rates are straight forward and don't care
> much about the buffer/packet sizes like 45,000 HZ. However the 44100
> hz rate (and 22050 and 11025) made popular by CDs is interesting
> because it doesn't divide by 1000, the FS frame rate. So a driver must
> output 9 packets of 44 samples (times the number of bytes in sample
> width times stereo/mono) and 1 of 45 samples. Typically USB chips
> determine the sample rate by the interface and the number of bytes
> coming per frame.

The USB side is already implemented. I need an isochronous endpoint with a 
packet size just a bit bigger than what would be required by the sample rate. 
The amount of data per packet will vary (some might even be empty), but that 
won't be a problem.

I now need to fill the packets with data. When a packet has been successfully 
transferred on USB the USB device controller will notify me with an interrupt. 
I then have to copy audio data from the ALSA ring buffer to the USB request 
buffer and queue the request for transmission (a USB request, in the USB 
gadget device driver terminology, is a data structure that describes a USB 
transfer).

To copy data from the ALSA ring buffer I need to know how much data is 
available at that particular moment, in order to avoid buffer underruns. I'm 
still not sure how to do that.

> This is a challenging project, compounded by the audio usb class spec.
> In my opinion audio is the worst, hardest to understand spec. Second
> is the HID-PID spec.

Challenges are usually interesting :-) With a little luck part of the 
complexity will be handle outside the UAC gadget driver, either on the host 
side or by the userspace application on the device side.

Best regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
