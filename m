From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 7 Jul 2011 14:29:15 +0200
Message-ID: <CACTFLAPN=mye5fhyPwv4QPU3d_inLNrT4poTeZoGm1NqoW0CmQ@mail.gmail.com>
References: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA@mail.gmail.com>
	<4E15A308.7080502@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E15A308.7080502-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, florian-sVu6HhrpSfRAfugRpC6u6w@public.gmane.org, pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, William Light <wrl-NbOgcKT07AGsTnJN9+BGXg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 7, 2011 at 2:14 PM, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org> wrote:
> Daniel Mack wrote:
>> I have to revisit an issue we've discussed in length around a year ago
>> and which still remains unsolved. I've been getting feedback from more
>> users of my driver snd-usb-caiaq who report the issue found in bug
>> #15580 in the kernel bugzilla:
>> https://bugzilla.kernel.org/show_bug.cgi?id=15580
>>
>> Let me quickly summarize the current state of this issue as I see it.
>>
>> The problem seems to be that certain 64bit chipsets can't deal with
>> the fact that an URB's transfer_buffer is allocated with
>> kmalloc(GFP_KERNEL). The effect is that kmalloc() is very likely to
>> hand out memory which is not addressable by devices that are connected
>> via 32bit PCI busses, such as EHCI controllers. In theory, DMA bounce
>> buffers should be installed in such cases, or the IOMMU would be in
>> charge to re-map these buffers to suitable locations, but for at least
>> two people who have reported the issue, this obviously fails.
>
> The problem is that snd-usb-caiaq modifies the URB buffer after
> submission.

Hmm, no, it doesn't. I know I stated that once, but I confused the
implementation of the Linux driver with the approach I chose for the
Mac OS X driver code. Sorry about that.

The driver simply copies audio material to its output URB and calls
usb_submit_urb(). The URB buffer is not touched after that call.


Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
