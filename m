From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001838]: Unknown model for ALC880 again, First International Computer p4m-915gd1 no sound
Date: Thu, 16 Feb 2006 17:08:51 +0100
Message-ID: <28b8fceb89a96e368193797982edd572@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C52F718A
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2006 17:08:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1838> 
======================================================================
Reported By:                graabein
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1838
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.15-1.1831_FC4smp
======================================================================
Date Submitted:             02-10-2006 23:27 CET
Last Modified:              02-16-2006 17:08 CET
======================================================================
Summary:                    Unknown model for ALC880 again, First International
Computer p4m-915gd1 no sound
Description: 
I'm unable to get any sound on my FIC p4m-915gd1 motherboard's built-in
sound. There are no error messages and I can play content all I want, I
just don't get any sound.

The manufacturer's page lists the hardware as "Intel HDA, Azalia 8
Channel, Realtek ALC880":
http://www.fic.com.tw/product/motherboard/intel/p4m-915gd1.aspx

I've found other, similar reports here in the bug tracker (#1460, #1563,
#1589), including reports that this problem was resolved as of 1.0.11rc1.

Accordingly, I tried compiling alsa from cvs sources as of today, but this
made no difference. I still have no sound.

======================================================================

----------------------------------------------------------------------
 Eugene Seppel - 02-15-06 23:46 
----------------------------------------------------------------------
Same problems with ALC880 chip (hda-intel) on ATI Xpress 200 Motherboard
integrated sound.

Sometimes sound is looping or ragged.

----------------------------------------------------------------------
 Marijn Schouten - 02-16-06 17:08 
----------------------------------------------------------------------
There are two things you can do:
check out bug 1563 and apply the patch for 1.0.10-rc3
check out bug 1807 "Yes, position_fix=1 (or 3) fixes the problem."
 
 /etc/modprobe.conf:
 options snd-hda-intel position_fix=1

If one of these works, then this bug is a duplicate of those bugs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 23:27 graabein       New Issue                                    
02-10-06 23:27 graabein       Distribution              => Fedora Core 4   
02-10-06 23:27 graabein       Kernel Version            => 2.6.15-1.1831_FC4smp
02-10-06 23:38 graabein       Note Added: 0008010                          
02-15-06 23:46 Eugene Seppel  Issue Monitored: Eugene Seppel                    
02-15-06 23:46 Eugene Seppel  Note Added: 0008081                          
02-16-06 17:08 Marijn SchoutenNote Added: 0008098                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
