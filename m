From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fixups of ALSA memory maps
Date: Wed, 18 Nov 2009 15:20:56 +0100
Message-ID: <20091118142056.GB6615@linux-mips.org>
References: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com>
	<s5hd43iiebt.wl%tiwai@suse.de>
	<20091116174324.GA17748@linux-mips.org>
	<s5hhbst4hzt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eddie.linux-mips.org (eddie.linux-mips.org [78.24.191.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 50AE72414E
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 15:21:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59940 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493496AbZKROVW (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Wed, 18 Nov 2009 15:21:22 +0100
Content-Disposition: inline
In-Reply-To: <s5hhbst4hzt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Wu Zhangjin <wuzhangjin@gmail.com>, linux-kernel@vger.kernel.org, Wu Zhangjin <wuzj@lemote.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 17, 2009 at 10:29:10AM +0100, Takashi Iwai wrote:

> > > Actually, this has been a looong-standing problem.
> > > I have a series of patches to fix these issues, but it's more
> > > intensively involved with dma_*() functions.
> > > 
> > > The patches can be found in test/dma-fix branch of sound GIT tree.
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git test/dma-fix
> > > 
> > > This basically adds dma_mmap_coherent() function to feasible
> > > architectures, which is already implemented for ARM, so far.
> > 
> > Cool - but needs a little further tweaking to work right.  That's a
> > solution which will use uncached accesses on all MIPS systems.
> > 
> > IP27/IP35-family machines will explode when you try that.  Eventually the
> > cache coherency logic will notice that cache, directory caches and memory
> > have become inconsistent and bombard the CPU with a bunch of nasty
> > exceptions.
> 
> OK, that's really bad.

Hardware designers do such things to you.  Often even for a reason.

> > For cache-coherent machines otoh it's a big waste of performance.
> > 
> > int dma_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
> >                       void *cpu_addr, dma_addr_t handle, size_t size)
> > {
> >         struct page *pg;
> > 
> > 	if (!plat_device_is_coherent(dev))
> > 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> >         cpu_addr = (void *)dma_addr_to_virt(handle);
> >         pg = virt_to_page(cpu_addr);
> > 
> >         return remap_pfn_range(vma, vma->vm_start,
> >                                page_to_pfn(pg) + vma->vm_pgoff,
> >                                size, vma->vm_page_prot);
> > }
> > EXPORT_SYMBOL(dma_mmap_coherent);
> > 
> > Thomas - you're the IP28 specialist.  Would the plat_device_is_coherent()
> > above have to become a cpu_is_noncoherent_r10000() call?  Any further
> > nasties?
> 
> Thanks for checking!

You're welcome!

So basically I'd not mind putting this into the Linux/MIPS tree; we still
can iron out the kinks from there on and probably much better than by
having arch stuff in the ALSA tree.

I recall this new API having been posted for discussion to linux-arch.
What was the outcome?  I'd only like to add a new API if the other arch
maintainers see it fit their needs also.

  Ralf
