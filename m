From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001775]: headphone jack fails to work after wakeup from suspend-to-memory
Date: Mon, 23 Jan 2006 10:47:46 +0100
Message-ID: <70416b402c42cdcf255a8ef5dbca7ed7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D4DC8140
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2006 10:47:46 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1775> 
======================================================================
Reported By:                rlbobm
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1775
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-23-2006 10:47 CET
Last Modified:              01-23-2006 10:47 CET
======================================================================
Summary:                    headphone jack fails to work after wakeup from
suspend-to-memory
Description: 
Upon initial boot of the system sound works fine through both internal
speakers and headphones.  After a suspend/resume cycle (suspend to memory,
via ACPI) sound still works via the speakers, but when headphones are
plugged in, sound continues to come from the speakers rather than the
headphones.  This is the case regardless of switch settings like
"headphone jack sense".

This behavior has been consistent across all kernel versions I have tried
on this machine, starting with the vanilla 2.6.11-1.1369_FC4 of FC4,
through various 2.6.12-13-14 versions, right up to 2.6.15.1 today.  It has
also been consistent with both 1.0.9 and 1.0.10.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-23-06 10:47 rlbobm         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
