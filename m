From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001300]: modprobe goes into D-state when inserting snd-ad1816a
Date: Tue, 2 Aug 2005 16:56:16 +0200
Message-ID: <f739c950f6f7490d5f6cab648b98ea95@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7E8E91DF
	for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2005 16:56:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1300> 
======================================================================
Reported By:                tek01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1300
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.12.3 and 2.6.13-rc4
======================================================================
Date Submitted:             08-02-2005 16:56 CEST
Last Modified:              08-02-2005 16:56 CEST
======================================================================
Summary:                    modprobe goes into D-state when inserting
snd-ad1816a
Description: 
Under Linux 2.6.12.3 and Linux 2.6.13-rc4 inserting the snd-ad1816a module
causes the modprobe process to go into D-state forever. 

Linux 2.6.11.12 has been tested and is working fine.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 16:56 tek01          New Issue                                    
08-02-05 16:56 tek01          Distribution              => Debian Sarge    
08-02-05 16:56 tek01          Kernel Version            => 2.6.12.3 and
2.6.13-rc4
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
