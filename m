From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000353]: No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Date: Sat, 19 Mar 2005 12:38:20 +0100
Message-ID: <4608cc5eafd00b0b30833a6c23498a0e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1A6AB1D8
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 12:38:20 +0100 (MET)
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
Last Modified:              03-19-2005 12:38 CET
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
 rob_hughes - 03-19-05 12:08 
----------------------------------------------------------------------
It still affects 1.08 on my Audigy 2.0. I haven't gotten 1.09rc1 to compile
yet (using CVS).

----------------------------------------------------------------------
 jdthood - 03-19-05 12:38 
----------------------------------------------------------------------
>  It still affects 1.08 on my Audigy 2.0. I haven't gotten 1.09rc1 to
compile yet (using CVS).

Thanks for testing.

You should be able to build from the 1.0.9rc1 tarballs that have been
released.
If not then please file a bug report.

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
