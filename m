From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000582]: non-blocking write to alsa's OSS drivers eats data
Date: Mon, 18 Oct 2004 17:55:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018155511.AD9AB25018@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 013152E8
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2004 17:55:11 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000582
======================================================================
Reported By:                Benjamin Otte
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     582
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             10-15-2004 15:39 CEST
Last Modified:              10-18-2004 17:55 CEST
======================================================================
Summary:                    non-blocking write to alsa's OSS drivers eats data
Description: 
write() calls in non-blocking mode eat the written data and never return
-EAGAIN. The attached patch fixes the problem.

Signed-off-by: Benjamin Otte <otte@gnome.org>
======================================================================

----------------------------------------------------------------------
 tiwai - 10-18-2004 17:55 CEST 
----------------------------------------------------------------------
Thanks, the patch was applied to CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 15:39 Benjamin Otte  New Bug                                      
10-15-04 15:39 Benjamin Otte  File Added: dont-eat-data.diff                    
10-18-04 17:55 tiwai          Bugnote Added: 0002197                       
10-18-04 17:55 tiwai          Assigned To               => tiwai           
10-18-04 17:55 tiwai          Resolution               open => fixed       
10-18-04 17:55 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
