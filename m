From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: cs46xx capture dropout on busy systems
Date: Wed, 28 Jan 2004 09:16:24 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401280913480.2015@pnote.perex-int.cz>
References: <5.2.1.1.0.20040127224801.00a8b6b0@pop3.fone.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5.2.1.1.0.20040127224801.00a8b6b0@pop3.fone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Perry Scott <perry@ezlink.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Jan 2004, Perry Scott wrote:

> [2.4.23]
> 
> I've been chasing a capture dropout in the old OSS cs46xx driver 
> (drivers/sound/cs46xx.c) for the past two months (evenings and weekends), 
> and I finally nailed it.  I looked over at the ALSA driver, and I think I 
> see the same problem there as well.  I traced the peek/poke(PD1_CBA) from 
> the update_ptr routine to the read routine, so I'm pretty confident the bug 
> is there.
> 
> Briefly, I'm doing 8-channel recording, using 4 TB Santa Cruz 
> cards.  Occasionally, one of the cards loses a chunk of data.  I traced the 
> problem to the 4k dma buffer size.  The IRQ updates the capture pointer, 
> but it only has a 1/44th second real-time latency before it loses data.  If 
> the read doesn't get reposted by the application within that time, data 
> will be lost.  All it really takes is a busy system - either an IRQ from 
> another card, or another thread getting in the way.
> 
> I fixed the problem in the OSS driver by copying the 4k ping-pong into a 
> larger buffer, which is then drained by read().  Essentially, I implemented 
> the Scatter/Gather in the ISR.  It's not pretty, but it 
> works.  (Incidentally, if anyone has found the Cirrus documentation on 
> cs46xx capture S/G, I'd be most appreciative.  The only document I found in 
> the ALSA documentation archive glibly said that S/G is "complicated" and 
> that 1/44th second should be OK - yeah, right.)
> 
> This problem is likely to affect *any* sound card with a 4k dma 
> ping-pong.  I'm not sure if the cs46xx is the only pathological case out 
> there, but I wouldn't be surprised if there are others.  The really 
> disturbing thought is that ALSA itself has real-time issues because 4k is a 
> common dma size (say it isn't so!)
> 
> I'm a couple weeks away from porting my application to ALSA, so if someone 
> else wants to load up a bunch of sound cards, feel free.  I'm finding the 
> bug injecting a sine wave into the four cards, then looking for large 
> deltas from one sample to the next.
> 
> Comments?

Yes, we effectively use large buffer as well. Look to indirect_pointer()  
routines - we copy data from the 4k DMA buffer here. So you can have for
example 128k buffer. Of course, the 4k (resp. 2k limit for one chunk) is
limit only for interrupt latency, but if your system is well tuned, it
should be ok. In other words, we do things in same way as you use in the 
OSS code.

Note that the most of soundcards have at least 64k DMA buffer for samples.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
