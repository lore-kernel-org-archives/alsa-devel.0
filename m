From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001911]: Make Master 1 adjust volumes relative to each other for SB Extigy
Date: Sun, 12 Mar 2006 02:01:35 +0100
Message-ID: <0944b6ba210a8913d1312233c5bde0f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 881A71B5
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 02:01:35 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-11-2006 17:06 CET
Last Modified:              03-12-2006 02:01 CET
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
 andersin - 03-11-06 19:54 
----------------------------------------------------------------------
I opened a new bug in the driver category. Please close this one.



----------------------------------------------------------------------
 rlrevell - 03-12-06 02:01 
----------------------------------------------------------------------
Wrong category

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 17:06 andersin       New Issue                                    
03-11-06 17:08 andersin       Note Added: 0008419                          
03-11-06 19:17 rlrevell       Note Added: 0008422                          
03-11-06 19:43 andersin       Note Added: 0008425                          
03-11-06 19:54 andersin       Note Edited: 0008425                         
03-12-06 02:01 rlrevell       Status                   new => closed       
03-12-06 02:01 rlrevell       Note Added: 0008428                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
