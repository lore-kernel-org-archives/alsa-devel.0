From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001270]: "External amplifier" consistently mis-configured on upgrade, breaks sound
Date: Thu, 21 Jul 2005 09:10:16 +0200
Message-ID: <62a3318836ac151c96166be0fbc74974@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6F2E91ED
	for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2005 09:10:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1270> 
======================================================================
Reported By:                eyequeue
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1270
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu (breezy)
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-21-2005 09:10 CEST
Last Modified:              07-21-2005 09:10 CEST
======================================================================
Summary:                    "External amplifier" consistently mis-configured on
upgrade, breaks sound
Description: 
Each time the ALSA packages are upgraded, sound becomes inoperative.

To fix, I have to run alsamixer as root, and DISable the "External
amplifier" setting, which somehow keeps getting turned on, upon package
upgrade.

This is a laptop, so there is no "external" anything, and turning this
setting off again allows sound to once again work.

Upon asking advice on IRC i was told this was an upstream "AC97 codec bug"
if that phrase helps you in any way.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-05 09:10 eyequeue       New Issue                                    
07-21-05 09:10 eyequeue       Distribution              => Ubuntu (breezy) 
07-21-05 09:10 eyequeue       Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
