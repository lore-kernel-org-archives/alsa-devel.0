From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000471]: (Patch) Adds field to ignore control bug with LineX device.
Date: Tue, 9 Nov 2004 16:14:47 +0100
Message-ID: <a617c7e0272ffefa39e684d6913cc014@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 24445244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:14:48 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=471> 
======================================================================
Reported By:                dignome
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   471
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-29-2004 08:22 CEST
Last Modified:              11-09-2004 16:14 CET
======================================================================
Summary:                    (Patch) Adds field to ignore control bug with LineX
device.
Description: 
This patch adds PID/VID to usbmixer_maps.c so that a control bug, which
prevents the device from being claimed for use with snd-usb-audio, will be
ignored.

Patch goes against 1.0.6a.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 09-02-04 14:41 
----------------------------------------------------------------------
Please provide (here or to <clemens@ladisch.de>) your name/email for the
Signed-off-by: information.

----------------------------------------------------------------------
 dignome - 09-03-04 14:28 
----------------------------------------------------------------------
Signed off by Lonnie Mendez (dignome@gmail.com).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-29-04 08:22 dignome        New Issue                                    
08-29-04 08:22 dignome        File Added: linex-usbmixer_maps.patch             
      
09-02-04 14:41 Clemens LadischNote Added: 0001683                          
09-03-04 14:28 dignome        Note Added: 0001691                          
09-03-04 14:34 Clemens LadischStatus                   assigned => resolved
09-03-04 14:34 Clemens LadischResolution               open => fixed       
11-09-04 16:14 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
