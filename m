From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000353]: No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Date: Sat, 23 Oct 2004 23:27:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4e88b7989d09bf1fba7123f9a95da14b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1AEEC275
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2004 23:27:55 +0200 (MEST)
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
Last Modified:              10-23-2004 23:27 CEST
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
 rob_hughes - 10-23-04 22:41 
----------------------------------------------------------------------
This issue is still occurring as of 1.7rc2 on a SB Audigy 2. Sound works
for the root user on the system, but no "regular" users can access the
sound functions. Other sound functions, such as playing sound back through
xmms, xine, or amarok work when either alsa or arts is selected as the
output.

----------------------------------------------------------------------
 rob_hughes - 10-23-04 23:27 
----------------------------------------------------------------------
Also, the correct bugzilla number is 124447, but that bug is still marked
as new.

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
