From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Sudden ISA DMA problems
Date: Mon, 18 Feb 2002 14:14:14 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202181411530.505-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA31611
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 14:16:25 +0100
In-Reply-To: <s5hheofceqk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rankin <rankincj@yahoo.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Feb 2002, Takashi Iwai wrote:

> At Sun, 17 Feb 2002 10:29:20 +0100 (CET),
> Jaroslav wrote:
> >
> > On Sat, 16 Feb 2002, [iso-8859-1] Chris Rankin wrote:
> >
> > > Hi,
> > >
> > > I saw from the CVS ChangeLog that ALSA is moving away
> > > from the deprecated virt_to_bus() to the new
> > > pci_allocate_consistent() system calls. Unfortunately,
> > > this is causing problems for my ISA DMA sound driver
> > > (CS4231 / MPU401 based). I have currently "fixed"
> > > things by #undef-ing the ISA_USE_PCI_ALLOC in
> > > core/pcm_memory.c. Once I do this, I get sound out of
> > > my speakers again.
> > >
> > > My soundcard also needs a DMA-able buffer so that it
> > > can upload its firmware. Previously, I used
> > > snd_malloc_pages(), and I tried changing this to
> > > snd_malloc_isa_pages(). However, you don't export this
> > > function, and even when I cut-and-pasted it into the
> > > source file, the firmware wouldn't upload until I used
> > > the virt_to_bus()-based compatibility version.
> > >
> > > It would probably be a good idea to export the
> > > following functions:
> > >
> > > snd_malloc_pci_pages()
> > > snd_malloc_isa_pages()
> > > snd_free_pci_pages()
> > > snd_free_isa_pages()
> > >
> > > Does anyone have any idea why
> > > pci_allocate_consistent() isn't working here, please?
> >
> > Using pci_allocate_consistent() for ISA DMA allocation routines is
> > definitely a bad idea. I added snd_malloc_isa_pages() code as you
> > suggested to snd.o (it seems that it's good to abstract such bus specific
> > allocation routines).
>
> I don't think it's so bad to use pci_allocate_consistent().  It gives
> the only generic way to get DMA buffer allocation over all
> architectures without virt_to_bus.  If it doesn't work well, it should
> be a bug of this function..

I verified the contents of pci_allocate_consistent() and I agree that it
should work at least for i386 and alpha architectures so I reverted back
your code.

> Anyway, yes, it would be better to use a generic function until the
> kernel function is fixed.  Thanks.
>
> BTW, use of GFP_KERNEL for a large DMA buffer is safe on 2.4 too?
> For PCI buffers, when a module tries to allocate large memory areas
> with GFP_KERNEL, it stays blocking (and waiting for the enough space)
> and even more badly it cannot be killed.

I removed dma_flags from isa pages allocation routines. We use
GFP_ATOMIC|GFP_DMA like pci_allocate_consistent(). I'm not only sure about
2.2 kernels, but it's easy to fix this problem.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
