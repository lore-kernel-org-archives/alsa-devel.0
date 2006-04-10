From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001732]: Support for Intel D945Pvs Board
Date: Mon, 10 Apr 2006 16:40:31 +0200
Message-ID: <e0aa14772c2f7014f5066f1f322961c3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7AA39181
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 16:40:31 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1732> 
======================================================================
Reported By:                timtt
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1732
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               FC4
Kernel Version:             2.6.14-1656
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-11-2006 04:53 CET
Last Modified:              04-10-2006 16:40 CEST
======================================================================
Summary:                    Support for Intel D945Pvs Board
Description: 
Alsa is only able to output regular 2-channel audio via the headphone jack
at the back of this motherboard. This motherboard has an SPDIF connection
available that is currently not supported, but should be.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-09-06 23:30 
----------------------------------------------------------------------
Can you please send the patch to alsa-devel at lists.sourceforge.net
mailing list (you do not have to subscribe), and include a Signed-Off-By
line?

----------------------------------------------------------------------
 tiwai - 04-10-06 16:40 
----------------------------------------------------------------------
Fixed on CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 04:53 timtt          New Issue                                    
01-11-06 04:53 timtt          Distribution              => FC4             
01-11-06 04:53 timtt          Kernel Version            => 2.6.14-1656     
01-11-06 05:04 rlrevell       Note Added: 0007558                          
01-11-06 18:30 timtt          Note Added: 0007563                          
01-11-06 18:36 rlrevell       Note Added: 0007564                          
01-20-06 22:47 timtt          Note Added: 0007728                          
04-09-06 23:19 aclark         Note Added: 0009187                          
04-09-06 23:19 aclark         File Added: sigmatel.diff                    
04-09-06 23:19 aclark         Issue Monitored: aclark                      
04-09-06 23:30 rlrevell       Note Added: 0009188                          
04-10-06 16:40 tiwai          Status                   assigned => resolved
04-10-06 16:40 tiwai          Resolution               open => fixed       
04-10-06 16:40 tiwai          Note Added: 0009193                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
