From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001208]: 2 Typos and a little Question to device.c
Date: Wed, 29 Jun 2005 20:32:13 +0200
Message-ID: <44c9d910368cd755d315d3ae048c2f73@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F1237167
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2005 20:32:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1208> 
======================================================================
Reported By:                Henne
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1208
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-22-2005 23:58 CEST
Last Modified:              06-29-2005 20:32 CEST
======================================================================
Summary:                    2 Typos and a little Question to device.c
Description: 
The comment @type of snd_device_new() is wrong. I belive it has to be
SNDDRV_DEV_XXX instead of SNDDRV_DEV_TYPE_XXX .

The comment in snd_device_disconnect() has to be snd_device_disconnect
instead of snd_device_free.

The sound_assert() macros in snd_device_new() and snd_device_register()
have a couple of expessions, and I belive it would be better for debuggin
if the macro calls would be called for paramter seperately, like in all
the other functions.

 
======================================================================

----------------------------------------------------------------------
 Henne - 06-28-05 16:28 
----------------------------------------------------------------------
Here we go!

Take the third patch(device_c.diff). Forgot to sign off.
Why can't I erase my submitted files?
I wrote a patch for core.h and add it to this thread.



----------------------------------------------------------------------
 tiwai - 06-29-05 20:32 
----------------------------------------------------------------------
Thanks, both patches are applied to CVS.

The restriction of removal of attachments is the feature of mantis.
Perhaps because there is no owner for attachments...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-22-05 23:58 Henne          New Issue                                    
06-23-05 10:50 tiwai          Note Added: 0005166                          
06-23-05 12:12 Henne          File Added: device-patch.diff                    
06-23-05 12:14 Henne          Note Added: 0005179                          
06-23-05 12:17 Henne          File Added: device-patch2.diff                    
06-23-05 12:18 Henne          Note Edited: 0005179                         
06-28-05 16:24 Henne          File Added: device_c.diff                    
06-28-05 16:28 Henne          Note Edited: 0005179                         
06-28-05 16:28 Henne          File Added: core_h.diff                      
06-29-05 20:32 tiwai          Status                   new => resolved     
06-29-05 20:32 tiwai          Resolution               open => fixed       
06-29-05 20:32 tiwai          Assigned To               => tiwai           
06-29-05 20:32 tiwai          Note Added: 0005314                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
