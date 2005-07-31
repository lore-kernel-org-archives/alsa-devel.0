From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ALSA memory allocator rants
Date: Sun, 31 Jul 2005 16:46:44 +0100
Message-ID: <42ECF264.80202@superbug.demon.co.uk>
References: <20050731122713.GA24483@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050731122713.GA24483@lst.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

Here is a email I received as a result of talks I had at KS.
The general point is that they want the memory alloc function calls in 
alsa-kernel to not be calls to wrappers, but instead be proper kernel 
2.6 function calls.
The other general point is that some of the code we use should be 
generalised so that other non-audio drivers can reuse it.

Comments please,

James


Christoph Hellwig wrote:
> At KS I promised you to send you my rants about ALSA memory allocations,
> so here we go finally.
> 
> First stance from me is that a subsystem needing it's own memory
> allocation helpers is always a bug, either in the subsystem or in the
> generic allocators.  In the ALSA case we have both..
> 
> sound/core/memalloc.c:
> 
>  - snd_dma_hack_alloc_coherent shouldn't exist, instead the arch
>    dma_alloc_coherent should do hacks similar to it.  The
>    kmalloc_dev/kmalloc_mask as proposed at KS should fix this
>  - snd_malloc_pages is bogus.  the only additional thing it does over
>    __get_free_pages is to set the page reserved which is the wrong
>    thing to do (we're getting rid of PageReserved soon)
>  - snd_malloc_dev_pages should be just dma_alloc_coherent, the
>    __GFP_FLAG clearing should be in those, and playing PageReserved
>    tricks with dma coherent memory is totally wrong in any case
>  - dito for snd_malloc_sbus_pages, mid-term I'd love to see one of the
>    sparc hackers to switch sparc to support sbus with dma_alloc_coherent
>  - what's the point of snd_dma_alloc_pages()?  It supports very different
>    kinds of memory allocations, and overloads the device field in
>    non-trivial ways.  The code would get a lot cleaner by letting
>    everyone call the allocator they actually need instead of adding such
>    broken 'abstractions'.  Same thing can be said about struct
>    snd_dma_buffer.
>  - snd_dma_alloc_pages_fallback should go to generic dma code, it's not
>    sound specific
>  - preallocations should go into generic code or go away, it has no
>    business in sound code
>  - similar dma coherent stats should go into generic dma code
> 
> sound/core/memory.c
> 
>  - all this should happen at the slab level, not in some subsystem
> 
> sound/core/sgbuf.c
> 
>  - something like this should go into generic code, lots of video
>    drivers need something like this.  They use streaming dma mappings,
>    though while alsa wants consistant ones.  In general doing this on
>    consistant ones can't be done in architecture-independent code, what
>    alsa does now does lots of assumptions about how dma_alloc_coherent
>    is implemented, and it can't work on arm for example.
> 
> sound/core/pcm_memory.c
> 
>  - same preallocation comment as above.
> 
> 



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
