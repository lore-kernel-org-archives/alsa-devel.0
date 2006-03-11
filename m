From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001911]: Make Master 1 adjust volumes relative to each other for SB Extigy
Date: Sat, 11 Mar 2006 19:43:18 +0100
Message-ID: <f63f77013f9113b3122a29895bbb4913@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DCE96174
	for <alsa-devel@alsa-project.org>; Sat, 11 Mar 2006 19:43:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1911> 
======================================================================
Reported By:                andersin
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1911
Category:                   aconnect
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-11-2006 17:06 CET
Last Modified:              03-11-2006 19:43 CET
======================================================================
Summary:                    Make Master 1 adjust volumes relative to each other
for SB Extigy
Description: 
The Master 1 volume control sets the volume of all channels to the desired
volume level. When adjusting the volume of several speakers, it is
desirable, to adjust the volume while keeping the relative differences
between the channels intact. This can be implemented by adding the volume
level of Master1 to the volume of the other channels. The other channels
can hence be used individually or used to specify a relative offset.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-11-06 19:17 
----------------------------------------------------------------------
Don't.  These are all bugs in the Extigy driver, not general ALSA bugs. 
I'll close this so you can re-file it correctly.

----------------------------------------------------------------------
 andersin - 03-11-06 19:43 
----------------------------------------------------------------------
I opened a new bug for the driver. Please close this one.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 17:06 andersin       New Issue                                    
03-11-06 17:08 andersin       Note Added: 0008419                          
03-11-06 19:17 rlrevell       Note Added: 0008422                          
03-11-06 19:43 andersin       Note Added: 0008425                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
