From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000453]: it is impossible to select spdif as capture source
Date: Fri, 27 Aug 2004 19:39:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827173958.854752C003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DB1941E5
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 19:39:58 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000453
======================================================================
Reported By:                Andrew
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     453
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-18-2004 13:16 CEST
Last Modified:              08-27-2004 19:39 CEST
======================================================================
Summary:                    it is impossible to select spdif as capture source
Description: 
There are no anything spdif-input-related among
capture source enumeration.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-25-2004 19:55 CEST 
----------------------------------------------------------------------
Did you use 'iec958' pcm?

    % arecord -Diec958 -fdat foo.wav

----------------------------------------------------------------------
 Andrew - 08-25-2004 23:47 CEST 
----------------------------------------------------------------------
A dat fromat doesn't work: "Sample format non available"
I have tried

arecord -Diec958 -fs32_LE -r48000 -c2 -d600 foo.wav

Format/rate are accepted, but the resulted file is empty.
I use aureon 7.1.

While filing the isuue, I have thought about capture selecting via
mixer Capture Source control. Does this (others?) control influence
to shown above command working?

----------------------------------------------------------------------
 tiwai - 08-27-2004 19:39 CEST 
----------------------------------------------------------------------
You can use'plug:iec958' for 16bit conversion.

"Capture Source" shouldn't affect the digital input.
It might be a wrong CS8415 initialization sequence in the driver...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 13:16 Andrew         New Bug                                      
08-25-04 19:55 tiwai          Bugnote Added: 0001625                       
08-25-04 23:47 Andrew         Bugnote Added: 0001628                       
08-27-04 19:39 tiwai          Bugnote Added: 0001648                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
