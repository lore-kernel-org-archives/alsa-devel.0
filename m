From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000526]: Kernel crash during the module snd-azx load
Date: Tue, 28 Sep 2004 23:20:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040928212002.CD16246008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 254A1320
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2004 23:20:03 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000526
======================================================================
Reported By:                Grazy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     526
Category:                   PCI - azx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.8
Resolution:                 fixed
======================================================================
Date Submitted:             09-23-2004 19:33 CEST
Last Modified:              09-28-2004 23:20 CEST
======================================================================
Summary:                    Kernel crash during the module snd-azx load
Description: 
The kernel crash during the load of the snd-azx.
It is the recursive funtion set_mic_rp_wid_connection wich never end.

======================================================================

----------------------------------------------------------------------
 tiwai - 09-28-2004 23:20 CEST 
----------------------------------------------------------------------
Thanks, applied to CVS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-23-04 19:33 Grazy          New Bug                                      
09-23-04 19:33 Grazy          File Added: patch_azx_discover.gz                    
09-23-04 19:33 Grazy          Distribution              => Debian          
09-23-04 19:33 Grazy          Kernel Version            => 2.6.8           
09-28-04 23:20 tiwai          Bugnote Added: 0001960                       
09-28-04 23:20 tiwai          Assigned To               => tiwai           
09-28-04 23:20 tiwai          Resolution               open => fixed       
09-28-04 23:20 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
