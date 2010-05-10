From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [alsa-devel] USB transfer_buffer allocations on 64bit systems
Date: Mon, 10 May 2010 11:50:56 +0900
Message-ID: <20100510115048E.fujita.tomonori@lab.ntt.co.jp>
References: <20100507102408.GM30801@buzzloop.caiaq.de>
	<Pine.LNX.4.44L0.1005071048220.1804-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005071048220.1804-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu
Cc: daniel@caiaq.de, clemens@ladisch.de, tiwai@suse.de, alsa-devel@alsa-project.org, gregkh@suse.de, konrad.wilk@oracle.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, iommu@lists.linux-foundation.org, andi@firstfloor.org, pedrib@gmail.com, akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, 7 May 2010 10:51:10 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Fri, 7 May 2010, Daniel Mack wrote:
> 
> > > At least the audio class and ua101 drivers don't do this and fill the
> > > buffers before they are submitted.
> > 
> > Gnaa, you're right. I _thought_ my code does it the way I described, but
> > what I wrote is how I _wanted_ to do it, not how it's currently done. I
> > have a plan to change this in the future.
> > 
> > So unfortunately, that doesn't explain it either. Sorry for the noise.
> 
> At one point we tried an experiment, printing out the buffer and DMA 
> addresses.  I don't recall seeing anything obviously wrong, but if an 
> IOMMU was in use then that might not mean anything.  Is it possible 
> that the IOMMU mappings sometimes get messed up for addresses above 4 
> GB?

You mean that an IOMMU could allocate an address above 4GB wrongly? If
so, IIRC, all the IOMMU implementations use dev->dma_mask and
dev->coherent_dma_mask properly. And the DMA address space of the
majority of IOMMUs are limited less than 4GB.
