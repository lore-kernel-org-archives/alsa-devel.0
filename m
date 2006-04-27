From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002069]: No sound on via SPDIF out, very low volume on analog out (MSI K8NGM2-FID with ACL880)
Date: Thu, 27 Apr 2006 18:40:29 +0200
Message-ID: <a98c22acc2ca3f14540d73cc49aca34b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E1D57184
	for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 18:40:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2069> 
======================================================================
Reported By:                gtmkramer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2069
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.16-1.2069_FC4smp
======================================================================
Date Submitted:             04-25-2006 20:43 CEST
Last Modified:              04-27-2006 18:40 CEST
======================================================================
Summary:                    No sound on via SPDIF out, very low volume on analog
out (MSI K8NGM2-FID with ACL880)
Description: 
On my new MSI K8NGM2-FID motherboard with a Realtek ACL880 a get only sound
from the analog output (although the volume is very low).

The codec is not properly recognized:
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...

I've tried with various model= settings to no avail.
======================================================================

----------------------------------------------------------------------
 gtmkramer - 04-27-06 18:34 
----------------------------------------------------------------------
What do I need to do to get my sound properly working?

----------------------------------------------------------------------
 gtmkramer - 04-27-06 18:40 
----------------------------------------------------------------------
Added some extra info which might be useful:

00:10.1 Class 0403: 10de:026c (rev a2)
        Subsystem: 1462:7207
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 18
        Memory at fead8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [6c] HyperTransport: MSI Mapping

Output from amixer:

Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [on]
  Front Right: Playback 64 [100%] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 0 [0%] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 0 [0%] [off]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65
  Mono:
  Front Left: Playback 0 [0%] [on]
  Front Right: Playback 0 [0%] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 35
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Input Source',0
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic'
Simple mixer control 'Input Source',2
  Capabilities: enum
  Items: 'Mic' 'Front Mic' 'Line' 'CD'
  Item0: 'Mic

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 20:43 gtmkramer      New Issue                                    
04-25-06 20:43 gtmkramer      File Added: codec.tar.gz                     
04-25-06 20:43 gtmkramer      Distribution              => Fedora Core 4   
04-25-06 20:43 gtmkramer      Kernel Version            => 2.6.16-1.2069_FC4smp
04-27-06 18:34 gtmkramer      Note Added: 0009533                          
04-27-06 18:40 gtmkramer      Note Added: 0009534                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
