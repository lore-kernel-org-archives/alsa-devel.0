From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: FW: DMA producer/consumer
Date: Fri, 12 Mar 2004 15:29:23 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA09F290B1@DBDE01>
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

	No no I was asking about the transfer of data from Application to
the ring buffer (which is performed by ALSA middle layer),  let me reframe
the doubt I have.  
When we queue a next period to the DMA engine, we have no idea whether data
for the next period has been already filled up ( filled up means --> data
filled up by Alsa middle layer , which is sent by the application ).  So
before queueing a next period to the DMA engine we will have to check
whether the ring buffer has sufficient data or not (because DMA will
transfer even if it is empty).  And for that purpose we might need to use
appl_ptr , which you said is a bad idea.

regards
-kshitij

ps: the assumptions you said about small fifo and DMA engine are also true

-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Friday, March 12, 2004 3:19 PM
To: Gupta, Kshitij
Cc: Takashi Iwai; alsa-devel@lists.sourceforge.net
Subject: RE: FW: [Alsa-devel] DMA producer/consumer


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
