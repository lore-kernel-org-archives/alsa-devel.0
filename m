From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000059]: On au8820 left and right channels are swapped
Date: Sat, 27 Aug 2005 04:43:18 +0200
Message-ID: <f624c2f41f13d3421bec84f36f3a5b93@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F2B00196
	for <alsa-devel@alsa-project.org>; Sat, 27 Aug 2005 04:43:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59> 
======================================================================
Reported By:                kernel_bug
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   59
Category:                   PCI - au88x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     confirmed
Distribution:               
Kernel Version:             2.6.2
======================================================================
Date Submitted:             02-13-2004 11:40 CET
Last Modified:              08-27-2005 04:43 CEST
======================================================================
Summary:                    On au8820 left and right channels are swapped
Description: 
In most cases, left and right channels are swapped. But in approx. 5% cases
all OK. Looks like the matter is somewhere in byte alignment...
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000949 Randomly, left and right tracks are swaped
======================================================================

----------------------------------------------------------------------
 kernel_bug - 08-26-05 17:41 
----------------------------------------------------------------------
> Please upgrade to CVS if possible
> perform speaker-test again after upgrade
I have upgraded directory pci/au88x0 (I suppose it should be sufficient).
No changes.

> alsactl store
> post the content of /etc/asound.state
See attached file.

----------------------------------------------------------------------
 Raymond - 08-27-05 04:43 
----------------------------------------------------------------------
0:7c = 574d
0:7e = 4c00

You may need to upgrade to CVS since there is a patch for WM codecs.

This means you cannot just copy pci/ac97/*.*
1) alsa-driver
2) alsa-lib
3) alsa-util

02:02.0 Class 0401: 12eb:0001 (rev 02)
        Subsystem: 12eb:0001

Is your Vortex card OEM ?

http://portal.suse.com/sdb/en/2001/03/chofman_vortex.html

Other user do not have your problem but his au8820 card use STAC9704 and
your card use WM9701A. 

The other user has WM9701A on his au8810.

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948


Do you find "vortex: IRQ fifo error" in system log when you play sound ?

http://lists.nongnu.org/archive/html/openvortex-dev/2005-03/msg00015.html

Using "vortex_adbdma_stopfifo()" instead of "vortex_adbdma_pausefifo()"
in snd_vortex_pcm_trigger() (ie. in the same way before au88x0 migrated
from alsa-driver to alsa-kernel) seem to fix the front/rear channels swap
when playing 4 channels sound on my au8830.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 11:40 kernel_bug     New Issue                                    
02-21-04 15:40 kernel_bug     Note Added: 0000280                          
03-02-04 02:56 Tim            Note Added: 0000429                          
04-09-04 11:54 kernel_bug     Note Added: 0000774                          
04-09-04 18:35 mjander        Note Added: 0000777                          
04-17-04 18:59 mjander        Status                   assigned => closed  
04-17-04 18:59 mjander        Note Added: 0000849                          
04-26-04 17:04 kernel_bug     Status                   closed => feedback  
04-26-04 17:04 kernel_bug     Resolution               open => reopened    
04-26-04 17:04 kernel_bug     Note Added: 0000953                          
04-26-04 23:27 mjander        Note Added: 0000956                          
03-10-05 15:31 jdthood        Note Added: 0003866                          
03-10-05 16:44 mjander        Note Added: 0003867                          
03-10-05 21:25 kernel_bug     Note Added: 0003873                          
03-22-05 22:33 jdthood        Relationship added       related to 0000949  
03-28-05 04:27 jdthood        Note Added: 0004235                          
03-28-05 04:27 jdthood        Status                   feedback => assigned
03-28-05 04:29 jdthood        Status                   assigned => confirmed
08-26-05 14:50 Raymond        Note Added: 0005951                          
08-26-05 15:12 kernel_bug     Note Added: 0005955                          
08-26-05 16:07 Raymond        Note Added: 0005956                          
08-26-05 17:38 kernel_bug     File Added: asound.state                     
08-26-05 17:41 kernel_bug     Note Added: 0005957                          
08-27-05 04:43 Raymond        Note Added: 0005959                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
