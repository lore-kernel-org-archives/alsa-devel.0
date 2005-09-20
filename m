From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000353]: No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Date: Tue, 20 Sep 2005 12:06:43 +0200
Message-ID: <e2eb92756e98f74cc2e494e158ef0dac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0795719C
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2005 12:06:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=353> 
======================================================================
Reported By:                JSchmitt
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   353
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-30-2004 19:36 CEST
Last Modified:              09-20-2005 12:06 CEST
======================================================================
Summary:                    No sound as startup of KDE 3.2.3, errormessage in
snd_pcm_hw.c
Description: 
When I try to start X with KDE 3.2.3, I will get the following error
mesages:

ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

I will not get any sound.
======================================================================

----------------------------------------------------------------------
 rob_hughes - 09-19-05 22:45 
----------------------------------------------------------------------
I'm believe that I was referring to accessing /dev/dsp would work for root,
but not a regular user, as that was a problem I had for awhile before I
finally just made the device node 666 instead of using groups, although
the group access should have worked. This is still a problem I run into
from time to time, where /dev/dsp is accessible to root, or if it's set
666, but not when its owner is root:audio, permissions 660, and the user
is a member of the audio group. Any rate, it's not related to this issue.

At any rate, since I switched to Ubuntu (Alsa 1.0.8), the problem has gone
away, so this is probably just more redhat kernel brokeness, unless
someone else can reproduce it.

As far as I'm concerned, and since the original reporter seems to have
wandered off permanently, I'd say close it.

----------------------------------------------------------------------
 jdthood - 09-20-05 12:06 
----------------------------------------------------------------------
Apparently not a bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-30-04 19:36 JSchmitt       New Issue                                    
07-06-04 18:33 JSchmitt       Issue Monitored: JSchmitt                    
07-15-04 14:20 perex          Note Added: 0001433                          
07-15-04 17:57 JSchmitt       Note Added: 0001436                          
08-17-04 06:11 samy           Note Added: 0001572                          
08-17-04 06:11 samy           Issue Monitored: samy                        
10-23-04 22:41 rob_hughes     Note Added: 0002256                          
10-23-04 22:50 rob_hughes     Issue Monitored: rob_hughes                    
10-23-04 23:27 rob_hughes     Note Added: 0002258                          
10-25-04 01:08 rob_hughes     Note Edited: 0002256                         
03-19-05 09:06 jdthood        Note Added: 0004011                          
03-19-05 12:08 rob_hughes     Note Added: 0004034                          
03-19-05 12:38 jdthood        Note Added: 0004035                          
03-21-05 04:01 rob_hughes     Note Added: 0004115                          
03-22-05 19:56 tiwai          Note Added: 0004130                          
03-24-05 02:28 rob_hughes     Note Added: 0004190                          
03-24-05 08:16 jdthood        Note Added: 0004192                          
09-19-05 22:45 rob_hughes     Note Added: 0006303                          
09-20-05 12:06 jdthood        Status                   new => closed       
09-20-05 12:06 jdthood        Note Added: 0006312                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
