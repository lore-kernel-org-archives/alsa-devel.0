From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001765]: Issue 001595 does not fix Audigy 4
Date: Sat, 21 Jan 2006 01:49:19 +0100
Message-ID: <5cbadbd3c0a5dac61f3df11aa3719be7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B78FC138
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 01:49:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1765> 
======================================================================
Reported By:                alexholkner
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1765
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-21-2006 01:49 CET
Last Modified:              01-21-2006 01:49 CET
======================================================================
Summary:                    Issue 001595 does not fix Audigy 4
Description: 
I have an Audigy 4 with the same device/subsystem as khampf from issue
1595.  I applied his patch, but it does NOT work unless I change
.ca0102_chip = 1 to .ca0108_chip = 1.

I did experience the same confusion where loading one driver with ca0108
will make any subsequent driver work (e.g., ca0102) until the next reboot.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-21-06 01:49 alexholkner    New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
