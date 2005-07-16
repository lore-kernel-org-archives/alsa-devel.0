From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000773]: Kernel 2.6.10 with ALSA 1.08rc1 from CVS (12/30/2004)
Date: Sat, 16 Jul 2005 16:32:00 +0200
Message-ID: <20050716143200.8C3C3184@alsa.jcu.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C3C3184
	for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2005 16:32:00 +0200 (MEST)
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

Audigy2 Value - SB0400 card
Audigy2 Value- AUX-In and LINE-IN no sound
Message-ID: <6646fcedeae230ae50154a2b348618fa@bugtrack.alsa-project.org>
X-Priority: 3
X-Mailer: PHPMailer [version 1.72]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=773> 
======================================================================
Reported By:                hodgesw
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   773
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               1.08rc1
Kernel Version:             2.6.10
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             01-01-2005 01:21 CET
Last Modified:              07-16-2005 16:31 CEST
======================================================================
Summary:                    Kernel 2.6.10 with ALSA 1.08rc1 from CVS
(12/30/2004)
Audigy2 Value - SB0400 card
Audigy2 Value- AUX-In and LINE-IN no sound
Description: 
Kernel 2.6.10 with ALSA 1.08rc1 from CVS (12/30/2004)
Audigy2 Value - SB0400 card
After trying many modprobe.preload/modprobe.conf alternatives I
manually loaded driver  using  "modprobe -v snd-emu10k1"
with /etc/modprobe.conf: "options snd-emu10k1  extin="0x3fff"
After setting alsamixer volumes
"speakertest" works; "aplay" produces good sound; mic produces good
sound;
"line in" does not work; "auxin" does nor work.
kde configure plays sound.
xmms cannot find sound card.

======================================================================

----------------------------------------------------------------------
 jdthood - 04-18-05 23:20 
----------------------------------------------------------------------
Submitter: Try setting the levels with gamix.

Can you please summarize the remaining problems?

----------------------------------------------------------------------
 jdthood - 07-16-05 16:29 
----------------------------------------------------------------------
> Close the issue.

OK

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-01-05 01:21 hodgesw        New Issue                                    
01-01-05 01:21 hodgesw        Distribution              => 1.08rc1         
01-01-05 01:21 hodgesw        Kernel Version            => 2.6.10          
01-01-05 02:27 rlrevell       Note Added: 0003029                          
01-01-05 16:13 hodgesw        Note Added: 0003032                          
01-01-05 18:44 rlrevell       Note Added: 0003033                          
01-01-05 20:35 pzad           Note Added: 0003035                          
01-01-05 21:51 hodgesw        Note Added: 0003036                          
01-01-05 22:01 rlrevell       Note Added: 0003037                          
01-01-05 23:02 pzad           Note Added: 0003040                          
01-02-05 00:30 hodgesw        Note Added: 0003042                          
01-02-05 04:00 hodgesw        Note Added: 0003043                          
01-02-05 09:20 pzad           Note Added: 0003044                          
01-02-05 23:21 hodgesw        File Added: test.state                       
01-03-05 22:48 hodgesw        Note Added: 0003075                          
01-04-05 19:50 pzad           Note Added: 0003079                          
01-05-05 02:07 hodgesw        Note Added: 0003088                          
04-18-05 23:20 jdthood        Note Added: 0004517                          
07-16-05 16:29 jdthood        Note Added: 0005495                          
07-16-05 16:31 jdthood        Status                   new => resolved     
07-16-05 16:31 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
