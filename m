From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: Dma query
Date: Thu, 26 Feb 2004 19:45:04 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F29032@DBDE01>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Jaroslav Kysela' <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
	So does that mean that the __next period__ DMA transfer parameters
should be set in the interrupt routine(end of transfer of one period).  But
to set the next DMA transfer params we must know the start address of the
buffer which the middle layer has filled (and if the middle layer has filled
up more than one buffers then this buffer should be at the head of the
list).
Also one more point is that the hardware provides us the mechanism of
linking the DMA channels ( linking means that once one dma channel finishes
the transfer other one starts automatically).  So this feature provides us
the facility of queuing up the DMA transfers.
regards
-kshitij

ps: one more nasty question I wanted to ask on the list was about how much
time does it take to write a driver(from scratch) with such a complex
framework ;)...probably just sharing experiences....

regards
-kshitij

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Thursday, February 26, 2004 4:57 PM
To: Gupta, Kshitij
Cc: alsa-devel@lists.sourceforge.net
Subject: RE: [Alsa-devel] Dma query


On Thu, 26 Feb 2004, Gupta, Kshitij wrote:

> hi ,
> 	That's correct the pages will be in whole meory space and I will be
> using snd_pcm_lib_preallocate_pages_for_all api for allocating the space.
> There are some DMA apis (for our dma framework) like 
> 
> set_dma_transfer_params(srcaddr, destaddr, mode ...)
> 
> Now I need to call this API whenever the transmit for one of the buffers
is
> complete.  Or is it like, these things should be done just once upfront.
> But that means we need n channels if we want n buffers to be ring buffers.


The ALSA midlevel expects if trigger callback is called, then the data
starts the transfer from the allocated ring buffer (which is filled by the
ALSA midlevel code or application - mmap mode). It's not necessary that
ring buffer is continous from the physical memory perspective, but it must
be continuous from the user space perspective (using MMU and page
mapping).

Then after one period transfer is finished, you need to call
period_elapsed() callback from the interrupt to notify ALSA midlevel code
about this situation and continue with the DMA transfer (next period).  
Note that the pointer callback must give the actual pointer in the ring
buffer at this point.

I hope this helps.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
