From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001205]: Mark M-Audio Revolution 7.1 (and probably other ICE1724 cards) as the one with no capture in card matrix
Date: Mon, 20 Jun 2005 00:30:35 +0200
Message-ID: <cfb4537835a1bed1476829b84387a157@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A0AFE1D0
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2005 00:30:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1205> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1205
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-20-2005 00:30 CEST
Last Modified:              06-20-2005 00:30 CEST
======================================================================
Summary:                    Mark M-Audio Revolution 7.1 (and probably other
ICE1724 cards) as the one with no capture in card matrix
Description: 
Takashi said the following regarding M-Audio Revolution 7.1 card:

in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1096 :

"
No, there is no capture control at all on this board, indeed. At least,
the hardware spec I got tells nothing about the capture controls. No gain
control, no input selection.
";

in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1164 :

"
Again, revo has no capture control. At least, the hardware spec I got
tells so.
";

in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1187 :

"
The input selection of line-in and mic is unknown thing - i.e. we have no
technical information about this feature at all. 
".

The quoted words above were said in response to my questions regarding
enabling capture.

>From the same quoted words I understand that at the moment there is no
known
way to enable capture.

Because of this I think it would be fair to mark the card as the one with
unsupported capture. Probably other ICE1724-based cards have the same
problem
too.

It would be a pity if other people buy the card and wouldn't be able to
use its
capture.

I have uploaded current snapshot of ALSA card matrix, it says:
"
 (4) Capture of sound not supported.
",
so I think this marker should be added to the card's description.

Thanks,
  Sergei.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-20-05 00:30 sst4           New Issue                                    
06-20-05 00:30 sst4           File Added: alsa_card_matrix.html                 
  
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
