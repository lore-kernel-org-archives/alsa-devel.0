From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: FW: DMA producer/consumer
Date: Fri, 12 Mar 2004 10:49:12 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403121042540.2696@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F290AE@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA09F290AE@DBDE01>
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

> hi Jaroslav,
> 	yeah I completely agree with you.  We can always queue upfront, and
> then in interrupt context queue next period.  But the only issue I see is
> that when we queue a next period, are we sure that the middle layer has
> already filled up this next period fully.  Don't we have to check this
> before queueing a next period.  

Ok, but when are samples transferred to the codec (or better - taken from
the memory)? There is usually only small fifo (16-64 bytes or something
like this) on the bus which is continuously filled. The audio samples are
filled ahead from application, too. So the time frame where "broken"
samples can be transferred to end device is very small so you don't need
to check for this condition in the lowlevel driver. As far, as I know, all
audio hardware works in this way.

I assume that the DMA engine does DMA transfers for you and the DMA 
engine works with samples directly from the ALSA's ring buffer. If this 
assumption is not true (you have to prepare/copy samples to another 
location for the DMA engine), then it might be problem and you need to 
solve it in another way as Takashi suggested.


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
