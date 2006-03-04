From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001545]: Flash player hangs in Firefox when using aoss
Date: Sat, 4 Mar 2006 19:15:21 +0100
Message-ID: <6bc72193a64e535c380b7eac4994a971@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 22408173
	for <alsa-devel@alsa-project.org>; Sat,  4 Mar 2006 19:15:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1545> 
======================================================================
Reported By:                smagoun
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1545
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-11-2005 21:30 CET
Last Modified:              03-04-2006 19:15 CET
======================================================================
Summary:                    Flash player hangs in Firefox when using aoss
Description: 
I'm trying to get aoss to work with Firefox 1.5b2 and the Flash 7 plugin on
an XScale (PXA 270) running Linux 2.6.13.4. Problem is, the browser hangs
when navigating off a page that has Flash w/ sounds. The problem only
happens when using aoss. GDB reports that the browser's hung up in
snd_pcm_wait_nocheck, called from snd_pcm_dmix_drain.

This sounds a bit like
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1306, which was
reportedly fixed in ALSA
1.0.9a. I'm using the 1.0.9b drivers from 2.6.13.4 (plus patches for the
AC97 that were subsequently rolled into 2.6.14). Upgrading alsa-oss and
alsa-libs to 1.0.10rc3 didn't fix the problem.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001559 hang in snd_pcm_drain()
======================================================================

----------------------------------------------------------------------
 gvy - 03-04-06 16:32 
----------------------------------------------------------------------
See #1559 which is reportedly fixed in 1.0.11rc1.

----------------------------------------------------------------------
 gvy - 03-04-06 19:15 
----------------------------------------------------------------------
http://www.alsa-project.org/changes/v1-0-10--v1-0-11rc1.txt
search for 1559

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-05 21:30 smagoun        New Issue                                    
12-22-05 11:43 ikonst         Issue Monitored: ikonst                      
12-22-05 11:43 ikonst         Note Added: 0007122                          
03-04-06 16:32 gvy            Note Added: 0008349                          
03-04-06 16:33 gvy            Issue Monitored: gvy                         
03-04-06 19:07 rlrevell       Relationship added       related to 0001559  
03-04-06 19:15 gvy            Note Added: 0008353                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
