From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 19:15:07 +0200
Message-ID: <20100412171507.GB30801@buzzloop.caiaq.de>
References: <20100412162947.GQ18855@one.firstfloor.org>
	<Pine.LNX.4.44L0.1004121252310.1702-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A84AD243BA
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Apr 2010 19:15:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1004121252310.1702-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2010 at 12:57:16PM -0400, Alan Stern wrote:
> On Mon, 12 Apr 2010, Andi Kleen wrote:
> > Hmm, thanks. But things must still go wrong somewhere, otherwise
> > the GFP_DMA32 wouldn't be needed?
> 
> Indeed, something must go wrong somewhere.  Since Daniel's patch fixed
> the problem by changing the buffer from a streaming mapping to a
> coherent mapping, it's logical to assume that bad DMA addresses have
> something to do with it.  But we don't really know for certain.

Given that - at least for non-64-aware host controllers - we want memory
<4GB anyway for USB transfers to avoid DMA bouncing buffers, maybe we
should just do that and fix the problem at this level? I already started
to implement usb_[mz]alloc() and use it in some USB drivers.

But even after all collected wisdom about memory management in this
thread, I'm still uncertain of how to get suitable memory. Using
dma_alloc_coherent() seems overdone as that type of memory is not
necessarily needed and might be a costly good on some platforms. And as
fas as I understand, kmalloc(GFP_DMA) does not avoid memory >4GB.

Can anyone explain which is the right way to go?

Daniel
