From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001421]: AC97 device name changed in ac97_codec.c
Date: Wed, 4 Jan 2006 17:46:35 +0100
Message-ID: <736f6e9e9b6dc215c8a6d46eac717710@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 96942184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:46:35 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1421> 
======================================================================
Reported By:                do13
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1421
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.13
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-14-2005 22:12 CEST
Last Modified:              01-04-2006 17:46 CET
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
 rlrevell - 12-30-05 23:14 
----------------------------------------------------------------------
Any news on this?

----------------------------------------------------------------------
 tiwai - 01-04-06 17:46 
----------------------------------------------------------------------
It shows now like 0-0:WM9713.

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
01-04-06 17:46 tiwai          Status                   new => resolved     
01-04-06 17:46 tiwai          Resolution               open => fixed       
01-04-06 17:46 tiwai          Assigned To               => tiwai           
01-04-06 17:46 tiwai          Note Added: 0007448                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
