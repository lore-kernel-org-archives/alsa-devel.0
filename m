From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Re: [PATCH 2.6.13.1 1/1] CS5535 AUDIO ALSA driver
Date: Tue, 6 Dec 2005 17:42:03 +0000
Message-ID: <20051206174203.GA24569@infradead.org>
References: <200509190639.j8J6dIM4007948@localhost.localdomain> <20050920152830.7ef6733b.akpm@osdl.org> <47f5dce305092017031a2ba375@mail.gmail.com> <20050920172309.626db866.akpm@osdl.org> <20050921083109.GA27254@infradead.org> <s5hpsqsdn6g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hpsqsdn6g.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, jayakumar.alsa@gmail.com, perex@suse.cz, mj@ucw.cz, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 29, 2005 at 03:21:43PM +0200, Takashi Iwai wrote:
> At Wed, 21 Sep 2005 09:31:09 +0100,
> Christoph Hellwig wrote:
> > 
> > On Tue, Sep 20, 2005 at 05:23:09PM -0700, Andrew Morton wrote:
> > > > I'm not sure what to do. I'd be happy to take them out. But I woudn't
> > > > mind leaving them in if that's what alsa convention is.
> > > 
> > > I'd be inclined to stick with the alsa style.  That's just an fyi if you
> > > plan on working in other places.
> > 
> > I'd _really_ prefer to fix all of alsa.  Alsa is so full of wrappers
> > and multiple names for the same thing that's it's almost impossibly
> > for a normal kernel developer to fix anythign in there.
> 
> Oh I guess you're referring to the messy memory stuff in ALSA code?
> 
> (Or you mean about the foo_t style?  Then it would be easy to fix, and
>  I'd appreciate if someone takes this job :)
> 
> Basically I agree with all your suggestions - hacks have been there
> simply as workarounds.  They should be removed.
> 
> The following are in WIP on my local tree:
> 
> - Merge of dma_alloc_coherent() hacks for pages <32bit to kernel core
>   (for i386 and ppc)

Did this get out?

> 
> - PageReserve and mmaps:
>   dma_mmap_coherent() will be used in all architectures instead of
>   vma nopage callback.  Of course, dma_mmap_coherent() should be
>   ported to all archs.

What about just making the i386 one Russell posted generic?  It shouldn't
be any less broken than what we do now and every architecture that needs
something more specific can implements it.

> - Removal of the common allocator in sound/core/memalloc.c
>   Instead, each driver has alloc_buffer() and free_buffer()
>   callbacks.

this isn't in mainline yet, is it?

> - The "right" way to allocate/mmap coherent SG-buffers.

How do you get coherent SG-buffers?  The only way to get coherent dma
allocations is dma_alloc_coheren (and the pci variant), but that's not
handing back an SG list.  But even if you build one yourself it should
be handled by dma_mmap_coherent.

> - A common API for mmap vmalloc buffers.

What API do you think about?  If you do alloc_page yourself and use
vmap everything gets much much easier.  And with the new vm_install_page
this becomes pretty easy:

init_routine()
{

	...
	for (i = 0; i < NR_PAGES; i++) {
		pages[i] = alloc_page(GFP_KERNEL);
		...
	}

	dma_buffer = vmap(pages, ...);
}

dma_map()
{
	for (i = 0; i < NR_PAGES; i++) {
		dma_map_page(pages[i, ....);
		...
	}
}

mmap()
{
	for (i = 0; i < NR_PAGES; i++) {
		vm_insert_page(..., pages[i], ..);
		...
	}
}

maybe some tiny helpers that encapsulate the loop over the pages would
be nice, but we shouldn't need much of a new API here.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
