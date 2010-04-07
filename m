From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 7 Apr 2010 12:47:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004071245410.1779-100000@iolanthe.rowland.org>
References: <20100407161603.GL30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100407161603.GL30801@buzzloop.caiaq.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Apr 2010, Daniel Mack wrote:

> Ok, I'll write some dummies for usb_malloc() and usb_zalloc() which
> will just call kmalloc() with GFP_DMA32 for now. And while at it,
> usb_alloc_buffer() will be renamed to usb_alloc_consistent(). Then I'll
> try to clean up all existing drivers to use this new interface and
> follow the changes.
> 
> In a next step, we should fine-tune when GFP_DMA32 is really needed.
> And I'll leave all occurances of usb_alloc_consistent() as they are now.
> 
> Does that sound ok?

Yes, that should work out well.

Alan Stern
