From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000582]: non-blocking write to alsa's OSS drivers eats data
Date: Fri, 15 Oct 2004 15:39:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041015133921.15ED73B025@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 65A172FE
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2004 15:39:21 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 34C0C253E0
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2004 15:39:21 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000582
======================================================================
Reported By:                Benjamin Otte
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     582
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-15-2004 15:39 CEST
Last Modified:              10-15-2004 15:39 CEST
======================================================================
Summary:                    non-blocking write to alsa's OSS drivers eats data
Description: 
write() calls in non-blocking mode eat the written data and never return
-EAGAIN. The attached patch fixes the problem.

Signed-off-by: Benjamin Otte <otte@gnome.org>
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 15:39 Benjamin Otte  New Bug                                      
10-15-04 15:39 Benjamin Otte  File Added: dont-eat-data.diff                    
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
