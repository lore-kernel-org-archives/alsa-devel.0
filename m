From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: FW: DMA producer/consumer
Date: Fri, 12 Mar 2004 15:11:06 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F290AE@DBDE01>
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

hi Jaroslav,
	yeah I completely agree with you.  We can always queue upfront, and
then in interrupt context queue next period.  But the only issue I see is
that when we queue a next period, are we sure that the middle layer has
already filled up this next period fully.  Don't we have to check this
before queueing a next period.  
regards
-kshitij

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Friday, March 12, 2004 3:03 PM
To: Gupta, Kshitij
Cc: Takashi Iwai; alsa-devel@lists.sourceforge.net
Subject: RE: FW: [Alsa-devel] DMA producer/consumer


On Fri, 12 Mar 2004, Gupta, Kshitij wrote:

> hi,
> 
> 	Even thought the SA11xx ARM platform DMA engine has a queueing
> mechanism (as you mentioned), it is not being utilized.  Since we are
> queueing(or starting) the next dma transfer in the interrupt context, and
we
> recieve this interrupt only when the previous dma transfer ends.  Queueing

It's bad usage. For SA11xx (see sa1100_start_dma function in 2.6 kernels),
you can queue one buffer while other is running. So, you need to queue two
blocks (periods) at the start of stream in trigger() and later - in the
interrupt contents - queue next period ahead.

I admit that the current SA11xx code in ALSA driver is for 2.4 kernels 
where the queuing mechanism was not very good.

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
