From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001008]: only one application can play at once
Date: Sun, 3 Apr 2005 13:33:00 +0200
Message-ID: <75927269b61f8f244893eef4c787cfe6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 39F0F1F8
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 13:33:00 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1008> 
======================================================================
Reported By:                msillence
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1008
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-22-2005 22:15 CET
Last Modified:              04-03-2005 13:32 CEST
======================================================================
Summary:                    only one application can play at once
Description: 
when two applications try and play or write to the dsp at the same time the
second  gets a device in use message.
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-03-05 13:32 
----------------------------------------------------------------------
This is normal behaviour for the Sound card hardware. You will have to try
using the "dmix" feature (see wiki at alsa.opensrc.org).
Tell me if it helps.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-05 22:15 msillence      New Issue                                    
03-22-05 22:15 msillence      Kernel Version            => 2.6.11.5        
04-03-05 13:32 jcdutton       Note Added: 0004308                          
04-03-05 13:32 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
