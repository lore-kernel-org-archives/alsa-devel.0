From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] Some idea about usb audio gadget driver.
Date: Wed, 24 Sep 2008 09:15:00 +0200
Message-ID: <48D9E8F4.4060909@ladisch.de>
References: <386072610809230250w2e43c20ei89076a8db62c5044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <386072610809230250w2e43c20ei89076a8db62c5044-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Bryan Wu wrote:
>  - A new usb gadget driver which recognized by Linux/Windows PC as an
> USB audio card.
>  - There is an ALSA sound card on the same embedded device.
>  - The usb gadget driver receives audio data from host and send them
> to ALSA sound card to playback
> ...
>  - Is there any similar things on this planet?
>  - How about gmidi usb midi gadget driver?

gmidi does not access other sound cards; it makes the USB MIDI interface
available to userspace.

>  - How can I open/playback/record/close a ALSA sound card in kernel
> space not using alsalib in user space?

If you really want to do this in the kernel, have a look at the OSS
emulation (sound/core/oss/).


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
