From: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget driver
Date: Mon, 18 May 2009 16:47:41 +0200
Message-ID: <200905181647.41771.laurent.pinchart@skynet.be>
References: <20090515201519.7C347BCE6@ip-64-139-1-69.sjc.megapath.net> <200905171925.23956.laurent.pinchart@skynet.be> <4A111EBC.2010606@ladisch.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A111EBC.2010606-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

On Monday 18 May 2009 10:39:24 Clemens Ladisch wrote:
> Laurent Pinchart wrote:
> > The applicable techniques require knowledge of both the audio clock and
> > the SOF clock in a common place. My driver has no access to the audio
> > clock. All it knows about is the SOF clock.
> >
> > There are only two options I can think of.
> >
> > The first one is to use an asynchronous endpoint and sent the occasional
> > smaller or bigger packet (or duplicate/drop one sample). As the driver
> > can't access the audio clock it needs to derive the information from the
> > amount of data present in the ALSA ring buffer. To be honest I'm not sure
> > if that will be possible at all, as the application will write data at a
> > non-constant rate.
>
> The ALSA API assumes that the device controls the audio clock and that
> the application derives its own speed from that, not the other way
> round.

That's a sensible requirement for a sound card. I now know that my use case is 
out of ALSA's bounds :-)

> > The second one, which sounds easier, at least on the driver side, is to
> > use a synchronous endpoint with a fixed packet size. The application will
> > perform rate matching (duplicating/dropping a sample or resampling the
> > audio stream) using the audio clock and the SOF clock. What I'm still
> > unsure about is how the application can access the audio clock and the
> > SOF clock through ALSA, but I suppose that's possible.
>
> The ALSA API doesn't give you access to the SOF clock.

Does the ALSA API give applications access to the audio clock ? As Alan Stern 
mention in his e-mail, does ALSA allow an application to resample audio from 
an ALSA source (microphone on sound card 1) before sending it to an ALSA sink 
(speaker on sound card 2) ?

> What you want to do is not possible (or impracticably hard) with the
> ALSA API; I strongly suggest that you define your own API for your
> audio gadget driver so that SOF clock information is made available to
> the application, and that packet sizes can be directly controlled by the
> application.

I'll have a look at that. ALSA was appealing because of the existing user base 
and its ability to transfer audio data from/to userspace applications. I knew 
it hasn't been designed with my use case in mind, so I didn't close to door to 
using a custom API, but I still wanted to give it a try.

Best regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
