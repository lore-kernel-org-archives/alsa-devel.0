From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001000]: All programs that try to use alsa lockup.
Date: Wed, 22 Mar 2006 03:38:42 +0100
Message-ID: <b3cdea62e23e385b61cc1034f67fc778@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D7661A0
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:38:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1000> 
======================================================================
Reported By:                dr0p
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1000
Category:                   PCI - intel8x0
Reproducibility:            unable to duplicate
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.10
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-19-2005 16:05 CET
Last Modified:              03-22-2006 03:38 CET
======================================================================
Summary:                    All programs that try to use alsa lockup.
Description: 
I left the computer seeding some torrent the whole night.. no sound playing
or sound notification by the torrent client. The computer was up 19 hours.
Then i played some music (xmms). Everything was fine for some time, but
when xmms tried to play the 5 -th song in the playlist nothing happens. I
tried to play it manualy but then xmms just freezed. killall -9 xmms
xmms.bin closed the program. I start xmms again but this time xmms lockup
again when i play the first song. I tryed mpg123 - same thing. aplay ""
locksup too. I stoped X, killed xmms mpg123, aplay and unload the kernel
modules, then i load the alsa modules again i after a short time - the
same situation.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-22-05 15:25 
----------------------------------------------------------------------
Submitter: Any better luck with the latest ALSA release?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:38 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-05 16:05 dr0p           New Issue                                    
03-19-05 16:05 dr0p           Kernel Version            => 2.6.10          
09-22-05 15:25 jdthood        Note Added: 0006351                          
03-22-06 03:38 rlrevell       Status                   new => closed       
03-22-06 03:38 rlrevell       Note Added: 0008827                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
