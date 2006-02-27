From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001858]: surround40 could be opened only 15 times
Date: Mon, 27 Feb 2006 17:06:55 +0100
Message-ID: <3c47a7ea29b131cc3b0f2cf066783334@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C4D82190
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 17:06:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1858> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1858
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-19-2006 20:40 CET
Last Modified:              02-27-2006 17:06 CET
======================================================================
Summary:                    surround40 could be opened only 15 times
Description: 
The device surround40 could be opened only 15 times even if we have 32 pcm
front channel and 32 rear channel.
======================================================================

----------------------------------------------------------------------
 Raymond - 02-20-06 04:15 
----------------------------------------------------------------------
Can you open 32 front pcm and 32 rear pcm at the same time ?

How many front pcm can you open at the same time ? (mono/stereo)

May be some pcm hardware reserve for capturing.



----------------------------------------------------------------------
 Raymond - 02-27-06 17:06 
----------------------------------------------------------------------
cat /proc/asound/pcm



( 32 - 1 ) / 2 = 15.5

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-06 20:40 darkbrain      New Issue                                    
02-20-06 04:12 Raymond        Note Added: 0008141                          
02-20-06 04:15 Raymond        Note Edited: 0008141                         
02-27-06 17:06 Raymond        Note Added: 0008225                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
