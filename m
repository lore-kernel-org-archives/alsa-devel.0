From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000471]: (Patch) Adds field to ignore control bug with LineX device.
Date: Sun, 29 Aug 2004 08:22:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040829062200.5F88D39007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A45621BF
	for <alsa-devel@alsa-project.org>; Sun, 29 Aug 2004 08:22:00 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000471
======================================================================
Reported By:                dignome
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Bug ID:                     471
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-29-2004 08:22 CEST
Last Modified:              08-29-2004 08:22 CEST
======================================================================
Summary:                    (Patch) Adds field to ignore control bug with LineX device.
Description: 
This patch adds PID/VID to usbmixer_maps.c so that a control bug, which
prevents the device from being claimed for use with snd-usb-audio, will be
ignored.

Patch goes against 1.0.6a.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 08:22 dignome        New Bug                                      
08-29-04 08:22 dignome        File Added: linex-usbmixer_maps.patch                    
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
