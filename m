From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000451]: Corruption in /etc/asound.state causes alsa to hang when restoring mixer levels during reboot.
Date: Tue, 9 Nov 2004 16:31:30 +0100
Message-ID: <ef04f5a07294b70713cb5c328afdfe3f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4BEF02A9
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:31:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=451> 
======================================================================
Reported By:                cuardin
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Issue ID:                   451
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-18-2004 10:00 CEST
Last Modified:              11-09-2004 16:31 CET
======================================================================
Summary:                    Corruption in /etc/asound.state causes alsa to hang
when restoring mixer levels during reboot.
Description: 
If the file /etc/asound.state is corrupted, for example due to a
file-system corruption after a hard-reboot, the boot process will halt
when attempting to restore the mixer settings. Pressing Ctrl-C will resume
the boot process. 

Upon shutdown, the process will halt when attempting to store mixer
settings requiring a hard reboot.

A work-around is to delete the offending file. 
======================================================================

----------------------------------------------------------------------
 perex - 09-08-04 18:44 
----------------------------------------------------------------------
This patch (included in CVS) fixes your problem:

Index: conf.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf.c,v
retrieving revision 1.69
diff -u -r1.69 conf.c
--- conf.c      25 Feb 2004 11:24:29 -0000      1.69
+++ conf.c      8 Sep 2004 16:41:59 -0000
@@ -813,6 +813,7 @@
        case '}':
        case '[':
        case ']':
+       case '\\':
                return LOCAL_UNEXPECTED_CHAR;
        case '\'':
        case '"':

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 10:00 cuardin        New Issue                                    
08-18-04 10:00 cuardin        File Added: asound.state                     
08-19-04 04:54 eradicator     Issue Monitored: eradicator                    
09-08-04 18:44 perex          Status                   new => resolved     
09-08-04 18:44 perex          Resolution               open => fixed       
09-08-04 18:44 perex          Assigned To               => perex           
09-08-04 18:44 perex          Note Added: 0001739                          
11-09-04 16:31 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
