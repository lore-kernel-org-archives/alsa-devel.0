From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001125]: reproducible hang on nforce3 -- all applications
Date: Wed, 25 May 2005 00:39:45 +0200
Message-ID: <ca7c92f910a3e62ef4e56416b294f3b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 29CF11FC
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2005 00:39:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1125> 
======================================================================
Reported By:                dogpatch
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1125
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11-gentoo-r8
======================================================================
Date Submitted:             05-24-2005 23:36 CEST
Last Modified:              05-25-2005 00:39 CEST
======================================================================
Summary:                    reproducible hang on nforce3 -- all applications
Description: 
Just upgraded to the latest kernel/alsa-driver via Gentoo emerge. I'm using
Gentoo profile 2005.0. Prior to the upgrade, sound worked fine both as
direct ALSA and via OSS emulation.

Now, any attempt to play a sound causes the playing application to hang
forever on an ioctl.

This happens even after a poweroff cold boot.
intel8x0m module is not and has not ever been loaded.
No other applications using the sound devices.
======================================================================

----------------------------------------------------------------------
 dogpatch - 05-24-05 23:43 
----------------------------------------------------------------------
Forgot this ...

pachyderm:asound 517 $> cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 10de:00e1 (nVidia Corporation) (rev 161).
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].
  Bus  0, device   1, function  0:
    ISA bridge: PCI device 10de:00e0 (nVidia Corporation) (rev 162).
  Bus  0, device   1, function  1:
    SMBus: PCI device 10de:00e4 (nVidia Corporation) (rev 161).
      IRQ 10.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      I/O at 0x9000 [0x901f].
      I/O at 0x4c00 [0x4c3f].
      I/O at 0x4c40 [0x4c7f].
  Bus  0, device   2, function  0:
    USB Controller: PCI device 10de:00e7 (nVidia Corporation) (rev 161).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe4002000 [0xe4002fff].
  Bus  0, device   2, function  1:
    USB Controller: PCI device 10de:00e7 (nVidia Corporation) (rev 161).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe4003000 [0xe4003fff].
  Bus  0, device   2, function  2:
    USB Controller: PCI device 10de:00e8 (nVidia Corporation) (rev 162).
      IRQ 5.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe4004000 [0xe40040ff].
  Bus  0, device   5, function  0:
    Ethernet controller: PCI device 10de:00e6 (nVidia Corporation) (rev
162).
      IRQ 10.
      Master Capable.  No bursts.  Min Gnt=1.Max Lat=20.
      Non-prefetchable 32 bit memory at 0xe4005000 [0xe4005fff].
      I/O at 0x9c00 [0x9c07].
  Bus  0, device   6, function  0:
    Multimedia audio controller: PCI device 10de:00ea (nVidia Corporation)
(rev 161).
      IRQ 11.
      Master Capable.  No bursts.  Min Gnt=2.Max Lat=5.
      I/O at 0xa000 [0xa0ff].
      I/O at 0xa400 [0xa47f].
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe4000fff].
  Bus  0, device   8, function  0:
    IDE interface: PCI device 10de:00e5 (nVidia Corporation) (rev 162).
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      I/O at 0xf000 [0xf00f].
  Bus  0, device  10, function  0:
    IDE interface: PCI device 10de:00e3 (nVidia Corporation) (rev 162).
      IRQ 11.
      Master Capable.  No bursts.  Min Gnt=3.Max Lat=1.
      I/O at 0x9f0 [0x9f7].
      I/O at 0xbf0 [0xbf3].
      I/O at 0x970 [0x977].
      I/O at 0xb70 [0xb73].
      I/O at 0xc000 [0xc00f].
      I/O at 0xc400 [0xc47f].
  Bus  0, device  11, function  0:
    PCI bridge: PCI device 10de:00e2 (nVidia Corporation) (rev 162).
      Master Capable.  Latency=16.  Min Gnt=14.
  Bus  0, device  14, function  0:
    PCI bridge: PCI device 10de:00ed (nVidia Corporation) (rev 162).
      Master Capable.  No bursts.  Min Gnt=6.Max Lat=2.
  Bus  0, device  24, function  0:
    Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge (rev 0).
  Bus  0, device  24, function  1:
    Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge (rev 0).
  Bus  0, device  24, function  2:
    Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge (rev 0).
  Bus  0, device  24, function  3:
    Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge (rev 0).
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200]
(rev 161).
      IRQ 5.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe0ffffff].
      Prefetchable 32 bit memory at 0xd8000000 [0xdfffffff].
  Bus  2, device   8, function  0:
    FireWire (IEEE 1394): NEC Corporation IEEE 1394 Host Controller (rev
1).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=20.Max Lat=44.
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe2000fff].
  Bus  2, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 Video Capture
(rev 17).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xe3000000 [0xe3000fff].
  Bus  2, device   9, function  1:
    Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev
17).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xe3001000 [0xe3001fff].

----------------------------------------------------------------------
 dogpatch - 05-25-05 00:39 
----------------------------------------------------------------------
Okay, this is probably my fault.

Was using gentoo ebuild of alsa-driver 1.0.9r3.

Removed alsa-driver ebuild and went with the kernel builtin drivers
(1.0.8) and all is well again.

Apologies ... please cancel this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-05 23:36 dogpatch       New Issue                                    
05-24-05 23:36 dogpatch       File Added: aplay.trace                      
05-24-05 23:36 dogpatch       Distribution              => Gentoo          
05-24-05 23:36 dogpatch       Kernel Version            => 2.6.11-gentoo-r8
05-24-05 23:41 dogpatch       Issue Monitored: dogpatch                    
05-24-05 23:43 dogpatch       Note Added: 0004733                          
05-25-05 00:39 dogpatch       Note Added: 0004734                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
