From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: FW: DMA producer/consumer
Date: Fri, 12 Mar 2004 16:10:46 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F290B4@DBDE01>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,
	:) maps almost perfectly ...thanx a lot.  Only other doubt I had
was, why are we always getting underruns in case of ARM (as Russell also
pointed out that there are some cache coherency problems), but I am not able
to map cache coherency problems to the underruns we are getting.  We are
getting underruns consistently, even with very small period size (about 1k).

regards
-kshitij

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Friday, March 12, 2004 3:45 PM
To: Gupta, Kshitij
Cc: Takashi Iwai; alsa-devel@lists.sourceforge.net
Subject: RE: FW: [Alsa-devel] DMA producer/consumer


On Fri, 12 Mar 2004, Gupta, Kshitij wrote:

> hi,
> 
> 	No no I was asking about the transfer of data from Application to
> the ring buffer (which is performed by ALSA middle layer),  let me reframe
> the doubt I have.  
> When we queue a next period to the DMA engine, we have no idea whether
data
> for the next period has been already filled up ( filled up means --> data
> filled up by Alsa middle layer , which is sent by the application ).  So
> before queueing a next period to the DMA engine we will have to check
> whether the ring buffer has sufficient data or not (because DMA will
> transfer even if it is empty).  And for that purpose we might need to use
> appl_ptr , which you said is a bad idea.
> 
> ps: the assumptions you said about small fifo and DMA engine are also true

Fine, I think that you didn't catch my point:

1) midlevel calls trigger(START)
   - the lowlevel driver enqueues two blocks (periods) to DMA engine here
2) dma engine starts to transfer first block (period)
3) dma engine finished to transfer first block (period) and triggered
   interrupt; dma engine start to transfer the second block automatically
   (because it was enqueued in trigger)
4) lowlevel driver calls snd_pcm_period_elapsed() in the interrupt handler
5) midlevel code decides in the snd_pcm_period_elapsed() if underrun 
   occured (no more data) and if this condition is true, trigger(STOP)
   callback is called and the lowlevel driver aborts the DMA operation
6) if midlevel code has enough data from application - no trigger callback
   is called
7) lowlevel driver should enqueue next DMA block (period) ahead - this 
   operation might be done in the start of interrupt handler before 
   snd_pcm_period_elapsed() is called

So, in this algorithm, there is only a very small time window between
the interrupt condition and aborting of the DMA transfer in the 
trigger(STOP) callback which is acceptable. Note that underruns or 
overruns (xruns in our terminology ;-)) are bad and should not happen
when the system has a good configuration. So a transfer of a few "wrong" 
samples is acceptable in this case.

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
