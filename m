From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000629]: snd-powermac.o: unresolved symbol num_controls
Date: Fri, 5 Nov 2004 10:59:06 +0100
Message-ID: <a76d61426a041aa22f038e3f1f7930bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F094E248
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2004 10:59:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=629> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   629
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-05-2004 10:03 CET
Last Modified:              11-05-2004 10:59 CET
======================================================================
Summary:                    snd-powermac.o: unresolved symbol num_controls
Description: 
Please see Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=279731 
(http://bugs.debian.org/279731)

The submitter sees:
    /lib/modules/2.4.25-ben1/updates/alsa/snd-powermac.o: unresolved
symbol num_controls
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-05-04 10:59 
----------------------------------------------------------------------
fixed since 1.0.7rc1 with the following patch:
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/ppc/awacs.c?r1=1.25&r2=1.26&diff_format=u

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-05-04 10:03 jdthood        New Issue                                    
11-05-04 10:59 Clemens LadischStatus                   assigned => resolved
11-05-04 10:59 Clemens LadischResolution               open => fixed       
11-05-04 10:59 Clemens LadischNote Added: 0002305                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
