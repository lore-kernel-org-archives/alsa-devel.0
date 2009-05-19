From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget
 driver
Date: Tue, 19 May 2009 13:01:07 +0200
Message-ID: <4A129173.6090205@ladisch.de>
References: <20090515201519.7C347BCE6@ip-64-139-1-69.sjc.megapath.net> <200905171925.23956.laurent.pinchart@skynet.be> <4A111EBC.2010606@ladisch.de> <200905181647.41771.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905181647.41771.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Laurent Pinchart wrote:
> On Monday 18 May 2009 10:39:24 Clemens Ladisch wrote:
> > The ALSA API doesn't give you access to the SOF clock.
> 
> Does the ALSA API give applications access to the audio clock ?

ALSA wakes up the application (if it's blocked) whenever a sound card
interrupt happens, i.e., at period boundaries.  At all times, you can
get the current sample position by calling snd_pcm_delay().

> As Alan Stern mention in his e-mail, does ALSA allow an application to
> resample audio from an ALSA source (microphone on sound card 1) before
> sending it to an ALSA sink (speaker on sound card 2) ?

It is possible, if the application monitors the speed of both devices.


Best regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
