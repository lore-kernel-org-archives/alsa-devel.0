From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: FW: DMA producer/consumer
Date: Fri, 12 Mar 2004 10:32:50 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403121029370.2696@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F290AC@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA09F290AC@DBDE01>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Mar 2004, Gupta, Kshitij wrote:

> hi,
> 
> 	Even thought the SA11xx ARM platform DMA engine has a queueing
> mechanism (as you mentioned), it is not being utilized.  Since we are
> queueing(or starting) the next dma transfer in the interrupt context, and we
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
