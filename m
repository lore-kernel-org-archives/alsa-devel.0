From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000436]: How to have sound to Digital and Analog at the same time ?
Date: Tue,  7 Sep 2004 16:38:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907143800.C1526E01F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0C66828E
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 16:38:01 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000436
======================================================================
Reported By:                tho_x_tran
Assigned To:                perex
======================================================================
Project:                    ALSA - tools
Bug ID:                     436
Category:                   ac3dec
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
======================================================================
Date Submitted:             08-12-2004 20:36 CEST
Last Modified:              09-07-2004 16:38 CEST
======================================================================
Summary:                    How to have sound to Digital and Analog at the same time ?
Description: 
I play Xine and Watch TV at the same time, and Xine audio can only go to
Digital Opt out while TV sound goes to Analog front speakers only.  How
can I make it go to both devices AT THE SAME TIME for all applications.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-01-2004 22:53 CEST 
----------------------------------------------------------------------
Basically it's a job of application.
ALSA doesn't decode AC3 by itself.
So, apps should send both AC3-analog and AC3-passthru signals to
different PCM (if possible).  And, this is not always possible
on many motherboards...

----------------------------------------------------------------------
 perex - 09-07-2004 16:38 CEST 
----------------------------------------------------------------------
Application problem.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-12-04 20:36 tho_x_tran     New Bug                                      
08-12-04 20:36 tho_x_tran     File Added: asound.conf                      
09-01-04 22:53 tiwai          Bugnote Added: 0001678                       
09-07-04 16:38 perex          Bugnote Added: 0001712                       
09-07-04 16:38 perex          Resolution               open => fixed       
09-07-04 16:38 perex          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
