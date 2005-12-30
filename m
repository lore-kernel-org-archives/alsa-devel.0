From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001421]: AC97 device name changed in ac97_codec.c
Date: Fri, 30 Dec 2005 23:14:25 +0100
Message-ID: <cf6bc960d3a27e92ade2683527595737@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F4BA148
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:14:25 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1421> 
======================================================================
Reported By:                do13
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1421
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-14-2005 22:12 CEST
Last Modified:              12-30-2005 23:14 CET
======================================================================
Summary:                    AC97 device name changed in ac97_codec.c
Description: 
Bug #0001334 changed the device name on the AC97-bus into card#-# this
prevents external drivers to access the AC97 codec.
The basic idea of the AC97-bus was to bind external drivers to an codec to
use their extended features (touchscreen, AD- converter etc). With this
naming change we can't bind drivers to the codec, because the device name
isn't the name of the driver.

Andy ideas about this?


======================================================================

----------------------------------------------------------------------
 liam - 09-15-05 17:12 
----------------------------------------------------------------------
Does anybody object to :-

card1-0:WM9713

This way the card number, ac97 bus id and codec id are preserved.

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:14 
----------------------------------------------------------------------
Any news on this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-14-05 22:12 do13           New Issue                                    
09-14-05 22:12 do13           Kernel Version            => 2.6.13          
09-15-05 14:18 Clemens LadischNote Added: 0006195                          
09-15-05 16:07 tiwai          Note Added: 0006212                          
09-15-05 17:04 liam           Note Added: 0006216                          
09-15-05 17:12 liam           Note Added: 0006217                          
12-30-05 23:14 rlrevell       Note Added: 0007280                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
