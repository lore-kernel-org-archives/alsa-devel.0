From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001028]: Raising PCM volume above 70% introduces clipping
Date: Thu, 31 Mar 2005 16:32:21 +0200
Message-ID: <930156e98190893c80b3b7ffd704f6dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AD6EA19A
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 16:32:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1028> 
======================================================================
Reported By:                cabbage
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1028
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian AMD64
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-31-2005 16:32 CEST
Last Modified:              03-31-2005 16:32 CEST
======================================================================
Summary:                    Raising PCM volume above 70% introduces clipping
Description: 
If the PCM volume slider (in alsamixer, kmix, etc) is raised above 70% the
soundcard (Chaintech AV710) front channel analog output starts clipping
(squaring the peaks of the signal). This behaviour is irrespective of the
setting of the Master slider.

Thus the sound card will produce clipped output at any volume setting -
severely reducing quality. While this is not a major problem (it's easy to
workaround by just keeping PCM set at 50% and adjusting Master) it could
cause unknowing users to have terrible sound quality.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-05 16:32 cabbage        New Issue                                    
03-31-05 16:32 cabbage        Distribution              => Debian AMD64    
03-31-05 16:32 cabbage        Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
