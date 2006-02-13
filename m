From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000851]: Ali M1535 controller, AC'97 0 does not respond
Date: Mon, 13 Feb 2006 14:23:45 +0100
Message-ID: <3c031c94d4582b05e06cd63ece69d5ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8ACAA1A6
	for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2006 14:23:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=851> 
======================================================================
Reported By:                omargosh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   851
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora FC3
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-27-2005 21:46 CET
Last Modified:              02-13-2006 14:23 CET
======================================================================
Summary:                    Ali M1535 controller, AC'97 0 does not respond
Description: 
My Ali5451 rev 1 based card (embedded in an Ali M1535 controller) is not
detected.

dmesg shows:

PCI: Found IRQ 9 for device 0000:00:04.0
AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0x0], removing mixer.
ali mixer creating error.
ALI 5451: probe of 0000:00:04.0 failed with error -5
======================================================================

----------------------------------------------------------------------
 omargosh - 05-10-05 22:09 
----------------------------------------------------------------------
No I dont, I was never able to get ALSA working with the M1535 chipset,
currently using OSS Trident support.

----------------------------------------------------------------------
 dvalin - 02-13-06 14:23 
----------------------------------------------------------------------
same happens here:
Linux blade100-1.mandriva.no 2.6.16-rc2.8mdk #1 Sun Feb 12 20:28:15 EST
2006 sparc64 TI UltraSparc IIe (Hummingbird) unknown GNU/Linux

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-05 21:46 omargosh       New Issue                                    
01-27-05 21:46 omargosh       Distribution              => Fedora FC3      
01-27-05 21:46 omargosh       Kernel Version            => 2.6.10          
01-28-05 22:40 omargosh       Note Added: 0003437                          
04-13-05 22:10 jdthood        Note Added: 0004483                          
05-10-05 22:09 omargosh       Note Added: 0004635                          
02-13-06 14:23 dvalin         Note Added: 0008050                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
