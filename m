From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: FW: DMA producer/consumer
Date: Fri, 12 Mar 2004 14:54:54 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F290AC@DBDE01>
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
To: 'Jaroslav Kysela' <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

	Even thought the SA11xx ARM platform DMA engine has a queueing
mechanism (as you mentioned), it is not being utilized.  Since we are
queueing(or starting) the next dma transfer in the interrupt context, and we
recieve this interrupt only when the previous dma transfer ends.  Queueing
makes sense only when a dma transfer is active and we queue another dma
transfer (to avoid a delay between starting another transfer).  
So for now I think we might have to use the mechanisms suggested by Takashi
to queue extra periods to the dma engine.

regards
-kshitij

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Thursday, March 11, 2004 11:30 PM
To: Takashi Iwai
Cc: Gupta, Kshitij; alsa-devel@lists.sourceforge.net
Subject: Re: FW: [Alsa-devel] DMA producer/consumer


On Thu, 11 Mar 2004, Takashi Iwai wrote:

> At Thu, 11 Mar 2004 18:43:39 +0100 (CET),
> Jaroslav wrote:
> > 
> > On Thu, 11 Mar 2004, Takashi Iwai wrote:
> > 
> > > unfortunately, the current implementation of ALSA PCM middle layer
> > > isn't well suited for this kind of hardwares.  it'll be a bit more
> > > complicated than you think.
> > 
> > I don't think that's this case. I'm not sure, if the basic midlevel 
> > mechanism is understood: The midle level code expects that driver 
> > start/stop the stream in the trigger callback, so if you can queue
> > more 'periods' into the DMA engine, do it and abort/pause the transfer
> > only the trigger callback request. You don't need to check appl/hw_ptr
> > in the lowlevel code.
> 
> hmm, if i understand correctly, this DMA engine needs the update of
> DMA queue.  i.e. the driver needs to feed chunks manually in prior
> to the DMA start, and continues feeding the available chunks after
> that as long as the stream is running.  this is somewhat analogous
> with the case with the external hardware buffer.

It was case for sb8 driver, I think that all newer hardware which can do
DMA transfers is designed to enqueue more blocks to avoid fifo underruns 
at the block boundary. At least the SA11xx ARM platform has the DMA engine 
for two blocks (one can be prepared during transfer of the opposite).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
