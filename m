From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: An driver error when I using aplay!
Date: Mon, 7 Jun 2004 16:44:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040607164401.G28526@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0406071239110.3294@pnote.perex-int.cz> <s5hk6yj4jvj.wl@alsa2.suse.de> <20040607140817.A28526@flint.arm.linux.org.uk> <s5hbrjv4hbs.wl@alsa2.suse.de> <20040607145113.B28526@flint.arm.linux.org.uk> <s5h4qpn4fjk.wl@alsa2.suse.de> <20040607160442.D28526@flint.arm.linux.org.uk> <s5h1xkr4d04.wl@alsa2.suse.de> <20040607161812.F28526@flint.arm.linux.org.uk> <s5hzn7f2xkc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzn7f2xkc.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Jun 07, 2004 at 05:32:35PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Roc Wu <cooloney@yahoo.com.cn>, Clemens Ladisch <clemens@ladisch.de>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 07, 2004 at 05:32:35PM +0200, Takashi Iwai wrote:
> At Mon, 7 Jun 2004 16:18:12 +0100,
> Russell King wrote:
> > 
> > > No, the problematic line is:
> > > 
> > > 	WARN_ON(chan->tx_substream != substream);
> > > 
> > > It can't pass because chan->tx_substream is always NULL (as you wrote)
> > > unless hw_params is called.  The check is wrong.
> > 
> > Ah, well, in my current version of this, I've completely removed that
> > check.  Whether there are any other changes, I've no idea.
> 
> I also won't debug this any more unless the code is opened
> publicly...

I wasn't asking you to. 8)

> >   However,
> > my current version doesn't work at all at the moment because its in
> > the middle of having experimental DMA support added, rather than
> > being sucky PIO-only.
> 
> Where we're here:  I'd really like to fix the DMA problem of ALSA on
> ARM.  As I sent you before, the patch is already there but I have no
> idea whether it's really right or not.  Could you please comment
> whether the assumptions below are correct?
> 
> - the page struct can be retrieved from dma_addr_t of
>   dma_alloc_coherent() like
> 
> 	virt_to_page(bus_to_virt(addr))

Well, bus_to_virt() is a deprecated interface, and one which is
meaningless on certain classes of machines.  Really, we shouldn't
be adding code which relies on it.

What we should be doing is something like the following, which is
a generic set of coherent DMA allocation, freeing, and mmap
functions which would cover any driver-model based device.

snd_pcm_ops_t should have a mmap() method just like everything else
in the kernel, which allows drivers to select the appropriate mmap()
implementation.

> - adding pgprot_noncached() in fop->mmap callback assures that the
>   mmaped page is accessed without cache side effects.

Correct, but as it has been already decided elsewhere, interfaces
which expose pgprot tweaking are broken and new ones should not be
introduced.  They also _may_ only affect the userspace mapping of
that memory and not kernel space, so this doesn't help the control
or status mmaped pages.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
