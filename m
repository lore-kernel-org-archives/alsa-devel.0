From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000905]: Creative Labs SB Audigy LS  uses snd-ca0106 driver
Date: Wed, 8 Jun 2005 16:25:02 +0200
Message-ID: <dfdbb34de51612c2c527e8ccea7e78d5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3E6241F4
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 16:25:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=905> 
======================================================================
Reported By:                adaviel
Assigned To:                perex
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   905
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-12-2005 23:46 CET
Last Modified:              06-08-2005 16:25 CEST
======================================================================
Summary:                    Creative Labs SB Audigy LS  uses snd-ca0106 driver
Description: 
The Creative Labs SB card identified by
PCI Class 0401: 1102:0007
is supported by the 
snd-ca0106 driver (not audigyls as implied by the current matrix)

My current system (FCI) says it's an unknown device. The user said it 
was an SB Live. But 
http://pciids.sourceforge.net/iii/?i=1102
says it's an SB Audigy LS, so I guess that's what it is ...
======================================================================

----------------------------------------------------------------------
 perex - 06-08-05 16:25 
----------------------------------------------------------------------
It's correct now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-12-05 23:46 adaviel        New Issue                                    
06-08-05 16:25 perex          Status                   new => resolved     
06-08-05 16:25 perex          Resolution               open => fixed       
06-08-05 16:25 perex          Assigned To               => perex           
06-08-05 16:25 perex          Note Added: 0004951                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
