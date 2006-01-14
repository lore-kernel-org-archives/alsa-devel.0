From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001747]: Error messages while loading
Date: Sat, 14 Jan 2006 22:03:27 +0100
Message-ID: <4e434f51fe948bfb35aa070df3d88d39@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1CEF127
	for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2006 22:03:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1747> 
======================================================================
Reported By:                Henne
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1747
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-14-2006 21:59 CET
Last Modified:              01-14-2006 22:03 CET
======================================================================
Summary:                    Error messages while loading
Description: 
Hi,

I get these messages while booting:

ALSA sound/pci/ac97/ac97_codec.c:1898: AC'97 1 does not respond - RESET
ALSA sound/pci/ac97/ac97_codec.c:1907: AC'97 1 access is not valid
[0xffffffff],
 removing mixer.
ALSA sound/pci/intel8x0.c:2128: Unable to initialize codec #1
intel8x0_measure_ac97_clock: measured 50165 usecs
intel8x0: clocking to 48000

How can I help? What can I try?

======================================================================

----------------------------------------------------------------------
 Henne - 01-14-06 22:03 
----------------------------------------------------------------------
Sorry, my alsa-driver version is 1.0.11rc2.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-14-06 21:59 Henne          New Issue                                    
01-14-06 22:03 Henne          Note Added: 0007655                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
