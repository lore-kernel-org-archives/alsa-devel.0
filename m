From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001298]: Creative Labs Sound Blaster Live! 24-bit not detected
Date: Sat, 10 Sep 2005 12:55:34 +0200
Message-ID: <afb2310b54c86b58cd060497efc72a93@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C4B87197
	for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2005 12:55:34 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1298> 
======================================================================
Reported By:                andrewvegan
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1298
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369_FC4smp
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             08-01-2005 15:15 CEST
Last Modified:              09-10-2005 12:55 CEST
======================================================================
Summary:                    Creative Labs Sound Blaster Live! 24-bit not
detected
Description: 
Unable to get the sound card detected in Fedora Core 4. PC is a Shuttle XPC
SD31P which has an onboard "Creative Labs Sound Blaster Live! 24-bit EAX
high-definition 7.1 audio processor".

from dmesg:

AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0x0], removing mixer.
CA0106: probe of 0000:03:0b.0 failed with error -5

When I run lspci it lists a different card (Creative Labs SB Audigy LS):
 
[root@localhost ~]# lspci
00:00.0 Host bridge: Intel Corporation Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corporation PCI Express Graphics Port (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01)
00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
Serial ATA Storage Controllers cc=IDE (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce
6600] (rev a2)
02:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789
Gigabit Ethernet PCI Express (rev 11)
03:0a.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
03:0b.0 Multimedia audio controller: Creative Labs SB Audigy LS






======================================================================

----------------------------------------------------------------------
 andrewvegan - 08-13-05 03:59 
----------------------------------------------------------------------
This sound card is now correctly detected and working after following the
instructions from Clemens. On 8/2 I download the CVS version of ALSA,
added the following entry to the ca0106_chip_details array in
alsa-kernel/pci/ca0106/ca0106_main.c:

         /* Shuttle XPC SD31P with onboard SB Live 24bit without AC97 */
         { .serial = 0x30381297,
           .name   = "Shuttle XPC SD31P [SB04??]",
           .gpio_type = 1,
           .i2c_adc = 1 } ,

But I have been unable to confirm if sound capture is working as my mic is
dead.

----------------------------------------------------------------------
 jcdutton - 09-10-05 12:55 
----------------------------------------------------------------------
Fixed in CVS: 12 Aug 2005.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-01-05 15:15 andrewvegan    New Issue                                    
08-01-05 15:15 andrewvegan    Distribution              => Fedora Core 4   
08-01-05 15:15 andrewvegan    Kernel Version            => 2.6.11-1.1369_FC4smp
08-13-05 00:52 jcdutton       File Added: 1298.diff.txt                    
08-13-05 00:53 jcdutton       Note Added: 0005796                          
08-13-05 00:53 jcdutton       Status                   assigned => feedback
08-13-05 03:59 andrewvegan    Note Added: 0005801                          
09-10-05 12:55 jcdutton       Status                   feedback => closed  
09-10-05 12:55 jcdutton       Note Added: 0006113                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
