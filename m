From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 7 Apr 2010 18:16:03 +0200
Message-ID: <20100407161603.GL30801@buzzloop.caiaq.de>
References: <20100407153154.GC13425@kroah.com>
	<Pine.LNX.4.44L0.1004071149140.1779-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B988243B9
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 18:16:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1004071149140.1779-100000@iolanthe.rowland.org>
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
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 07, 2010 at 11:55:19AM -0400, Alan Stern wrote:
> On Wed, 7 Apr 2010, Greg KH wrote:
> 
> > Alan, any objection to just using usb_buffer_alloc() for every driver?
> > Or is that too much overhead?
> 
> I don't know what the overhead is.  But usb_buffer_alloc() requires the 
> caller to keep track of the buffer's DMA address, so it's not a simple 
> plug-in replacement.  In addition, the consistent memory that 
> usb_buffer_alloc() provides is a scarce resource on some platforms.
> 
> Writing new functions is the way to go.

Ok, I'll write some dummies for usb_malloc() and usb_zalloc() which
will just call kmalloc() with GFP_DMA32 for now. And while at it,
usb_alloc_buffer() will be renamed to usb_alloc_consistent(). Then I'll
try to clean up all existing drivers to use this new interface and
follow the changes.

In a next step, we should fine-tune when GFP_DMA32 is really needed.
And I'll leave all occurances of usb_alloc_consistent() as they are now.

Does that sound ok?

Thanks,
Daniel
