From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000524]: [PATCH] aserver.c -- terminate long options list and thus prevent segmentation fault on invalid command line options
Date: Tue, 9 Nov 2004 16:38:48 +0100
Message-ID: <d74564c3c291f754e0a2b100a94f6694@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0CA202B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:38:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=524> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   524
Category:                   general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-22-2004 23:38 CEST
Last Modified:              11-09-2004 16:38 CET
======================================================================
Summary:                    [PATCH] aserver.c -- terminate long options list and
thus prevent segmentation fault on invalid command line options
Description: 
--- aserver/aserver.c.orig      2004-09-04 16:16:53.000000000 +0200
+++ aserver/aserver.c   2004-09-04 16:34:56.000000000 +0200
@@ -1006,7 +1006,8 @@
 int main(int argc, char **argv)
 {
        static struct option long_options[] = {
-               {"help", 0, 0, 'h'}
+               {"help", 0, 0, 'h'},
+                { 0 , 0 , 0, 0 }
        };
        int c;
        snd_config_t *conf;
======================================================================

----------------------------------------------------------------------
 jdthood - 09-24-04 21:23 
----------------------------------------------------------------------
Summary: Terminate long_options array

Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>

----------------------------------------------------------------------
 tiwai - 09-28-04 19:22 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-22-04 23:38 jdthood        New Issue                                    
09-23-04 18:17 tiwai          Note Added: 0001828                          
09-24-04 21:23 jdthood        Note Added: 0001904                          
09-28-04 19:22 tiwai          Status                   new => resolved     
09-28-04 19:22 tiwai          Resolution               open => fixed       
09-28-04 19:22 tiwai          Assigned To               => tiwai           
09-28-04 19:22 tiwai          Note Added: 0001955                          
11-09-04 16:38 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
