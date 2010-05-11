From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [alsa-devel] USB transfer_buffer allocations on 64bit systems
Date: Tue, 11 May 2010 23:22:24 +0900
Message-ID: <20100511232216R.fujita.tomonori@lab.ntt.co.jp>
References: <20100511100637D.fujita.tomonori@lab.ntt.co.jp>
	<Pine.LNX.4.44L0.1005110956330.1834-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005110956330.1834-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu
Cc: fujita.tomonori@lab.ntt.co.jp, dwmw2@infradead.org, daniel@caiaq.de, clemens@ladisch.de, tiwai@suse.de, alsa-devel@alsa-project.org, gregkh@suse.de, konrad.wilk@oracle.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, iommu@lists.linux-foundation.org, andi@firstfloor.org, pedrib@gmail.com, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Tue, 11 May 2010 10:00:50 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> > > The problem goes away when Pedro boots with mem=4G.  And the dma_mask
> > > value is set properly (in fact, the ehci-hcd driver currently doesn't
> > > use 64-bit DMA at all).
> > > 
> > > If anyone wants to see the debug log entries showing the buffer and DMA
> > > addresses, they are attached to this email message:
> > > 
> > > 	http://marc.info/?l=linux-kernel&m=127076841801054&w=2
> > > 
> > > Either the data isn't getting written to the buffer correctly or else
> > > the buffer isn't getting sent to the device correctly.  Can anybody
> > > suggest a means of determining which is the case?
> > 
> > I can't say anything about this log that including only DMA addresses.
> > I'm not familiar with how the USB core does DMA stuff. And the USB
> > stack design that the USB core does DMA stuff (allocating, mappings,
> > etc) makes debugging DMA issues really difficult.
> 
> The DMA stuff is simple enough in this case.  The urb->transfer_buffer
> address is passed to dma_map_single(), and the DMA address it returns
> is stored in urb->transfer_dma.  Those are the two values printed out
> by the debugging patch.

You've already confirmed that all the returned addresses
(urb->transfer_dma) in the log is less than 4GB, right?

Drivers need to take care of more things (not only about addresses) to
do DMA properly, that is, use the DMA API in the proper way (such as,
once calling dma_map_single, drivers can't touch the buffer until
calling dma_unmap_single)

Using the DMA API and performing DMA transfer in different places just
make things complicated.
