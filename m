From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000172]: Master volume control only controls front speakers
Date: Fri, 10 Mar 2006 02:45:56 +0100
Message-ID: <1c68f2d2cb520c6db40170a98e4bef8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D3DA1DD
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2006 02:45:56 +0100 (MET)
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
Last Modified:              03-10-2006 02:45 CET
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
 muffty - 03-09-06 19:53 
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
The original author of the patch is Mikael Magnusson and as I know it is
posted to alsa-devel.
I tested with alsa 1.0.10 and SB Live! 5.1 (SB0220)



----------------------------------------------------------------------
 Raymond - 03-10-06 02:45 
----------------------------------------------------------------------
The "Sigmatel Surround" control the ratio of the front and rear speakers.

The "Surround" control the volume of the rear speakers.

amixer contents

numid=78,iface=MIXER,name='Master Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=79,iface=MIXER,name='Master Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=28,28


numid=101,iface=MIXER,name='PCM Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=102,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=28,28
numid=80,iface=MIXER,name='Surround Playback Switch'
  ; type=BOOLEAN,access=rw---,values=2
  : values=on,on
numid=81,iface=MIXER,name='Surround Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=23,23

numid=113,iface=MIXER,name='Sigmatel 4-Speaker Stereo Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=112,iface=MIXER,name='Sigmatel Output Bias Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=114,iface=MIXER,name='Sigmatel Surround Phase Inversion Playback '
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=82,iface=MIXER,name='Sigmatel Surround Playback Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=off
numid=83,iface=MIXER,name='Sigmatel Surround Playback Volume'
  ; type=INTEGER,access=rw---,values=2,min=0,max=31,step=0
  : values=0,0

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
03-09-06 11:18 muffty         File Added: master_volume_v3.patch                
   
03-09-06 11:19 muffty         Note Edited: 0008387                         
03-09-06 11:24 muffty         Issue Monitored: muffty                      
03-09-06 12:23 Miwer          Issue Monitored: Miwer                       
03-09-06 19:53 muffty         Note Edited: 0008387                         
03-10-06 02:45 Raymond        Note Added: 0008398                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
