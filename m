From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: 02 micro 6933 cardbus controller creates problem
 with the hammerfall dsp driver
Date: Tue, 10 Feb 2004 17:14:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040210171427.4c72d331@laptop>
References: <20040208191040.191bcd24@laptop>
	<4026C668.7060905@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4026C668.7060905@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pcmcia-cs-devel@lists.sourceforge.net
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi all,

i tried to run the hammerfall dsp using the pcmcia-cs driver for the
yenta-socket instead of the kernel driver and the behaviour of the card
is the same ...

so, do you have any insights, what's the difference between both
drivers, or what is the same? is there anything, that could cause such a
problem (related to dmas ... see below)?

the dmesg output for the pcmcia-cs system is:
Linux PCMCIA Card Services 3.2.7
  kernel build: 2.4.24-ck1 #3 Fri Feb 6 17:40:50 CET 2004
  options:  [pci] [cardbus]
Intel ISA/PCI/CardBus PCIC probe:
PCI: Found IRQ 5 for device 02:00.0
PCI: Sharing IRQ 5 with 01:00.0
PCI: Found IRQ 11 for device 02:00.1
PCI: Sharing IRQ 11 with 00:1f.3
PCI: Sharing IRQ 11 with 00:1f.5
PCI: Sharing IRQ 11 with 00:1f.6
  O2Micro OZ6933 rev 01 PCI-to-CardBus at slot 02:00, mem 0x20000000
    host opts [0]: [pci/way] [pci irq 5] [lat 168/176] [bus 3/6]
    host opts [1]: [pci/way] [pci irq 11] [lat 168/176] [bus 7/10]
    ISA irqs (default) = 3,4,7,9,10 PCI status changes
cs: cb_alloc(bus 7): vendor 0x10ee, device 0x3fc5
PCI: Enabling device 07:00.0 (0080 -> 0082)
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:663: Hammerfall-DSP: no
Digiface or Multiface connected! ALSA
../../alsa-kernel/pci/rme9652/hdsp.c:5052: card initialization pending :
waiting for firmware ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:807: wait
for FIFO status <= 0 failed after 30 iterations ALSA
../../alsa-kernel/pci/rme9652/hdsp.c:4711: initializing firmware upload
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:678: loading firmware ALSA
../../alsa-kernel/pci/rme9652/hdsp.c:716: finished firmware loading


> > i'm experiencing problems with the O2 micro 6933 card when trying to
> > use the hammerfall dsp sound device. i'm using the yenta socket
> > driver (the O2 micro 6933 should be 100% compatible to the yenta
> > socket)
> > 
> > i met thomas charbonnel, who maintains the alsa driver of the hdsp,
> > and concerning him, it seems to be a problem of the dma mapping in
> > the cardbus-pci bridge ... the alsa driver is working fine, until it
> > starts dma (to output sounds) ... (thomas, please correct me if i'm
> > saying something completely stupid, i'm a musician, not a kernel
> > hacker)
> > 
> 
> I believe a little more background information is needed. Tim's card
> is a busmaster carbus audio card capable of hardware routing, that is
> any audio stream arriving on the physical inputs of the card can be
> routed to any physical output without involving the computer in any
> way (this is done using an FPGA chip). The card can also do hardware
> peak and rms computation on incoming and playback streams. On Tim's
> machine the card is detected and initialized properly, and hardware
> routing works as expected until audio interrupts are enabled. Then
> something strange happens : parts of the incoming audio streams are
> found in the card's playback buffer (rms and peak values are reported
> for those signals), but the driver is not involved in this process. I
> got this piece of information from Martin Bjoernsen at RME, the
> company manufacturing the card :
> 
> "The HDSP cards use an internal double buffer per channel of 2*16 
> samples. Data is transferred in blocks of 16 samples. Every 16 samples
> 
> 16 samples per channel are read and written to and from the main
> memory. In the card the same buffer is used for inputs and outputs.
> Playback data is overwritten from new recorded data. If the hardware
> is started and an output dma channel is not enabled but the input is,
> you will hear the input delayed by 32 samples or silence when there is
> no input signal."
> 
> The driver does enable both input and output dma channels for all 
> possible streams, so my guess for now is that there is something wrong
> 
> in the underlying subsystem.
> 
> I hope this helps track the problem down.
> 
> Thomas
> 
> 
thanks a lot...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
