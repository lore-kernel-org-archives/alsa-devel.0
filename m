From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001918]: No sound when I boot into Linux
Date: Mon, 13 Mar 2006 03:09:38 +0100
Message-ID: <90e9d2cb29c4b62ac4bb5cd575fc38ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 04A9C1BC
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 03:09:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1918> 
======================================================================
Reported By:                gordon3913
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1918
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-13-2006 03:04 CET
Last Modified:              03-13-2006 03:09 CET
======================================================================
Summary:                    No sound when I boot into Linux
Description: 
I do not have sound every time that I boot into Linux
When I run "alsaconf" and follow the prompts in a terminal my sound will
work.
Next time I start my computer - no sound.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-13-06 03:09 
----------------------------------------------------------------------
After "alsaconf" gets your sound working try running "alsactl store".  Then
reboot, and if you don't get sound, run "alsactl restore".

If this works then the bug is in your distro, maybe you don't have all the
alsa packages installed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-06 03:04 gordon3913     New Issue                                    
03-13-06 03:09 rlrevell       Note Added: 0008437                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
