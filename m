From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000183]: Mic boost boosts mic playback and not recording
Date: Thu, 7 Apr 2005 00:12:17 +0200
Message-ID: <e8eecc12785f110ece412a641440f2d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2B83C204
	for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2005 00:12:18 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=183> 
======================================================================
Reported By:                Schugy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   183
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               SuSE 8.2
Kernel Version:             2.4.25
======================================================================
Date Submitted:             04-04-2004 13:51 CEST
Last Modified:              04-07-2005 00:12 CEST
======================================================================
Summary:                    Mic boost boosts mic playback and not recording
Description: 
I've tried to record my voice with broadcast2000. The recording level is at
-30db (maybe 2db louder than without mic boost) while mic playback seems
to be boosted up by 500% to an audiable level.


======================================================================

----------------------------------------------------------------------
 mlejeune - 04-27-04 17:33 
----------------------------------------------------------------------
Same thing here. Mic boost switch works only on monitoring, not recording
level, so mic input is unusable with standard mics. 

Alsa 1.0.4 (from sources) on vanilla 2.6.5 linux kernel.
CMI8738-MC6 chipset with cmipci driver.

----------------------------------------------------------------------
 tiwai - 04-30-04 11:43 
----------------------------------------------------------------------
well, unfortunately i can't find any relevant other register
bits for the mic boost...

----------------------------------------------------------------------
 Schugy - 05-23-04 19:45 
----------------------------------------------------------------------
Mic boost for recording isn't a hardware feature? Well, then we need a
dirty workaround anywhere in the alsa/oss-library or something similar
(feature request) to boost the volume of recorded sounds afterwards.
At the moment this card is unusable for mics.

Don't know whether it's useful to ask c-media for some information.

----------------------------------------------------------------------
 tiwai - 05-24-04 14:50 
----------------------------------------------------------------------
i have no idea unless the datasheet provides no information about it...

yes, please ask c-media.  i've got no response from them, but more
inquires may hit more frequently :)

----------------------------------------------------------------------
 thorstenhirsch - 07-24-04 19:47 
----------------------------------------------------------------------
Same thing here with a 0000:00:0c.0 Multimedia audio controller: C-Media
Electronics Inc CM8738 (rev 10) and kernel 2.6.7 (gentoo-dev-sources). The
mic boost is absolutely neccessary for netmeeting/teamspeak/skype.

I'm going to write a mail to C-Media and hope that they'll answer.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-04 13:51 Schugy         New Issue                                    
04-04-04 13:51 Schugy         Distribution              => SuSE 8.2        
04-04-04 13:51 Schugy         Kernel Version            => 2.4.25          
04-27-04 17:33 mlejeune       Note Added: 0000962                          
04-27-04 17:35 mlejeune       Issue Monitored: mlejeune                    
04-30-04 11:43 tiwai          Note Added: 0000982                          
05-23-04 19:45 Schugy         Note Added: 0001180                          
05-24-04 14:50 tiwai          Note Added: 0001183                          
07-24-04 19:47 thorstenhirsch Note Added: 0001471                          
04-07-05 00:12 jdthood        Status                   new => acknowledged 
04-07-05 00:12 jdthood        Resolution               open => not fixable 
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
