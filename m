From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000983]: amixer can't control "Capture Volume" and "Capture Switch" on azx, whereas gamix can
Date: Wed, 8 Jun 2005 19:50:25 +0200
Message-ID: <456fa02d9f5b483313e63c30659d0e97@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E99051E8
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 19:50:33 +0200 (MEST)
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


The following issue has been UPDATED.
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
Last Modified:              06-08-2005 19:50 CEST
======================================================================
Summary:                    amixer can't control "Capture Volume" and "Capture
Switch" on azx, whereas gamix can
Description: 
This bug was reported at http://bugs.debian.org/297624 and has been
discussed there at some length.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-16-05 12:59 
----------------------------------------------------------------------
Already fixed in the recent ersion.

----------------------------------------------------------------------
 jdthood - 03-16-05 13:09 
----------------------------------------------------------------------
For the record, the Debian bug report number is now
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=299458.
No further action needed.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
