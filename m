From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 13:14:39 +0200
Message-ID: <20100412111439.GU30801@buzzloop.caiaq.de>
References: <20100407090623.GN30807@buzzloop.caiaq.de>
	<Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org>
	<87sk719hbm.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E8802245B6
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Apr 2010 13:14:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87sk719hbm.fsf@basil.nowhere.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andi Kleen <andi@firstfloor.org>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2010 at 10:59:57AM +0200, Andi Kleen wrote:
> Alan Stern <stern@rowland.harvard.edu> writes:
> >> 
> >> The fix is to use usb_buffer_alloc() for that purpose which ensures
> >> memory that is suitable for DMA. And on x86_64, this also means that the
> >> upper 32 bits of the address returned are all 0's.
> >
> > That is not a good fix.  usb_buffer_alloc() provides coherent memory, 
> > which is not what we want.  I believe the correct fix is to specify the 
> > GFP_DMA32 flag in the kzalloc() call.
> 
> The traditional way to handle this is to leave it to swiotlb in
> pci_map_*. pci_map_* is needed anyways if you run with a IOMMU.
> 
> Also note at least on x86 systems coherent memory is the same as non coherent
> memory. And GFP_DMA32 is a x86 specific flag, doesn't necessarily 
> do any good anywhere else.
> 
> So if you add x86isms anyways you could as well use dma_alloc_coherent()
> directly which is actually better at this than a simple GFP_DMA32
> and as a bonus handles the IOMMUs correctly too.

Which is exactly what usb_buffer_alloc() does already. So at least for
x86 you say this is the right thing to do? However, we don't necessarily
need coherent memory on other platforms, which is why I hessitate to
enforce that type of memory for all transfer_buffer allocations.

> Or just use GFP_KERNEL and pci_map_* later.

The USB core does this already, but at least on Pedro's machine, this
seems unsufficient. Unfortunately, I can't reproduce the issue yet, even
with more than 4GB of RAM installed.

Daniel
