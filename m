From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001143]: echomixer shows vu meters in grmix wrong
Date: Wed, 8 Jun 2005 17:36:16 +0200
Message-ID: <89d878372c80e3da1ced551b5f5312c5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DBB6C1DE
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 17:36:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1143> 
======================================================================
Reported By:                Xero
Assigned To:                tiwai
======================================================================
Project:                    ALSA - tools
Issue ID:                   1143
Category:                   envy24control
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-29-2005 14:58 CEST
Last Modified:              06-08-2005 17:36 CEST
======================================================================
Summary:                    echomixer shows vu meters in grmix wrong
Description: 
this happens with alsa 1.0.9, and the change that causes it is revision 1.2
in cvs, so this problem has been around for a bit. Essentially, the vu
meters show each channel outputting the same level across all outputs, not
just the ones where it's actually outputting to. It's basically as if the
vu meters are not acknowleding the volume levels that are set. I've
attached a screen shot showing the issue, as it's sort of hard to
describe. You can clearly see the little yellow volume bars for V4 and V5
are bottomed out on all the outputs except for 2, but vu meters show up on
all of them.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-08-05 17:36 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-05 14:58 Xero           New Issue                                    
05-29-05 14:58 Xero           File Added: window.jpg                       
06-08-05 17:36 tiwai          Status                   new => resolved     
06-08-05 17:36 tiwai          Resolution               open => fixed       
06-08-05 17:36 tiwai          Assigned To               => tiwai           
06-08-05 17:36 tiwai          Note Added: 0004966                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
