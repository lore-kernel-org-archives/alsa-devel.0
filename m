From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 1/3 Implement generic device DMA mapping support
Date: Mon, 1 Mar 2004 17:45:17 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040301174517.J24955@flint.arm.linux.org.uk>
References: <20040229223820.C17862@flint.arm.linux.org.uk> <s5heksch8xf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5heksch8xf.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Mar 01, 2004 at 04:41:00PM +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 01, 2004 at 04:41:00PM +0100, Takashi Iwai wrote:
> At Sun, 29 Feb 2004 22:38:20 +0000,
> Russell King wrote:
> > 
> > This is the first shot at this - I've tested it on ARM, covering both
> > ISA ALSA devices on a PCI machine, and driver model devices on a non-
> > PCI, non-ISA machine.  However, it needs more testing.  Can people
> > on alsa-devel please test these patches.
> > 
> > This patch adds support for the generic device/driver model to ALSA
> > for the sole purpose of supporting their DMA mapping functionality.
> > 
> > This patch changes snd_malloc_sgbuf_pages() to use this dma mapping
> > functionality.
> 
> thanks for the patch.  using struct device is nice for
> generalization.
> 
> after a short glance, the only drawback i found is that you disabled
> the single pci page allocation hack for i386.  this was needed to
> cover the non-atomic page allocation.
> for example, sb live needs to allocate more than 100MB single pages
> for the wavetable data.  the allocation with GFP_ATOMIC can fail
> easily in such a case, althogh there is enough memory after swapping.
> maybe we can leave this function as another...

I think you've assumed that:

+       res = dma_alloc_coherent(dev, PAGE_SIZE << pg, dma, GFP_KERNEL);

in snd_malloc_dev_pages() uses GFP_ATOMIC.  Please look closer.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
