From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000581]: non-blocking write to alsa's OSS drivers eats data
Date: Mon, 18 Oct 2004 17:27:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018152701.0883D11030@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5890F24B
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2004 17:27:01 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000581
======================================================================
Reported By:                Benjamin Otte
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Bug ID:                     581
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 duplicate
Duplicate:                  582
======================================================================
Date Submitted:             10-15-2004 15:35 CEST
Last Modified:              10-18-2004 17:27 CEST
======================================================================
Summary:                    non-blocking write to alsa's OSS drivers eats data
Description: 
write() calls in non-blocking mode eat the written data and never return
-EAGAIN. The attached patch fixes the problem.

Signed-off-by: Benjamin Otte <otte@gnome.org>
======================================================================

----------------------------------------------------------------------
 Benjamin Otte - 10-15-2004 15:40 CEST 
----------------------------------------------------------------------
Disregard this bug and close it please, it's not an alsalib bug. I've
refiled it as bug 582 for alsa-driver.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 15:35 Benjamin Otte  New Bug                                      
10-15-04 15:35 Benjamin Otte  File Added: dont-eat-data.diff                    
10-15-04 15:40 Benjamin Otte  Bugnote Added: 0002167                       
10-18-04 17:27 tiwai          duplicate_id             0 => 582            
10-18-04 17:27 tiwai          Assigned To               => tiwai           
10-18-04 17:27 tiwai          Resolution               open => duplicate   
10-18-04 17:27 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
