From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001272]: sys_open symbol not known
Date: Fri, 22 Jul 2005 10:06:07 +0200
Message-ID: <8e0615198936b7be7434c1bd7575e9d1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 23C841A7
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2005 10:06:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1272> 
======================================================================
Reported By:                arturl
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1272
Category:                   ISA - wavefront
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora 4
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-22-2005 10:06 CEST
Last Modified:              07-22-2005 10:06 CEST
======================================================================
Summary:                    sys_open symbol not known
Description: 
The wavefront driver uses sys_open from kernel and this symbol is for
unknown reason not exported. As a consequence module cannot be loaded.
The sys_open function lack of export directive and after adding it all
works OK.
In fact this is not ALSA bug but...

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 10:06 arturl         New Issue                                    
07-22-05 10:06 arturl         Distribution              => Fedora 4        
07-22-05 10:06 arturl         Kernel Version            => 2.6.12          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
