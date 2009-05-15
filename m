From: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget driver
Date: Fri, 15 May 2009 17:52:57 +0200
Message-ID: <200905151752.58040.laurent.pinchart@skynet.be>
References: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net> <200905151136.52995.laurent.pinchart@skynet.be> <4A0D8532.4070104@ladisch.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A0D8532.4070104-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Friday 15 May 2009 17:07:30 Clemens Ladisch wrote:
> Laurent Pinchart wrote:
> > I know that ALSA is designed for asynchronous operation. This is fine for
> > devices that provide an audio clock (all sound cards do), but leads to a
> > few issues for devices that don't, like this one.
> >
> > When streaming audio data from a file to USB, there is simply no audio
> > clock in the system.
>
> In this case, you can use the USB frame clock as audio clock, i.e.,
> whenever one frame has been completed, you also submit audio data for
> one USB frame (one millisecond).
>
> This would be a synchronous endpoint.

Using a synchronous endpoint in this case sounds easy. I'll probably do that.

> > When streaming audio data from a real audio device to USB, the audio
> > clock comes from the real audio device and is beyond control of the
> > USB Audio Class gadget driver.
>
> In this case, you have _two_ clocks, the clock of the actual audio
> device, and the USB SOF clock.  What you need to know is the relative
> speed of these clocks, because that determines the number of samples per
> USB frame.

If I use a synchronous endpoint, isn't the number of samples per frame 
determined by the nominal sampling rate and the nominal SOF frequency ? With 
the SOF clock running at 1kHz, I expect a synchronous endpoint for a 16 bits 
mono 48kHz stream to deliver exactly 48 frames (96 bytes) per USB frame.

> > I can see two ways around this.
> >
> > 1. Use an asynchronous isochronous endpoint to stream data. The USB Audio
> > Class gadget driver will either have to be provided with a clock from
> > userspace, or stream data as fast as it can,
>
> The latter is not allowed by the USB specification; the data rate must
> change only gradually, i.e., the difference in successive frames must be
> no more than +/- one sample.

Thanks for pointing this out.

> > needing a way to check the amount of data present in the buffer (as
> > explained in my previous e-mail).
>
> The _current_ amount of valid data does not help because applications
> can write data irregularly.  You do not want to measure how fast the
> application writes data into your buffer, but the actual speed of the
> actual audio device.
>
> I'd guess that your gadget driver does not have access to the real audio
> device, so it is the application that must do the measurement.

That's right. The gadget driver doesn't care if data comes from a file or a 
real audio device.

> The ALSA API has no mechanism to tell the driver how fast to play, so it
> looks as if you have to write you own device driver.

If I use a synchronous endpoint I can solve the problem on the driver side. 
There would still be a problem on the application side, as the audio source 
clock will obviously not be synchronous with the USB SOF clock. The userspace 
application will request audio data at a nominal rate equal to the nominal 
sample frequency advertised on USB, and will need to perform rate matching 
between its source (real audio device) and sink (USB driver). Is that (at 
least relatively) easy to do with ALSA ? I suppose this is a common use case 
for all audio streaming applications such as internet radios, as in that case 
audio data streamed over the network will not be synchronous with the sound 
card audio clock and thus need to be resampled in the audio player before 
being sent to the sound card.

Best regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
