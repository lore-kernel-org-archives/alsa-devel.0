From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 19:56:09 +0200
Message-ID: <20100412175609.GC30801@buzzloop.caiaq.de>
References: <20100412162947.GQ18855@one.firstfloor.org>
	<Pine.LNX.4.44L0.1004121252310.1702-100000@iolanthe.rowland.org>
	<20100412171507.GB30801@buzzloop.caiaq.de>
	<20100412172233.GR18855@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A61E6246C1
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Apr 2010 19:56:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100412172233.GR18855@one.firstfloor.org>
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

On Mon, Apr 12, 2010 at 07:22:33PM +0200, Andi Kleen wrote:
> On Mon, Apr 12, 2010 at 07:15:07PM +0200, Daniel Mack wrote:
> > Given that - at least for non-64-aware host controllers - we want memory
> > <4GB anyway for USB transfers to avoid DMA bouncing buffers, maybe we
> > should just do that and fix the problem at this level? I already started
> > to implement usb_[mz]alloc() and use it in some USB drivers.
> 
> If the area is not mapped correctly it will fail in other situations,
> e.g. with an IOMMU active or in virtualized setups. So the bug
> has to be eventually tracked down.

Ok, agreed. But we all agree to the fact that we need an interface for
such allocations to avoid bounce buffers? If that is the case, we could
already start to implement that while we're tracking down the actual
bug.

[...]

> > Can anyone explain which is the right way to go?
> 
> The right thing would be to define a proper interface for it.
> 
> I had an attempt for it a couple of years ago with the mask allocator, 
> but it didn't make it into the tree.

Any plans to continue on this? Or can you dig it out again so others can
pick up the idea?

Daniel
