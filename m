From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000896]: hercules gamesurround 4 not supported
Date: Tue, 15 Feb 2005 10:01:41 +0100
Message-ID: <483197e43c7450b6903e6587d5bc89d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 057A9278
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2005 10:01:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=896> 
======================================================================
Reported By:                pompel55
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   896
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               libranet  --debian testing
Kernel Version:             tried 2.4.21, 26, 27 and 2.6.10
======================================================================
Date Submitted:             02-09-2005 13:28 CET
Last Modified:              02-15-2005 10:01 CET
======================================================================
Summary:                    hercules gamesurround 4 not supported
Description: 
Bought myself a FANTASTIC new soundcard but it does not seem to be
supported yet.
It's not listed yet either, there is support for hercules Game(surround)
up to
version III but it seems Gamesurround 4 is entirely new, a different, 24
bit chip.
-The chip is  recognized but the module installation gives this error:
"wrong eeprom", it seems linux thinks (autodetects it as envy24pt) this is
an integrated VIA chip. You get sound but
the mixer does not work and sound quality is low.
I suppose I'll have to wait until it's properly supported.

stein
======================================================================

----------------------------------------------------------------------
 tiwai - 02-09-05 17:14 
----------------------------------------------------------------------
Try to contact the hardware manufacturor.

The card will be never supported until we get detailed information.

----------------------------------------------------------------------
 pompel55 - 02-15-05 10:01 
----------------------------------------------------------------------
got this answer back when i tried to contact the hardware
vendor/manufacturer (Guillemot):

"Hello,

The card is based on VIA's ENVY 24 chip , which I believe is already
supported by ALSA (look for AudioTrack Prodigy 7.1  or M-Audio Delta
revolution 7.1 )."

-I'll try this of course but these are not mentioned anywhere in the docs
for alsa 1.0.8. maybe i have to try a development version?  I suspect the
surround mixer is not supported yet. Autodetetion/installation with
alsaconf does not give usable results.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 13:28 pompel55       New Issue                                    
02-09-05 13:28 pompel55       Distribution              => libranet  --debian
testing
02-09-05 13:28 pompel55       Kernel Version            => tried 2.4.21, 26, 27
and 2.6.10
02-09-05 17:14 tiwai          Note Added: 0003558                          
02-15-05 10:01 pompel55       Note Added: 0003616                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
