From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 17:21:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004091718040.1852-100000@iolanthe.rowland.org>
References: <201004092251.51739.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201004092251.51739.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Apr 2010, Oliver Neukum wrote:

> Am Freitag, 9. April 2010 17:15:43 schrieb Alan Stern:
> > > > Then usb_submit_urb(urb[i]) will copy the appropriate four bytes to a
> > > > bounce buffer and map the bounce buffer.  Accesses to the other parts
> > > > of xbuf won't violate the cacheline rules, because xbuf isn't mapped
> > > > for DMA -- only the bounce buffer is.  When urb[i] completes, the
> > > > bounce buffer contents will be copied back to the original four bytes
> > > > in xbuf.  Again, there is no violation of cacheline rules.
> > > 
> > > I think you are assuming that either every or no part of the buffer is mapped
> > > for DMA in place. I don't think you can assume that.
> > 
> > Yes I can, because the code that makes this decision is part of 
> > usbcore and it is under m
> 
> It seems to me that in usbcore you can positively know that a buffer
> will be mapped. However if the mapping is not done in usbcore you
> cannot know what the HCD driver will do to a buffer, in particular
> you don't know whether it will be processed by PIO or mapped for
> DMA.

The mapping is always done either by usb_buffer_alloc() or by 
map_urb_for_dma().  Both functions are in usbcore.

> Maybe I understand this wrongly. Which code exactly were you refering to?

Search for usages of "syncbuf" and "sync_dma" in sound/usb/usbaudio.c.

Alan Stern
