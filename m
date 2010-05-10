From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 10 May 2010 10:21:05 +0100
Message-ID: <1273483265.372.3383.camel@macbook.infradead.org>
References: <20100507102408.GM30801@buzzloop.caiaq.de>
	<Pine.LNX.4.44L0.1005071048220.1804-100000@iolanthe.rowland.org>
	<20100510115048E.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 344AE103815
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 11:21:34 +0200 (CEST)
In-Reply-To: <20100510115048E.fujita.tomonori@lab.ntt.co.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, konrad.wilk@oracle.com, tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de, linux-kernel@vger.kernel.org, chrisw@sous-sol.org, iommu@lists.linux-foundation.org, andi@firstfloor.org, stern@rowland.harvard.edu, pedrib@gmail.com, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-05-10 at 11:50 +0900, FUJITA Tomonori wrote:
> On Fri, 7 May 2010 10:51:10 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Fri, 7 May 2010, Daniel Mack wrote:
> > 
> > > > At least the audio class and ua101 drivers don't do this and fill the
> > > > buffers before they are submitted.
> > > 
> > > Gnaa, you're right. I _thought_ my code does it the way I described, but
> > > what I wrote is how I _wanted_ to do it, not how it's currently done. I
> > > have a plan to change this in the future.
> > > 
> > > So unfortunately, that doesn't explain it either. Sorry for the noise.
> > 
> > At one point we tried an experiment, printing out the buffer and DMA 
> > addresses.  I don't recall seeing anything obviously wrong, but if an 
> > IOMMU was in use then that might not mean anything.  Is it possible 
> > that the IOMMU mappings sometimes get messed up for addresses above 4 
> > GB?
> 
> You mean that an IOMMU could allocate an address above 4GB wrongly? If
> so, IIRC, all the IOMMU implementations use dev->dma_mask and
> dev->coherent_dma_mask properly. And the DMA address space of the
> majority of IOMMUs are limited less than 4GB.

The Intel IOMMU code will use dev->dma_mask and dev->coherent_dma_mask
properly. It is not limited to 4GiB, but it will tend to give virtual
DMA addresses below 4GiB even when a device is capable of more; it'll
only give out higher addresses when the address space below 4GiB is
exhausted.

-- 
dwmw2
