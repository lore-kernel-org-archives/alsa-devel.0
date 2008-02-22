From: Greg KH <greg@kroah.com>
Subject: Re: asihpi: Need help converting volatile to memory
	barriers
Date: Fri, 22 Feb 2008 09:37:56 -0800
Message-ID: <20080222173756.GA29271@kroah.com>
References: <200802221218.18249.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 589792445E
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 18:38:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200802221218.18249.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 22, 2008 at 12:18:18PM +1300, Eliot Blennerhassett wrote:
> Greetings,
> 
> first, the meta-help request:
> Is there another place that I should be making this request? (lkml, kernel 
> newbies, linux driver project etc)?

lkml is best for this.

> Theres quite a bit written about barriers, but most seems to be assuming SMP 
> situation or memory mapped devices. Not much about devices doing DMA.
> I.e I have read Documentation/memory-barriers.txt
> 
> Now the actual question:
> Currently I have a driver that uses "volatile" - heres the relevant source.
> http://hg.alsa-project.org/alsa-driver/file/89222d702376/pci/asihpi/hpi6205.c
> 
> The "volatile" is applied to structures that are either read or written by 
> device DMA.  Certainly the driver in its current state doesn't work without 
> volatile qualifier. (BTW the device doesn't use host interrupts)
> 
> Structures ("interface") used for dma are allocated with dma_alloc_coherent()
> 
> In the following, am I using the barriers correctly?
> 
> 1) Reading something updated by DMA
> 
> volatile struct bus_master_interface *interface;
> while (interface->ack != OK) { 
> 	sleep(a while)  	
> 	[ device changes interface->ack by dma ]
> };
> === after conversion
> struct bus_master_interface *interface;
> while (interface->ack != OK) { 
> 	sleep(a while);
> 	rmb(); 
> };
> 
> Here the volatile or rmb is needed or the loop gets optimised away.

Using rmb() is correct, not volatile, as volatile might not really do
what you are expecting it to do on all versions of gcc and
architectures.

So please remove all instances of volatile, it is not correct to use it
within kernel code.

thanks,

greg k-h
