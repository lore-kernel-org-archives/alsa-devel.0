From: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget driver
Date: Sun, 17 May 2009 19:25:23 +0200
Message-ID: <200905171925.23956.laurent.pinchart@skynet.be>
References: <20090515201519.7C347BCE6@ip-64-139-1-69.sjc.megapath.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090515201519.7C347BCE6-1EH7ZSm6cX1tFMQ1DeeEjrzXk6sypdOaHzxsA6J8rrk@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Hal,

On Friday 15 May 2009 22:15:18 Hal Murray wrote:
> > If I use a synchronous endpoint, isn't the number of samples per frame
> > determined by the nominal sampling rate and the nominal SOF frequency
> > ? With  the SOF clock running at 1kHz, I expect a synchronous endpoint
> > for a 16 bits  mono 48kHz stream to deliver exactly 48 frames (96
> > bytes) per USB frame.
>
> Beware of the "exact" in there.  In real life, crystals have a tolerance.
> The USB clock will not match the audio clock perfectly.  What should be 1
> kHz might be 1.00003 kHz or it might be 0.99997 kHz.
>
> If the USB clock in this example is slightly fast, you will get occasional
> times when there are only 47 samples ready.  If it's slightly slow, you
> will occasionally have 49 samples.
>
> That's slow/fast relative to the audio clock.  If the USB clock is 0.001%
> slow but the audio clock is 0.002% slow, then the USB clock will be fast
> for this discussion.

Except that the SOF clock *is* the reference clock. It will be slower or 
faster than the audio clock, and the userspace application will have to 
perform sample rate matching so that packets will be exactly 48 bytes long.

> This is a common problem in communications.  There are several techniques
> to cope with it.
>
> The simplest is to make the transport mechanism have a bit of extra
> bandwidth so you can always keep up.  It's just a matter of how often you
> use that extra bandwidth.  In this case, you would allocate enough
> bandwidth for 49 samples and only use 48 most of the time.  An occasional
> USB frame would have 47 or 49.

That's what would happen with an asynchronous endpoint. The hard bit is to 
find out when to send that occasional packet, as the driver doesn't have 
access to the audio clock.

> Another approach is to use big enough FIFO so you never get in trouble. 
> For this to work, you need a limit on the length of the data stream.  For
> example, suppose the longest song you want to send is 1000 seconds and both
> clocks are accurate to 50 ppm (parts per million).  The max difference in
> clocks is 100 ppm.  48 k samples/second * 1000 seconds is 48 million
> samples total.  100 ppm means that the worst difference would be 4800
> samples.  So if the USB side waits until it gets 4800 samples before it
> starts forwarding data, it won't run out if the audio clock is worst-case
> slow and the USB clock is worst-case fast.  You also need buffering for
> another 4800 samples in case the clock differences are reversed.  This adds
> a delay to get started while you collect the 4800 samples.

That won't work here, the stream can last forever (well, not quite, but still 
a long time).

> You can just drop or duplicate a sample whenever the clocks slip.

> You can derive both clocks from a common source.
>
> You can lock one clock to the other with a PLL (Phase Locked Loop).

The SOF clock is driven by the USB host, and the audio clock is driven by the 
audio codec. I can't lock one to another or derive both of them from a common 
source. There could even be no audio clock at all if I stream audio data from 
a file.

> There are probably other approaches.

The applicable techniques require knowledge of both the audio clock and the 
SOF clock in a common place. My driver has no access to the audio clock. All 
it knows about is the SOF clock. 

There are only two options I can think of.

The first one is to use an asynchronous endpoint and sent the occasional 
smaller or bigger packet (or duplicate/drop one sample). As the driver can't 
access the audio clock it needs to derive the information from the amount of 
data present in the ALSA ring buffer. To be honest I'm not sure if that will 
be possible at all, as the application will write data at a non-constant rate.

The second one, which sounds easier, at least on the driver side, is to use a 
synchronous endpoint with a fixed packet size. The application will perform 
rate matching (duplicating/dropping a sample or resampling the audio stream) 
using the audio clock and the SOF clock. What I'm still unsure about is how 
the application can access the audio clock and the SOF clock through ALSA, but 
I suppose that's possible.

Best regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
