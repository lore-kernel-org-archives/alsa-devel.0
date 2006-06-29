From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002244]: Aureon 7.1 Universe speakers
	in incorrect order when doing a speaker-test
Date: Thu, 29 Jun 2006 17:50:57 +0200
Message-ID: <44b71def985d7894d2cee791d0764e29@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26DEC29A
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 17:50:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2244> 
======================================================================
Reported By:                calestyo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2244
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.17
======================================================================
Date Submitted:             06-29-2006 01:35 CEST
Last Modified:              06-29-2006 17:50 CEST
======================================================================
Summary:                    Aureon 7.1 Universe speakers in incorrect order when
doing a speaker-test
Description: 
I use my Aureon 7.1 Universe with a TerraTec HomeAreon TXR 884 7.1 speaker
set.

I've connected the outputs of the soundard to those of the subwoofer
which
itself connects the small speakers the following way:

Soundcard -------------- Subwoofer --- Small Speakers
Out Front <---------+--> In FL <-----> Front Left Speaker
                    \--> In FR <-----> Font Right Speaker
Out Rear <----------+--> In SL <-----> Side Left Speaker
                    \--> In SR <-----> Side Right Speaker
Out Center/Subwoofer <-> In C <------> Center Speaker
                      \> In Subwoofer
Out Back Surround <----> In BL <-----> Back Left Speaker
                    \--> In BR <-----> Back Right Speaker

You might have a look at soundcard manual page 8
(http://supportuk.terratec.net/modules.php?op=modload&name=Downloads&file=index&req=getit&lid=574)
and speaker manual page 12
(http://supportuk.terratec.net/modules.php?op=modload&name=Downloads&file=index&req=getit&lid=724)
My speakers are placed in my room in a configuration as the 7.1 shown on
page 12
in the speaker manual.

As you note the connection from rear to side is a little bit strange (at
least I
thought so,...) but this seems to be correct, because when I use the
windows
mixer supplied by TerraTec itself, there is a surround test included which
shows
the position of the 8 speakers and let me put the indiviually on and off
and
this leads always to the correct position.

The problem now: I tried the same as under Windows unter Linux with the
speaker-test tool.
I called it via speaker-test -t wav -c 8 and the following came out:
What wav file was played ----- in which speaker position the wav file was
played
"Front Left" ----------------- Front Left Speaker  (correct)
"Front Center" --------------- Center Speaker      (correct)
"Front Right" ---------------- Front Right Speaker (correct)
"Side Right" ----------------- Back Right Speaker  (probably wrong!)
"Rear Right" ----------------- Side Right Speaker  (probably wrong!)
"Rear Left" ------------------ Side Left Speaker  (probably wrong!)
"Side Left" ------------------ Back Left Speaker  (probably wrong!)
"LFE" ------------------------ Subwoofer (correct)

No one could think that I should just switch the speaker cables but that
can't
be a proper solution (not only because this would break settings in the
original
Windows driver (which I only use for Upgrading my Plextor drive firmware
;) ).
I think the configuration of the surround for the Aureon 7.1 Universe has
here
some mistake, hasn't it?
======================================================================

----------------------------------------------------------------------
 calestyo - 06-29-06 16:19 
----------------------------------------------------------------------
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


# lspci -vn
00:00.0 0580: 10de:005e (rev a3)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 0601: 10de:0051 (rev a3)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at <ignored>

00:01.1 0c05: 10de:0052 (rev a2)
        Subsystem: 10f1:2895
        Flags: 66MHz, fast devsel
        I/O ports at 1000 [size=32]
        I/O ports at a000 [size=64]
        I/O ports at a040 [size=64]
        Capabilities: [44] Power Management version 2

00:02.0 0c03: 10de:005a (rev a2) (prog-if 10)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 201
        Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.1 0c03: 10de:005b (rev a3) (prog-if 20)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 66
        Memory at b0001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:04.0 0401: 10de:0059 (rev a2)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
        I/O ports at 1800 [size=256]
        I/O ports at 1400 [size=256]
        Memory at b0002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:06.0 0101: 10de:0053 (rev f2) (prog-if 8a)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at 1c00 [size=16]
        Capabilities: [44] Power Management version 2

00:07.0 0101: 10de:0054 (rev f3) (prog-if 85)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
        I/O ports at 1c40 [size=8]
        I/O ports at 1c34 [size=4]
        I/O ports at 1c38 [size=8]
        I/O ports at 1c30 [size=4]
        I/O ports at 1c10 [size=16]
        Memory at b0003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=0/2
Enable -
        Capabilities: [cc] HyperTransport: MSI Mapping

00:08.0 0101: 10de:0055 (rev f3) (prog-if 85)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
        I/O ports at 1c58 [size=8]
        I/O ports at 1c4c [size=4]
        I/O ports at 1c50 [size=8]
        I/O ports at 1c48 [size=4]
        I/O ports at 1c20 [size=16]
        Memory at b0004000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=0/2
Enable -
        Capabilities: [cc] HyperTransport: MSI Mapping

00:09.0 0604: 10de:005c (rev a2) (prog-if 01)
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: b0100000-b01fffff
        Capabilities: [8c] HyperTransport: MSI Mapping

00:0a.0 0680: 10de:0057 (rev a3)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 201
        Memory at b0005000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 1c60 [size=8]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/2
Enable -
        Capabilities: [64] HyperTransport: MSI Mapping

00:0e.0 0604: 10de:005d (rev a3)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: b1000000-b2ffffff
        Prefetchable memory behind bridge:
00000000c0000000-00000000cff00000
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1
Enable +
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:18.0 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface
        Capabilities: [a0] HyperTransport: Host or Secondary Interface
        Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:18.1 0600: 1022:1101
        Flags: fast devsel

00:18.2 0600: 1022:1102
        Flags: fast devsel

00:18.3 0600: 1022:1103
        Flags: fast devsel

00:19.0 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface
        Capabilities: [a0] HyperTransport: Host or Secondary Interface
        Capabilities: [c0] HyperTransport: Host or Secondary Interface

00:19.1 0600: 1022:1101
        Flags: fast devsel

00:19.2 0600: 1022:1102
        Flags: fast devsel

00:19.3 0600: 1022:1103
        Flags: fast devsel

01:05.0 0c00: 104c:8023 (prog-if 10)
        Subsystem: 10f1:2895
        Flags: bus master, medium devsel, latency 64, IRQ 58
        Memory at b0104000 (32-bit, non-prefetchable) [size=2K]
        Memory at b0100000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

02:00.0 0300: 10de:0091 (rev a1)
        Subsystem: 1043:81d4
        Flags: bus master, fast devsel, latency 0, IRQ 82
        Memory at b2000000 (32-bit, non-prefetchable) [size=16M]
        Memory at c0000000 (64-bit, prefetchable) [size=256M]
        Memory at b1000000 (64-bit, non-prefetchable) [size=16M]
        I/O ports at 2000 [size=128]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable -
        Capabilities: [78] Express Endpoint IRQ 0

08:0a.0 0604: 1022:7450 (rev 12)
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=08, secondary=09, subordinate=09, sec-latency=0
        Capabilities: [a0] PCI-X bridge device
        Capabilities: [b8] HyperTransport: Interrupt Discovery and
Configuration
        Capabilities: [c0] HyperTransport: Slave or Primary Interface

08:0a.1 0800: 1022:7451 (rev 01) (prog-if 10)
        Subsystem: 10f1:2895
        Flags: bus master, medium devsel, latency 0
        Memory at d0000000 (64-bit, non-prefetchable) [size=4K]

08:0b.0 0604: 1022:7450 (rev 12)
        Flags: bus master, 66MHz, medium devsel, latency 64
        Bus: primary=08, secondary=0a, subordinate=0a, sec-latency=136
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: d0100000-d04fffff
        Prefetchable memory behind bridge:
00000000a4000000-00000000a4100000
        Capabilities: [a0] PCI-X bridge device
        Capabilities: [b8] HyperTransport: Interrupt Discovery and
Configuration

08:0b.1 0800: 1022:7451 (rev 01) (prog-if 10)
        Subsystem: 10f1:2895
        Flags: bus master, medium devsel, latency 0
        Memory at d0001000 (64-bit, non-prefetchable) [size=4K]

0a:06.0 0100: 1000:0030 (rev 07)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 233
        I/O ports at 3000 [size=256]
        Memory at d0200000 (64-bit, non-prefetchable) [size=1M]
        Memory at d0100000 (64-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at a4000000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable -
        Capabilities: [68] PCI-X non-bridge device

0a:06.1 0100: 1000:0030 (rev 07)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 50
        I/O ports at 3400 [size=256]
        Memory at d0400000 (64-bit, non-prefetchable) [size=1M]
        Memory at d0300000 (64-bit, non-prefetchable) [size=1M]
        [virtual] Expansion ROM at a4100000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable -
        Capabilities: [68] PCI-X non-bridge device

0a:09.0 0401: 1412:1724 (rev 01)
        Subsystem: 153b:1153
        Flags: bus master, medium devsel, latency 64, IRQ 74
        I/O ports at 3880 [size=32]
        I/O ports at 3800 [size=128]
        Capabilities: [80] Power Management version 1

80:00.0 0580: 10de:005e (rev a3)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

80:01.0 0580: 10de:00d3 (rev a3)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0
        Memory at d0700000 (32-bit, non-prefetchable) [size=4K]

80:0a.0 0680: 10de:0057 (rev a3)
        Subsystem: 10f1:2895
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 209
        Memory at d0701000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 4000 [size=8]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/2
Enable -
        Capabilities: [64] HyperTransport: MSI Mapping

80:0e.0 0604: 10de:005d (rev a3)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=80, secondary=81, subordinate=81, sec-latency=0
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1
Enable +
        Capabilities: [58] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0




Note: You might also contact me via Jabber (calestyo@scientia.net), ICQ:
104576 or Yahoo: calestyo . This is perhaps faster ;)

----------------------------------------------------------------------
 tiwai - 06-29-06 17:50 
----------------------------------------------------------------------
I committed a fix to HG repo.  The latest driver and alsa-lib should work
with -Dsurround51.  Give it a try.

But the channel order is unchanged, so this bug is likely still valid.
If it's still there, we'd need a channel remapping using route plugin for
this device.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-06 01:35 calestyo       New Issue                                    
06-29-06 01:35 calestyo       Distribution              => Debian GNU/Linux
06-29-06 01:35 calestyo       Kernel Version            => 2.6.17          
06-29-06 01:36 calestyo       Note Added: 0010634                          
06-29-06 01:36 calestyo       Issue Monitored: calestyo                    
06-29-06 15:29 Raymond        Note Added: 0010647                          
06-29-06 15:36 calestyo       Note Added: 0010648                          
06-29-06 15:37 calestyo       Note Added: 0010649                          
06-29-06 15:40 Raymond        Note Added: 0010650                          
06-29-06 15:45 calestyo       Note Added: 0010651                          
06-29-06 15:52 Raymond        Note Added: 0010652                          
06-29-06 15:54 Raymond        Note Edited: 0010652                         
06-29-06 15:56 calestyo       Note Added: 0010653                          
06-29-06 15:58 Raymond        Note Added: 0010654                          
06-29-06 16:01 calestyo       Note Added: 0010655                          
06-29-06 16:04 Raymond        Note Added: 0010656                          
06-29-06 16:07 calestyo       Note Added: 0010657                          
06-29-06 16:08 Raymond        Note Edited: 0010656                         
06-29-06 16:12 Raymond        Note Added: 0010658                          
06-29-06 16:19 calestyo       Note Added: 0010659                          
06-29-06 17:50 tiwai          Note Added: 0010677                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
