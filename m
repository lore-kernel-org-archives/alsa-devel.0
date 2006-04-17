From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001800]: Input signal from analog input in snd-ca0106 with audigy SE distorted!
Date: Mon, 17 Apr 2006 06:58:18 +0200
Message-ID: <3436ce9f224bfa80ad94aef7094bfb77@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 704D81A8
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 06:58:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1800> 
======================================================================
Reported By:                AnarSoul
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1800
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Slackware
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-31-2006 15:56 CET
Last Modified:              04-17-2006 06:58 CEST
======================================================================
Summary:                    Input signal from analog input in snd-ca0106 with
audigy SE distorted!
Description: 
Recorded signal from my audigy SE from analog MIC input badly distorted! =(
======================================================================

----------------------------------------------------------------------
 AnarSoul - 04-16-06 19:07 
----------------------------------------------------------------------
Oh, I'm sorry :) Changing position of 'line in' slider in alsamixer has
effect, but not in kmix (from kde-multimidia) :( for some reason changing
'line in' volume in kmix has no effect. I don't know if this is kmix bug
or driver bug.

----------------------------------------------------------------------
 rlrevell - 04-17-06 06:58 
----------------------------------------------------------------------
kmix bug (the kmix ALSA support is atrocious), it can't even tell a
playback from a capture control.

For the purposes of bug reporting please make sure to use alsamixer, it's
the only "known good" reference implementation.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-06 15:56 AnarSoul       New Issue                                    
01-31-06 15:56 AnarSoul       Distribution              => Slackware       
01-31-06 15:56 AnarSoul       Kernel Version            => 2.6.15          
02-05-06 17:38 AnarSoul       Issue Monitored: AnarSoul                    
02-07-06 21:55 AnarSoul       Note Added: 0007961                          
04-13-06 21:51 jcdutton       Note Added: 0009273                          
04-13-06 21:51 jcdutton       Status                   assigned => feedback
04-14-06 21:16 AnarSoul       Note Added: 0009287                          
04-15-06 01:21 jcdutton       Note Added: 0009290                          
04-15-06 12:36 AnarSoul       File Added: amixer-out.txt                    
04-15-06 12:37 AnarSoul       Note Added: 0009294                          
04-15-06 12:42 AnarSoul       Note Added: 0009295                          
04-15-06 12:42 AnarSoul       File Added: lspci.txt                        
04-15-06 12:50 AnarSoul       Note Edited: 0009295                         
04-15-06 12:52 AnarSoul       Note Edited: 0009294                         
04-16-06 19:07 AnarSoul       Note Added: 0009297                          
04-17-06 06:58 rlrevell       Note Added: 0009302                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
