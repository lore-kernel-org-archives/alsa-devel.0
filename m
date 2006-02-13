From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001844]: Driver stops working regullary after some weeks/months
Date: Mon, 13 Feb 2006 17:18:44 +0100
Message-ID: <b0297710b3ce2a1d993d9498e52cfe86@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4668210E
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 17:18:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1844> 
======================================================================
Reported By:                sdistefano
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1844
Category:                   PCI - via82xx
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.15-gentoo-r1
======================================================================
Date Submitted:             02-13-2006 17:17 CET
Last Modified:              02-13-2006 17:18 CET
======================================================================
Summary:                    Driver stops working regullary after some
weeks/months
Description: 
It happened several times, sound works good with ALSA, then just gets
broken.
When it's broken, I can watch DVDs with sound in XINE (as they use Dolby
Digital and I use S/PDIF) but no PCM audio.
I usually fix it switching from modules to static or from kernel to
alsa-driver, but now I'm not being able to fix it.
It's broken in any case.
The dmesg says
codec_read: codec 0 is not valid [0x107e5370]
in any case.
I had it working many times but it always gets broken after a while, in
any linux box I tryed to.
I think it's a driver issue.
The chip is onboard in a Asus a7a8x-x
======================================================================

----------------------------------------------------------------------
 sdistefano - 02-13-06 17:18 
----------------------------------------------------------------------
cat /proc/interrupts
           CPU0
  0:     561016          XT-PIC  timer
  1:       6633          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:      57162          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb2,
uhci_hcd:usb3, uhci_hcd:usb4
  5:       2285          XT-PIC  VIA8233
  7:          0          XT-PIC  parport0
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:       6486          XT-PIC  eth0
 14:      30319          XT-PIC  ide0
 15:      24262          XT-PIC  ide1
NMI:          0
ERR:          0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-06 17:17 sdistefano     New Issue                                    
02-13-06 17:17 sdistefano     File Added: dmesg                            
02-13-06 17:17 sdistefano     Distribution              => Gentoo          
02-13-06 17:17 sdistefano     Kernel Version            => 2.6.15-gentoo-r1
02-13-06 17:18 sdistefano     Note Added: 0008057                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
