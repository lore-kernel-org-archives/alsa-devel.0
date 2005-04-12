From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000594]: Sound level is extremely low
Date: Tue, 12 Apr 2005 23:51:51 +0200
Message-ID: <3115770841c2890526f5e512cf1a228c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6482027E
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2005 23:51:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=594> 
======================================================================
Reported By:                danstef
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   594
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.4.20
======================================================================
Date Submitted:             10-21-2004 23:19 CEST
Last Modified:              04-12-2005 23:51 CEST
======================================================================
Summary:                    Sound level is extremely low
Description: 
I compiled and installed drivers and utilities without a 
problem. 
I used the alsamixer and unmute all channels and raise levels. I also used
aumix to max the gain. When I play
a wave file (play --volume=100) I can barely hear the sound.
I have speakers hooked up to the line out and a front panel
speaker. Sound is coming out of both at the same really, really low level.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-12-05 17:44 
----------------------------------------------------------------------
Please attach /etc/asound.state and /proc/asound/card0/codec97#0/* files
for debugging.

----------------------------------------------------------------------
 danstef - 04-12-05 23:51 
----------------------------------------------------------------------
Please disregard this issue.
This is not an alsa bug, we found that we need to use an audio amplifier
with the motherboard we are using, the previous motherboard had enough
power out to not need an amplifier. 
Thanks for looking into this.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-04 23:19 danstef        New Issue                                    
10-21-04 23:19 danstef        Kernel Version            => 2.4.20          
10-21-04 23:21 danstef        Note Added: 0002224                          
04-09-05 16:26 jdthood        Note Added: 0004412                          
04-12-05 17:44 tiwai          Note Added: 0004456                          
04-12-05 23:51 danstef        Note Added: 0004466                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
