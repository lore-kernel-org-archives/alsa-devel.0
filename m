From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000524]: [PATCH] aserver.c -- terminate long options list and thus prevent segmentation fault on invalid command line options
Date: Tue, 28 Sep 2004 19:22:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928172255.15EF646008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 77638316
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 19:22:55 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000524
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     524
Category:                   general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             09-22-2004 23:38 CEST
Last Modified:              09-28-2004 19:22 CEST
======================================================================
Summary:                    [PATCH] aserver.c -- terminate long options list and thus prevent segmentation fault on invalid command line options
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
 tiwai - 09-23-2004 18:17 CEST 
----------------------------------------------------------------------
Please provide a signed-off-by line...

----------------------------------------------------------------------
 jdthood - 09-24-2004 21:23 CEST 
----------------------------------------------------------------------
Summary: Terminate long_options array

Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>

----------------------------------------------------------------------
 tiwai - 09-28-2004 19:22 CEST 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-22-04 23:38 jdthood        New Bug                                      
09-23-04 18:17 tiwai          Bugnote Added: 0001828                       
09-24-04 21:23 jdthood        Bugnote Added: 0001904                       
09-28-04 19:22 tiwai          Bugnote Added: 0001955                       
09-28-04 19:22 tiwai          Assigned To               => tiwai           
09-28-04 19:22 tiwai          Resolution               open => fixed       
09-28-04 19:22 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
