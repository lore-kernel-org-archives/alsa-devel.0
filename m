From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001789]: aoss skype is blocking.
Date: Sat, 28 Jan 2006 03:22:05 +0100
Message-ID: <279015c862ae2a6ee5e97183cbc2c73f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 425C91B1
	for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2006 03:22:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1789> 
======================================================================
Reported By:                nono31
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1789
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-28-2006 03:15 CET
Last Modified:              01-28-2006 03:22 CET
======================================================================
Summary:                    aoss skype is blocking.
Description: 
I'm using a Shuttle SN25P, which is an nForce4 motherboard with onboard
ice1724.

I use 1.0.11rc2 card's config file to have mutilple apps playing at the
same time.
This works great :-)
I have xmms, mplayer using alsa, aoss mplayer using oss working at the
same time.

The only problem I have is with skype: it still blocks my sound dev!

no way I can use other sound app when I am using skype... (so no way I can
hear gaim notification)...
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-28-06 03:22 
----------------------------------------------------------------------
Please attach the output of "strace aoss skype"

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-06 03:15 nono31         New Issue                                    
01-28-06 03:22 rlrevell       Note Added: 0007820                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
