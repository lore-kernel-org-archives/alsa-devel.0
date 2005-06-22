From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001208]: 2 Typos and a little Question to device.c
Date: Wed, 22 Jun 2005 23:58:15 +0200
Message-ID: <e3d36052c32414daf8c4fbcbdc36fe85@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BD21920C
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 23:58:15 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1208> 
======================================================================
Reported By:                Henne
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1208
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-22-2005 23:58 CEST
Last Modified:              06-22-2005 23:58 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-22-05 23:58 Henne          New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
