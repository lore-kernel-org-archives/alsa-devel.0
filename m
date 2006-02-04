From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001818]: Support for new nforce4 ALC655-based chipset
Date: Sat, 4 Feb 2006 05:32:17 +0100
Message-ID: <a7f911b4635843bcdb4c12d64bd64403@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 44B1F144
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2006 05:32:17 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1818> 
======================================================================
Reported By:                templar
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1818
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux 2005.1
Kernel Version:             2.6.14
======================================================================
Date Submitted:             02-04-2006 05:32 CET
Last Modified:              02-04-2006 05:32 CET
======================================================================
Summary:                    Support for new nforce4 ALC655-based chipset
Description: 
A new nForce4 ALC655-based chipset is not recognized by the intel8x0 driver
of the latest alsa-driver, 1.0.11_rc3.

# lspci -v | grep audio
00:10.2 Multimedia audio controller: nVidia Corporation MCP51 AC97 Audio
Controller (rev a2)
04:08.0 Multimedia audio controller: Creative Labs SB Audigy LS

# lspci -n | grep 026b
00:10.2 0401: 10de:026b (rev a2)

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-04-06 05:32 templar        New Issue                                    
02-04-06 05:32 templar        File Added: alsa-driver-1.0.10-mcp51.patch        
           
02-04-06 05:32 templar        Distribution              => Gentoo Linux 2005.1
02-04-06 05:32 templar        Kernel Version            => 2.6.14          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
