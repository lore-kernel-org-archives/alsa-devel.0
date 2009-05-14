From: Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class
 gadget driver
Date: Thu, 14 May 2009 11:18:07 -0700
Message-ID: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net>
References: <laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Message from Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
   of "Thu, 14 May 2009 15:45:01 +0200." <200905141545.01798.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


> I need an API to transfer audio data from userspace to kernelspace. I
> initially thought about ALSA, but it turns out some assumptions made
> by ALSA  are not fulfilled by my system. One of the most serious
> problems is that the  UAC gadget driver doesn't have any audio clock.
> The only hardware clock  available is the USB device controller
> interrupts generated at the USB  transfer rate, and those are much
> faster than the audio sample rate. This will  cause buffer underruns
> that I need to handle. 

You don't need a clock.  The data will come to you at the right rate.  All 
you need to do is pass it on when you have enough to fill up a buffer.  The 
buffer size is fixed.  It's part of the spec for the device you are emulating.

Assume that you get samples one at a time each time the source clock ticked.  
The normal state of your system would be to have a buffer that is partially 
filled.  When a new sample fills up the buffer, you would move it from the 
input side to the ready-for-USB queue and setup a new buffer for future input 
samples.

Soon the USB side will read the queued buffer, you free that buffer and you 
are now back to the normal state of collecting input data.

You are in trouble if that doesn't happen before the nest buffer is ready, 
that is the ready-for-USB queue should normally be empty.  If you can't keep 
it empty it will eventually overflow.  Short chunks of time where the queue 
builds up might be OK.  For debugging, you should probably count them.

Now consider the case where you get several samples at a time rather than 
one.  Logically, copy them over one at a time.  That turns into a burst of 
source clocks, but the average will work out right.  Your ready-for-USB queue 
should still be empty most of the time.

If that doesn't make sense, I'll try again.  Consider something like audio 
over a network.  There is no audio clock on the network.  The receiver can 
derive the source clock by watching the data stream.





-- 
These are my opinions, not necessarily my employer's.  I hate spam.



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
