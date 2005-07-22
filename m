From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001273]: snd_intel8x0 and kexec() don't work together
Date: Fri, 22 Jul 2005 10:25:07 +0200
Message-ID: <2defc3e3c2c8e7ecb9106803014f855c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A175C1A7
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2005 10:25:07 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1273> 
======================================================================
Reported By:                hildeb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1273
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian/unstable
Kernel Version:             2.6.13-rc3-git4
======================================================================
Date Submitted:             07-22-2005 10:23 CEST
Last Modified:              07-22-2005 10:25 CEST
======================================================================
Summary:                    snd_intel8x0 and kexec() don't work together
Description: 
Whenever I use kexec() to reboot into a new kernel, sound doesn't work
properly. KDE doesn't display a mixer.

All modules seem to be loaded, though - and after a reboot using
"reboot" instead of "kexec", sound works flawlessly with the same setup.

/etc/init.d/alsa restart doesn't change things, either.

If I unload the sounddriver:

# rmmod snd_intel8x0

and the reload it:

# modprobe snd_intel8x0

I get:

ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 22 (level, low)
-> IRQ 19
PCI: Setting latency timer of device 0000:00:06.0 to 64
AC'97 warm reset still in progress? [0xffffffff]
Intel ICH: probe of 0000:00:06.0 failed with error -5

======================================================================

----------------------------------------------------------------------
 hildeb - 07-22-05 10:25 
----------------------------------------------------------------------
# lspci
0000:00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
0000:00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
0000:00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
0000:00:02.0 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.1 USB Controller: nVidia Corporation nForce3 USB 1.1 (rev a5)
0000:00:02.2 USB Controller: nVidia Corporation nForce3 USB 2.0 (rev a2)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio
(rev a2)
0000:00:06.1 Modem: nVidia Corporation: Unknown device 00d9 (rev a2)
0000:00:08.0 IDE interface: nVidia Corporation nForce3 IDE (rev a5)
0000:00:0a.0 PCI bridge: nVidia Corporation nForce3 PCI Bridge (rev a2)
0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 AGP Bridge (rev a4)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4
420 Go 32M] (rev a3)
0000:02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:02:02.0 Network controller: Broadcom Corporation BCM4301 802.11b (rev
02)
0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev
01)
0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev
01)
0000:02:04.2 System peripheral: Texas Instruments: Unknown device 8201
(rev 01)

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio
(rev a2)
        Subsystem: Hewlett-Packard Company: Unknown device 006d
        Flags: 66MHz, fast devsel, IRQ 19
        I/O ports at 1400 [size=256]
        I/O ports at 1c00 [size=128]
        [virtual] Memory at e8002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 10:23 hildeb         New Issue                                    
07-22-05 10:23 hildeb         Distribution              => Debian/unstable 
07-22-05 10:23 hildeb         Kernel Version            => 2.6.13-rc3-git4 
07-22-05 10:25 hildeb         Note Added: 0005545                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
