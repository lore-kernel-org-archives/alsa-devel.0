From: Tom Watson <sdc695@yahoo.com>
Subject: Re: Attempts on the ESS-1869 card (one more time)
Date: Sun, 2 May 2004 01:48:29 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040502084829.56484.qmail@web60801.mail.yahoo.com>
References: <403e519e.johana@johana.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <403e519e.johana@johana.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com, alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Well, I've gone to another Compaq laptop.  The previous one I had to
resort to OSS (yuck) drivers and send it on its way.  This laptop is
one I'm going to use, so I'd like to get ALSA working on it.

So...  I've loaded ALSA and put the following in 'modules.conf':
alias char-major-116 snd
alias snd-card-0 snd-es18xx
options snd-es18xx index=1 id=1 enable=1 isapnp=0 port=0x220 ...
mpu_port=0x330 fm_port=0x338 irq=5 dma1=1 dma2=0

(please excuse the line wraps)

But alas, nothing works.  I even tried using the sound blaster stuff
mentioned in the other part of this email (nope, doesn't work either).

So, what IS the deal.  This ought to work.  I'm trying to do this on a
Compaq Presario 1244, Alsa V 1.0.3, Kernel 2.4.20 (RH-9).


--- James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> Looks like a Sound Blaster compatible.
> Try
> modprobe snd-sb16 enable=1 isapnp=0 port=0x0220 mpu_port=0x330 irq=5 
> dma8=1 dma16=5
> 
> Cheers
> James
> 
> 
> Tom Watson wrote:
> > Ah, a new card to try...
> > This time it is an Ensonic ESS-1869 that is built into an older
> Compaq
> > laptop (Armada 3500).  When I put in the "setup" disk, it reports
> that
> > the sound card has the following I/O stuff:
> > IRQ 5
> > DMA 1
> > DMA 5
> > ports at 0x0220 thru 0x022F   (16 ports)
> > ports at 0x0388 thru 0x038B   (4 ports)
> > ports at 0x0330 thru 0x0331   (2 ports)
> > some other port range at 0x0250 thru 0x0257   (8 ports).
> > 
> > In reading the driver I see that "port" reserves 16, "fm_port"
> reserves
> > 4, and "mpu_port" reserves 2.
> > 
> > Being a "nice guy" I attempt to load the module with insmod, and
> the
> > file "modules.conf" has:
> > ...
> > alias snd-card-0 snd-es18xx
> > options snd-es18xx id="first" enable=1 dma1=1 dma2=5 irq=5
> port=0x220 \
> >    fm_port=0x338 mpu_port=0x330
> > ...
> > 
> > But all is not well as I get an error upon doing an insmod:
> > .../es18xx.c:2256: ESS AudioDrive ES18xx soundcard not found or
> device
> > busy.
> > 
> > Am I missing something simple to get this thing working??  From the
> > look of things, I should have all the stuff working.  I even
> attempted
> > to try an ISAPNP, but that didn't appear to work either.
> > 
> > Any better ideas from the group.
> > 
> > ...Thanks
> > 
> > =====
> 
> -- 
> Tom Watson         Generic short signature
> tsw@johana.com     (I'm at home now)


=====
-- 
Tom Watson
tsw@johana.com


	
		
__________________________________
Do you Yahoo!?
Win a $20,000 Career Makeover at Yahoo! HotJobs  
http://hotjobs.sweepstakes.yahoo.com/careermakeover 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
