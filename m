From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000570]: Sparse mixer for RME96
Date: Thu,  7 Oct 2004 14:11:27 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041007121127.44F8A2100D@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9C1002B6
	for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2004 14:11:27 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000570
======================================================================
Reported By:                ungod
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     570
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-07-2004 10:59 CEST
Last Modified:              10-07-2004 14:11 CEST
======================================================================
Summary:                    Sparse mixer for RME96
Description: 
Noticed that almost all mixer controls was identified as PCM controles, so
I did a small patch.

Summary: RME96 Mixer fix

 - Fix mixer bugs

Signed-off-by: Peter Chrisensen <peter@developers.dk>
======================================================================

----------------------------------------------------------------------
 tiwai - 10-07-2004 14:11 CEST 
----------------------------------------------------------------------
The patch will break alsa-tools/rmedigicontrol.

I agree with convesion to IFACE_MIXER, but I'm not sure what was the
author's original intention...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-07-04 10:59 ungod          New Bug                                      
10-07-04 10:59 ungod          File Added: rme96-mixerfix.diff                    
10-07-04 14:11 tiwai          Bugnote Added: 0002030                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
