From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000471]: (Patch) Adds field to ignore control bug with LineX device.
Date: Fri,  3 Sep 2004 14:34:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040903123407.96B482D0C0@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DD3782C4
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 14:34:07 +0200 (MEST)
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
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             08-29-2004 08:22 CEST
Last Modified:              09-03-2004 14:34 CEST
======================================================================
Summary:                    (Patch) Adds field to ignore control bug with LineX device.
Description: 
This patch adds PID/VID to usbmixer_maps.c so that a control bug, which
prevents the device from being claimed for use with snd-usb-audio, will be
ignored.

Patch goes against 1.0.6a.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 09-02-2004 14:41 CEST 
----------------------------------------------------------------------
Please provide (here or to <clemens@ladisch.de>) your name/email for the
Signed-off-by: information.

----------------------------------------------------------------------
 dignome - 09-03-2004 14:28 CEST 
----------------------------------------------------------------------
Signed off by Lonnie Mendez (dignome@gmail.com).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 08:22 dignome        New Bug                                      
08-29-04 08:22 dignome        File Added: linex-usbmixer_maps.patch                    
09-02-04 14:41 Clemens LadischBugnote Added: 0001683                       
09-03-04 14:28 dignome        Bugnote Added: 0001691                       
09-03-04 14:34 Clemens LadischResolution               open => fixed       
09-03-04 14:34 Clemens LadischStatus                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
