From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000172]: Master volume control only controls front speakers
Date: Thu, 9 Mar 2006 11:17:37 +0100
Message-ID: <5a34d592565296e6d7412e415db906b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1398C1DF
	for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2006 11:17:38 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=172> 
======================================================================
Reported By:                gruberroland
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   172
Category:                   2_mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-31-2004 11:50 CEST
Last Modified:              03-09-2006 11:17 CET
======================================================================
Summary:                    Master volume control only controls front speakers
Description: 
The master volume control has no effect on the rear speakers.
The rear speakers can be controlled by "Sigmatel Surround" but not
completly muted.

I use "Sigmatel 4-Speaker Stereo" to get sound on all 4 speakers. The
speakers are plugged into both output plugs on the soundcard.

I tried all volume controls that are provided, there seems to be no master
control.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000154 Master volume only controls front outpu...
related to          0000919 Master volume doesn't control rear spea...
======================================================================

----------------------------------------------------------------------
 perex - 03-31-04 16:35 
----------------------------------------------------------------------
It's feature request. We haven't designed abstract mixer layer at the
moment,
but you are allowed to control fully hardware anyway. If you cannot mute
completely the rear speakers, then it's probably hardware problem.

----------------------------------------------------------------------
 muffty - 03-09-06 11:17 
----------------------------------------------------------------------
After a long discussion in alsa-user@lists.sourceforge.net about this
problem a member of the list (Christian Haertwig) send me a patch to the
emu10k1 driver that adds a volume control called 'Digital Master' and is
able to control all 6 channels of the card.
This is a part of the mail he send to me:
---------------------
A "good" (where good means pretty easy to realize) fix *is* 
available. I have attached the patch file that does the job. You need to 
recompile alsa drivers that for. with the Patch included you will have a
new 
volume slider that indeed sets the overall volume for all channels. Since
i 
am no developer i cant tell you exactly why this patch is not included in
the 
drivers, but for emu10k1 and sb live i have found out it works great. i am

using it with alsa-driver and -lib version 1.0.10 and have had no *real* 
issues yet. unfortunately i know people reporting that this patch causes
the 
overall output volume to be a bit quiter than normal, but i cannot
confirm. 
Thanks again to whoever has send that patch to me.
---------------------
I tested the patch and it appeard that it doesn't work for me. 
When playing 2-channel sound my left front speaker was muted and when
playing 6-channel sound the rear left speaker was muted.
After a suggestion from Lee Revell I played arround with the
SND_EMU10K1_GPR_CONTROLS and made it work when leaving this setting to 44
and not changing it to 46 as the patch did. After these changes everything
works fine. A new volume called 'Digital Master' can control all channels
of the card. I have tested the card only in analog mode, as I don't have
digital speakers. 
If this is working for You give some feedback.
I'm attaching the original patch I was send as accourding to Christian it
works for other people. If it doesn't work for You try changing the
SND_EMU10K1_GPR_CONTROLS as I did.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-04 11:50 gruberroland   New Issue                                    
03-31-04 11:50 gruberroland   Kernel Version            => 2.4.25          
03-31-04 16:33 perex          Assigned To               => perex           
03-31-04 16:33 perex          Severity                 major => feature    
03-31-04 16:33 perex          Status                   new => assigned     
03-31-04 16:35 perex          Note Added: 0000725                          
10-22-04 16:44 perex          Relationship added       related to 0000154  
10-29-04 21:03 BMS            Issue Monitored: BMS                         
02-22-05 09:57 perex          Relationship added       related to 0000919  
02-22-05 09:59 perex          Project                  ALSA - driver => ALSA -
lib
02-22-05 09:59 perex          Category                 PCI - ens1371 => mixer
03-09-06 11:17 muffty         Note Added: 0008387                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
