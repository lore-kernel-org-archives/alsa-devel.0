From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: runtime->dma_addr
Date: Wed, 3 Mar 2004 23:10:26 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040303231026.C15007@flint.arm.linux.org.uk>
References: <F509E6111989D311B63700805FA761DA09F2905D@DBDE01> <Pine.LNX.4.58.0403031928440.2089@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403031928440.2089@pnote.perex-int.cz>; from perex@suse.cz on Wed, Mar 03, 2004 at 07:29:19PM +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "Gupta, Kshitij" <kshitij@ti.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 03, 2004 at 07:29:19PM +0100, Jaroslav Kysela wrote:
> On Wed, 3 Mar 2004, Gupta, Kshitij wrote:
> > hi,
> > 	Can someone please explain me what is  the difference between
> > runtime->dma_addr and runtime->dma_area
> > 
> > where runtime = substream->runtime
> > 
> > I am getting a very strange problem where I am getting a rumtime->dma_addr
> > value as 0 while runtime->dma_area is a proper value.  
> > Any hints will be helpful
> 
> dma_area is virtual address (visible from the CPU view)
> dma_addr is the physical bus address (visible from the hardware)

Not quite true - dma_addr is the bus address.

Linux has three memory spaces: virtual, physical and bus.  The value
returned from dma_alloc_coherent/pci_alloc_consistent has always been
this magical "bus" address which may be unique to the device it's
being programmed into.

This is why DMA-mapping.txt says:

  pci_alloc_consistent returns two values: the virtual address which you
  can use to access it from the CPU and dma_handle which you pass to the
  card.

rather than calling dma_handle the "physical" address.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
