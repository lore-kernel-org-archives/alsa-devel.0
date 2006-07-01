From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002189]: No sound on speakers,
	low volume on the headphones, Packard bell V7900
Date: Sat, 1 Jul 2006 13:46:05 +0200
Message-ID: <3eeb26bf36f0cf4349e00db394e5407a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B4FFD248
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 13:46:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2189> 
======================================================================
Reported By:                bettored
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2189
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.15-23-386
======================================================================
Date Submitted:             06-07-2006 19:47 CEST
Last Modified:              07-01-2006 13:46 CEST
======================================================================
Summary:                    No sound on speakers, low volume on the headphones,
Packard bell V7900
Description: 
Hi,
I have a Packard Bell with a soundcard Realtek ALC260 HD Audio, with Intel
hda-intel, with problems.
I have no sound on speakers and very low on the headphones.
In the alsamixer all is on.
Recently i actualized to Alsa 1.0.11 but with same problem.

In the Volumen Control, i have two:
1. HDA intel (alsa mixer)
2. Realtek ALC260 (oss mixer)
And it is correct.

Here leave same test:


janek@janek-laptop:~$ lsmod | grep snd
snd_hda_intel          19348  2
snd_hda_codec         143152  1 snd_hda_intel
snd_pcm_oss            43936  0
snd_mixer_oss          18944  2 snd_pcm_oss
snd_pcm                89352  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              25348  1 snd_pcm
snd                    55396  8
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixe r_oss,snd_pcm,snd_timer
soundcore              10208  2 snd
snd_page_alloc         10760  2 snd_hda_intel,snd_pcm

--------------------------------------------------------------------------------

janek@janek-laptop:~$ lspci
0000:00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub
(rev 03)
0000:00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics
Port (rev 03)
0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
0000:00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 (rev 02)
0000:00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 2 (rev 02)
0000:00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 3 (rev 02)
0000:00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 4 (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev
e2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus
Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown
device 71c5
0000:03:00.0 Network controller: Intel Corporation: Unknown device 4222
(rev 02)
0000:06:02.0 FireWire (IEEE 1394): O2 Micro, Inc.: Unknown device 00f7
(rev 02)
0000:06:02.2 0805: O2 Micro, Inc.: Unknown device 7120 (rev 01)
0000:06:02.3 Mass storage controller: O2 Micro, Inc.: Unknown device 7130
(rev 01)
0000:06:08.0 Ethernet controller: Intel Corporation: Unknown device 1092
(rev 02)


-------------------------------------------------------------------------------

janek@janek-laptop:~$ modinfo soundcore
filename:       /lib/modules/2.6.15-23-386/kernel/sound/soundcore.ko
description:    Core sound module
author:         Alan Cox
license:        GPL
alias:          char-major-14-*
vermagic:       2.6.15-23-386 preempt 486 gcc-4.0
depends:
srcversion:     DD426F1CCA2CC5F060F6F92


---------------------------------------------------------------------------


Thanks for your time 




======================================================================

----------------------------------------------------------------------
 bonobo - 06-25-06 21:37 
----------------------------------------------------------------------
lspci -nv :

0000:00:00.0 0600: 8086:27a0 (rev 03)
	Subsystem: 1631:c017
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] #09 [5109]

0000:00:01.0 0604: 8086:27a1 (rev 03)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: 5c200000-5c2fffff
	Prefetchable memory behind bridge: 0000000048000000-000000004ff00000
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
	Capabilities: [a0] #10 [0141]

0000:00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 1631:c017
	Flags: bus master, fast devsel, latency 0, IRQ 58
	Memory at 5c300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
	Capabilities: [70] #10 [0091]

0000:00:1c.0 0604: 8086:27d0 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: 5b200000-5c1fffff
	Prefetchable memory behind bridge: 0000000054100000-0000000055000000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

0000:00:1c.1 0604: 8086:27d2 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: 5a100000-5b1fffff
	Prefetchable memory behind bridge: 0000000055100000-0000000056000000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

0000:00:1c.2 0604: 8086:27d4 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: 59100000-5a0fffff
	Prefetchable memory behind bridge: 0000000056100000-0000000057000000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

0000:00:1c.3 0604: 8086:27d6 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: 58100000-590fffff
	Prefetchable memory behind bridge: 0000000057100000-0000000058000000
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

0000:00:1d.0 0c03: 8086:27c8 (rev 02)
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at 7080 [size=32]

0000:00:1d.1 0c03: 8086:27c9 (rev 02)
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 0, IRQ 177
	I/O ports at 7060 [size=32]

0000:00:1d.2 0c03: 8086:27ca (rev 02)
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at 7040 [size=32]

0000:00:1d.3 0c03: 8086:27cb (rev 02)
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 0, IRQ 193
	I/O ports at 7020 [size=32]

0000:00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 0, IRQ 169
	Memory at 5c304000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=32
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 52000000-540fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
	Capabilities: [50] #0d [0000]

0000:00:1f.0 0601: 8086:27b9 (rev 02)
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] #09 [100c]

0000:00:1f.1 0101: 8086:27df (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 70a0 [size=16]

0000:00:1f.3 0c05: 8086:27da (rev 02)
	Subsystem: 1631:c017
	Flags: medium devsel, IRQ 11
	I/O ports at 7000 [size=32]

0000:01:00.0 0300: 1002:71c5
	Subsystem: 1631:c017
	Flags: bus master, fast devsel, latency 0, IRQ 169
	Memory at 48000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 6000 [size=256]
	Memory at 5c200000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at 5c220000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #10 [0011]
	Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-

0000:03:00.0 0280: 8086:4222 (rev 02)
	Subsystem: 8086:1001
	Flags: bus master, fast devsel, latency 0, IRQ 177
	Memory at 5a100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
	Capabilities: [e0] #10 [0011]

0000:06:02.0 0c00: 1217:00f7 (rev 02) (prog-if 10)
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 64, IRQ 169
	Memory at 54003000 (32-bit, non-prefetchable) [size=4K]
	Memory at 54004000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [60] Power Management version 2

0000:06:02.2 0805: 1217:7120 (rev 01)
	Subsystem: 1631:c017
	Flags: slow devsel, IRQ 169
	Memory at 54004800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [a0] Power Management version 2

0000:06:02.3 0180: 1217:7130 (rev 01)
	Subsystem: 1631:c017
	Flags: slow devsel, IRQ 11
	Memory at 54001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [a0] Power Management version 2

0000:06:08.0 0200: 8086:1092 (rev 02)
	Subsystem: 1631:c017
	Flags: bus master, medium devsel, latency 64, IRQ 66
	Memory at 54000000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 1200 [size=64]
	Capabilities: [dc] Power Management version 2

----------------------------------------------------------------------
 bonobo - 07-01-06 13:46 
----------------------------------------------------------------------
I tried the test model with alsa 1.12rc1.
I can get things to happen by connecting different pins to different
outputs or inputs in the options tab in gnome mixer but I can get sound in
the line out only, never in the laptop speakers. Mics seem to work
allright.

Can someone tell me what is the way to go to find the right combination ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 19:47 bettored       New Issue                                    
06-07-06 19:47 bettored       Kernel Version            => 2.6.15-23-386   
06-15-06 20:25 bonobo         Note Added: 0010243                          
06-15-06 20:32 bonobo         Note Edited: 0010243                         
06-18-06 23:59 ixM            Note Added: 0010304                          
06-20-06 19:52 tiwai          Note Added: 0010350                          
06-21-06 19:02 ixM            Note Added: 0010402                          
06-21-06 19:16 tiwai          Note Added: 0010403                          
06-22-06 23:18 urdle          Issue Monitored: urdle                       
06-25-06 14:02 bonobo         Note Added: 0010507                          
06-25-06 21:37 bonobo         Note Added: 0010519                          
07-01-06 13:46 bonobo         Note Added: 0010761                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
