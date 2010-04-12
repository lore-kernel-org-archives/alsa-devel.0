From: Andi Kleen <andi@firstfloor.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 18:29:47 +0200
Message-ID: <20100412162947.GQ18855@one.firstfloor.org>
References: <20100412154323.GP18855@one.firstfloor.org> <Pine.LNX.4.44L0.1004121214460.1702-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1004121214460.1702-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andi Kleen <andi@firstfloor.org>, Daniel Mack <daniel@caiaq.de>, Pedro Ribeiro <pedrib@gmail.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2010 at 12:17:22PM -0400, Alan Stern wrote:
> On Mon, 12 Apr 2010, Andi Kleen wrote:
> 
> > > Well, the sound driver itself doesn't care for any of those things, just
> > > like any other USB driver doesn't. The USB core itself of the host
> > > controller driver should do, and as far as I can see, it does that, yes.
> > 
> > Hmm, still things must go wrong somewhere. Perhaps need some instrumentation
> > to see if all the transfer buffers really hit the PCI mapping functions.
> 
> Such a test has already been carried out earlier in this thread:
> 
> 	http://marc.info/?l=linux-usb&m=127074587029353&w=2
> 	http://marc.info/?l=linux-usb&m=127076841801051&w=2
> 	http://marc.info/?l=linux-usb&m=127082890510415&w=2

Hmm, thanks. But things must still go wrong somewhere, otherwise
the GFP_DMA32 wouldn't be needed?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
