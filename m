From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000558]: Hardware Monitoring is missing for EWS88D
Date: Wed,  6 Oct 2004 12:11:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041006101116.ECF8A12009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6098127C
	for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2004 12:11:17 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000558
======================================================================
Reported By:                theitch
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     558
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               FC 1 - CCRMA
Kernel Version:             2.4.26
======================================================================
Date Submitted:             10-02-2004 05:03 CEST
Last Modified:              10-06-2004 12:11 CEST
======================================================================
Summary:                    Hardware Monitoring is missing for EWS88D
Description: 
The Hardware Monitoring for the the envy24/ice1712-based Terratec EWS88D
does not function when using the ice1712 driver.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-04-2004 18:55 CEST 
----------------------------------------------------------------------
It's a bug of jack.  Since EWS88D has no analog I/O for multi-channel
mode, it doesn't have the corresponding control for analog but only
for SPDIF.

----------------------------------------------------------------------
 theitch - 10-05-2004 16:06 CEST 
----------------------------------------------------------------------
Thanks. I will go check the jack bug db.
Would it also be a bug with envy24control? 
Would the ice1712 (the ASIC, not the driver) ever be able to H/W monitor
the 8 ADAT-based channels?

edited on: 10-05-04 16:06

----------------------------------------------------------------------
 tiwai - 10-06-2004 12:11 CEST 
----------------------------------------------------------------------
Envy24control is OK.  Again, EWS88D has no analog I/O for
multi-channel mode.  That's why there are missing.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-02-04 05:03 theitch        New Bug                                      
10-02-04 05:03 theitch        Distribution              => FC 1 - CCRMA    
10-02-04 05:03 theitch        Kernel Version            => 2.4.26          
10-03-04 20:36 theitch        Bug Monitored: theitch                       
10-04-04 18:55 tiwai          Bugnote Added: 0002012                       
10-05-04 16:00 theitch        Bugnote Added: 0002016                       
10-05-04 16:06 theitch        Bugnote Edited: 0002016                      
10-06-04 12:11 tiwai          Bugnote Added: 0002021                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
