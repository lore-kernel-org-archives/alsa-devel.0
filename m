From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001268]: alsa-lib-1.0.9 fails on sparc-linux
Date: Tue, 19 Jul 2005 08:31:07 +0200
Message-ID: <ac9ec9294eacfaa092697022e3a00837@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9DC081C1
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 08:31:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1268> 
======================================================================
Reported By:                eradicator
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1268
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-19-2005 08:31 CEST
Last Modified:              07-19-2005 08:31 CEST
======================================================================
Summary:                    alsa-lib-1.0.9 fails on sparc-linux
Description: 
After upgrading from alsa-lib-1.0.8 to 1.0.9, sound fails to play on my
sparc:

$ aplay /usr/kde/3.4/share/sounds/pop.wav 
ALSA lib pcm_direct.c:689:(snd_pcm_direct_initialize_slave) requested or
auto-format is not available
ALSA lib pcm_dmix.c:814:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:533: audio open error: Invalid argument

The drivers installed are 1.0.9b with the new ioctl compat (need patch
from bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1267)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-05 08:31 eradicator     New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
