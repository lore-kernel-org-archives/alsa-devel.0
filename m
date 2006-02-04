From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001597]: alsamixer does not work
Date: Sat, 4 Feb 2006 20:00:16 +0100
Message-ID: <977f8ca68186b95b4553883148ddc744@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7409F16E
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2006 20:00:16 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1597> 
======================================================================
Reported By:                lanewhoy
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - lib
Issue ID:                   1597
Category:                   simple mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-25-2005 04:19 CET
Last Modified:              02-04-2006 20:00 CET
======================================================================
Summary:                    alsamixer does not work
Description: 
Any attempt to run a alsamixer or alsactl fails with the error:

ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback
Volume',0,140733193388032,46909632806912) appears twice or more

======================================================================

----------------------------------------------------------------------
 lanewhoy - 02-04-06 19:53 
----------------------------------------------------------------------
This issue has gone away with 1.0.11_rc3

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-25-05 04:19 lanewhoy       New Issue                                    
02-04-06 19:53 lanewhoy       Note Added: 0007922                          
02-04-06 20:00 rlrevell       Status                   new => resolved     
02-04-06 20:00 rlrevell       Resolution               open => fixed       
02-04-06 20:00 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
