From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: Dma query
Date: Thu, 26 Feb 2004 15:26:11 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402261518490.13076@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F29032@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA09F29032@DBDE01>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 26 Feb 2004, Gupta, Kshitij wrote:

> Hi,
> 	So does that mean that the __next period__ DMA transfer parameters
> should be set in the interrupt routine(end of transfer of one period).  But
> to set the next DMA transfer params we must know the start address of the
> buffer which the middle layer has filled (and if the middle layer has filled
> up more than one buffers then this buffer should be at the head of the
> list).
> Also one more point is that the hardware provides us the mechanism of
> linking the DMA channels ( linking means that once one dma channel finishes
> the transfer other one starts automatically).  So this feature provides us
> the facility of queuing up the DMA transfers.
> regards
> -kshitij

Basically, we only copy the soundcard hardware and old ISA DMA engine 
which is same as for PCI hardware etc.

The buffer size is divided to subblocks (we call them periods). These 
periods determine spaces between interrupts and it's not necessary that
buffer_size == period_size * N (where N is an integer). Some hardware 
(like ISA DMA controllers) can do any period sizes.

So, simply program your DMA controller to runtime->dma_addr + offset 
for actual period and next periods. If you allow to set any period size, 
then you need also handle shifts (you can avoid this by settings
snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) ).

> ps: one more nasty question I wanted to ask on the list was about how much
> time does it take to write a driver(from scratch) with such a complex
> framework ;)...probably just sharing experiences....

One week with full debugging. And I don't think that coding drivers is 
complex, but it's required to know what's going on in the midlevel code
and you need to know the Linux kernel side memory handling.

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
