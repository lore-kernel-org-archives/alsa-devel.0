From: Tom Watson <sdc695@yahoo.com>
Subject: Re: Attempts on the ESS-1869 card
Date: Thu, 26 Feb 2004 18:34:33 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040227023433.64429.qmail@web60808.mail.yahoo.com>
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
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

The documentation seems to imply sound blaster compatable as well.  So
I tried that driver, as suggested (thanks!) and got a similar result:
"...snd-sb16.o: init_module: No such device"
"Hint..."

Oh, well.  Any new ideas??  Does anyone have experience with this
laptop and its sound card??

...Thanks again
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


=====
-- 
Tom Watson
tsw@johana.com

__________________________________
Do you Yahoo!?
Get better spam protection with Yahoo! Mail.
http://antispam.yahoo.com/tools


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
