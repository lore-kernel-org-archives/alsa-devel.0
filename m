From: Andrei Boros <andrei@srr.ro>
Subject: Re: Opti92x-ad1848 won't take Opti924 card
Date: Wed, 24 Sep 2003 14:24:07 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F717ED7.15306C51@srr.ro>
References: <Pine.HPX.4.33n.0309230903041.1405-100000@studcom.urz.uni-halle.de>
	 <3F7001AF.C13AC3CC@srr.ro> <Pine.LNX.4.53.0309231107220.10953@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Jaroslav Kysela wrote:
> 
> > > Andrei Boros wrote:
> > > > options snd-opti-92x-ad1848     index=1 isapnp=1 id="Opti924" port=0x220
> > > > irq=5 dma1=0 fm_port=0x380 mpu_port=0x300 mpu_irq=7
> > I corrected it to 0x388. Doesn't work

> > snd-isapnp module is not loaded automatically.
> >
> > If I load it manually, I see the following in the log :
> > kernel: isapnp: Card 'OPTi Audio 16'
> > kernel: isapnp: 1 Plug & Play card detected total
> >
> > Then modprobe snd-opti92x-ad1848 says :
> > kernel: no OPTi 82C92x soundcard found
> 
> Send us the contents of /proc/isapnp after 'modprobe snd-isapnp'.
> 

modprobe snd-isapnp

---------------------------------------------------------------
Card 1 'OPT0924:OPTi Audio 16' PnP version 1.0
  Logical device 0 'OPT0000:Pro Audio 16'
    Device is not active
    Active port 0x220
    Resources 0
      Priority preferred
      Port 0x220-0x240, align 0x1f, size 0x10, 10-bit address decoding
      Port 0x130-0x3f0, align 0x3, size 0x8, 10-bit address decoding
    Resources 1
      Priority acceptable
      Port 0x380-0x380, align 0xf, size 0xc, 10-bit address decoding
      IRQ 5,7,10 High-Edge
      DMA 0,1,3 8-bit compatible
      Alternate resources 1:1
        Priority acceptable
        Port 0x380-0x3f0, align 0xf, size 0xc, 10-bit address decoding
        IRQ 5,7,2/9,10,11 High-Edge
        DMA 0,1,3 8-bit compatible
        DMA 0,1,3 8-bit compatible
  Logical device 1 'OPT0001:Game Port'
    Compatible device PNPb02f
    Device is not active
    Resources 0
      Priority acceptable
      Port 0x201-0x201, align 0x0, size 0x1, 10-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x100-0x3f0, align 0xf, size 0x2, 10-bit address decoding
  Logical device 2 'OPT0002:MPU401'
    Device is not active
    Active port 0x300
    Active IRQ 9 [0x2]
    Resources 0
      Priority preferred
      Port 0x300-0x330, align 0xf, size 0x2, 10-bit address decoding
      IRQ 5,7,2/9,10 High-Edge
  Logical device 3 'OPT0003:CD'
    Compatible device PNP0600
    Device is active
    Active port 0x376,0x170
    Active IRQ 15 [0x2]
    Resources 0
      Priority preferred
      IRQ 15 High-Edge
    Resources 1
      Priority acceptable
      Port 0x376-0x376, align 0xf, size 0x2, 10-bit address decoding
      Port 0x170-0x170, align 0xf, size 0x8, 10-bit address decoding
      Alternate resources 1:1
        Priority acceptable
        Port 0x376-0x3f6, align 0xf, size 0x2, 10-bit address decoding
        Port 0x170-0x3f0, align 0xf, size 0x8, 10-bit address decoding
  Logical device 4 'OPT0004:Modem'
    Compatible device PNP0500
    Device is not active
    Resources 0
      Priority preferred
      IRQ 3,4,5,7,2/9,10,11 High-Edge
    Resources 1
      Priority acceptable
      Port 0x2e8-0x2f8, align 0xf, size 0x8, 10-bit address decoding
      Alternate resources 1:1
        Priority acceptable
        Port 0x3e8-0x3f8, align 0xf, size 0x8, 10-bit address decoding
      Alternate resources 1:2
        Priority acceptable
        Port 0x100-0x3f0, align 0xf, size 0x8, 10-bit address decoding
  Logical device 5 'OPT0005:OPT924'
    Device is not active
    Active port 0x30d
    Resources 0
      Priority preferred
      Port 0x30d-0x3ed, align 0x1f, size 0x9, 10-bit address decoding
    Resources 1
      Priority acceptable
      IRQ 5,10,11 High-Edge




-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
