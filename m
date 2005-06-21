From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001204]: Mono recording produces audio at half volume
Date: Tue, 21 Jun 2005 12:47:35 +0200
Message-ID: <811b8f17d233f50d86a5604b19a947a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D15F71EE
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2005 12:47:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1204> 
======================================================================
Reported By:                pascal
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1204
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.4.16 highmem smp
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             06-19-2005 17:07 CEST
Last Modified:              06-21-2005 12:47 CEST
======================================================================
Summary:                    Mono recording produces audio at half volume
Description: 
Mono recording yields audio data at half the expected volume.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-21-05 12:47 
----------------------------------------------------------------------
It's a feature.
If you don't this behavior, set route_policy in plug plugin to "copy".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-19-05 17:07 pascal         New Issue                                    
06-19-05 17:07 pascal         Kernel Version            => 2.4.16 highmem smp
06-21-05 12:47 tiwai          Status                   new => resolved     
06-21-05 12:47 tiwai          Resolution               open => not an issue
06-21-05 12:47 tiwai          Assigned To               => tiwai           
06-21-05 12:47 tiwai          Note Added: 0005108                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
