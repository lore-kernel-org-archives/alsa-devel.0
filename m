From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000474]: Compiling with -Wshadow generates warning messages with gcc-2.95
Date: Tue, 9 Nov 2004 16:34:04 +0100
Message-ID: <fcdecbe3a35e91377b2d2690d684b63c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 886FC2B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:34:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=474> 
======================================================================
Reported By:                erikd-alsa
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   474
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-30-2004 12:52 CEST
Last Modified:              11-09-2004 16:34 CET
======================================================================
Summary:                    Compiling with -Wshadow generates warning messages
with gcc-2.95
Description: 
In file included from /usr/include/alsa/asoundlib.h:49,
                 from alsa.c:3:
/usr/include/alsa/pcm.h:535: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:536: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:537: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:538: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:539: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:1260: warning: declaration of `access' shadows
global declaration
/usr/include/alsa/pcm.h:1270: warning: declaration of `access' shadows
global declaration
In file included from /usr/include/alsa/asoundlib.h:52,
                 from alsa.c:3:
/usr/include/alsa/hwdep.h:142: warning: declaration of `index' shadows
global declaration
In file included from /usr/include/alsa/asoundlib.h:56,
                 from alsa.c:3:
/usr/include/alsa/seq.h:363: warning: declaration of `index' shadows
global declaration

======================================================================

----------------------------------------------------------------------
 tiwai - 08-31-04 12:42 
----------------------------------------------------------------------
They are quite harmless, although it'd be better to be fixed.

----------------------------------------------------------------------
 tiwai - 09-21-04 12:38 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-04 12:52 erikd-alsa     New Issue                                    
08-31-04 12:42 tiwai          Note Added: 0001672                          
09-21-04 12:38 tiwai          Status                   new => resolved     
09-21-04 12:38 tiwai          Resolution               open => fixed       
09-21-04 12:38 tiwai          Assigned To               => tiwai           
09-21-04 12:38 tiwai          Note Added: 0001799                          
11-09-04 16:34 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
