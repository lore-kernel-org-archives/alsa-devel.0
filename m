From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001219]: alsamixer cannot handle mixer controls that have separate mute for each channel.
Date: Wed, 29 Jun 2005 21:26:17 +0200
Message-ID: <2ad0ee5d42a9f8f08e9ae0b8ce51f0b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51EFA192
	for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2005 21:26:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1219> 
======================================================================
Reported By:                jcdutton
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1219
Category:                   simple mixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-29-2005 11:11 CEST
Last Modified:              06-29-2005 21:26 CEST
======================================================================
Summary:                    alsamixer cannot handle mixer controls that have
separate mute for each channel.
Description: 
When a mixer control has a mute control for each channel, alsamixer is only
able to adjust the left channel mute.
For example, with a snd-intel8x0 driver with the ac97 ALC650 codec, this
has a separate mute control for surround left and surround right.
alsamixer is only able to adjust/toggle the surround left mute control.
So far in my investigations, this does not appear to be a bug in
alsamixer. This still might be a bug in alsa-lib functions:
snd_mixer_selem_get_playback_switch(elem, chn_right, &sw);
snd_mixer_selem_set_playback_switch(elem, chn_right, !sw);
or in alsa-kernel ac97_codec.c where is manages the stereo mute controls.

I will investigate further when I get a chance.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-29-05 20:07 
----------------------------------------------------------------------
Does this happen with 1.0.9b?  I thought the surround mute problem was
fixed in the recent version.

----------------------------------------------------------------------
 jcdutton - 06-29-05 21:26 
----------------------------------------------------------------------
The problem is with the current CVS of alsa-driver, alsa-lib and alsa-utils

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-29-05 11:11 jcdutton       New Issue                                    
06-29-05 20:07 tiwai          Note Added: 0005309                          
06-29-05 21:26 jcdutton       Note Added: 0005315                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
