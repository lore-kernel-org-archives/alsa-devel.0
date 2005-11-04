From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001526]: No sound from device
Date: Fri, 4 Nov 2005 16:08:54 +0100
Message-ID: <006afbb61127d3f24895d81af3d74329@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EDACB129
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2005 16:08:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1526> 
======================================================================
Reported By:                winggndm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1526
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.14
======================================================================
Date Submitted:             11-04-2005 04:02 CET
Last Modified:              11-04-2005 16:08 CET
======================================================================
Summary:                    No sound from device
Description: 
As of 1.0.10a which is int he 2.6.14 kernel, my sound card will not play
any sound.  The problem is with the configuration of the card.  If i first
load windows,let it init the card, and reboot, the card works fine. 
Something is not being configured corectly or at all and i think it could
be the external amp.  I have a similar problem with 1.0.9 but if i just
reload the module, it works fine.
======================================================================

----------------------------------------------------------------------
 winggndm - 11-04-05 16:08 
----------------------------------------------------------------------
Ok the problem is with the amp,  It seems it has to be "kicked started".
What i do is put pcm and master to max when i unmute the external amp
control.  This has to be done every time i unmute the external amp.  After
its "kicked started" everything works fine.  As a side note, all
dxs_support modes from 0 to 5 are working fine.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-04-05 04:02 winggndm       New Issue                                    
11-04-05 04:02 winggndm       Distribution              => gentoo          
11-04-05 04:02 winggndm       Kernel Version            => 2.6.14          
11-04-05 16:08 winggndm       Note Added: 0006606                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
