From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001836]: Cannot capture sound on Shark Predator ISA (AD1816a based)
Date: Fri, 10 Feb 2006 07:28:43 +0100
Message-ID: <80c5febf954631fc56fdf10ac59e9d47@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 62248194
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 07:28:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1836> 
======================================================================
Reported By:                arromdee
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1836
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandrake Linux
Kernel Version:             2.6.8.1-12mdk
======================================================================
Date Submitted:             02-10-2006 07:28 CET
Last Modified:              02-10-2006 07:28 CET
======================================================================
Summary:                    Cannot capture sound on Shark Predator ISA (AD1816a
based)
Description: 
Attempting to capture sound using arecord produces the following error:

arecord: pcm_read:1196: read error: Input/output error

The resulting capture file is always 44 bytes long (basically empty).

Capturing sound works fine under Windows 98.

I've never tried to capture sound before this and my guess is that nobody
other than me uses this driver.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 07:28 arromdee       New Issue                                    
02-10-06 07:28 arromdee       Distribution              => Mandrake Linux  
02-10-06 07:28 arromdee       Kernel Version            => 2.6.8.1-12mdk   
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
