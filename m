From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [alsa-devel] USB transfer_buffer allocations on 64bit systems
Date: Tue, 11 May 2010 10:24:40 -0400
Message-ID: <20100511142439.GA4898@phenom.dumpdata.com>
References: <20100511100637D.fujita.tomonori@lab.ntt.co.jp> <Pine.LNX.4.44L0.1005110956330.1834-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1005110956330.1834-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, iommu@lists.linux-foundation.org, andi@firstfloor.org, daniel@caiaq.de, pedrib@gmail.com, akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: alsa-devel@alsa-project.org

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

Is that address (urb->transfer_dma) the same as 'virt_to_phys(urb->transfer_buffer)'
(if not, then SWIOTLB is being utilized) and is the dma_sync_* done on the
urb->transfer_dma (to properly sync the data from the SWIOTLB to the
transfer_buffer) before you start using the urb->transfer_buffer?
