From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001421]: AC97 device name changed in ac97_codec.c
Date: Thu, 15 Sep 2005 17:12:05 +0200
Message-ID: <745b75dbdfa0effd5b70bb6445c2b21e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4BFCF184
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 17:12:05 +0200 (MEST)
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
Last Modified:              09-15-2005 17:12 CEST
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
 liam - 09-15-05 17:04 
----------------------------------------------------------------------
The name should also include the codec name as each ad-hoc driver is codec
specific. Currently, the wm97xx touch screen driver registers with a
"WM97" string to match any WM97** codec.

----------------------------------------------------------------------
 liam - 09-15-05 17:12 
----------------------------------------------------------------------
Does anybody object to :-

card1-0:WM9713

This way the card number, ac97 bus id and codec id are preserved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-14-05 22:12 do13           New Issue                                    
09-14-05 22:12 do13           Kernel Version            => 2.6.13          
09-15-05 14:18 Clemens LadischNote Added: 0006195                          
09-15-05 16:07 tiwai          Note Added: 0006212                          
09-15-05 17:04 liam           Note Added: 0006216                          
09-15-05 17:12 liam           Note Added: 0006217                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
