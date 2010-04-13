From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] USB: rename usb_buffer_alloc() and usb_buffer_free()
Date: Tue, 13 Apr 2010 13:26:07 -0700
Message-ID: <20100413202607.GA3567@suse.de>
References: <20100413181631.GT30801@buzzloop.caiaq.de> <Pine.LNX.4.44L0.1004131525500.1551-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1004131525500.1551-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Robert Hancock <hancockrwd@gmail.com>, Andi Kleen <andi@firstfloor.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 13, 2010 at 03:27:36PM -0400, Alan Stern wrote:
> On Tue, 13 Apr 2010, Daniel Mack wrote:
> 
> > On Mon, Apr 12, 2010 at 01:17:25PM +0200, Daniel Mack wrote:
> > > For more clearance what the functions actually do,
> > > 
> > >   usb_buffer_alloc() is renamed to usb_alloc_coherent()
> > >   usb_buffer_free()  is renamed to usb_free_coherent()
> > > 
> > > They should only be used in code which really needs DMA coherency.
> > > 
> > > All call sites have been changed accordingly, except for staging
> > > drivers.
> > 
> > Is this ok? As it's quite big, I think it should be merged soon if there
> > are no objections.
> 
> I have no objection.  All it does is rename a couple of functions.  
> There's no reason for this to go into 2.6.34; it can wait for the next 
> merge window.

I think I will split this up into the following set of patches:
	- rename the functions and add a macro for the old names
	- rename all in-kernel usages
	- rename the staging tree usages
	- remove the macros

the first patch can go in to Linus's tree now, to make it easier for the
2nd and 3rd patches to live in linux-next easier as we might need to
look at the usages in other development trees before we can add the last
one.

Sound good?

thanks,

greg k-h
