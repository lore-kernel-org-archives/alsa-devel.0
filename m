From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000751]: flash in firefox/mozilla/konqeror dies a horrible death taking the brower with it
Date: Mon, 4 Apr 2005 08:12:29 +0200
Message-ID: <dd9a67901aea5cc724e89ad8b1832d12@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7F2AC224
	for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2005 08:12:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=751> 
======================================================================
Reported By:                koni
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   751
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     feedback
Distribution:               Slackware 10.0 and Slack-current
Kernel Version:             2.4.28/2.6.9
======================================================================
Date Submitted:             12-28-2004 02:30 CET
Last Modified:              04-04-2005 08:12 CEST
======================================================================
Summary:                    flash in firefox/mozilla/konqeror dies a horrible
death taking the brower with it
Description: 
For a complete list of hardware in the box you can hit
http://www.iamnotanerd.com
Asus a7v
athlon 1.3 underclocked to 1.0
sblive! 24bit using ca0106
nvidia geforce2 w/64mb
Everything sounds good in games, xine, xmms, but when I open firefox, no
sound. I checked permissions, were good. I opened flash and flash does ok
until I hover over something with a sound element.  Then the flash gets
choppy and halts. I cannot close firefox/mozilla. Kill client leaves a
zombied process that must be killed. Switched to nv (instead of nvidia)
drivers same issue.  Pulled firefox/flash from a known working install
played half a sound then same issue.  Halted artsd  same issue. Removed
drivers and modded modules.conf to not load, flash works fine.
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-03-05 13:26 
----------------------------------------------------------------------
I need the following information in order to help:
1) A URL for some web sites that provide music?
2) Which media player are you using in firefox? Post output of
"about:plugins"
3) output of "cat /proc/asound/cards"
4) output of "cat /proc/asound/version"


----------------------------------------------------------------------
 nadavkav - 04-04-05 08:12 
----------------------------------------------------------------------
i changed sblive (which was poorly supported) to audigy zs and i'm veryyyy
happy (it rocks!)
so i can't help here anymore.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 02:30 koni           New Issue                                    
12-28-04 02:30 koni           Distribution              => Slackware 10.0 and
Slack-current
12-28-04 02:30 koni           Kernel Version            => 2.4.28/2.6.9    
12-30-04 22:03 koni           Issue Monitored: koni                        
01-22-05 22:32 nadavkav       Note Added: 0003380                          
04-03-05 13:26 jcdutton       Note Added: 0004307                          
04-03-05 13:26 jcdutton       Status                   assigned => feedback
04-04-05 08:12 nadavkav       Note Added: 0004323                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
