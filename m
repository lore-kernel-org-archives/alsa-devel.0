From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [RFC] ALSA vs. dedicated char device for a USB	Audio
 Class gadget driver
Date: Fri, 15 May 2009 09:01:48 +0200
Message-ID: <4A0D135C.7090806@ladisch.de>
References: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net>	<200905142258.42935.laurent.pinchart@skynet.be>	<4a5ff6bc0905141412t5ab4f0f5x6c50b4e38af0790f@mail.gmail.com> <200905142325.24408.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905142325.24408.laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
Cc: Steve Calfee <stevecalfee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hal Murray <hmurray-8cQiHa/C+6Go9G/jEpaUCQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Laurent Pinchart wrote:
> To copy data from the ALSA ring buffer I need to know how much data is 
> available at that particular moment, in order to avoid buffer underruns.

This is not how ALSA drivers are supposed to work.  The framework was
designed for DMA devices that run asynchronously and just take data out
of the ring buffer whenever they need them.  Your driver should work in
the same way, i.e., you queue a packet of data when you need to queue
it.


Best regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
