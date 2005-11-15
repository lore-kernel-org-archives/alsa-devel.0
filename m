From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001268]: alsa-lib-1.0.9 fails on sparc-linux
Date: Tue, 15 Nov 2005 20:17:48 +0100
Message-ID: <1a0374dedcb02624ca4369eec64de9a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 690751A4
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2005 20:17:48 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1268> 
======================================================================
Reported By:                eradicator
Assigned To:                jdthood
======================================================================
Project:                    ALSA - lib
Issue ID:                   1268
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-19-2005 08:31 CEST
Last Modified:              11-15-2005 20:17 CET
======================================================================
Summary:                    alsa-lib-1.0.9 fails on sparc-linux
Description: 
After upgrading from alsa-lib-1.0.8 to 1.0.9, sound fails to play on my
sparc:

$ aplay /usr/kde/3.4/share/sounds/pop.wav 
ALSA lib pcm_direct.c:689:(snd_pcm_direct_initialize_slave) requested or
auto-format is not available
ALSA lib pcm_dmix.c:814:(snd_pcm_dmix_open) unable to initialize slave
aplay: main:533: audio open error: Invalid argument

The drivers installed are 1.0.9b with the new ioctl compat (need patch
from bug #1267)
======================================================================

----------------------------------------------------------------------
 eradicator - 11-15-05 19:12 
----------------------------------------------------------------------
This is fixed with 1.0.10_rc3

----------------------------------------------------------------------
 jdthood - 11-15-05 20:17 
----------------------------------------------------------------------
>  This is fixed with 1.0.10_rc3

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-05 08:31 eradicator     New Issue                                    
07-19-05 08:33 eradicator     File Added: aplay.strace                     
11-15-05 19:12 eradicator     Note Added: 0006733                          
11-15-05 20:17 jdthood        Status                   new => resolved     
11-15-05 20:17 jdthood        Resolution               open => fixed       
11-15-05 20:17 jdthood        Assigned To               => jdthood         
11-15-05 20:17 jdthood        Note Added: 0006734                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
