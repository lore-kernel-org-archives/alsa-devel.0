From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Thu, 8 Apr 2010 18:20:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004081817230.21642-100000@iolanthe.rowland.org>
References: <201004082324.31481.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201004082324.31481.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 8 Apr 2010, Oliver Neukum wrote:

> Am Donnerstag, 8. April 2010 18:59:38 schrieb Alan Stern:
> > On Thu, 8 Apr 2010, Oliver Neukum wrote:
> > 
> > > Am Mittwoch, 7. April 2010 17:46:17 schrieb Alan Stern:
> > > > Or alternatively, instead of allocating regular memory the routine
> > > > could simply fail.  Then the caller would be responsible for checking
> > > > and using regular memory instead of dma-consistent memory.  Of course,
> > > > that would put an even larger burden on the caller than just forcing it
> > > > to keep track of what flag to use.
> > > 
> > > Then it would be sensible to pass it a filled URB, modify it or return
> > > an error code.
> > 
> > That would work, but it doesn't match the way existing drivers use the
> > interface.  For example, the audio driver allocates a 16-byte coherent
> > buffer and then uses four bytes from it for each of four different 
> > URBs.
> 
> That will not work with any fallback that does not yield a coherent buffer.

What you mean isn't entirely clear.  But it certainly does work in 
various circumstances that don't yield coherent buffers.  For example, 
it works if the controller uses PIO instead of DMA.  It also works if 
the controller uses DMA and the URBs have to be bounced.

Alan Stern
