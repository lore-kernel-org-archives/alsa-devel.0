From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000649]: alsaplayer only works as root
Date: Sun, 20 Mar 2005 13:31:39 +0100
Message-ID: <898a649323c89cd2f6b3485378d3b666@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4C089250
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 13:31:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=649> 
======================================================================
Reported By:                mthoro
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   649
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-14-2004 15:37 CET
Last Modified:              03-20-2005 13:31 CET
======================================================================
Summary:                    alsaplayer only works as root
Description: 
changed permissions on snd devices to 777.  player only works after login
as root.  after login as user in audio group, player will not work even if
I log back in as root.  I have to reboot and login as root to get the
player to work again. gnome cd player works okay, but the alsaplayer is
great!
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 11-15-04 18:10 
----------------------------------------------------------------------
It seems you're using a system that automatically creates device nodes
(devfs or udev).  You have to change the devfs/udev configuration so that
it sets correct permissions.  Ask the debian experts.

----------------------------------------------------------------------
 jdthood - 03-20-05 13:31 
----------------------------------------------------------------------
This report can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-04 15:37 mthoro         New Issue                                    
11-15-04 18:10 Clemens LadischNote Added: 0002417                          
03-20-05 13:31 jdthood        Note Added: 0004087                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
