From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001303]: AD1816A sound driver has no parameter to adjust reference clock frequency
Date: Tue, 2 Aug 2005 17:38:09 +0200
Message-ID: <6cb69c88822efcbdb6f624cd5adb7191@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F1A71DF
	for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2005 17:38:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1303> 
======================================================================
Reported By:                tek01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1303
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               does not matter
Kernel Version:             at least up to 2.6.13-rc4
======================================================================
Date Submitted:             08-02-2005 17:38 CEST
Last Modified:              08-02-2005 17:38 CEST
======================================================================
Summary:                    AD1816A sound driver has no parameter to adjust
reference clock frequency
Description: 
The ALSA AD1816A sound driver has no parameter to specify the reference
clock frequency. The AD1816A chip has been designed for a 33MHz reference
clock, however some cards are shipped with different reference clocks
(mostly 32.125MHz). Thus the sample rate has to be corrected on those
cards before it is written to the hardware registers for proper capture
and playback speed.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 17:38 tek01          New Issue                                    
08-02-05 17:38 tek01          Distribution              => does not matter 
08-02-05 17:38 tek01          Kernel Version            => at least up to
2.6.13-rc4
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
