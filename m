From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000234]: Sound problems with APM Suspend/Resume on HP Omnibook 4150
Date: Sun, 3 Apr 2005 20:01:54 +0200
Message-ID: <7d9518b781ef785828678c96b5211247@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 231C31EC
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 20:01:55 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=234> 
======================================================================
Reported By:                mtvoid
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   234
Category:                   ISA - ad1848
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-26-2004 10:09 CEST
Last Modified:              04-03-2005 20:01 CEST
======================================================================
Summary:                    Sound problems with APM Suspend/Resume on HP
Omnibook 4150
Description: 
I have an HP Omnibook 4150 notebook. It is reported to have a Crystal Sound
chipset, and sound support works with both the CS423x and the AD1848
driver modules. I am using the snd-ad1848 driver with the following
settings: port=0x534 irq=7 dma1=1. The sound works alright with this, but
it seems the driver has trouble dealing with a system that has resumed
from an APM suspend state. After resuming, the sound samples play with
breaks and repetitions. Often, the following is printed into the syslog:
kernel: mce_down [0x534]: serious init problem - codec still busy

Note: This is observed even if I do not load any sound modules at bootup,
do a suspend/resume, and then load the drivers. It seems that after
resume, the card is put in a state different from before, which the driver
is unable to handle.
======================================================================

----------------------------------------------------------------------
 jdthood - 04-03-05 20:01 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?

> Note: This is observed even if I do not load any sound
> modules at bootup, do a suspend/resume, and then load
> the drivers. It seems that after resume, the card is put
> in a state different from before, which the driver is
> unable to handle.

This suggests that the driver is/was not initializing the hardware
properly.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-04 10:09 mtvoid         New Issue                                    
04-26-04 10:09 mtvoid         Kernel Version            => 2.6.5           
04-03-05 20:01 jdthood        Note Added: 0004315                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
