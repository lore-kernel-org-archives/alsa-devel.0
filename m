From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget
 driver
Date: Fri, 15 May 2009 17:07:30 +0200
Message-ID: <4A0D8532.4070104@ladisch.de>
References: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net> <200905142325.24408.laurent.pinchart@skynet.be> <4A0D135C.7090806@ladisch.de> <200905151136.52995.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905151136.52995.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Laurent Pinchart wrote:
> I know that ALSA is designed for asynchronous operation. This is fine for
> devices that provide an audio clock (all sound cards do), but leads to a few
> issues for devices that don't, like this one.
> 
> When streaming audio data from a file to USB, there is simply no audio clock
> in the system.

In this case, you can use the USB frame clock as audio clock, i.e.,
whenever one frame has been completed, you also submit audio data for
one USB frame (one millisecond).

This would be a synchronous endpoint.

> When streaming audio data from a real audio device to USB, the audio
> clock comes from the real audio device and is beyond control of the
> USB Audio Class gadget driver.

In this case, you have _two_ clocks, the clock of the actual audio
device, and the USB SOF clock.  What you need to know is the relative
speed of these clocks, because that determines the number of samples per
USB frame.

> I can see two ways around this.
> 
> 1. Use an asynchronous isochronous endpoint to stream data. The USB Audio 
> Class gadget driver will either have to be provided with a clock from 
> userspace, or stream data as fast as it can,

The latter is not allowed by the USB specification; the data rate must
change only gradually, i.e., the difference in successive frames must be
no more than +/- one sample.

> needing a way to check the amount of data present in the buffer (as
> explained in my previous e-mail).

The _current_ amount of valid data does not help because applications
can write data irregularly.  You do not want to measure how fast the
application writes data into your buffer, but the actual speed of the
actual audio device.

I'd guess that your gadget driver does not have access to the real audio
device, so it is the application that must do the measurement.


The ALSA API has no mechanism to tell the driver how fast to play, so it
looks as if you have to write you own device driver.


Best regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
