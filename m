From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000451]: Corruption in /etc/asound.state causes alsa to hang when restoring mixer levels during reboot.
Date: Wed,  8 Sep 2004 18:44:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908164419.6F01B13001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D18CC280
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 18:44:22 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000451
======================================================================
Reported By:                cuardin
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Bug ID:                     451
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             08-18-2004 10:00 CEST
Last Modified:              09-08-2004 18:44 CEST
======================================================================
Summary:                    Corruption in /etc/asound.state causes alsa to hang when restoring mixer levels during reboot.
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
 perex - 09-08-2004 18:44 CEST 
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 10:00 cuardin        New Bug                                      
08-18-04 10:00 cuardin        File Added: asound.state                     
08-19-04 04:54 eradicator     Bug Monitored: eradicator                    
09-08-04 18:44 perex          Bugnote Added: 0001739                       
09-08-04 18:44 perex          Assigned To               => perex           
09-08-04 18:44 perex          Resolution               open => fixed       
09-08-04 18:44 perex          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
