From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001207]: Cannot control front panel audio with PCM slider
Date: Wed, 22 Jun 2005 18:58:36 +0200
Message-ID: <1d5c72057c579e1fabbb6ed46d3402ee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8DF841F8
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 18:58:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1207> 
======================================================================
Reported By:                jbrsubscribe
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1207
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               SuSE
Kernel Version:             2.6.11.4-21.7-smp (SMP)
======================================================================
Date Submitted:             06-22-2005 18:58 CEST
Last Modified:              06-22-2005 18:58 CEST
======================================================================
Summary:                    Cannot control front panel audio with PCM slider
Description: 
I am running an ASUS P5AD2-E Premium motherboard with the hda-intel/CMI9880
audio card with alsa driver 1.0.9a installed. This board has a Front Panel
Audio Connector (10-1 AAFP) which connects to an audio i/o module on the
front of the system case.
None of the mixers on the system are able to control the volume on the
front panel connector. I have used alsamixer, KAMix, Kmix, QAMix and gamix
- all with the same result. The volume on the Front panel connector seem
to be set to the maximum and I have not yet found a way by which it can be
controlled.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-22-05 18:58 jbrsubscribe   New Issue                                    
06-22-05 18:58 jbrsubscribe   Distribution              => SuSE            
06-22-05 18:58 jbrsubscribe   Kernel Version            => 2.6.11.4-21.7-smp
(SMP)
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
