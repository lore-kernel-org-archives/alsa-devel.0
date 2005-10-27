From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001508]: flash mozilla plugin steals the sound from other plugins
Date: Thu, 27 Oct 2005 16:51:02 +0200
Message-ID: <0897fd76f8182e0b4cb0ab3c378b7062@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9C37B19D
	for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2005 16:51:02 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1508> 
======================================================================
Reported By:                sermat
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1508
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-27-2005 16:51 CEST
Last Modified:              10-27-2005 16:51 CEST
======================================================================
Summary:                    flash mozilla plugin steals the sound from other
plugins
Description: 
Hi to all:
This is probably the last obstacle for achieving my Linux computer
(PCLinuxOS, based on Mandriva/KDE) to work 100%.

When I visit a web site that first plays some flash content, flash video
and sound are OK, but when after that I try to play Realplayer content,
video is OK, ***BUT*** no sound.  On its own, Realplayer plugin sound and
video are 100% OK.

Here is the output, after attempting to play Realplayer content
***AFTER*** flash content just played:

[root@presario plugins]# artsd
ALSA lib pcm_dmix.c:802:(snd_pcm_dmix_open) unable to open slave
Error while initializing the sound driver:
device: default can't be opened for playback (Device or resource busy)
[root@presario plugins]#

Many thanks, and regards to all,
sermat.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-27-05 16:51 sermat         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
