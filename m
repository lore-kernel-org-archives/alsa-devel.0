From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000983]: amixer can't control "Capture Volume" and "Capture Switch" on azx, whereas gamix can
Date: Wed, 15 Jun 2005 15:00:50 +0200
Message-ID: <8e762147e4ad3b7ab75a51cb5841cd45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C0BBE1EF
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 15:00:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=983> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   983
Category:                   amixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-12-2005 12:54 CET
Last Modified:              06-15-2005 15:00 CEST
======================================================================
Summary:                    amixer can't control "Capture Volume" and "Capture
Switch" on azx, whereas gamix can
Description: 
This bug was reported at http://bugs.debian.org/297624 and has been
discussed there at some length.
======================================================================

----------------------------------------------------------------------
 jdthood - 06-04-05 17:00 
----------------------------------------------------------------------
> Your bug is hopefully fixed in the 1.0.9 release of ALSA.  Please check
> this by installing 1.0.9 versions of the ALSA base package, ALSA
modules
> package and ALSA library package. [...]
>
> Please reply to let us know whether or not the bug is really fixed.

It is not fixed - alsamixer work good, but amixer don't control 'Input
Source' 
and 'Capture On/Off switch':

$ amixer -v
amixer version 1.0.9a
$ /usr/bin/amixer set 'Capture',0 on
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 30
  Front Left: Capture 6 [20%] [off]
  Front Right: Capture 6 [20%] [off]

----------------------------------------------------------------------
 tiwai - 06-15-05 15:00 
----------------------------------------------------------------------
amixer should be possible to handle capture on/off and volume.
But it can't handle the "Input Source" enum control with "sset".  You'd
need to use "cset" to change a proper control.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 12:54 jdthood        New Issue                                    
03-16-05 12:59 tiwai          Status                   new => resolved     
03-16-05 12:59 tiwai          Resolution               open => fixed       
03-16-05 12:59 tiwai          Assigned To               => tiwai           
03-16-05 12:59 tiwai          Note Added: 0003951                          
03-16-05 12:59 tiwai          Assigned To              tiwai =>            
03-16-05 13:09 jdthood        Status                   resolved => feedback
03-16-05 13:09 jdthood        Resolution               fixed => reopened   
03-16-05 13:09 jdthood        Note Added: 0003954                          
03-28-05 04:04 jdthood        Status                   feedback => resolved
03-28-05 04:04 jdthood        Resolution               reopened => fixed   
06-04-05 17:00 jdthood        Status                   resolved => feedback
06-04-05 17:00 jdthood        Resolution               fixed => reopened   
06-04-05 17:00 jdthood        Note Added: 0004887                          
06-04-05 17:02 jdthood        Severity                 major => minor      
06-04-05 17:02 jdthood        Status                   feedback => new     
06-04-05 17:02 jdthood        Category                 alsamixer => amixer 
06-04-05 17:02 jdthood        version                  1.0.8 => 1.0.9      
06-08-05 19:50 jdthood        Summary                  alsamixer and amixer
can't control "Capture Volume" and "Capture Switch" on azx, whereas gamix can =>
amixer can't control "Capture Volume" and "Capture Switch" on azx, whereas gamix
can
06-15-05 15:00 tiwai          Note Added: 0005029                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
