From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000524]: [PATCH] aserver.c -- terminate long options list and thus prevent segmentation fault on invalid command line options
Date: Wed, 22 Sep 2004 23:38:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040922213841.52DBE9006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A1B11321
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 23:38:41 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 6262326A1E
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 23:38:41 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000524
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     524
Category:                   general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-22-2004 23:38 CEST
Last Modified:              09-22-2004 23:38 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-22-04 23:38 jdthood        New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
