From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000353]: No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Date: Thu, 24 Mar 2005 08:16:55 +0100
Message-ID: <80d1c126a5bc21cdf1f5e96b451cc542@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3438B2A3
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 08:16:56 +0100 (MET)
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
Last Modified:              03-24-2005 08:16 CET
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
 rob_hughes - 03-24-05 02:28 
----------------------------------------------------------------------
Please check your log again.

----------------------------------------------------------------------
 jdthood - 03-24-05 08:16 
----------------------------------------------------------------------
> Sound works for the root user on the system, but no "regular"
> users can access the sound functions. Other sound functions,
> such as playing sound back through xmms, xine, or amarok work
> when either alsa or arts is selected as the output.


These two sentences appear to contradict each other.  Can you say
more clearly what works and what does not?

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
