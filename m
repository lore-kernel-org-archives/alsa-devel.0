From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001249]: dmix doesn't survive suspend to RAM
Date: Sun, 10 Jul 2005 11:33:38 +0200
Message-ID: <61f9760940189ef4f19418d5457c14d6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F9B0186
	for <alsa-devel@alsa-project.org>; Sun, 10 Jul 2005 11:33:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1249> 
======================================================================
Reported By:                nijel
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1249
Category:                   simple mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-10-2005 11:33 CEST
Last Modified:              07-10-2005 11:33 CEST
======================================================================
Summary:                    dmix doesn't survive suspend to RAM
Description: 
After resuming from suspend to RAM, dmix stops working. Application(s) that
had sound device opened can still use it, while the newly started can
not:

ALSA lib pcm_direct.c:196:(make_local_socket) connect failed:
/tmp/alsa-dmix-3679-1120945544-968306: No such file or directory
ALSA lib pcm_dmix.c:834:(snd_pcm_dmix_open) unable to connect client
ALSA snd_pcm_open error: No such file or directory

Stoping application that has opened device makes it work again.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-10-05 11:33 nijel          New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
