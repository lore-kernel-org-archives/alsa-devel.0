From: Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class
 gadget driver
Date: Fri, 15 May 2009 13:15:18 -0700
Message-ID: <20090515201519.7C347BCE6@ip-64-139-1-69.sjc.megapath.net>
References: <laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Message from Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
   of "Fri, 15 May 2009 17:52:57 +0200." <200905151752.58040.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


> If I use a synchronous endpoint, isn't the number of samples per frame
> determined by the nominal sampling rate and the nominal SOF frequency
> ? With  the SOF clock running at 1kHz, I expect a synchronous endpoint
> for a 16 bits  mono 48kHz stream to deliver exactly 48 frames (96
> bytes) per USB frame. 

Beware of the "exact" in there.  In real life, crystals have a tolerance.  
The USB clock will not match the audio clock perfectly.  What should be 1 kHz 
might be 1.00003 kHz or it might be 0.99997 kHz.

If the USB clock in this example is slightly fast, you will get occasional 
times when there are only 47 samples ready.  If it's slightly slow, you will 
occasionally have 49 samples.

That's slow/fast relative to the audio clock.  If the USB clock is 0.001% 
slow but the audio clock is 0.002% slow, then the USB clock will be fast for 
this discussion.


This is a common problem in communications.  There are several techniques to 
cope with it.

The simplest is to make the transport mechanism have a bit of extra bandwidth 
so you can always keep up.  It's just a matter of how often you use that 
extra bandwidth.  In this case, you would allocate enough bandwidth for 49 
samples and only use 48 most of the time.  An occasional USB frame would have 
47 or 49.


Another approach is to use big enough FIFO so you never get in trouble.  For 
this to work, you need a limit on the length of the data stream.  For 
example, suppose the longest song you want to send is 1000 seconds and both 
clocks are accurate to 50 ppm (parts per million).  The max difference in 
clocks is 100 ppm.  48 k samples/second * 1000 seconds is 48 million samples 
total.  100 ppm means that the worst difference would be 4800 samples.  So if 
the USB side waits until it gets 4800 samples before it starts forwarding 
data, it won't run out if the audio clock is worst-case slow and the USB 
clock is worst-case fast.  You also need buffering for another 4800 samples 
in case the clock differences are reversed.  This adds a delay to get started 
while you collect the 4800 samples.

You can just drop or duplicate a sample whenever the clocks slip.

You can derive both clocks from a common source.

You can lock one clock to the other with a PLL (Phase Locked Loop).

There are probably other approaches.


-- 
These are my opinions, not necessarily my employer's.  I hate spam.



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
