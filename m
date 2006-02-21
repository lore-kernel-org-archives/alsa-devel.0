From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001861]: Computer crashes when any alsa software is ran
Date: Tue, 21 Feb 2006 05:40:46 +0100
Message-ID: <7a48d23360cf2fe92c3c6e9fa58bf785@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DF6C196
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2006 05:40:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1861> 
======================================================================
Reported By:                sdistefano
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1861
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-21-2006 05:39 CET
Last Modified:              02-21-2006 05:40 CET
======================================================================
Summary:                    Computer crashes when any alsa software is ran
Description: 
When running alsaconf, alsamixer or soundgarden (as it handles MIDI) the PC
crashes with the message
Code:Bad EIP value
Kernel panic - not syncing : Fatal exception in interrupt
Same thing happens whenever I try to unload the sound modules.

But it does work great for PCM and DVD playback on SPDIF
======================================================================

----------------------------------------------------------------------
 sdistefano - 02-21-06 05:40 
----------------------------------------------------------------------
cat /proc/interrupts
           CPU0
  0:     168027          XT-PIC  timer
  1:        610          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:       1964          XT-PIC  eth0
  7:          0          XT-PIC  parport0
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi, ICE1724
 11:        353          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb2,
uhci_hcd:usb3, uhci_hcd:usb4
 14:      22910          XT-PIC  ide0
 15:       6990          XT-PIC  ide1
NMI:          0
ERR:          0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 05:39 sdistefano     New Issue                                    
02-21-06 05:40 sdistefano     Note Added: 0008151                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
