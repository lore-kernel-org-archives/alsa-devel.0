From: nick mainsbridge <beatroot@optushome.com.au>
Subject: Re: problems with 0.9.8 drivers and rme9652
Date: 19 Nov 2003 03:05:05 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069171504.382.36.camel@datablender>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello,
i'm having the same problems with my hammerfall digi9652 and
alsa-driver-0.9.8 that were reported by Martin Dausel.
i'm using kernel 2.4.22 SMP with capabilities and low latency patches on
a dual pIII system.
alsa-driver-0.9.7c works fine with the same system.

after compiling using --with-debug=detect or 'full' i only get the
mysterious "Nov 19 02:37:02 datablender kernel: RME Digi9652/Digi9636:
no cards found" in /var/log/messages.

anyway, here's some more useful(?) information;

lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
        Flags: bus master, medium devsel, latency 16
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: dbe00000-ddefffff
        Prefetchable memory behind bridge: d7c00000-dbcfffff
        Capabilities: [80] Power Management version 2
 
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
 
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master
IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
 
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
 
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2
 
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Flags: medium devsel, IRQ 5
        Capabilities: [68] Power Management version 2
 
00:09.0 Multimedia audio controller: Xilinx, Inc. RME Digi9652
(Hammerfall) (rev 03)
        Flags: bus master, stepping, slow devsel, latency 64, IRQ 17
        Memory at df000000 (32-bit, non-prefetchable) [size=16M]
 
00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at d400 [size=128]
        Memory at deffff80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at defc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
 
01:00.0 VGA compatible controller: nVidia Corporation RIVA TNT2 Model 64
(rev 15) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc. AGP-V3800M
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
        Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at ddef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

modprobe snd-rme9652
/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o: init_module:
No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o: insmod
/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o failed
/lib/modules/2.4.22/kernel/sound/pci/rme9652/snd-rme9652.o: insmod
snd-rme9652 failed

-- 
nick mainsbridge <beatroot@optushome.com.au>



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
