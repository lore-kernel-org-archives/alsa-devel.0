From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000154]: Master volume only controls front output (emu10k1)
Date: Mon, 13 Mar 2006 13:51:09 +0100
Message-ID: <4a7f9d8e6868fc03869f7aaad5c51b8a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5D021C1
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 13:51:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154> 
======================================================================
Reported By:                wzzrd
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   154
Category:                   2_mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-23-2004 17:31 CET
Last Modified:              03-13-2006 13:51 CET
======================================================================
Summary:                    Master volume only controls front output (emu10k1)
Description: 
Setting the alsamixer Master Volume slider only controls the front two
speakers. The rear speakers have to be controlled with the Wave Surround
setting. I'm not sure whether this is an alsamixer bug or a alsa-driver
bug. If I'm wrong putting it here, sorry.

It would be very convenient to be able to control all four speakers with
the Master Volume setting and to have a Front and Rear slider to control
the front and rear speakers individually.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000176 Master volume does not alters center, L...
has duplicate       0000786 Master can't handle all channel
has duplicate       0001256 surround51: Master Volume control and M...
has duplicate       0001071 Help with Volume Controls
related to          0000919 Master volume doesn't control rear spea...
======================================================================

----------------------------------------------------------------------
 tiwai - 03-13-06 13:28 
----------------------------------------------------------------------
I'd suggest to rename the ac97 Master to Front, and the new Master Digital
to a real Master.  Also, for avoid regressions (no sound after update),
make the default value of Front full and unmuted.

----------------------------------------------------------------------
 muffty - 03-13-06 13:51 
----------------------------------------------------------------------
I posted this on bug #172 by mistake, so I'll move the original post here:

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
drivers, but for emu10k1 and sb live i have found out it works great. i
am
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
The original author of the patch is Mikael Magnusson and as I know it is
posted to alsa-devel.
I tested with alsa 1.0.10 and SB Live! 5.1 (SB0220)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-04 17:31 wzzrd          New Issue                                    
03-23-04 18:42 perex          View Status              @0@ => public       
03-23-04 18:42 perex          Description Updated                          
03-23-04 18:42 perex          Additional Information Updated                    
03-23-04 18:43 perex          Status                   new => assigned     
03-23-04 18:43 perex          Assigned To               => perex           
03-26-04 20:21 djtm           Note Added: 0000708                          
04-19-04 02:47 tarball        Issue Monitored: tarball                     
04-19-04 21:23 perex          Relationship added       has duplicate 0000176
05-24-04 22:51 delmonico      Note Added: 0001199                          
10-22-04 16:44 perex          Relationship added       related to 0000172  
10-23-04 01:09 djtm           Note Added: 0002253                          
10-23-04 01:09 djtm           File Added: alsavol.sh                       
10-23-04 01:10 djtm           Note Edited: 0002253                         
11-25-04 12:46 rpolach        Issue Monitored: rpolach                     
01-04-05 21:01 Miwer          Note Added: 0003081                          
01-04-05 21:11 rlrevell       Note Added: 0003082                          
01-04-05 21:29 pzad           Note Added: 0003083                          
01-04-05 21:38 rlrevell       Note Added: 0003084                          
01-04-05 22:30 pzad           Note Added: 0003085                          
01-04-05 22:38 rlrevell       Note Added: 0003086                          
01-07-05 18:23 tiwai          Relationship added       has duplicate 0000786
01-09-05 20:28 voroskoi       Issue Monitored: voroskoi                    
01-27-05 00:58 adamk75        Issue Monitored: adamk75                     
01-27-05 01:00 adamk75        Note Added: 0003418                          
02-01-05 22:57 adamk75        Note Added: 0003475                          
02-03-05 20:20 rlrevell       Note Added: 0003493                          
02-17-05 22:01 adamk75        Note Added: 0003642                          
02-17-05 22:59 rlrevell       Note Added: 0003646                          
02-17-05 23:28 adamk75        Note Added: 0003647                          
02-22-05 09:56 perex          Relationship added       related to 0000919  
05-20-05 20:39 Miwer          Issue Monitored: Miwer                       
05-20-05 22:02 Miwer          Note Added: 0004699                          
05-20-05 22:05 rlrevell       Note Added: 0004700                          
07-13-05 18:56 rlrevell       Relationship added       has duplicate 0001256
07-16-05 17:11 jdthood        Relationship added       has duplicate 0001071
09-02-05 19:55 blueSceaDa     Issue Monitored: blueSceaDa                    
03-09-06 11:34 muffty         Note Added: 0008388                          
03-09-06 11:37 muffty         Issue Monitored: muffty                      
03-12-06 21:27 rlrevell       Relationship deleted     related to 0000172  
03-12-06 21:34 rlrevell       File Added: master_volume_v3.patch                
   
03-12-06 21:35 rlrevell       Note Added: 0008436                          
03-13-06 13:28 tiwai          Note Added: 0008440                          
03-13-06 13:49 muffty         Note Deleted: 0008388                        
03-13-06 13:51 muffty         Note Added: 0008442                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
