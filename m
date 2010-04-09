From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 20:09:42 +0200
Message-ID: <20100409180942.GK30801@buzzloop.caiaq.de>
References: <m2n74fd948d1004081613n90408827s7c51ef572848fb1d@mail.gmail.com>
 <Pine.LNX.4.44L0.1004091155570.1852-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1004091155570.1852-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pedro Ribeiro <pedrib@gmail.com>, Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 09, 2010 at 12:01:27PM -0400, Alan Stern wrote:
> On Fri, 9 Apr 2010, Pedro Ribeiro wrote:
> > here is the output of the patch you sent me when the interference is triggered.
> > 
> > The log is long, 1.3mb in size.
> 
> I don't see anything suspicious.  The transfer_buffer addresses repeat 
> every 32 URBs, and the DMA addresses cycle almost entirely uniformly 
> from 0x20000000 to 0x23ffffff in units of 0x2000 (there are a few gaps 
> where the interval is a little bigger).

The DMA pointers do indeed look sane. I wanted to take a deeper look at
this and set up a 64bit system today. However, I fail to see the problem
here. Pedro, how much RAM does your machine have installed?

Daniel
