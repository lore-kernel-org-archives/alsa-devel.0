From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000488]: stac946x.h is missing in CVS
Date: Tue, 9 Nov 2004 16:20:36 +0100
Message-ID: <43d92b40af5ca47b0970fd2b918648aa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 10513244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:20:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=488> 
======================================================================
Reported By:                sashak
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   488
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.7-gentoo-r13
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-08-2004 13:21 CEST
Last Modified:              11-09-2004 16:20 CET
======================================================================
Summary:                    stac946x.h is missing in CVS
Description: 
Today's 7/09 CVS snapshot 'prodigy192.c' (new file) compilation fails
because of missing 'stac946x.h' file (most likely
alsa-kernel/pci/ice1712/stac946x.h). Error message frag is below:

In file included from
/home/sashak/alsa/alsa-driver/pci/ice1712/prodigy192.c:2:
/home/sashak/alsa/alsa-driver/alsa-kernel/pci/ice1712/prodigy192.c:37:22:
stac946x.h: No such file or directory
In file included from
/home/sashak/alsa/alsa-driver/pci/ice1712/prodigy192.c:2:
/home/sashak/alsa/alsa-driver/alsa-kernel/pci/ice1712/prodigy192.c: In
function `stac9460_dac_mute_get':
/home/sashak/alsa/alsa-driver/alsa-kernel/pci/ice1712/prodigy192.c:68:
error: `STAC946X_MASTER_VOLUME' undeclared (first use in this function)
...
======================================================================

----------------------------------------------------------------------
 perex - 09-08-04 13:29 
----------------------------------------------------------------------
I'm sorry, I missed this one. It's fixed in CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-08-04 13:21 sashak         New Issue                                    
09-08-04 13:21 sashak         Kernel Version            => 2.6.7-gentoo-r13
09-08-04 13:29 perex          Status                   assigned => resolved
09-08-04 13:29 perex          Resolution               open => fixed       
09-08-04 13:29 perex          Note Added: 0001728                          
11-09-04 16:20 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
