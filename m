From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002245]: Master volume is controlled
	via the "Headphone" mixer element and not via "Master
Date: Thu, 29 Jun 2006 16:47:00 +0200
Message-ID: <6c6c171dfe72921a918c76fe7f30d4d7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6338829C
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 16:47:00 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2245> 
======================================================================
Reported By:                calestyo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2245
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.17
======================================================================
Date Submitted:             06-29-2006 01:43 CEST
Last Modified:              06-29-2006 16:46 CEST
======================================================================
Summary:                    Master volume is controlled via the "Headphone"
mixer element and not via "Master
Description: 
I have the following ALSA devices:
$ cat /proc/asound/cards
 0 [default        ]: Aureon71Universe -
                       at 0x3880, irq 74
 1 [CK804          ]: NFORCE - NVidia CK804
                      NVidia CK804 with AD1981B at 0xb0002000, irq 217
 2 [U0x46d0x8b2    ]: USB-Audio - USB Device 0x46d:0x8b2
                      USB Device 0x46d:0x8b2 at usb-0000:00:02.0-3, full

The problem is with #1 which uses snd-intel8x0.

When I play any sounds and change the values for "Master" or "Master Mono"
nothing happens at all. But what one would expect from "Master" is done by
the "Headphone" mixer element.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-29-06 16:33 
----------------------------------------------------------------------
Use ac97_quirk=hp_only module option.
If it works, show the output of lspci -nv (for class 0401 device only).

----------------------------------------------------------------------
 calestyo - 06-29-06 16:46 
----------------------------------------------------------------------
Yes that works. I now no longer have a "Headphone" mixer element but still
a "Head phone Jack Sense" which I can mute/unmute without anything
happening (what is it good for at all (both the Headphone/Headphone Jack
Sense)?

# lspci
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev
a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio
Controller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev
f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev
f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link)
02:00.0 VGA compatible controller: nVidia Corporation GeForce 7800 GTX
(rev a1)
08:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12)
08:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
08:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
(rev 12)
08:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
0a:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-MPT Dual Ultra320 SCSI (rev 07)
0a:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X
Fusion-MPT Dual Ultra320 SCSI (rev 07)
0a:09.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
80:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev
a3)
80:01.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev
a3)
80:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
80:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)


lspci -nv

....

00:04.0 0401: 10de:0059 (rev a2)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
        I/O ports at 1800 [size=256]
        I/O ports at 1400 [size=256]
        Memory at b0002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

....

0a:09.0 0401: 1412:1724 (rev 01)
        Subsystem: 153b:1153
        Flags: bus master, medium devsel, latency 64, IRQ 74
        I/O ports at 3880 [size=32]
        I/O ports at 3800 [size=128]
        Capabilities: [80] Power Management version 1

....

Note that the 2nd entry is probably from my 2nd soundcard which had no_
problems... !!!
So only 00:04.0 should be interesing for you,.. right?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 01:43 calestyo       New Issue                                    
06-29-06 01:43 calestyo       Distribution              => Debian GNU/Linux
06-29-06 01:43 calestyo       Kernel Version            => 2.6.17          
06-29-06 16:33 tiwai          Note Added: 0010661                          
06-29-06 16:46 calestyo       Note Added: 0010663                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
