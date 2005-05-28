From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000751]: flash in firefox/mozilla/konqeror dies a horrible death taking the brower with it
Date: Sat, 28 May 2005 12:25:56 +0200
Message-ID: <e6f4c9a3b20e1b2b383e2c5d24523023@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4835F214
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 12:25:56 +0200 (MEST)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Slackware 10.0 and Slack-current
Kernel Version:             2.4.28/2.6.9
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-28-2004 02:30 CET
Last Modified:              05-28-2005 12:25 CEST
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
 nadavkav - 04-04-05 08:12 
----------------------------------------------------------------------
i changed sblive (which was poorly supported) to audigy zs and i'm veryyyy
happy (it rocks!)
so i can't help here anymore.

----------------------------------------------------------------------
 jcdutton - 05-28-05 12:25 
----------------------------------------------------------------------
User changed sound card, so cannot provide any feedback any more.

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
04-04-05 08:12 nadavkav       Issue Monitored: nadavkav                    
04-04-05 08:13 nadavkav       Issue End Monitor: nadavkav                    
05-28-05 12:25 jcdutton       Status                   feedback => closed  
05-28-05 12:25 jcdutton       Note Added: 0004768                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
