From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP CardBus issue - /proc/ioports /proc/iomem
Date: Sat, 18 May 2002 16:49:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1795WT-0000Dc-00@satellite>
Reply-To: thomas@undata.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from satellite (ALyon-101-1-6-151.abo.wanadoo.fr [217.128.18.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA06782
	for <alsa-devel@alsa-project.org>; Sat, 18 May 2002 16:58:09 +0200
Received: from toma by satellite with local (Exim 3.35 #1 (Debian))
	id 1795WT-0000Dc-00
	for <alsa-devel@alsa-project.org>; Sat, 18 May 2002 16:49:29 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There seems to be no difference in /proc/ioports and /proc/iomem before and 
after insertion.
Though, cardctl ident gives:
Socket 0:
  product info: "Martin Kirst", "Hammerfall DSP", "CardBus Audio Card 1.00"
Socket 1:
  no product info available

and /proc/pci shows the card on pci bus 3:
  Bus  3, device   0, function  0:
    Multimedia audio controller: PCI device 10ee:3fc5 (rev 10).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0xd2400000 [0xd20fffff].

It seems you were right, Paul, it isn't an ALSA issue.
Maybe I should try kernel 2.4.19-pre8 ?

Thomas



Before card insertion:

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : PCI device 8086:248a (Intel Corp.)
  0170-0177 : ide1
01f0-01f7 : PCI device 8086:248a (Intel Corp.)
  01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : PCI device 8086:248a (Intel Corp.)
  0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : PCI device 8086:248a (Intel Corp.)
  03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1800-181f : PCI device 8086:2482 (Intel Corp.)
  1800-181f : usb-uhci
1820-183f : PCI device 8086:2484 (Intel Corp.)
  1820-183f : usb-uhci
1840-185f : PCI device 8086:2487 (Intel Corp.)
  1840-185f : usb-uhci
1860-186f : PCI device 8086:248a (Intel Corp.)
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : PCI device 8086:2483 (Intel Corp.)
18c0-18ff : Intel Corp. AC'97 Audio Controller
1c00-1cff : Intel Corp. AC'97 Audio Controller
2000-207f : PCI device 8086:2486 (Intel Corp.)
2400-24ff : PCI device 8086:2486 (Intel Corp.)
3000-3fff : PCI Bus #02
  3000-30ff : Realtek Semiconductor Co., Ltd. RTL-8139
    3000-30ff : 8139too

/proc/iomem
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ce800-000cf7ff : Extension ROM
000d8000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-00288f19 : Kernel code
  00288f1a-003164d3 : Kernel data
0fef0000-0fefefff : ACPI Tables
0feff000-0fefffff : ACPI Non-volatile Storage
0ff00000-0ff7ffff : System RAM
0ff80000-0fffffff : reserved
d0000000-d00003ff : PCI device 8086:248a (Intel Corp.)
d1000000-d1ffffff : PCI Bus #01
  d1000000-d1ffffff : nVidia Corporation GeForce2 Go
d2000000-d20fffff : PCI Bus #02
  d2000000-d2003fff : PCI device 104c:8023 (Texas Instruments)
  d2004000-d20047ff : PCI device 104c:8023 (Texas Instruments)
    d2004000-d20047ff : ohci1394
  d2004800-d20048ff : Realtek Semiconductor Co., Ltd. RTL-8139
    d2004800-d20048ff : 8139too
  d2004c00-d2004c1f : PCI device 1179:0804 (Toshiba America Info Systems)
  d2005000-d2005fff : Texas Instruments PCI1420
  d2006000-d2006fff : Texas Instruments PCI1420 (#2)
e0000000-efffffff : PCI device 8086:3575 (Intel Corp.)
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation GeForce2 Go
ffb80000-ffbfffff : reserved
fffffc00-ffffffff : reserved


After insertion:

/proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : PCI device 8086:248a (Intel Corp.)
  0170-0177 : ide1
01f0-01f7 : PCI device 8086:248a (Intel Corp.)
  01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : PCI device 8086:248a (Intel Corp.)
  0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : PCI device 8086:248a (Intel Corp.)
  03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1800-181f : PCI device 8086:2482 (Intel Corp.)
  1800-181f : usb-uhci
1820-183f : PCI device 8086:2484 (Intel Corp.)
  1820-183f : usb-uhci
1840-185f : PCI device 8086:2487 (Intel Corp.)
  1840-185f : usb-uhci
1860-186f : PCI device 8086:248a (Intel Corp.)
  1860-1867 : ide0
  1868-186f : ide1
1880-189f : PCI device 8086:2483 (Intel Corp.)
18c0-18ff : Intel Corp. AC'97 Audio Controller
1c00-1cff : Intel Corp. AC'97 Audio Controller
2000-207f : PCI device 8086:2486 (Intel Corp.)
2400-24ff : PCI device 8086:2486 (Intel Corp.)
3000-3fff : PCI Bus #02
  3000-30ff : Realtek Semiconductor Co., Ltd. RTL-8139
    3000-30ff : 8139too

/proc/iomem
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ce800-000cf7ff : Extension ROM
000d8000-000dffff : reserved
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-00288f19 : Kernel code
  00288f1a-003164d3 : Kernel data
0fef0000-0fefefff : ACPI Tables
0feff000-0fefffff : ACPI Non-volatile Storage
0ff00000-0ff7ffff : System RAM
0ff80000-0fffffff : reserved
d0000000-d00003ff : PCI device 8086:248a (Intel Corp.)
d1000000-d1ffffff : PCI Bus #01
  d1000000-d1ffffff : nVidia Corporation GeForce2 Go
d2000000-d20fffff : PCI Bus #02
  d2000000-d2003fff : PCI device 104c:8023 (Texas Instruments)
  d2004000-d20047ff : PCI device 104c:8023 (Texas Instruments)
    d2004000-d20047ff : ohci1394
  d2004800-d20048ff : Realtek Semiconductor Co., Ltd. RTL-8139
    d2004800-d20048ff : 8139too
  d2004c00-d2004c1f : PCI device 1179:0804 (Toshiba America Info Systems)
  d2005000-d2005fff : Texas Instruments PCI1420
  d2006000-d2006fff : Texas Instruments PCI1420 (#2)
e0000000-efffffff : PCI device 8086:3575 (Intel Corp.)
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation GeForce2 Go
ffb80000-ffbfffff : reserved
fffffc00-ffffffff : reserved


_______________________________________________________________
Hundreds of nodes, one monster rendering program.
Now that's a super model! Visit http://clustering.foundries.sf.net/
