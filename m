From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001837]: No PCM, no Volume
Date: Tue, 18 Apr 2006 20:30:35 +0200
Message-ID: <229eedf25862243d2ff12aeeacb577ee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 52419183
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 20:30:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1837> 
======================================================================
Reported By:                corrosion
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1837
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-10-2006 18:14 CET
Last Modified:              04-18-2006 20:30 CEST
======================================================================
Summary:                    No PCM, no Volume
Description: 
I use KDE and in KMix and alsamixer, doesn't appear a Volume slider and a
PCM slider. Skype and TeamSpeak don't work with this card.
Soundcard model is: SB0570
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-13-06 21:53 
----------------------------------------------------------------------
Thats correct there is no PCM or Master Volume control.
Running alsamixer should control the audio gain via the "Analog Front",
"Analog Rear" etc. controls.
If alsamixer still fails to work, report back.

----------------------------------------------------------------------
 corrosion - 04-18-06 20:30 
----------------------------------------------------------------------
That's correct, I used Analog Front to control volume.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-10-06 18:14 corrosion      New Issue                                    
02-12-06 05:16 corrosion      Issue Monitored: corrosion                    
02-13-06 19:45 avuton         Issue Monitored: avuton                      
04-13-06 21:53 jcdutton       Note Added: 0009274                          
04-13-06 21:53 jcdutton       Status                   assigned => feedback
04-18-06 20:30 corrosion      Note Added: 0009341                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
