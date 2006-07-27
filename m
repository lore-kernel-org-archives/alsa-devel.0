From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002302]: Unsupported intel
Date: Thu, 27 Jul 2006 23:02:13 +0200
Message-ID: <ed9b474570ac44922988497a04f5ed91@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 74EA7186
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 23:02:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2302> 
======================================================================
Reported By:                pinaraf
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2302
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               kUbuntu edgy
Kernel Version:             2.6.17-5-686
======================================================================
Date Submitted:             07-25-2006 00:33 CEST
Last Modified:              07-27-2006 23:02 CEST
======================================================================
Summary:                    Unsupported intel
Description: 
Hello

One of my friends bought a laptop, and surprisingly, the sound card isn't
supported. I didn't see that happening since years, thanks to your great
work I suppose. 
His laptop is new, it's a Toshiba Satellite P100-197
Here are the results of various commands, I hope they're usable :
lspci :
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT
Express PCI Express Root Port (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1
(rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2
(rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3
(rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4
(rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial
ATA Storage Controller IDE (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 02)
01:00.0 VGA compatible controller: nVidia Corporation Unknown device 0398
(rev a1)
02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit Ethernet
Controller
03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network
Connection (rev 02)
0a:04.0 CardBus bridge: Texas Instruments Unknown device 8039
0a:04.1 FireWire (IEEE 1394): Texas Instruments Unknown device 803a
0a:04.2 Mass storage controller: Texas Instruments Unknown device 803b
0a:04.3 Class 0805: Texas Instruments Unknown device 803c

lspci -nv (only sound card) :
00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 1179:ff31
        Flags: bus master, fast devsel, latency 0, IRQ 66
        Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

lshw (only sound card) :
        *-multimedia UNCLAIMED
             description: Audio device
             product: 82801G (ICH7 Family) High Definition Audio
Controller
             vendor: Intel Corporation
             physical id: 1b
             bus info: pci@00:1b.0
             version: 02
             width: 64 bits
             clock: 33MHz
             capabilities: bus_master cap_list
             resources: iomemory:b0000000-b0003fff irq:11


Currently, the driver snd-hda-intel is loaded.
Content of /proc/asound/timers :
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE

We tried every model= setting possible for this driver, none gave any
other PCM playback device.


Thanks
======================================================================

----------------------------------------------------------------------
 tiwai - 07-27-06 12:57 
----------------------------------------------------------------------
The controller is already supported by snd-hda-intel driver.  But whether
it really works dependson the codec chip and the configuration set up on
the device.

If the driver doesn't work out-of-the-box, try various model module option
as found in ALSA-Configuration.txt.

----------------------------------------------------------------------
 pinaraf - 07-27-06 23:02 
----------------------------------------------------------------------
Hi

We already tried every available model module option, without any success
:/

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-25-06 00:33 pinaraf        New Issue                                    
07-25-06 00:33 pinaraf        Distribution              => kUbuntu edgy    
07-25-06 00:33 pinaraf        Kernel Version            => 2.6.17-5-686    
07-27-06 12:57 tiwai          Note Added: 0011268                          
07-27-06 23:02 pinaraf        Note Added: 0011280                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
