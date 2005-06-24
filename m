From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001211]: type dmix produces noise, type plug slave.pcm "dmix" does not on SB EXtigy
Date: Fri, 24 Jun 2005 14:55:12 +0200
Message-ID: <6ceb197137eeb772cf448174b89bc055@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D9283216
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 14:55:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1211> 
======================================================================
Reported By:                andersin
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1211
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-24-2005 00:02 CEST
Last Modified:              06-24-2005 14:55 CEST
======================================================================
Summary:                    type dmix produces noise, type plug slave.pcm "dmix"
does not on SB EXtigy
Description: 
I recently noticed crackling sound when using the dmix plugin. While the
simple case { type plug; slave.pcm "dmix" } works, { type dmix; slave.pcm
"extigy" } (where extigy is the pcm for the card) produces a crackling
sound. (I observe the same problem with my build in ICH4 card, but AFAIR
this has been reported already).

I have tried a variety of buffering and period settings that I found in
various documentations on the web, but all attempts were unsuccessful.
======================================================================

----------------------------------------------------------------------
 andersin - 06-24-05 13:40 
----------------------------------------------------------------------
Even if I do not specify any parameters in my asound.conf, I can observer
the effect. I might be wrong, but I assume, that the default settings of
plug dmix and type dmix match.

Where can I find out, which parameters the default dmix uses so that I can
test it with that setup?

----------------------------------------------------------------------
 tiwai - 06-24-05 14:55 
----------------------------------------------------------------------
In the case of aplay, you can see the plug configuration via -v option.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-24-05 00:02 andersin       New Issue                                    
06-24-05 00:02 andersin       Kernel Version            => 2.6.11          
06-24-05 11:11 tiwai          Note Added: 0005210                          
06-24-05 13:40 andersin       Note Added: 0005219                          
06-24-05 14:55 tiwai          Note Added: 0005222                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
