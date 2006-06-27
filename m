From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002236]: No sound at all on toshiba
	P100-197 laptop
Date: Tue, 27 Jun 2006 20:41:35 +0200
Message-ID: <15475fad440c8d4e31ad5773fb04190f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ACF4626F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 20:41:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2236> 
======================================================================
Reported By:                theliar
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2236
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.15
======================================================================
Date Submitted:             06-27-2006 20:27 CEST
Last Modified:              06-27-2006 20:41 CEST
======================================================================
Summary:                    No sound at all on  toshiba P100-197 laptop
Description: 
My laptop is enable to produce a single sound with alsa driver 1.0.12rc1
(and with 1.0.11 and 1.0.10).
======================================================================

----------------------------------------------------------------------
 theliar - 06-27-06 20:35 
----------------------------------------------------------------------
My chipset seems to be a conexant CX20551-22

----------------------------------------------------------------------
 theliar - 06-27-06 20:41 
----------------------------------------------------------------------
francesco@laptop:~$ lspci
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
0000:00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controllers cc=IDE (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus
Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device
0398 (rev a1)
0000:02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit
Ethernet Controller
0000:03:00.0 Network controller: Intel Corporation: Unknown device 4222
(rev 02)0000:0a:04.0 CardBus bridge: Texas Instruments: Unknown device
8039
0000:0a:04.1 FireWire (IEEE 1394): Texas Instruments: Unknown device 803a
0000:0a:04.2 Mass storage controller: Texas Instruments: Unknown device
803b
0000:0a:04.3 0805: Texas Instruments: Unknown device 803c

francesco@laptop:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.12rc1.
Compiled on Jun 27 2006 for kernel 2.6.15-25-686 (SMP).

francesco@laptop:~$ cat /proc/asound/cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xb0000000 irq 58



francesco@laptop:~$ cat /proc/asound/devices
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-06 20:27 theliar        New Issue                                    
06-27-06 20:27 theliar        Kernel Version            => 2.6.15          
06-27-06 20:32 theliar        Issue Monitored: theliar                     
06-27-06 20:35 theliar        Note Added: 0010599                          
06-27-06 20:41 theliar        Note Added: 0010600                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
