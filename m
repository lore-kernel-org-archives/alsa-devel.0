From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: Dma query
Date: Thu, 26 Feb 2004 16:49:14 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F29026@DBDE01>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,
	Any insights will be really helpful :) .
regards
-kshitij

-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net
[mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Gupta,
Kshitij
Sent: Wednesday, February 25, 2004 4:59 PM
To: 'Jaroslav Kysela'
Cc: alsa-devel@lists.sourceforge.net
Subject: RE: [Alsa-devel] Dma query


hi ,
	That's correct the pages will be in whole meory space and I will be
using snd_pcm_lib_preallocate_pages_for_all api for allocating the space.
There are some DMA apis (for our dma framework) like 

set_dma_transfer_params(srcaddr, destaddr, mode ...)

Now I need to call this API whenever the transmit for one of the buffers is
complete.  Or is it like, these things should be done just once upfront.
But that means we need n channels if we want n buffers to be ring buffers. 

regards
-kshitij

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Wednesday, February 25, 2004 4:05 PM
To: Gupta, Kshitij
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Dma query


On Wed, 25 Feb 2004, Gupta, Kshitij wrote:

> hi,
> 	I have a very trivial question about the dma transfers with respect
> to ALSA framework.  
> 
> Let me first explain a scenario
> We have a 
> Circularly linked Buffer pool
> 
> buf1    buf2    buf3     buf4  .... bufn
> 
> In very simple terms playing an audio stream is reading from these buffers
> and continuously dma'ing it to the audio device (let's assume we have a
read
> and write register with the audio device).  And in this circulary linked
> audio buffer the user fills the data and the driver empties it to the
> device.
> 
> Now I am not able to fit this scenario in the ALSA framework.  I am
> referrring to alsa-kernel/arm/sa11xx-uda1341.c file as a reference for my
> driver.  And here I don't understand where do we specify the the exact dma
> parameters (like the start address of buffer and the destination address).

DMA buffer is allocated hw_params callback. It depends, how the DMA pages 
have to be allocated. You didn't write any details. If pages can be in
the whole memory space (from the view of CPU and DMA controller), then we 
have SNDRV_DMA_TYPE_CONTINUOUS for it (use 
snd_pcm_lib_preallocate_pages_for_all at init and standard functions 
like in other drivers in hw_params and hw_free callbacks).

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
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
