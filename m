From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001277]: Choosing of default playback device on the fly
Date: Sat, 23 Jul 2005 10:42:27 +0200
Message-ID: <309b67c63c0876d7ae95f5e5c1a05ac4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24412178
	for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2005 10:42:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1277> 
======================================================================
Reported By:                oldium
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1277
Category:                   0_general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-23-2005 10:42 CEST
Last Modified:              07-23-2005 10:42 CEST
======================================================================
Summary:                    Choosing of default playback device on the fly
Description: 
Situation: There is on-board sound card and one pluggable (USB/PCMCIA)
sound card which is preferred to play the sound.

Problem: If the preferred sound card is plugged-in before the boot time,
it is taken as the default output card (as of snd-card-0 settings and
driver is loaded first), but when the sound card is plugged after the
boot, it gets index 1 and is not the default.

Suggestion: Please consider creating plugin to use preferred sound card as
default output whenever it is plugged in and use fallback card whenever it
is not available, or let the user space program (shell script) decide
which card is default.

Usage: This is good for laptops using external sound card at home and
built-in on the way.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-23-05 10:42 oldium         New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
