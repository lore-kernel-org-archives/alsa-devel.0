From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] no reset_resume for driver snd-usb-audio for logitech
 headset H600
Date: Wed, 9 Oct 2013 10:33:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1310091028340.1371-100000@iolanthe.rowland.org>
References: <525516D5.6030200@ladisch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525516D5.6030200-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, baumber-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Oct 2013, Clemens Ladisch wrote:

> And why does the kernel whine about the lack of a callback that is
> documented as being optional?

It might indeed be a good idea to change that dev_warn() statement to 
dev_dbg().  On the other hand, without that message this particular 
failure might have been harder to diagnose.

Does anybody have strong feelings either way?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
