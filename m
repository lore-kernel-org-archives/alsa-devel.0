From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000353]: No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Date: Tue, 22 Mar 2005 19:56:52 +0100
Message-ID: <71530ae088bdfd6165607293c0b3d37e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 71DDF287
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 19:56:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=353> 
======================================================================
Reported By:                JSchmitt
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   353
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-30-2004 19:36 CEST
Last Modified:              03-22-2005 19:56 CET
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
 rob_hughes - 03-21-05 04:01 
----------------------------------------------------------------------
Despite my belief that tarballs are for girly-men ;), I went ahead and did
the build. Still getting a .xsession-errors full of 

ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe


Card is Audigy 2, OS FC3, kernel 2.6.10-1.770_FC3.

----------------------------------------------------------------------
 tiwai - 03-22-05 19:56 
----------------------------------------------------------------------
With ALSA 1.0.9, this message is no longer shown.
If you still see this message, the lib wasn't updated properly.

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
