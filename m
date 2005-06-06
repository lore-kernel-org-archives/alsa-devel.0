From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001155]: New snddevices script
Date: Mon, 6 Jun 2005 10:36:30 +0200
Message-ID: <2626ff8abe3bfec53cd625f7fdc4d2e5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EEE8317A
	for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2005 10:36:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1155> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1155
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-04-2005 17:31 CEST
Last Modified:              06-06-2005 10:36 CEST
======================================================================
Summary:                    New snddevices script
Description: 
In Debian we need to create static devices in /dev/.static/dev/ if /dev/ is
controlled by udev.  Also, we don't want the script to wipe away sound
devices that are already present.  I have therefore adapted the existing
snddevices script so that it optionally does what Debian wants.  The
default behavior of the new script is the same as that of the old script. 
However, the new script has some additional options:

  [-h|--help] [max] [--no-wipe] [--dev-dir=PATHNAME] [--owner=USER:GROUP]

The new script is attached to this report.
======================================================================

----------------------------------------------------------------------
 perex - 06-06-05 10:36 
----------------------------------------------------------------------
Thanks. The updated script is in CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-04-05 17:31 jdthood        New Issue                                    
06-04-05 17:31 jdthood        File Added: snddevices                       
06-06-05 10:36 perex          Status                   assigned => resolved
06-06-05 10:36 perex          Resolution               open => fixed       
06-06-05 10:36 perex          Note Added: 0004894                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
