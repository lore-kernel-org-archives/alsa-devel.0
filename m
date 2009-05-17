From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB Audio Class gadget
 driver
Date: Sun, 17 May 2009 17:28:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905171654500.20300-100000@netrider.rowland.org>
References: <200905171925.23956.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905171925.23956.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Cc: Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sun, 17 May 2009, Laurent Pinchart wrote:

> The applicable techniques require knowledge of both the audio clock and the 
> SOF clock in a common place. My driver has no access to the audio clock. All 
> it knows about is the SOF clock. 

This whole discussion is a little puzzling.

The Gadget API doesn't provide any way to tie the buffer contents of
Isochronous usb_request's to the frame number.  Here's what I mean:
Suppose you want to transfer a new audio data buffer every frame.  You
queue some requests, let's say

	R0 for frame F0
	R1 for frame F1
	R2 for frame F2
	etc.

But what happens if a communications error prevents R0 from being 
delivered during F0?  That's the sort of thing you expect to happen 
from time to time, and Isochronous streams are supposed to handle such 
errors by simply ignoring them.  So ideally you'd like to forget about 
the missing data, and go ahead with R1 during F1 and so on.

But as far as I can see, the Gadget API doesn't provide any way to do
this!  Depending on the implementation of the device controller driver,
you might end up transferring R0 during F1, R1 during F2, and so on.  
Everything would be misaligned from then on.  I don't see any solution
to this problem.

I'd like to answer your questions about synchronizing the USB audio 
stream with an ALSA audio stream, but since I don't know anything about 
how either audio protocol is supposed to work, I can't.  Suppose you 
were trying to write a normal program that accepted data from an ALSA 
microphone and sent it to an ALSA speaker; how would such a program 
synchronize the input and output streams?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
