From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] USB transfer_buffer allocations on 64bit systems
Date: Fri, 7 May 2010 10:45:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005071042410.1804-100000@iolanthe.rowland.org>
References: <20100507115810.GN30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100507115810.GN30801-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 7 May 2010, Daniel Mack wrote:

> > Or to be precise it could be done with coherent memory, but you'd risk
> > transfering partially updated buffers, as you cannot know when DMA will
> > be done and we don't guarantee that DMA will be done right as we transfer.
> 
> If the memory is coherent, it should be possible. And if buffers are
> only partially updated, the audio buffer scheduling is too tight. IOW,
> the configured buffer size of audio clients in userspace is too small.

Even with coherent memory, this dynamic updating of buffer contents 
isn't a good idea.  There's no guarantee that coherent memory won't be 
implemented using a bounce buffer during URB submission.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
