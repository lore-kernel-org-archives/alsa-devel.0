From: bugtrack@alsa-project.org
Subject: [ALSA - plugins 0001790]: add ability to set different applications apart (one line of code needs to change)
Date: Mon, 30 Jan 2006 16:15:37 +0100
Message-ID: <eb95c927a3406e04ba1ba5de8e3b04d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C60A1CB
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2006 16:15:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1790> 
======================================================================
Reported By:                madman2003
Assigned To:                tiwai
======================================================================
Project:                    ALSA - plugins
Issue ID:                   1790
Category:                   PCM - jack
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-28-2006 10:26 CET
Last Modified:              01-30-2006 16:15 CET
======================================================================
Summary:                    add ability to set different applications apart (one
line of code needs to change)
Description: 
Currently there is no way of making multiple alsa-jack plugins and setting
them apart by their name. Which can be inconvient in some cases (when
using qjackctl patchbay) when you want one or two apps treated
differently.

I know very little c, but i was able to change it after fiddling around a
while.

It's only one line of code that needs changing, i'm not sure if the patch
is in the right format, but it should be applied directly to pcm_jack.c .
======================================================================

----------------------------------------------------------------------
 tiwai - 01-30-06 16:15 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-06 10:26 madman2003     New Issue                                    
01-28-06 10:26 madman2003     File Added: patch.txt                        
01-30-06 16:15 tiwai          Status                   new => resolved     
01-30-06 16:15 tiwai          Resolution               open => fixed       
01-30-06 16:15 tiwai          Assigned To               => tiwai           
01-30-06 16:15 tiwai          Note Added: 0007839                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
