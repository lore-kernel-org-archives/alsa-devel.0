From: jfm3 <jfm3@ouroboros-complex.org>
Subject: more or less pcmcia hdsp problems
Date: 12 May 2003 00:56:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052714907.1296.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: ALSA Developer List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Planet CCRMA: kernel 2.4.20+stuff, alsa 0.9.2

OK. I get further after putting this into the first lines of
/etc/rc.sysinit:

modprobe pcmcia_core
modprobe yenta_socket
modprobe ds
modprobe snd-hammerfall-mem

dmesg output:
PCI: Enabling device 01:00.0 (0080 -> 0082)
Hammerfall memory allocator: buffers allocated for 1 cards
PCI: Setting latency timer of device 01:00.0 to 64
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:508: Hammerfall-DSP: no
Digiface or Multiface connected!
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:4092: card initialization
pending : waiting for firmware

edited lspci -vv output:
01:00.0 Multimedia audio controller: Xilinx, Inc. RME Hammerfall DSP
(rev 0b)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 17800000 (32-bit, non-prefetchable)
[size=64K]

hdsploader output:
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : RME Hammerfall DSP at 0x17800000, irq 9
Upload firmware for card hw:0
<<< good long pause >>>
Hwdep ioctl error on card hw:0 : Input/output error.

Yell at me if this belongs on alsa-user. I honestly can't tell.

Is this one of those "your firmware is too new" problems I've heard so
much about?

-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
