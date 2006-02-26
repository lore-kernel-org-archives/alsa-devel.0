From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001880]: Can not use alsamixer when using CK804  and the iec598 volume has to be all the day down
Date: Sun, 26 Feb 2006 06:31:13 +0100
Message-ID: <ac7f6cc6fd5e2eaa1a73f5e4808834b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3DE551BA
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2006 06:31:13 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1880> 
======================================================================
Reported By:                davegermiquet
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1880
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-26-2006 06:31 CET
Last Modified:              02-26-2006 06:31 CET
======================================================================
Summary:                    Can not use alsamixer when using CK804  and the
iec598 volume has to be all the day down
Description: 
First the IEC958 P volume has to be all the way down for my Coax cable to
work and the only option that works to get it running is

mplayer -ao device=surround51

mplayer -ao device=hw0,2 does not work.

When that is ran surround works and i my coax works but I can not use alsa
mixer to modify volumes it is like its inactive however volume controls
work in kaffeine and amarok.

Using revision 3 and motherboard a8ne-fm
Have attached file
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-06 06:31 davegermiquet  New Issue                                    
02-26-06 06:31 davegermiquet  File Added: card.txt                         
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
