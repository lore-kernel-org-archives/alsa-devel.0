From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: An driver error when I using aplay!
Date: Mon, 7 Jun 2004 19:04:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040607190416.K28526@flint.arm.linux.org.uk>
References: <20040607140817.A28526@flint.arm.linux.org.uk> <s5hbrjv4hbs.wl@alsa2.suse.de> <20040607145113.B28526@flint.arm.linux.org.uk> <s5h4qpn4fjk.wl@alsa2.suse.de> <20040607160442.D28526@flint.arm.linux.org.uk> <s5h1xkr4d04.wl@alsa2.suse.de> <20040607161812.F28526@flint.arm.linux.org.uk> <s5hzn7f2xkc.wl@alsa2.suse.de> <20040607164401.G28526@flint.arm.linux.org.uk> <s5hvfi32v4k.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvfi32v4k.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Jun 07, 2004 at 06:25:15PM +0200
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

On Mon, Jun 07, 2004 at 06:25:15PM +0200, Takashi Iwai wrote:
> At Mon, 7 Jun 2004 16:44:01 +0100,
> Russell King wrote:
> > What we should be doing is something like the following, which is
> > a generic set of coherent DMA allocation, freeing, and mmap
> > functions which would cover any driver-model based device.
> 
> So, do you mean to hide the stuffs like above (and cache disabling) in
> this new mmap function dedicated for the coherent DMA?

Absolutely - it hides how the mapping from the coherent DMA allocation
is handled from the drivers and puts it where it's supposed to be - in
the architecture code.

> > snd_pcm_ops_t should have a mmap() method just like everything else
> > in the kernel, which allows drivers to select the appropriate mmap()
> > implementation.
> 
> I thought of this, too.  This may help some cases, but we still need a
> generic solution, because a PCI driver can be used in different
> architectures.

Yes, but at least if you have a common function you won't have to
modify thousands of drivers - and you'll need that function to
get at the struct device.  Eg, something like:

static int aaci_pcm_mmap(snd_pcm_substream_t *substream, struct vm_area_struct *vma)
{
        struct aaci *aaci = substream->private_data;
        return devdma_mmap(&aaci->dev->dev, substream, vma);
}

int devdma_mmap(struct device *dev, snd_pcm_substream_t *substream, struct vm_area_struct *vma)
{
        snd_pcm_runtime_t *runtime = substream->runtime;
        return dma_mmap_coherent(dev, vma, runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
}

And devdma_mmap contains whatever is necessary for each architecture
until they implement dma_mmap_coherent - which would be something akin
to the code currently in pcm_native.c for handling this itself.  IOW,
snd_pcm_mmap_data_open, snd_pcm_mmap_data_close, snd_pcm_mmap_data_nopage
and the bulk of snd_pcm_mmap_data in devdma_mmap().

> > > - adding pgprot_noncached() in fop->mmap callback assures that the
> > >   mmaped page is accessed without cache side effects.
> > 
> > Correct, but as it has been already decided elsewhere, interfaces
> > which expose pgprot tweaking are broken and new ones should not be
> > introduced.
> 
> Hmm, is there a standard interface for this purpose?

No - because it's completely non-portable.  Eg, not all architectures
are capable of turning off the cache on a per-page basis.

> > They also _may_ only affect the userspace mapping of
> > that memory and not kernel space, so this doesn't help the control
> > or status mmaped pages.
> 
> Oh yes, then how about to use a DMA page for the control/status mmap,
> too?

Oddly that's what I did on VIVT caches to get Alsa working a few months
ago, but its very unclean and the way I did it, it exposes the "dma"
address in the actual page - which would be a major security problem
if I let the code out.  As I said back then, I didn't have a clean
solution for this.

There are other problems with VIPT caches where the cache colour
becomes important and directly impinges on this "shared" mmap method,
but that's another story.

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
