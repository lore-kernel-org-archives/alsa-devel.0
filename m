From: Florian Mickler <florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 7 Jul 2011 17:16:20 +0200
Message-ID: <CAGxyxNCjyoiAdniT9z7af31TETuO1u1RksTCXm6wnWR8oOaYPA@mail.gmail.com>
References: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA@mail.gmail.com>
	<201107071433.42081.oliver@neukum.org>
	<CACTFLAN=GOw8KLtvVBM6omvYzW3RBHggv-Kc2_2QVD--M-Jxkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACTFLAN=GOw8KLtvVBM6omvYzW3RBHggv-Kc2_2QVD--M-Jxkg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Hancock <hancockrwd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

[adding Robert Hancock]
see here for the whole thread: https://lkml.org/lkml/2011/7/7/150

2011/7/7 Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Thu, Jul 7, 2011 at 2:33 PM, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org> wro=
te:
>
>> PS: =A0Do you still see this if you enable 64bit DMA for EHCI?
>
> The problem is that I personally don't see that issue at all. I even
> installed 4GB of RAM to my development machine last year to be able t=
o
> reproduce this, but I can't, even when the memory allocator is under
> heavy load. The only people who see this effect are Pedro Ribeiro and
> William Light (both in Cc:), and both have been very helpful in tryin=
g
> patches and reporting back in detail. Which instructions could we
> probably give to these people to finally hunt this issue down?
>
> Daniel
>
>

Did someone affected already try the suggestions from Robert :
http://lkml.org/lkml/2010/4/10/66

That is checking if it really is a 64bit vs 32bit issue by booting
with mem=3D4096M ?


Regards,
=46lo
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
